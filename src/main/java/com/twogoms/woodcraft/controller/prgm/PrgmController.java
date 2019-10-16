package com.twogoms.woodcraft.controller.prgm;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import com.twogoms.woodcraft.constant.WoodCraftConstant;
import com.twogoms.woodcraft.dto.exprn.ExprnDto;
import com.twogoms.woodcraft.dto.exprn.ReqDto;
import com.twogoms.woodcraft.dto.exprn.criteria.ExprnCriteria;
import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;
import com.twogoms.woodcraft.service.exprn.ExprnService;
import com.twogoms.woodcraft.service.exprn.ReqService;
import com.twogoms.woodcraft.service.wcrf.WcrfBuyService;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 프로그램 Controller
 */
@Controller
@RequestMapping("/prgm")
public class PrgmController {

    /** EgovMessageSource */
    @Resource(name = "egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Autowired
    private ExprnService prgmService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    @Autowired
    private WcrfBuyService wcrfBuyService;

    @Autowired
    private ReqService reqService;

    @Resource(name = "wcrfOrerSeqGnrService")
    private EgovIdGnrService wcrfOrerSeqGnrService;

    @Autowired
    private EgovFileMngService egovFileMngService;

    /**
     * 교육 프로그램 안내
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgmIntro.do")
    public ModelAndView getPrgmIntro(HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        ExprnCriteria prgmCriteria = new ExprnCriteria();
        prgmCriteria.setTypeCd("02");

        Map<String, Object> retMap = prgmService.getExprnPgmListMap(prgmCriteria);

        long time = System.currentTimeMillis();
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyy/MM/dd");
        String strDay = dayTime.format(new Date(time));

        model.put("resultList01", retMap.get("retList01"));
        model.put("resultList02", retMap.get("retList02"));
        model.put("resultList03", retMap.get("retList03"));

        model.put("retListCnt01", retMap.get("retListCnt01"));
        model.put("retListCnt02", retMap.get("retListCnt02"));
        model.put("retListCnt03", retMap.get("retListCnt03"));

        model.put("strDay", strDay);

        return new ModelAndView("/prgm/04_01", model);
    }

    /**
     * 교육 프로그램 리스트
     * @param prgmCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgmList.do")
    public ModelAndView getPrgmList(@ModelAttribute("frmSearch")ExprnCriteria prgmCriteria,
                                    @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        if (pageIndex!= null)
            prgmCriteria.setPageIndex(Integer.parseInt(pageIndex));

        prgmCriteria.setPageUnit(10);
        prgmCriteria.setPageSize(10);

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(prgmCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(prgmCriteria.getPageUnit());
        paginationInfo.setPageSize(prgmCriteria.getPageSize());

        prgmCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        prgmCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        prgmCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        //프로그램
        prgmCriteria.setTypeCd("02");

        Map<String, Object> retMap = prgmService.getExprnListMap(prgmCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        long time = System.currentTimeMillis();
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyy/MM/dd");
        String strDay = dayTime.format(new Date(time));

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", prgmCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);
        modelMap.put("strDay", strDay);

        return new ModelAndView("/prgm/04_02", modelMap);
    }

    /**
     * 교육 프로그램 상세
     * @param prgmDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgmView.do")
    public ModelAndView getPrgmView(@ModelAttribute("PrgmForm") ExprnDto prgmDto,
                                     HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        prgmDto = prgmService.getExprn(prgmDto);

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("PrgmForm", prgmDto);

        if(prgmDto.getAtchFileId() !=null){
            String file_id = prgmDto.getAtchFileId();
            FileVO fvo;

            if(!file_id.equals("")){
                fvo = new FileVO();
                fvo.setAtchFileId(file_id);
                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                model.put("fileResult",fRS);
            }
        }

        long time = System.currentTimeMillis();
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyy/MM/dd");
        String strDay = dayTime.format(new Date(time));
        model.put("strDay", strDay);

        return new ModelAndView("/prgm/04_03", model);
    }

    /**
     * 교육 프로그램 결재
     * @param prgmDto
     * @param commandMap
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgmPay.do")
    public ModelAndView getPrgmPay(@ModelAttribute("PrgmForm") ExprnDto prgmDto,
                                   @RequestParam Map<String, String> commandMap,
                                    HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        Map<String,Object> model = new HashMap<String, Object>();

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

            req.getSession().setAttribute(WoodCraftConstant.SessionAttribute.BEFORE_LOGIN_URL, beforeURL);

            mv.setViewName("redirect:/login.do");
            return mv;
        }

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        prgmDto = prgmService.getExprn(prgmDto);
        model.put("PrgmForm", prgmDto);

        ReqDto reqDto = new ReqDto();

        reqDto.setReqNm(loginVO.getName());
        reqDto.setReqEmail(loginVO.getEmail());
        if (!EgovStringUtil.isEmpty(loginVO.getHp()) && loginVO.getHp().length() >= 12) {
            String[] array = loginVO.getHp().split("-");
            reqDto.setTelNo(array[0]);
            reqDto.setTelNoMid(array[1]);
            reqDto.setTelNoLast(array[2]);
        }

        model.put("ReqForm", reqDto);

        return new ModelAndView("/prgm/04_04", model);
    }

    /**
     * 교육 프로그램 결재정보 저장
     * @param reqDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgmListSave.do")
    public ModelAndView prgmListSave(@ModelAttribute("ReqForm") ReqDto reqDto,
                                      HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        reqDto.setRgstrId(loginVO.getId());
        reqDto.setUpdtrId(loginVO.getId());
        reqDto.setMberId(loginVO.getId());

        //storeDelngId
        String storeDelngId = "ORDR_"+wcrfOrerSeqGnrService.getNextStringId().substring(4,14);

        String setleSe = reqDto.getSetleSe();
        String cashReceiptsOpt = reqDto.getCashReceiptsOpt();

        reqDto.setStoreDelngId(storeDelngId);
        reqDto.setSetleSe(setleSe);
        reqDto.setCashReceiptsOpt(cashReceiptsOpt);
        reqService.saveReq(reqDto);

        reqDto.setReqNm(loginVO.getName());
        reqDto.setReqEmail(loginVO.getEmail());
        reqDto.setTelNo(loginVO.getHp());

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("ReqForm", reqDto);
        model.put("orerAddr", loginVO.getAdres());
        model.put("orerZip", loginVO.getZip());
        model.put("storeDelngId", storeDelngId);

        model.put("setleSe", setleSe);

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD001");
        vo.setCode(setleSe);
        List<CmmnDetailCode> list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            model.put("setleSeNm", code.getCodeNm());
        }

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD009");
        vo.setCode(cashReceiptsOpt);
        list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            model.put("cashReceiptsOptNm", code.getCodeNm());
        }

        return new ModelAndView("/prgm/04_12", model);
    }

    /**
     * 교육 프로그램 결재
     * @param reqDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgmPaySave.do")
    public ModelAndView prgmPaySave(@ModelAttribute("ReqForm") ReqDto reqDto,
                                     HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        WcrfBuyDto wcrfBuyDto = reqService.getReqPay(reqDto);

        // 주문확인 처리 (무통자입금의 경우 결제대기로 변경)
        if (wcrfBuyDto.getSetleSe().equals("02")) {

            wcrfBuyDto.setCmd("EXPRN");

            wcrfBuyDto.setPurchsProgrsSttus("02");
            wcrfBuyDto.setSetleAmt("0");
            wcrfBuyDto.setCardConfmNo(null);

            //로그인유저
            LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
            wcrfBuyDto.setUpdtrId(loginVO.getId());
            wcrfBuyService.savePayComplete(wcrfBuyDto);
        }

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("WcrfBuyForm", wcrfBuyDto);

        return new ModelAndView("/prgm/04_13", model);
    }

    /**
     * 교육 프로그램 결제성공
     * @param commandMap
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/payComplete.do")
    public ModelAndView payComplete(
            @RequestParam Map<String, String> commandMap,
            HttpServletResponse rep) throws Exception {

        //ajax통신
        String imp_uid = (String)commandMap.get("imp_uid");
        String merchant_uid = (String)commandMap.get("merchant_uid");

        //System.out.println(imp_uid);
        //System.out.println(merchant_uid);

        String test_api_key = egovMessageSource.getMessage("api.key");
        String test_api_secret = egovMessageSource.getMessage("api.secret");
        IamportClient client = new IamportClient(test_api_key, test_api_secret);

        String test_imp_uid = imp_uid;

        IamportResponse<Payment> payment_response = client.paymentByImpUid(test_imp_uid);
        System.out.println(payment_response.getResponse());
        System.out.println(test_imp_uid + " " + payment_response.getResponse().getImpUid());

        Payment payment = payment_response.getResponse();

        //DB에 있는 금액과 비교
        ReqDto reqDto = new ReqDto();
        reqDto.setStoreDelngId(payment.getMerchantUid());
        WcrfBuyDto wcrfBuyDto = reqService.getReqPay(reqDto);

        //wcrfBuyDto.getPurchsAllAmt();

        boolean flag = false;
        if ("01".equals(wcrfBuyDto.getSetleSe())) {
            if ("card".equals(payment.getPayMethod())) {
                if (wcrfBuyDto.getPurchsAllAmt().equals(String.valueOf(payment.getAmount()))) {
                    flag = true;
                }
            }
        }

        //결제정보 DB에 등록 및 상태값 변경(01 -> 03)

        ModelAndView mav = new ModelAndView("jsonView");

        if (flag) {
            //체험
            wcrfBuyDto.setCmd("EXPRN");

            wcrfBuyDto.setPurchsProgrsSttus("03");
            wcrfBuyDto.setSetleAmt(String.valueOf(payment.getAmount()));
            wcrfBuyDto.setCardConfmNo(payment.getApplyNum());

            //로그인유저
            LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
            wcrfBuyDto.setUpdtrId(loginVO.getId());
            wcrfBuyDto.setStoreDelngId(payment.getMerchantUid());
            wcrfBuyService.savePayComplete(wcrfBuyDto);

            //정상상태이면 상태값 반환
            mav.addObject("status", "success");
            mav.addObject("exprnReqstId", wcrfBuyDto.getPurchsLstId());
            mav.addObject("storeDelngId", payment.getMerchantUid());

        } else {
            mav.addObject("status", "fail");
        }

        return mav;
    }

}
