package kr.go.gyeongnam.human.controller.wcrf;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.go.gyeongnam.human.constant.WoodCraftConstant;
import kr.go.gyeongnam.human.dto.mypage.BsktDto;
import kr.go.gyeongnam.human.dto.wcrf.WcrfBuyDto;
import kr.go.gyeongnam.human.dto.wcrf.WcrfDto;
import kr.go.gyeongnam.human.dto.wcrf.criteria.WcrfCriteria;
import kr.go.gyeongnam.human.service.mypage.BsktService;
import kr.go.gyeongnam.human.service.wcrf.WcrfBuyService;
import kr.go.gyeongnam.human.service.wcrf.WcrfService;
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
import java.util.*;

/**
 * 목공예품 Controller
 */
@Controller
@RequestMapping("/wcrf")
public class WcrfController {

    /** EgovMessageSource */
    @Resource(name = "egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name="propertiesService")
    private EgovPropertyService propertyService;

    @Autowired
    private WcrfService wcrfService;

    @Autowired
    private WcrfBuyService wcrfBuyService;

    @Autowired
    private BsktService bsktService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    @Autowired
    private EgovFileMngService egovFileMngService;

    /**
     * 목공예란
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfIntro.do")
    public ModelAndView getWcrfIntro(HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/wcrf/03_01", model);
    }

    /**
     * 목공예품 리스트
     * @param wcrfCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfList.do")
    public ModelAndView getWcrfList(@ModelAttribute("frmSearch") WcrfCriteria wcrfCriteria,
                                    @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        //LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            wcrfCriteria.setPageIndex(Integer.parseInt(pageIndex));

        wcrfCriteria.setPageUnit(8);
        wcrfCriteria.setPageSize(10);

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(wcrfCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(wcrfCriteria.getPageUnit());
        paginationInfo.setPageSize(wcrfCriteria.getPageSize());

        wcrfCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        wcrfCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        wcrfCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> retMap = wcrfService.getWcrfListMap(wcrfCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", wcrfCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/wcrf/03_03", modelMap);
    }

    /**
     * 목공예품 상세화면
     * @param wcrfCriteria
     * @param wcrfDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfPay.do")
    public ModelAndView getWcrfPay(@ModelAttribute("frmSearch") WcrfCriteria wcrfCriteria,
                                    @ModelAttribute("WcrfForm") WcrfDto wcrfDto,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        wcrfDto = wcrfService.getWcrf(wcrfDto);

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("WcrfForm", wcrfDto);
        model.put("frmSearch", wcrfCriteria);

        if(wcrfDto.getAtchFileId() !=null){
            String file_id = wcrfDto.getAtchFileId();
            FileVO fvo;

            if(!file_id.equals("")){
                fvo = new FileVO();
                fvo.setAtchFileId(file_id);
                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                model.put("fileResult",fRS);
            }
        }

        return new ModelAndView("/wcrf/03_04", model);
    }

    /**
     * 목공예품 결재등록
     * @param wcrfDto
     * @param commandMap
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfPayList.do")
    public ModelAndView getWcrfPayList(@ModelAttribute("WcrfForm") WcrfDto wcrfDto,
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

        WcrfBuyDto wcrfBuyDto = new WcrfBuyDto();
        List<WcrfDto> resultList = new ArrayList<WcrfDto>();

        if (!EgovStringUtil.isEmpty(wcrfDto.getWcrfId())) {

            String qy = wcrfDto.getWcrfCnt();

            wcrfDto = wcrfService.getWcrf(wcrfDto);
            wcrfDto.setWcrfCnt(qy);
            String menuNo = "11303000";
            model.put("menuNo", menuNo);
            model.put("WcrfForm", wcrfDto);

            resultList.add(wcrfDto);

        } else {

            String bsktIdList = (String)commandMap.get("bsktIdList");
            String[] array = bsktIdList.split(",");
            for (String bsktId2 : array) {

                if (EgovStringUtil.isEmpty(bsktId2)) continue;

                BsktDto bsktDto = new BsktDto();
                bsktDto.setBsktId(bsktId2);

                wcrfDto = bsktService.getBskt(bsktDto);
                resultList.add(wcrfDto);
            }

            String menuNo = "11702000";
            model.put("menuNo", menuNo);
            model.put("bsktIdList", bsktIdList);
        }

        model.put("resultList", resultList);
        model.put("sum", sumPrice(resultList));

        wcrfBuyDto.setByerNm(loginVO.getName());
        wcrfBuyDto.setByerEmail(loginVO.getEmail());
        if (!EgovStringUtil.isEmpty(loginVO.getHp()) && loginVO.getHp().length() >= 12) {
            String[] array = loginVO.getHp().split("-");
            wcrfBuyDto.setByerTelNo(array[0]);
            wcrfBuyDto.setByerTelNoMid(array[1]);
            wcrfBuyDto.setByerTelNoLast(array[2]);
        }

        wcrfBuyDto.setOrerNm(loginVO.getName());
        wcrfBuyDto.setOrerZip(loginVO.getZip());
        wcrfBuyDto.setOrerAddr(loginVO.getAdres());
        wcrfBuyDto.setOrerAddrDtl(loginVO.getAdresDtl());
        if (!EgovStringUtil.isEmpty(loginVO.getHp()) && loginVO.getHp().length() >= 12) {
            String[] array = loginVO.getHp().split("-");
            wcrfBuyDto.setOrerTelNo(array[0]);
            wcrfBuyDto.setOrerTelNoMid(array[1]);
            wcrfBuyDto.setOrerTelNoLast(array[2]);
        }

        model.put("WcrfBuyForm", wcrfBuyDto);

        return new ModelAndView("/wcrf/03_05", model);
    }

    private int sumPrice(List<WcrfDto> resultList) {

        int sum = 0;
        for (WcrfDto wcrfDto : resultList) {
            sum = sum + (Integer.parseInt(wcrfDto.getWcrfAmt()) * Integer.parseInt(wcrfDto.getWcrfCnt()));
        }
        return sum;
    }

    /**
     * 목공예품 결재확인
     * @param wcrfBuyDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfListSave.do")
    public ModelAndView wcrfListSave(@ModelAttribute("WcrfBuyForm") WcrfBuyDto wcrfBuyDto,
                                       HttpServletRequest req,
                                       HttpServletResponse rep) throws Exception {

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        wcrfBuyDto.setRgstrId(loginVO.getId());
        wcrfBuyDto.setUpdtrId(loginVO.getId());
        wcrfBuyDto.setMberId(loginVO.getId());

        wcrfBuyDto = wcrfBuyService.saveWcrfList(wcrfBuyDto, loginVO);

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD001");
        vo.setCode(wcrfBuyDto.getSetleSe());
        List<CmmnDetailCode> list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfBuyDto.setSetleSeNm(code.getCodeNm());
        }

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD009");
        vo.setCode(wcrfBuyDto.getCashReceiptsOpt());
        list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfBuyDto.setCashReceiptsOptNm(code.getCodeNm());
        }

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("WcrfBuyForm", wcrfBuyDto);

        model.put("menuNo", wcrfBuyDto.getMenuNo());
        model.put("bsktIdList", wcrfBuyDto.getBsktIdList());

        return new ModelAndView("/wcrf/03_06", model);
    }

    /**
     * 목공예품 결재
     * @param wcrfBuyDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfPaySave.do")
    public ModelAndView wcrfPaySave(@ModelAttribute("WcrfBuyForm") WcrfBuyDto wcrfBuyDto,
                                       HttpServletRequest req,
                                       HttpServletResponse rep) throws Exception {

        String menuNo = wcrfBuyDto.getMenuNo();
        wcrfBuyDto = wcrfBuyService.getWcrfBuyTot(wcrfBuyDto);

        // 주문확인 처리 (무통자입금의 경우 결제대기로 변경)
        if (wcrfBuyDto.getSetleSe().equals("02")) {
            wcrfBuyDto.setPurchsProgrsSttus("02");
            wcrfBuyDto.setSetleAmt("0");
            wcrfBuyDto.setCardConfmNo(null);

            //로그인유저
            LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
            wcrfBuyDto.setUpdtrId(loginVO.getId());
            wcrfBuyService.savePayComplete(wcrfBuyDto);
        }

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD001");
        vo.setCode(wcrfBuyDto.getSetleSe());
        List<CmmnDetailCode> list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfBuyDto.setSetleSeNm(code.getCodeNm());
        }

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("WcrfBuyForm", wcrfBuyDto);

        model.put("menuNo", menuNo);

        return new ModelAndView("/wcrf/03_07", model);
    }

    /**
     * 목공예품 결재성공
     * @param commandMap
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/payComplete.do")
    public ModelAndView payComplete(
            @RequestParam Map<String, String> commandMap,
            //@RequestBody Map<String, String> params,
                                    HttpServletResponse rep) throws Exception {

        //ajax통신

        //wcrfService.saveWcrfList(wcrfBuyDto);

        //6452717290103360
        //jbvpWcWABwQmFABzGJEY6l1Ezokjx3ZReuhbHdLjKCFpdhZT0DR7ZTLyi6RQ9RHolZz3dlmXX1naim4j

        String imp_uid = (String)commandMap.get("imp_uid");
        String merchant_uid = (String)commandMap.get("merchant_uid");

        //String imp_uid = (String)params.get("imp_uid");
        //String merchant_uid = (String)params.get("merchant_uid");

        //String imp_uid = req.getParameter("");
        //String merchant_uid = req.getParameter("");

        String test_api_key = egovMessageSource.getMessage("api.key");
        String test_api_secret = egovMessageSource.getMessage("api.secret");
        IamportClient client = new IamportClient(test_api_key, test_api_secret);

        //String test_imp_uid = "imp_524223945095";
        //String test_imp_uid = String.valueOf(params.get("imp_uid"));
        String test_imp_uid = imp_uid;

        IamportResponse<Payment> payment_response = client.paymentByImpUid(test_imp_uid);
        System.out.println(payment_response.getResponse());
        System.out.println(test_imp_uid + " " + payment_response.getResponse().getImpUid());

        Payment payment = payment_response.getResponse();

        //DB에 있는 금액과 비교
        //payment.getImpUid();
        //payment.getAmount();
        //payment.getPayMethod();
        //payment.getMerchantUid();

        WcrfBuyDto wcrfBuyDto = new WcrfBuyDto();
        wcrfBuyDto.setStoreDelngId(payment.getMerchantUid());
        wcrfBuyDto = wcrfBuyService.getWcrfBuyTot(wcrfBuyDto);

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
            mav.addObject("purchsLstId", wcrfBuyDto.getPurchsLstId());
            mav.addObject("storeDelngId", payment.getMerchantUid());

        } else {
            mav.addObject("status", "fail");
        }

        //String test_imp_uid_cancelled = "imp_138841716839";
        //IamportResponse<Payment> cancelled_response = client.paymentByImpUid(test_imp_uid_cancelled);
        //Payment cancelled = cancelled_response.getResponse();
        //PaymentCancelDetail[] cancelDetail = cancelled.getCancelHistory();

        //System.out.println(cancelDetail.length + " " + 1);
        //System.out.println(cancelDetail[0].getPgTid());

        //Map<String,Object> model = new HashMap<String, Object>();
        //model.put("WcrfBuyForm", new WcrfBuyDto());

        return mav;
    }

}
