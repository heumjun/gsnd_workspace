package kr.go.gyeongnam.human.controller.mypage;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.go.gyeongnam.human.constant.HumanConstant;
import kr.go.gyeongnam.human.dto.exprn.ReqDto;
import kr.go.gyeongnam.human.dto.mypage.BsktDto;
import kr.go.gyeongnam.human.dto.mypage.criteria.BsktCriteria;
import kr.go.gyeongnam.human.dto.wcrf.WcrfBuyDto;
import kr.go.gyeongnam.human.dto.wcrf.WcrfDto;
import kr.go.gyeongnam.human.dto.wcrf.WcrfRefdDto;
import kr.go.gyeongnam.human.dto.wcrf.criteria.WcrfBuyCriteria;
import kr.go.gyeongnam.human.service.exprn.ReqService;
import kr.go.gyeongnam.human.service.mypage.BsktService;
import kr.go.gyeongnam.human.service.wcrf.WcrfBuyService;
import kr.go.gyeongnam.human.service.wcrf.WcrfRefdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 마이페이지 Controller
 */
@Controller
@RequestMapping("/mypage")
public class MypageController {

    @Autowired
    private BsktService bsktService;

    @Resource(name="propertiesService")
    private EgovPropertyService propertyService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    @Autowired
    private WcrfBuyService wcrfBuyService;

    @Autowired
    private WcrfRefdService wcrfRefdService;

    @Autowired
    private ReqService reqService;

    /** userManageService */
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;

    /** EgovLoginService */
    @Resource(name = "loginService")
    private EgovLoginService loginService;

