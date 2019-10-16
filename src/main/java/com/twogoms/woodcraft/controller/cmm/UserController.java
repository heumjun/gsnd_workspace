package com.twogoms.woodcraft.controller.cmm;

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
import egovframework.rte.fdl.property.EgovPropertyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.util.UriComponents;

import javax.annotation.Resource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@Controller
public class UserController {

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

    @Resource(name="propertiesService")
    private EgovPropertyService propertyService;

    private final static Logger LOGGER = LoggerFactory.getLogger(UserController.class);

    @RequestMapping(method = RequestMethod.GET, value = "/user/userCheck.do")
    public ModelAndView userCheck(HttpServletRequest request,
                                  HttpServletResponse response) throws Exception {

        if (request.getParameterMap().isEmpty()) {
            EgovSessionCookieUtil.removeSessionAttribute(request, "SPRING_SECURITY_LAST_EXCEPTION");
        }
        return new ModelAndView("/cmm/00_02");
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/userTerms.do")
    public ModelAndView userTerms(HttpServletRequest request,
                                  HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false);
        String sDupInfo = (String)session.getAttribute("sDupInfo");

        LoginVO vo = new LoginVO();
        vo.setIhidNum(sDupInfo);

        //정상처리...
        //DI값으로 유저정보 추출
        LoginVO resultVO = loginService.actionAuthLogin(vo);

        Map<String, Object> model = new HashMap<String, Object>();

        if (resultVO != null &&
            (!EgovStringUtil.isEmpty(resultVO.getId())
                && !resultVO.getId().startsWith("TMP_")
                  && !EgovStringUtil.isEmpty(resultVO.getHp()))) {
            model.put("errorMsg", "이미 등록된 사용자입니다.");
        }

        return new ModelAndView("/cmm/00_03", model);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/user/userRegist.do")
    public ModelAndView userRegist(HttpServletRequest request,
                                  HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        LoginVO userVO = (LoginVO) session.getAttribute("userVO");

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("userVO", userVO);

        return new ModelAndView("/cmm/00_04", model);
    }

    /**
     * 등록/수정
     * @param userVO
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.POST, value = "/user/userSave.do")
    public ModelAndView userSave(@ModelAttribute("usreVO") LoginVO userVO,
                                 HttpServletRequest request,
                                 HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        String sDupInfo = (String) session.getAttribute("sDupInfo");
        LoginVO checkUserVO = (LoginVO) session.getAttribute("userVO");

        UserManageVO userManageVO = new UserManageVO();
        //고유아이디 셋팅
        String uniqId = null;
        if (!EgovStringUtil.isEmpty(checkUserVO.getUniqId()))
            uniqId = checkUserVO.getUniqId();
        else
            uniqId = idgenService.getNextStringId();
        userManageVO.setUniqId(uniqId);
        userManageVO.setEmplyrId(userVO.getId());
        userManageVO.setPassword(userVO.getPassword());
        userManageVO.setIhidnum(sDupInfo);
        userManageVO.setEmplyrNm(userVO.getName());

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
        userManageVO.setHomeadres(userVO.getAdres());
        userManageVO.setDetailAdres(userVO.getAdresDtl());
        // ZIP
        userManageVO.setZip(userVO.getZip());
        // EMPLYR_STTUS_CODE
        userManageVO.setEmplyrSttusCode("P");
        userManageVO.setOrgnztId("ORGNZT_0000000000000");
        userManageVO.setGroupId("GROUP_00000000000000");

        userManageVO.setMoblphonNo(userVO.getHp());
        userManageVO.setEmailAdres(userVO.getEmail());

        //없으면 신규생성
        if (!EgovStringUtil.isEmpty(checkUserVO.getUniqId())) {

            userManageService.updateUser(userManageVO);
            userManageService.updatePassword(userManageVO);
        } else {

            userManageService.insertUser(userManageVO);

            DeptAuthor deptAuthor = new DeptAuthor();
            deptAuthor.setUniqId(uniqId);
            deptAuthor.setAuthorCode("ROLE_USER");
            egovDeptAuthorService.insertDeptAuthor(deptAuthor);
        }

        //로그인유저
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("userVO", userVO);

        return new ModelAndView("/cmm/00_05", model);
    }

    /**
     * 등록/수정
     * @param userVO
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/user/findId.do")
    public ModelAndView findId(HttpServletRequest request,
                                  HttpServletResponse response) throws Exception {

        return new ModelAndView("/cmm/00_06");
    }

    /**
     * 등록/수정
     * @param userVO
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/user/findPw.do")
    public ModelAndView findPw(HttpServletRequest request,
                               HttpServletResponse response) throws Exception {

        return new ModelAndView("/cmm/00_07");
    }

    /**
     * 등록/수정
     * @param userVO
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/user/checkId.do")
    public ModelAndView checkId(HttpServletRequest request,
                                   HttpServletResponse response) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("userVO", null);

        return new ModelAndView("/cmm/00_97", model);
    }

    /**
     * 등록/수정
     * @param userVO
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.POST, value = "/user/searchUserId.do")
    public ModelAndView searchUserId(@ModelAttribute("usreVO") LoginVO userVO,
                                HttpServletRequest request,
                                HttpServletResponse response) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("userVO", userVO);

        if (userManageService.checkIdDplct(userVO.getId()) > 0) {
            model.put("code", "NG");
        } else {
            model.put("code", "OK");
        }

        return new ModelAndView("/cmm/00_97", model);
    }

    /**
     * 등록/수정
     * @param userVO
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.POST, value = "/checkPlusSuccess2.do")
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

                //정상처리...
                vo.setName(sName);
                vo.setHp(sMobileNo);

                if (EgovStringUtil.nullConvert(resultVO.getId()).startsWith("TMP_"))
                    vo.setUniqId(resultVO.getUniqId());

                //로그인세션만들기
                // 2-1. 로그인 정보를 세션에 저장
                session.setAttribute("userVO", vo);
                session.setAttribute("sDupInfo", sDupInfo);

                //return "redirect:/authLogin.do";
                return "redirect:/EgovPageLink.do?link=/cmm/00_98";

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

        return "redirect:/EgovPageLink.do?link=/cmm/00_98";

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

    /** 회원가입 테스트용 */
    @RequestMapping(method = RequestMethod.GET, value = "/checkPlusSuccessTest2.do")
    public String checkPlusSuccessTest(HttpServletRequest request,
                                       HttpServletResponse response, ModelMap model,
                                       RedirectAttributes redirectAttr) throws Exception {

        HttpSession session = request.getSession(false);

        LoginVO vo = new LoginVO();
        vo.setIhidNum("MC0GCCqGSIb3DQIJAyEAe5+ccp+AU2Z/tCuLV1lKP1yftGnAI/QTXhwiOrmMtp4=");

        //정상처리...
        //정상처리...
        vo.setName("손정휘");
        vo.setHp("010-4828-4706");

        //로그인세션만들기
        // 2-1. 로그인 정보를 세션에 저장
        session.setAttribute("userVO", vo);
        session.setAttribute("sDupInfo", "MC0GCCqGSIb3DQIJAyEAe5+ccp+AU2Z/tCuLV1lKP1yftGnAI/QTXhwiOrmMtp4=");

        return "redirect:/EgovPageLink.do?link=/cmm/00_98";
    }

    /** 회원가입 테스트용 */
    @RequestMapping(method = RequestMethod.GET, value = "/checkPlusSuccessTest3.do")
    public String checkPlusSuccessTest3(HttpServletRequest request,
                                       HttpServletResponse response, ModelMap model,
                                       RedirectAttributes redirectAttr) throws Exception {

        HttpSession session = request.getSession(false);

        LoginVO vo = new LoginVO();
        vo.setIhidNum("MC0GCCqGSIb3DQIJAyEAe5+ccp+AU2Z/tCuLV1lKP1yftGnAI/QTXhwiOrmMtp4=");

        //정상처리...
        //정상처리...
        vo.setName("손정휘");
        vo.setHp("010-4828-4706");
        vo.setId("TEST2");

        //로그인세션만들기
        // 2-1. 로그인 정보를 세션에 저장
        session.setAttribute("userVO", vo);
        session.setAttribute("sDupInfo", "MC0GCCqGSIb3DQIJAyEAe5+ccp+AU2Z/tCuLV1lKP1yftGnAI/QTXhwiOrmMtp4=");

        return "redirect:/EgovPageLink.do?link=/cmm/00_96";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/checkPlusSuccess3.do")
    public String checkPlusSuccess3(HttpServletRequest request,
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

                //로그인세션만들기
                // 2-1. 로그인 정보를 세션에 저장
                session.setAttribute("userVO", resultVO);
                session.setAttribute("sDupInfo", sDupInfo);

                //return "redirect:/authLogin.do";
                return "redirect:/EgovPageLink.do?link=/cmm/00_96";

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

        return "redirect:/EgovPageLink.do?link=/cmm/00_96";

    }

    /** 비밀번호 변경 메일 발송 */
    @RequestMapping(method = RequestMethod.POST, value = "/user/sendUserEmail.do")
    public ModelAndView sendUserEmail(@ModelAttribute("usreVO") LoginVO userVO,
                                HttpServletRequest request,
                                HttpServletResponse response) throws Exception {

        //UserManageVO userVO2 = (UserManageVO) userManageService.selectUser(userVO.getId());
        Map<String, Object> model = new HashMap<String, Object>();

        try {

            userVO.setUserSe("USR");
            LoginVO userVO2 = loginService.searchId(userVO);

            if (userVO.getId().equals(userVO2.getId())) {

                // 메일발송

                String  pswd = "";
                StringBuffer sb = new StringBuffer();
                StringBuffer sc = new StringBuffer("!@#$%^&*-=?~");  // 특수문자 모음, {}[] 같은 비호감문자는 뺌

                // 대문자 4개를 임의 발생
                sb.append((char)((Math.random() * 26)+65));  // 첫글자는 대문자, 첫글자부터 특수문자 나오면 안 이쁨

                for( int i = 0; i<3; i++) {
                    sb.append((char)((Math.random() * 26)+65));  // 아스키번호 65(A) 부터 26글자 중에서 택일
                }

                // 소문자 4개를 임의발생
                for( int i = 0; i<4; i++) {
                    sb.append((char)((Math.random() * 26)+97)); // 아스키번호 97(a) 부터 26글자 중에서 택일
                }

                // 숫자 2개를 임의 발생
                for( int i = 0; i<2; i++) {
                    sb.append((char)((Math.random() * 10)+48)); //아스키번호 48(1) 부터 10글자 중에서 택일
                }

                // 특수문자를 두개  발생시켜 랜덤하게 중간에 끼워 넣는다
                sb.setCharAt(((int)(Math.random()*3)+1), sc.charAt((int)(Math.random()*sc.length()-1))); //대문자3개중 하나
                sb.setCharAt(((int)(Math.random()*4)+4), sc.charAt((int)(Math.random()*sc.length()-1))); //소문자4개중 하나

                pswd = sb.toString();

                System.out.println("password : " + pswd);

                userVO.setPassword(pswd);
                userVO.setPassword(EgovFileScrty.encryptPassword(userVO.getPassword(), userVO.getId()));
                // 메일전송...
                loginService.updatePassword(userVO);

                String host = egovMessageSource.getMessage("mail.host");
                String port = egovMessageSource.getMessage("mail.smtp.port");
                String email = egovMessageSource.getMessage("mail.id");
                String password = egovMessageSource.getMessage("mail.password");

                Properties props = new Properties();
                props.setProperty("mail.transport.protocol", "smtp");
                props.setProperty("mail.host", host);
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.port", port);
                props.put("mail.smtp.socketFactory.port", port);
                props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                props.put("mail.smtp.socketFactory.fallback", "false");
                props.setProperty("mail.smtp.quitwait", "false");

                Authenticator auth = new Authenticator(){
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(email, password);
                    }
                };

                Session session = Session.getDefaultInstance(props,auth);
                MimeMessage message = new MimeMessage(session);
                message.setSender(new InternetAddress(email));
                message.setSubject("임시비밀번호발급 (진주목공예전수관)");
                message.setRecipient(Message.RecipientType.TO, new InternetAddress(userVO.getEmail()));
                Multipart mp = new MimeMultipart();
                MimeBodyPart mbp1 = new MimeBodyPart();

                String text = "<!DOCTYPE html>\n" +
                        "<html lang=\"ko\">\n" +
                        "<head>\n" +
                        "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n" +
                        "<title>진주목공예전수관</title>\n" +
                        " </head>\n" +
                        "<body>\n" +
                        "\n" +
                        "<div style=\"position:relative;width:700px;margin:0 auto;background:#fff;font-family:'NanumGothic','나눔고딕',NanumGothic,'맑은 고딕','Malgun Gothic','돋움',Dotum,AppleGothic,helvetica,sans-serif;\">\n" +
                        "  <h1 style=\"width:600px;height:37px;padding:32px 0 13px 0;margin:0 auto;\"><img src=\"http://www.jinju.go.kr/mokgong/assets/images/woodcraft/www/email/logo.png\" alt=\"진주목공예전수관\" /></h1>\n" +
                        "  <div style=\"position:relative;width:600px;min-height:350px;height:auto !important;height:350px;margin:0 auto;padding:20px 30px;border:2px solid #dddddd;box-sizing: border-box;line-height:1.3;\">\n" +
                        "\n" +
                        "    <!-- 내용 -->\n" +
                        "      <div style=\"text-align:center;\">\n" +
                        "        <p style=\"font-size:18px;color:#111;font-weight:600;margin:10px 0;\">임시 비밀번호를 발급했습니다.</p>\n" +
                        "\n" +
                        "      </div>\n" +
                        "      <table style=\"width:100%;margin:.666em 0;border:0;border-collapse:collapse;border-top:3px solid #34241e;border-bottom:1px solid #34241e;font-size:14px;\">\n" +
                        "        <col style=\"width:13em\" /><col />\n" +
                        "        <tbody>\n" +
                        "        <tr style=\"border-bottom:1px solid #bbb;\">\n" +
                        "          <th style=\"background-color:#ddd;padding:10px 5px;\">임시비밀번호</th>\n" +
                        "          <td style=\"padding:10px 5px;;font-size:13px;\">"+pswd+"</td>\n" +
                        "        </tr>\n" +
                        "        </tbody>\n" +
                        "      </table>\n" +
                        "    <!-- // 내용 -->\n" +
                        "\n" +
                        "\n" +
                        "    <div style=\"margin:20px 0 10px 0;\">\n" +
                        "      <ul style=\"list-style:none;padding:0;margin:0;\">\n" +
                        "        <li style=\"background:url(http://www.jinju.go.kr/mokgong//assets/images/woodcraft/www/lib/li1bg.png) 0 10px no-repeat;color:#787878;font-size:14px;padding-left:10px;margin:5px 0;\">본 메일은 진주목공예전수관 고객님께 보내는 공지성 메일입니다.</li>\n" +
                        "        <li style=\"background:url(http://www.jinju.go.kr/mokgong//assets/images/woodcraft/www/lib/li1bg.png) 0 10px no-repeat;color:#787878;font-size:14px;padding-left:10px;margin:5px 0;\">발신전용으로 회신되지 않으니 궁금하신 점은 대표전화를 통해 문의하여 주시기 바랍니다.</li>\n" +
                        "      </ul>\n" +
                        "    </div>\n" +
                        "  </div>\n" +
                        "  <div id=\"woodcraft_copyright\" style=\"height:120px;background:#2e2e2e;color:#fff;margin-top:50px;\">\n" +
                        "    <div id=\"authorinfo\" style=\"margin:0 auto;width:640px;padding-top:22px;font-size:14px;line-height: 1.5;\">\n" +
                        "      <address style=\"display:block;padding:0;margin:0;font-style:normal;text-align:center;color:#a2a2a2;\">(52641) 경상남도 진주시 명석면 광제산로 367<br />대표전화 : 055-749-2114 / 팩스 : 055-749-2800</address>\n" +
                        "      <address class=\"copyright\" style=\"display:block;padding:0;margin:0;font-style:normal;text-align:center;color:#fff;padding-top:5px;font-weight:bold;\">COPYRIGHT (C) 2018 BY Jinju City ALL RIGHTS RESERVED.</address>\n" +
                        "    </div>    \n" +
                        "  </div>\n" +
                        "</div>\n" +
                        "\n" +
                        "\n" +
                        "\n" +
                        "</body>\n" +
                        "</html>";

                //mbp1.setText("임시비밀번호 : " + pswd);
                mbp1.setContent(text, "text/html; charset=utf-8");

                mp.addBodyPart(mbp1);
                message.setContent(mp);
                Transport.send(message);

                model.put("msgCd", "OK");
                return new ModelAndView("/cmm/00_07", model);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        model.put("msgCd", "NG");
        return new ModelAndView("/cmm/00_07", model);
    }

}
