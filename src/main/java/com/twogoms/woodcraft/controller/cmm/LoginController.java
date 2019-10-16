package com.twogoms.woodcraft.controller.cmm;

import com.twogoms.woodcraft.constant.WoodCraftConstant;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.sec.drm.service.DeptAuthor;
import egovframework.com.sec.drm.service.EgovDeptAuthorService;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    /** EgovMessageSource */
    @Resource(name = "egovMessageSource")
    EgovMessageSource egovMessageSource;

    /** EgovLoginService */
    @Resource(name = "loginService")
    private EgovLoginService loginService;

    /** userManageService */
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;

    @Resource(name = "egovDeptAuthorService")
    private EgovDeptAuthorService egovDeptAuthorService;

    /** egovUsrCnfrmIdGnrService */
    @Resource(name="egovUsrCnfrmIdGnrService")
    private EgovIdGnrService idgenService;

    private final static Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

    @RequestMapping(method = RequestMethod.GET, value = "/login.do")
    public ModelAndView pageLogin(HttpServletRequest request,
                                  HttpServletResponse response) throws Exception {

        if (request.getParameterMap().isEmpty()) {
            EgovSessionCookieUtil.removeSessionAttribute(request, "SPRING_SECURITY_LAST_EXCEPTION");
        }
        return new ModelAndView("/cmm/00_01");
    }

    @RequestMapping(method = RequestMethod.GET, value = "/authLogin.do")
    public ModelAndView authLogin(HttpServletRequest request,
                                  HttpServletResponse response) throws Exception {

        if (request.getParameterMap().isEmpty()) {
            EgovSessionCookieUtil.removeSessionAttribute(request, "SPRING_SECURITY_LAST_EXCEPTION");
        }
        return new ModelAndView("/cmm/00_99");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/checkPlusSuccess.do")
    public String checkPlusSuccess(HttpServletRequest request,
                                  HttpServletResponse response, ModelMap model,
                                   RedirectAttributes redirectAttr) throws Exception {

        HttpSession session = request.getSession(false);

        NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

        String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

        String sSiteCode = egovMessageSource.getMessage("nice.sSiteCode"); // NICE로부터 부여받은 사이트 코드
        String sSitePassword = egovMessageSource.getMessage("nice.sSitePassword"); // NICE로부터 부여받은 사이트 패스워드

        String sCipherTime = "";			// 복호화한 시간
        String sRequestNumber = "";			// 요청 번호
        String sResponseNumber = "";		// 인증 고유번호
        String sAuthType = "";				// 인증 수단
        String sName = "";					// 성명
        String sDupInfo = "";				// 중복가입 확인값 (DI_64 byte)
        String sConnInfo = "";				// 연계정보 확인값 (CI_88 byte)
        String sBirthDate = "";				// 생년월일(YYYYMMDD)
        String sGender = "";				// 성별
        String sNationalInfo = "";			// 내/외국인정보 (개발가이드 참조)
        String sMobileNo = "";				// 휴대폰번호
        String sMobileCo = "";				// 통신사
        String sMessage = "";
        String sPlainData = "";

        int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

        if( iReturn == 0 )
        {
            sPlainData = niceCheck.getPlainData();
            sCipherTime = niceCheck.getCipherDateTime();

            // 데이타를 추출합니다.
            java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

            sRequestNumber  = (String)mapresult.get("REQ_SEQ");
            sResponseNumber = (String)mapresult.get("RES_SEQ");
            sAuthType		= (String)mapresult.get("AUTH_TYPE");
            sName			= (String)mapresult.get("NAME");
            //sName			= (String)mapresult.get("UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
            sBirthDate		= (String)mapresult.get("BIRTHDATE");
            sGender			= (String)mapresult.get("GENDER");
            sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
            sDupInfo		= (String)mapresult.get("DI");
            sConnInfo		= (String)mapresult.get("CI");
            sMobileNo		= (String)mapresult.get("MOBILE_NO");
            sMobileCo		= (String)mapresult.get("MOBILE_CO");

            String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
            if(!sRequestNumber.equals(session_sRequestNumber))
            {

                sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
                sResponseNumber = "";
                sAuthType = "";

            } else {

                LoginVO vo = new LoginVO();
                vo.setIhidNum(sDupInfo);

                //정상처리...
                //DI값으로 유저정보 추출
                LoginVO resultVO = loginService.actionAuthLogin(vo);

                if (resultVO == null || resultVO.getId() == null || resultVO.getId().equals("")) {

                    UserManageVO userManageVO = new UserManageVO();
                    //고유아이디 셋팅
                    String uniqId = idgenService.getNextStringId();
                    userManageVO.setUniqId(uniqId);
                    userManageVO.setEmplyrId("TMP_" + sCipherTime);
                    userManageVO.setPassword(sDupInfo);

                    //패스워드 암호화
                    String pass = EgovFileScrty.encryptPassword(userManageVO.getPassword(), userManageVO.getEmplyrId());
                    userManageVO.setPassword(pass);

                    userManageVO.setIhidnum(sDupInfo);
                    userManageVO.setEmplyrNm(sName);

                    // 필수값 공백으로 설정
                    // AREA_NO
                    userManageVO.setAreaNo(" ");
                    // HOUSE_MIDDLE_TELNO
                    userManageVO.setHomemiddleTelno(" ");
                    // HOUSE_END_TELNO
                    userManageVO.setHomeendTelno(" ");
                    // PASSWORD_HINT
                    userManageVO.setPasswordHint(" ");
                    // PASSWORD_CNSR
                    userManageVO.setPasswordCnsr(" ");
                    // HOUSE_ADRES
                    userManageVO.setHomeadres(" ");
                    // ZIP
                    userManageVO.setZip(" ");
                    // EMPLYR_STTUS_CODE
                    userManageVO.setEmplyrSttusCode("P");
                    userManageVO.setOrgnztId("ORGNZT_0000000000000");
                    userManageVO.setGroupId("GROUP_00000000000000");

                    //SEXDSTN_CODE
                    //BRTHDY

                    //없으면 신규생성
                    userManageService.insertUser(userManageVO);

                    DeptAuthor deptAuthor = new DeptAuthor();
                    deptAuthor.setUniqId(uniqId);
                    deptAuthor.setAuthorCode("ROLE_USER");
                    egovDeptAuthorService.insertDeptAuthor(deptAuthor);

                    resultVO = loginService.actionAuthLogin(vo);

                }

                //로그인세션만들기
                // 2-1. 로그인 정보를 세션에 저장
                session.setAttribute("authVO", resultVO);
                session.setAttribute("sDupInfo", sDupInfo);

                //return "redirect:/authLogin.do";
                return "redirect:/uat/uia/actionLogin.do";

            }
        }
        else if( iReturn == -1)
        {
            sMessage = "복호화 시스템 에러입니다.";
        }
        else if( iReturn == -4)
        {
            sMessage = "복호화 처리오류입니다.";
        }
        else if( iReturn == -5)
        {
            sMessage = "복호화 해쉬 오류입니다.";
        }
        else if( iReturn == -6)
        {
            sMessage = "복호화 데이터 오류입니다.";
        }
        else if( iReturn == -9)
        {
            sMessage = "입력 데이터 오류입니다.";
        }
        else if( iReturn == -12)
        {
            sMessage = "사이트 패스워드 오류입니다.";
        }
        else
        {
            sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
        }

        model.addAttribute("message", egovMessageSource.getMessage("fail.common.login") + " " + sMessage);
        return "egovframework/com/uat/uia/EgovLoginUsr";

    }


    public String requestReplace (String paramValue, String gubun) {

        String result = "";

        if (paramValue != null) {

            paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

            paramValue = paramValue.replaceAll("\\*", "");
            paramValue = paramValue.replaceAll("\\?", "");
            paramValue = paramValue.replaceAll("\\[", "");
            paramValue = paramValue.replaceAll("\\{", "");
            paramValue = paramValue.replaceAll("\\(", "");
            paramValue = paramValue.replaceAll("\\)", "");
            paramValue = paramValue.replaceAll("\\^", "");
            paramValue = paramValue.replaceAll("\\$", "");
            paramValue = paramValue.replaceAll("'", "");
            paramValue = paramValue.replaceAll("@", "");
            paramValue = paramValue.replaceAll("%", "");
            paramValue = paramValue.replaceAll(";", "");
            paramValue = paramValue.replaceAll(":", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll("#", "");
            paramValue = paramValue.replaceAll("--", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll(",", "");

            if(gubun != "encodeData"){
                paramValue = paramValue.replaceAll("\\+", "");
                paramValue = paramValue.replaceAll("/", "");
                paramValue = paramValue.replaceAll("=", "");
            }

            result = paramValue;

        }
        return result;
    }

    /** 비회원 로그인 테스트용 */
    @RequestMapping(method = RequestMethod.GET, value = "/checkPlusSuccessTest.do")
    public String checkPlusSuccessTest(HttpServletRequest request,
                                   HttpServletResponse response, ModelMap model,
                                   RedirectAttributes redirectAttr) throws Exception {

        HttpSession session = request.getSession(false);

        LoginVO vo = new LoginVO();
        vo.setIhidNum("MC0GCCqGSIb3DQIJAyEAe5+ccp+AU2Z/tCuLV1lKP1yftGnAI/QTXhwiOrmMtp4=");

        //정상처리...
        //DI값으로 유저정보 추출
        LoginVO resultVO = loginService.actionAuthLogin(vo);

        //로그인세션만들기
        // 2-1. 로그인 정보를 세션에 저장
        session.setAttribute("authVO", resultVO);
        session.setAttribute("sDupInfo", "MC0GCCqGSIb3DQIJAyEAe5+ccp+AU2Z/tCuLV1lKP1yftGnAI/QTXhwiOrmMtp4=");

        return "redirect:/uat/uia/actionLogin.do";
    }

    /**
     * 수정일자 : 2018년 07월 06일
     * 수정자 : 김 태 형
     */
    @RequestMapping(method = RequestMethod.GET, value = "/loginSuccess.do")
    public String loginSuccess(HttpServletRequest request) throws Exception {

        String redirectURL = "redirect:";
        if (EgovStringUtil.nullConvert(request.getSession().getAttribute(WoodCraftConstant.SessionAttribute.BEFORE_LOGIN_URL)).length() == 0) {
           redirectURL += "/index.do";
        } else {
            redirectURL += request.getSession().getAttribute(WoodCraftConstant.SessionAttribute.BEFORE_LOGIN_URL).toString();
            request.getSession().removeAttribute(WoodCraftConstant.SessionAttribute.BEFORE_LOGIN_URL);
        }

        return redirectURL;
    }
}