    /**
     * 나의 정보
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/myInfo.do")
    public ModelAndView getMyInfo(HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("userVO", loginVO);

        return new ModelAndView("/mypage/07_01", model);
    }

    /**
     * 목공예품 결재(임시 페이지)
     * 결재모듈 확인 후 공통으로 변경 가능
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/userInfoSave.do")
    public ModelAndView userInfoSave(@ModelAttribute("usreVO") LoginVO userVO,
                                     HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        UserManageVO userManageVO = userManageService.selectUser(userVO.getUniqId());
        //고유아이디 셋팅
        userManageVO.setPassword(userVO.getPassword());

        //패스워드 암호화
        //String pass = EgovFileScrty.encryptPassword(userManageVO.getPassword(), userManageVO.getEmplyrId());
        //userManageVO.setPassword(pass);

        userManageVO.setEmplyrNm(userVO.getName());

        userManageVO.setMoblphonNo(userVO.getHp());
        // HOUSE_ADRES
        userManageVO.setHomeadres(userVO.getAdres()+userVO.getAdresDtl());
        // ZIP
        userManageVO.setZip(userVO.getZip());

        //없으면 신규생성
        userManageService.updateUser(userManageVO);

        userManageService.updatePassword(userManageVO);

        //로그인유저
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("userVO", userVO);

        return new ModelAndView("/mypage/07_01", model);
    }

    /**
     * 장바구니
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfBskt.do")
    public ModelAndView getWcrfBskt(HttpServletRequest req,
                                  HttpServletResponse rep) throws Exception {

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        BsktCriteria bsktCriteria = new BsktCriteria();
        bsktCriteria.setMberId(loginVO.getId());

        List<BsktDto> retList = bsktService.getBsktList(bsktCriteria);

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("resultList", retList);
        model.put("sum", sumPrice(retList));
        model.put("resultCnt", retList.size());

        return new ModelAndView("/mypage/07_02", model);
    }

    /**
     * 목공예 구매내역
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfMyPayList.do")
    public ModelAndView getWcrfMyPayList(@ModelAttribute("frmSearch") WcrfBuyCriteria wcrfBuyCriteria,
                                         @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        wcrfBuyCriteria.setRgstrId(loginVO.getId());

        if (pageIndex!= null)
            wcrfBuyCriteria.setPageIndex(Integer.parseInt(pageIndex));

        wcrfBuyCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        wcrfBuyCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(wcrfBuyCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(wcrfBuyCriteria.getPageUnit());
        paginationInfo.setPageSize(wcrfBuyCriteria.getPageSize());

        wcrfBuyCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        wcrfBuyCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        wcrfBuyCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> retMap = bsktService.getWcrfBuyListMap(wcrfBuyCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", wcrfBuyCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mypage/07_03", modelMap);
    }

    /**
     * 목공예 구매내역 상세
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfMyPayView.do")
    public ModelAndView getWcrfMyPayView(@RequestParam Map<String, String> commandMap,
                                         HttpServletRequest req,
                                         HttpServletResponse rep) throws Exception {

        //LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        String purchsLstId = (String)commandMap.get("purchsLstId");

        WcrfBuyDto wcrfBuyDto = new WcrfBuyDto();
        wcrfBuyDto.setPurchsLstId(purchsLstId);

        wcrfBuyDto = wcrfBuyService.getWcrfBuyTot(wcrfBuyDto);

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD001");
        vo.setCode(wcrfBuyDto.getSetleSe());
        List<CmmnDetailCode> list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfBuyDto.setSetleSeNm(code.getCodeNm());
        }

        Map<String,Object> model = new HashMap<String, Object>();

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD002");
        vo.setCode(wcrfBuyDto.getPurchsProgrsSttus());
        list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfBuyDto.setPurchsProgrsSttusNm(code.getCodeNm());
        }

        model.put("WcrfBuyForm", wcrfBuyDto);

        List<WcrfDto> retList = wcrfBuyService.getWcrfBuyList(wcrfBuyDto);
        model.put("wcrfBuyList", retList);
        model.put("sum", sumPrice2(retList));

        WcrfRefdDto wcrfRefdDto = new WcrfRefdDto();
        wcrfRefdDto.setPurchsLstId(wcrfBuyDto.getPurchsLstId());

        wcrfRefdDto = wcrfRefdService.getWcrfRefd(wcrfRefdDto);

        if (wcrfRefdDto == null) {
            wcrfRefdDto = new WcrfRefdDto();
            wcrfRefdDto.setRefdSttusCd("01");

            SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy/MM/dd", Locale.KOREA );
            Date currentTime = new Date ();
            String mTime = mSimpleDateFormat.format ( currentTime );

            wcrfRefdDto.setRefdReqDt(mTime);

            model.put("WcrfRefdForm", wcrfRefdDto);
        } else {
            model.put("WcrfRefdForm", wcrfRefdDto);
        }

        return new ModelAndView("/mypage/07_06", model);
    }

    /**
     * 목공예 구매 취소 및 환불
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfRefdSave.do")
    public String getWcrfRefdSave(@ModelAttribute("WcrfRefdForm") WcrfRefdDto wcrfRefdDto,
                                         HttpServletRequest req,
                                         HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        wcrfRefdDto.setRgstrId(loginVO.getId());
        wcrfRefdDto.setUpdtrId(loginVO.getId());

        // 취소반품진행상태 - 신청
        wcrfRefdDto.setRefdSttusCd("01");

        wcrfRefdService.saveWcrfRefd(wcrfRefdDto);

        // 상태값변경
        // 결제완료,발송준비 -> 결제취소요청(06)
        // 발송완료 -> 환불요청(07)

        WcrfBuyDto wcrfBuyDto = new WcrfBuyDto();
        wcrfBuyDto.setPurchsLstId(wcrfRefdDto.getPurchsLstId());
        if (wcrfRefdDto.getPurchsProgrsSttus().equals("05")) {
            wcrfBuyDto.setPurchsProgrsSttus("07");
        } else {
            wcrfBuyDto.setPurchsProgrsSttus("06");
        }
        wcrfBuyDto.setUpdtrId(loginVO.getId());

        wcrfBuyService.updateWcrfBuyTot(wcrfBuyDto);

        return "redirect:/mypage/wcrfMyPayList.do";
    }

    /**
     * 체험 신청/취소
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnMyList.do")
    public ModelAndView getExprnMyList(@ModelAttribute("frmSearch") WcrfBuyCriteria wcrfBuyCriteria,
                                       @RequestParam(value="pageIndex",required = false) String pageIndex,
                                       HttpServletRequest req,
                                         HttpServletResponse rep) throws Exception {

        if (!EgovUserDetailsHelper.isAuthenticated()) {
            ModelAndView mv = new ModelAndView();

            String beforeURL = req.getRequestURL().toString().replace(req.getScheme() + "://" + req.getHeader("Host") + req.getContextPath(), "");
            Enumeration e = req.getParameterNames();
            int index = 1;
            while (e.hasMoreElements()) {
                String paramName = (String) e.nextElement();
                String value = URLEncoder.encode(req.getParameter(paramName), "UTF-8");
                if (index == 1)
                    beforeURL += "?" + paramName + "=" + value;
                else
                    beforeURL += "&" + paramName + "=" + value;

                index++;
            }

            req.getSession().setAttribute(HumanConstant.SessionAttribute.BEFORE_LOGIN_URL, beforeURL);

            mv.setViewName("redirect:/login.do");
            return mv;
        }

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        wcrfBuyCriteria.setRgstrId(loginVO.getId());

        if (pageIndex!= null)
            wcrfBuyCriteria.setPageIndex(Integer.parseInt(pageIndex));

        wcrfBuyCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        wcrfBuyCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(wcrfBuyCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(wcrfBuyCriteria.getPageUnit());
        paginationInfo.setPageSize(wcrfBuyCriteria.getPageSize());

        wcrfBuyCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        wcrfBuyCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        wcrfBuyCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        wcrfBuyCriteria.setTypeCd("01");

        Map<String, Object> retMap = bsktService.getExprnReqListMap(wcrfBuyCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", wcrfBuyCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mypage/07_04", modelMap);
    }

    /**
     * 목공예 구매내역 상세
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnMyPayView.do")
    public ModelAndView getExprnMyPayView(@RequestParam Map<String, String> commandMap,
                                         HttpServletRequest req,
                                         HttpServletResponse rep) throws Exception {

        //LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        String purchsLstId = (String)commandMap.get("purchsLstId");

        ReqDto reqDto = new ReqDto();
        reqDto.setExprnReqstId(purchsLstId);
        WcrfBuyDto wcrfBuyDto = reqService.getReqPay(reqDto);

        Map<String,Object> model = new HashMap<String, Object>();

        model.put("WcrfBuyForm", wcrfBuyDto);
        model.put("sum", wcrfBuyDto.getPurchsAllAmt());

        WcrfRefdDto wcrfRefdDto = new WcrfRefdDto();
        wcrfRefdDto.setPurchsLstId(wcrfBuyDto.getPurchsLstId());

        wcrfRefdDto = wcrfRefdService.getWcrfRefd(wcrfRefdDto);

        if (wcrfRefdDto == null) {
            wcrfRefdDto = new WcrfRefdDto();
            wcrfRefdDto.setRefdSttusCd("01");

            SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy/MM/dd", Locale.KOREA );
            Date currentTime = new Date ();
            String mTime = mSimpleDateFormat.format ( currentTime );

            wcrfRefdDto.setRefdReqDt(mTime);

            model.put("WcrfRefdForm", wcrfRefdDto);
        } else {
            model.put("WcrfRefdForm", wcrfRefdDto);
        }

        return new ModelAndView("/mypage/07_07", model);
    }

    /**
     * 목공예 구매 취소 및 환불
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnRefdSave.do")
    public String getExprnRefdSave(@ModelAttribute("WcrfRefdForm") WcrfRefdDto wcrfRefdDto,
                                  HttpServletRequest req,
                                  HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        wcrfRefdDto.setRgstrId(loginVO.getId());
        wcrfRefdDto.setUpdtrId(loginVO.getId());

        // 취소반품진행상태 - 신청
        wcrfRefdDto.setRefdSttusCd("01");

        wcrfRefdService.saveWcrfRefd(wcrfRefdDto);

        // 상태값변경
        ReqDto reqDto = new ReqDto();
        reqDto.setExprnReqstId(wcrfRefdDto.getPurchsLstId());
        reqDto.setReqSttus("05");
        reqDto.setUpdtrId(loginVO.getId());

        reqService.updateReq(reqDto);

        return "redirect:/mypage/exprnMyList.do";
    }

    /**
     * 프로그램 신청/취소
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgmMyList.do")
    public ModelAndView getPrgmMyList(@ModelAttribute("frmSearch") WcrfBuyCriteria wcrfBuyCriteria,
                                      @RequestParam(value="pageIndex",required = false) String pageIndex,
                                        HttpServletRequest req,
                                       HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        wcrfBuyCriteria.setRgstrId(loginVO.getId());

        if (pageIndex!= null)
            wcrfBuyCriteria.setPageIndex(Integer.parseInt(pageIndex));

        wcrfBuyCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        wcrfBuyCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(wcrfBuyCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(wcrfBuyCriteria.getPageUnit());
        paginationInfo.setPageSize(wcrfBuyCriteria.getPageSize());

        wcrfBuyCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        wcrfBuyCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        wcrfBuyCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        wcrfBuyCriteria.setTypeCd("02");

        Map<String, Object> retMap = bsktService.getExprnReqListMap(wcrfBuyCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", wcrfBuyCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mypage/07_05", modelMap);
    }

    /**
     * 목공예 구매내역 상세
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgmMyPayView.do")
    public ModelAndView getPrgmMyPayView(@RequestParam Map<String, String> commandMap,
                                          HttpServletRequest req,
                                          HttpServletResponse rep) throws Exception {

        //LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        String purchsLstId = (String)commandMap.get("purchsLstId");

        ReqDto reqDto = new ReqDto();
        reqDto.setExprnReqstId(purchsLstId);
        WcrfBuyDto wcrfBuyDto = reqService.getReqPay(reqDto);

        Map<String,Object> model = new HashMap<String, Object>();

        model.put("WcrfBuyForm", wcrfBuyDto);
        model.put("sum", wcrfBuyDto.getPurchsAllAmt());

        WcrfRefdDto wcrfRefdDto = new WcrfRefdDto();
        wcrfRefdDto.setPurchsLstId(wcrfBuyDto.getPurchsLstId());

        wcrfRefdDto = wcrfRefdService.getWcrfRefd(wcrfRefdDto);

        if (wcrfRefdDto == null) {
            wcrfRefdDto = new WcrfRefdDto();
            wcrfRefdDto.setRefdSttusCd("01");

            SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy/MM/dd", Locale.KOREA );
            Date currentTime = new Date ();
            String mTime = mSimpleDateFormat.format ( currentTime );

            wcrfRefdDto.setRefdReqDt(mTime);

            model.put("WcrfRefdForm", wcrfRefdDto);
        } else {
            model.put("WcrfRefdForm", wcrfRefdDto);
        }

        return new ModelAndView("/mypage/07_08", model);
    }

    /**
     * 목공예 구매 취소 및 환불
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgmRefdSave.do")
    public String getPrgmRefdSave(@ModelAttribute("WcrfRefdForm") WcrfRefdDto wcrfRefdDto,
                                   HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        wcrfRefdDto.setRgstrId(loginVO.getId());
        wcrfRefdDto.setUpdtrId(loginVO.getId());

        // 취소반품진행상태 - 신청
        wcrfRefdDto.setRefdSttusCd("01");

        wcrfRefdService.saveWcrfRefd(wcrfRefdDto);

        // 상태값변경
        ReqDto reqDto = new ReqDto();
        reqDto.setExprnReqstId(wcrfRefdDto.getPurchsLstId());
        reqDto.setReqSttus("05");
        reqDto.setUpdtrId(loginVO.getId());

        reqService.updateReq(reqDto);

        return "redirect:/mypage/prgmMyList.do";

    }

    /**
     * 목공예품 결재성공
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfBsktAdd.do")
    public ModelAndView wcrfBsktAdd(
            @RequestParam Map<String, String> commandMap,
            HttpServletRequest req,
            HttpServletResponse rep) throws Exception {

        String wcrfId = (String)commandMap.get("wcrfId");
        String wcrfCnt = (String)commandMap.get("wcrfCnt");

        ModelAndView mav = new ModelAndView("jsonView");

        if(!EgovUserDetailsHelper.isAuthenticated()) {
            //미인증 상태
            mav.addObject("status", "fail");
            String referer = req.getHeader("referer").replace(req.getScheme() + "://" + req.getHeader("Host") + req.getContextPath(),"");

            req.getSession().setAttribute(HumanConstant.SessionAttribute.BEFORE_LOGIN_URL, referer);

            return mav;
        }

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        BsktDto bsktDto = new BsktDto();
        bsktDto.setWcrfId(wcrfId);
        bsktDto.setQy(wcrfCnt);
        bsktDto.setMberId(loginVO.getId());
        bsktDto.setRgstrId(loginVO.getId());
        bsktDto.setUpdtrId(loginVO.getId());

        WcrfDto wcrfDto = bsktService.getBskt(bsktDto);
        if (wcrfDto != null && !EgovStringUtil.isEmpty(wcrfDto.getWcrfId())) {
            //장바구니 중복
            mav.addObject("status", "duplicate");
            return mav;
        }

        //장바구니 추가
        bsktService.saveBskt(bsktDto);

        //정상상태이면 상태값 반환
        mav.addObject("status", "success");

        return mav;
    }

    /**
     * 장바구니
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfBsktUpdate.do")
    public ModelAndView getWcrfBskt(@RequestParam Map<String, String> commandMap,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        String bsktId = (String)commandMap.get("bsktId");
        String qy = (String)commandMap.get("qy");

        BsktDto bsktDto = new BsktDto();
        bsktDto.setBsktId(bsktId);
        bsktDto.setQy(qy);
        bsktDto.setUpdtrId(loginVO.getId());

        bsktService.saveBskt(bsktDto);

        BsktCriteria bsktCriteria = new BsktCriteria();
        bsktCriteria.setMberId(loginVO.getId());

        List<BsktDto> retList = bsktService.getBsktList(bsktCriteria);

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("resultList", retList);
        model.put("sum", sumPrice(retList));

        return new ModelAndView("/mypage/07_02", model);
    }

    /**
     * 장바구니
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfBsktDelete.do")
    public ModelAndView getWcrfBsktDelete(
                                    @RequestParam Map<String, String> commandMap,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        String bsktId = (String)commandMap.get("bsktId");

        if (EgovStringUtil.isEmpty(bsktId)) {

            String bsktIdList = (String)commandMap.get("bsktIdList");
            String[] array = bsktIdList.split(",");
            for (String bsktId2 : array) {

                if (EgovStringUtil.isEmpty(bsktId2)) continue;

                BsktDto bsktDto = new BsktDto();
                bsktDto.setBsktId(bsktId2);

                bsktService.deleteBskt(bsktDto);
            }

        } else {
            BsktDto bsktDto = new BsktDto();
            bsktDto.setBsktId(bsktId);

            bsktService.deleteBskt(bsktDto);
        }

        BsktCriteria bsktCriteria = new BsktCriteria();
        bsktCriteria.setMberId(loginVO.getId());

        List<BsktDto> retList = bsktService.getBsktList(bsktCriteria);

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("resultList", retList);
        model.put("sum", sumPrice(retList));

        return new ModelAndView("/mypage/07_02", model);
    }

    private int sumPrice(List<BsktDto> retList) {

        int sum = 0;
        for (BsktDto bsktDto : retList) {
            sum = sum + (Integer.parseInt(bsktDto.getWcrfAmt()) * Integer.parseInt(bsktDto.getQy()));
        }
        return sum;
    }

    private int sumPrice2(List<WcrfDto> retList) {

        int sum = 0;
        for (WcrfDto wcrfDto : retList) {
            sum = sum + (Integer.parseInt(wcrfDto.getWcrfAmt()) * Integer.parseInt(wcrfDto.getWcrfCnt()));
        }
        return sum;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/userOutRegist.do")
    public ModelAndView userOutRegist(HttpServletRequest request,
                               HttpServletResponse response) throws Exception {

        return new ModelAndView("/mypage/07_09");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/userOutSave.do")
    public ModelAndView userOutSave(@ModelAttribute("usreVO") LoginVO userVO,
                                HttpServletRequest request,
                               HttpServletResponse response) throws Exception {


        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        userVO.setId(loginVO.getId());
        userVO = loginService.actionLogin(userVO);
        if (userVO != null) {

            userManageService.deleteUser("USR03:" + loginVO.getUniqId());

            ((HttpServletRequest)request).getSession().setAttribute("loginVO", null);
            /**
             * @WOODCRAFT 로그인 이후 메뉴 초기화
             */
            HttpServletRequest httpServletRequest = ((HttpServletRequest)request);
            EgovSessionCookieUtil.removeSessionAttribute(httpServletRequest, HumanConstant.SessionAttribute.ALL_MENU_LIST);
            EgovSessionCookieUtil.removeSessionAttribute(httpServletRequest, HumanConstant.SessionAttribute.MENU_LIST);

            return new ModelAndView("redirect:/egov_security_logout");
        }

        return new ModelAndView("/mypage/07_09");
    }
}
