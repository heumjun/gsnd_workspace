package com.twogoms.woodcraft.controller.prgm;

import com.google.gson.Gson;
import com.twogoms.woodcraft.dto.cmm.DropDownItem;
import com.twogoms.woodcraft.dto.exprn.ExprnDto;
import com.twogoms.woodcraft.dto.exprn.ReqDto;
import com.twogoms.woodcraft.dto.exprn.criteria.ExprnCriteria;
import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfRefdDto;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfBuyCriteria;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfRefdCriteria;
import com.twogoms.woodcraft.service.cmm.CmnCodeService;
import com.twogoms.woodcraft.service.exprn.ExprnService;
import com.twogoms.woodcraft.service.exprn.ReqService;
import com.twogoms.woodcraft.service.mypage.BsktService;
import com.twogoms.woodcraft.service.wcrf.WcrfBuyService;
import com.twogoms.woodcraft.service.wcrf.WcrfRefdService;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.*;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 프로그램 관리자 Controller
 */
@Controller
@RequestMapping("/mng")
public class PrgmMngController {

    @Resource(name = "egovMessageSource")
    private EgovMessageSource messageSource;

    @Autowired
    private EgovFileMngService egovFileMngService;

    @Autowired
    private EgovFileMngUtil egovFileMngUtil;

    @Resource(name="propertiesService")
    private EgovPropertyService propertyService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    @Autowired
    private ExprnService prgmService;

    @Autowired
    private CmnCodeService cmnCodeService;

    @Autowired
    private BsktService bsktService;

    @Autowired
    private ReqService reqService;

    @Autowired
    private WcrfBuyService wcrfBuyService;

    @Autowired
    private WcrfRefdService wcrfRefdService;

    @ModelAttribute("exprnSttus")
    public List<DropDownItem> getPrgmSttus() throws Exception {
        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("codeId", "WOD007");
        searchMap.put("useAt", "Y");

        return cmnCodeService.selectListCmnCodeDetl(searchMap);
    }

    @ModelAttribute("exprnSe")
    public List<DropDownItem> getPrgmSe() throws Exception {
        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("codeId", "WOD006");
        searchMap.put("useAt", "Y");

        return cmnCodeService.selectListCmnCodeDetl(searchMap);
    }

    @ModelAttribute("purchsProgrsSttus")
    public List<DropDownItem> getPurchsProgrsSttus() throws Exception {
        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("codeId", "WOD008");
        searchMap.put("useAt", "Y");

        return addBlinkOption(cmnCodeService.selectListCmnCodeDetl(searchMap));
    }

    private List<DropDownItem> addBlinkOption(List<DropDownItem> list) {

        List<DropDownItem> list2 = new ArrayList<DropDownItem>();

        DropDownItem dropDownItem = new DropDownItem();
        dropDownItem.setText("");
        dropDownItem.setValue("");
        list2.add(dropDownItem);

        list2.addAll(list);

        return list2;
    }

    /**
     * 프로그램 목록
     *
     * @param prgmCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgm/prgmList.do")
    public ModelAndView getPrgmList(@ModelAttribute("frmSearch")ExprnCriteria prgmCriteria,
                                    @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            prgmCriteria.setPageIndex(Integer.parseInt(pageIndex));

        prgmCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        prgmCriteria.setPageSize(propertyService.getInt("pageSize"));

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

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", prgmCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mng/prgm/prgmList", modelMap);
    }

    /**
     * 프로그램 목록(신청현황)
     *
     * @param prgmCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgm/prgmList2.do")
    public ModelAndView getPrgmList2(@ModelAttribute("frmSearch")ExprnCriteria prgmCriteria,
                                    @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            prgmCriteria.setPageIndex(Integer.parseInt(pageIndex));

        prgmCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        prgmCriteria.setPageSize(propertyService.getInt("pageSize"));

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

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", prgmCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mng/prgm/prgmList2", modelMap);
    }

    /**
     * 프로그램 수정화면
     *
     * @param prgmDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/prgm/prgmRegit.do")
    public ModelAndView goPrgmForm(@ModelAttribute("PrgmForm") ExprnDto prgmDto,
                                   HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        Map<String,Object> model = new HashMap<String, Object>();
        return new ModelAndView("/mng/prgm/prgmRegit", model);

    }

    /**
     * 프로그램 상세
     *
     * @param files
     * @param files2
     * @param prgmDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/prgm/prgmSave.do" , method = RequestMethod.POST)
    public ModelAndView savePrgm(@RequestParam List<MultipartFile> files,
                                  @RequestParam List<MultipartFile> files2,
                                @ModelAttribute("PrgmForm") ExprnDto prgmDto,
                                   HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        int size = files.size();
        if (size > 0) {

            final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
            for(MultipartFile file : files) {
                uploadItems.put(file.getOriginalFilename(), file);
            }

            String atchFileId = prgmDto.getAtchFileId();

            if (EgovStringUtil.isEmpty(atchFileId)) {
                List<FileVO> result = egovFileMngUtil.parseFileInf(uploadItems, "FILE_", 0, atchFileId, "");
                atchFileId = egovFileMngService.insertFileInfs(result);
            } else {
                FileVO fileVO = new FileVO();
                fileVO.setAtchFileId(atchFileId);
                int cnt = egovFileMngService.getMaxFileSN(fileVO);
                List<FileVO> result = egovFileMngUtil.parseFileInf(uploadItems, "FILE_", cnt, atchFileId, "");
                egovFileMngService.updateFileInfs(result);
            }

            prgmDto.setAtchFileId(atchFileId);
        }

        size = files2.size();
        if (size > 0) {

            final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
            for(MultipartFile file : files2) {
                uploadItems.put(file.getOriginalFilename(), file);
            }

            String atchFileId = prgmDto.getAtchFileId2();

            if (EgovStringUtil.isEmpty(atchFileId)) {
                List<FileVO> result = egovFileMngUtil.parseFileInf(uploadItems, "FILE_", 0, atchFileId, "");
                atchFileId = egovFileMngService.insertFileInfs(result);
            } else {
                FileVO fileVO = new FileVO();
                fileVO.setAtchFileId(atchFileId);
                int cnt = egovFileMngService.getMaxFileSN(fileVO);
                List<FileVO> result = egovFileMngUtil.parseFileInf(uploadItems, "FILE_", cnt, atchFileId, "");
                egovFileMngService.updateFileInfs(result);
            }

            prgmDto.setAtchFileId2(atchFileId);
        }

        Map<String,Object> model = new HashMap<String, Object>();

        // 프램그램
        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        prgmDto.setRgstrId(loginVO.getId());
        prgmDto.setUpdtrId(loginVO.getId());
        prgmDto.setTypeCd("02");
        prgmService.saveExprn(prgmDto);
        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/prgm/prgmRegit", model);
    }

    /**
     * 프로그램 상세
     * @param prgmDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/prgm/prgmView.do")
    public ModelAndView getPrgm(@ModelAttribute("PrgmForm")  ExprnDto prgmDto,
                                  HttpServletRequest req,
                                  HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        Map<String,Object> model = new HashMap<String, Object>();
        prgmDto = prgmService.getExprn(prgmDto);

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

        if(prgmDto.getAtchFileId2() !=null){
            String file_id = prgmDto.getAtchFileId2();
            FileVO fvo;

            if(!file_id.equals("")){
                fvo = new FileVO();
                fvo.setAtchFileId(file_id);
                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                model.put("fileResult2",fRS);
            }
        }

        Map<String, Object> retMap = prgmService.getExprnPrgmReqListMap(prgmDto);
        model.put("PrgmForm", prgmDto);
        model.put("retList", retMap.get("retList"));
        model.put("retCnt", retMap.get("retCnt"));

        return new ModelAndView("/mng/prgm/prgmRegit", model);
    }


    /**
     * 프로그램 상세(신청현황)
     * @param prgmDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/prgm/prgmView2.do")
    public ModelAndView getPrgmList(@ModelAttribute("PrgmForm")  ExprnDto prgmDto,
                                HttpServletRequest req,
                                HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        Map<String,Object> model = new HashMap<String, Object>();
        prgmDto = prgmService.getExprn(prgmDto);

//        if(prgmDto.getAtchFileId() !=null){
//            String file_id = prgmDto.getAtchFileId();
//            FileVO fvo;
//
//            if(!file_id.equals("")){
//                fvo = new FileVO();
//                fvo.setAtchFileId(file_id);
//                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
//                model.put("fileResult",fRS);
//            }
//        }
//
//        if(prgmDto.getAtchFileId2() !=null){
//            String file_id = prgmDto.getAtchFileId2();
//            FileVO fvo;
//
//            if(!file_id.equals("")){
//                fvo = new FileVO();
//                fvo.setAtchFileId(file_id);
//                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
//                model.put("fileResult2",fRS);
//            }
//        }

        Map<String, Object> retMap = prgmService.getExprnPrgmReqListMap(prgmDto);
        model.put("PrgmForm", prgmDto);
        model.put("retList", retMap.get("retList"));
        model.put("retCnt", retMap.get("retCnt"));

        return new ModelAndView("/mng/prgm/prgmRegit2", model);
    }

    /**
     * 프로그램 삭제
     * @param prgmDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/prgm/prgmDelete.do")
    public ModelAndView deleteArtist(@ModelAttribute("PrgmForm") ExprnDto prgmDto,
                                     HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        prgmService.deleteExprn(prgmDto);

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("message", messageSource.getMessage("success.common.delete"));
        model.put("result","OK");

        return new ModelAndView("/mng/prgm/prgmRegit", model);

    }

    /**
     * 프로그램 예약 목록
     * @param wcrfBuyCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgm/prgmReqList.do")
    public ModelAndView getPrgmReqList(@ModelAttribute("frmSearch")WcrfBuyCriteria wcrfBuyCriteria,
                                        @RequestParam(value="pageIndex",required = false) String pageIndex,
                                        HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            wcrfBuyCriteria.setPageIndex(Integer.parseInt(pageIndex));

        if (EgovStringUtil.isEmpty(wcrfBuyCriteria.getSearchBgnDe()))
            wcrfBuyCriteria.setSearchBgnDe(EgovDateUtil.convertDate(EgovDateUtil.addDay(EgovDateUtil.getToday(), -14),
                    "0000", "yyyy-MM-dd"));
        if (EgovStringUtil.isEmpty(wcrfBuyCriteria.getSearchEndDe()))
            wcrfBuyCriteria.setSearchEndDe(EgovDateUtil.getCurrentDate("yyyy-MM-dd"));

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

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD001");
        List<CmmnDetailCode> codeList = cmmUseService.selectCmmCodeDetail(vo);

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD008");
        List<CmmnDetailCode> codeList2 = cmmUseService.selectCmmCodeDetail(vo);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", wcrfBuyCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        Gson gson = new Gson();
        String jsonString = gson.toJson(codeList);
        modelMap.put("setleSeList", jsonString);

        jsonString = gson.toJson(codeList2);
        modelMap.put("purchsProgrsSttusList", jsonString);

        return new ModelAndView("/mng/prgm/prgmReqList", modelMap);
    }

    /**
     * 프로그램 예약 수정화면
     * @param reqDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/prgm/prgmReqRegit.do")
    public ModelAndView goPrgmReqForm(@ModelAttribute("ReqForm") ReqDto reqDto,
                                      HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        WcrfBuyDto wcrfBuyDto = reqService.getReqPay(reqDto);

        Map<String,Object> model = new HashMap<String, Object>();

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD008");
        List<CmmnDetailCode> codeList2 = cmmUseService.selectCmmCodeDetail(vo);

        Gson gson = new Gson();
        String jsonString = gson.toJson(codeList2);
        model.put("purchsProgrsSttusList", jsonString);

        model.put("WcrfBuyForm", wcrfBuyDto);

        return new ModelAndView("/mng/prgm/prgmReqRegit", model);

    }

    /**
     * 프로그램 예약 저장
     * @param wcrfBuyDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/prgm/prgmReqSave.do" , method = RequestMethod.POST)
    public ModelAndView saveWcrfReq(@ModelAttribute("WcrfBuyForm") WcrfBuyDto wcrfBuyDto,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {


        ReqDto reqDto = new ReqDto();
        reqDto.setExprnReqstId(wcrfBuyDto.getPurchsLstId());
        reqDto.setReqSttus(wcrfBuyDto.getPurchsProgrsSttus());

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        wcrfBuyDto.setUpdtrId(loginVO.getId());
        reqDto.setUpdtrId(loginVO.getId());

        Map<String,Object> model = new HashMap<String, Object>();

        // 결제금액 체크
        WcrfBuyDto wcrfBuyDto2 = reqService.getReqPay(reqDto);

        // 무통장입금
        if (wcrfBuyDto2.getSetleSe().equals("02")) {
            // 결제대기 -> 결제완료
            if (wcrfBuyDto2.getPurchsProgrsSttus().equals("02") && wcrfBuyDto.getPurchsProgrsSttus().equals("03")) {
                // 결제 금액과 입금 금액이 같은지
                if (!wcrfBuyDto2.getPurchsAllAmt().equals(wcrfBuyDto.getRcpmnyAmt())) {

                    model.put("message", "결제금액과 입금금액이 일치하지않습니다.");
                    model.put("result","NG");

                    return new ModelAndView("/mng/prgm/prgmReqRegit", model);

                } else {
                    //결제 정보 갱신
                    wcrfBuyDto.setSetleAmt(wcrfBuyDto.getRcpmnyAmt());
                    wcrfBuyDto.setRcpmnyAmt(wcrfBuyDto.getRcpmnyAmt());
                    wcrfBuyService.updateWcrfPay(wcrfBuyDto);
                }
            }
        }

        reqService.updateReq(reqDto);
        //wcrfBuyService.updateWcrfBuyTot(wcrfBuyDto);

        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/prgm/prgmReqRegit", model);
    }

    /**
     * 프로그램환불 목록
     * @param exprnRefdCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/prgm/prgmRefdList.do")
    public ModelAndView getExprnRefdList(@ModelAttribute("frmSearch")WcrfRefdCriteria exprnRefdCriteria,
                                         @RequestParam(value="pageIndex",required = false) String pageIndex,
                                         HttpServletRequest req,
                                         HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            exprnRefdCriteria.setPageIndex(Integer.parseInt(pageIndex));

        exprnRefdCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        exprnRefdCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(exprnRefdCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(exprnRefdCriteria.getPageUnit());
        paginationInfo.setPageSize(exprnRefdCriteria.getPageSize());

        exprnRefdCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        exprnRefdCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        exprnRefdCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        exprnRefdCriteria.setTypeCd("02");

        Map<String, Object> retMap = wcrfRefdService.getExprnRefdListMap(exprnRefdCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", exprnRefdCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD008");
        List<CmmnDetailCode> codeList = cmmUseService.selectCmmCodeDetail(vo);

        Gson gson = new Gson();
        String jsonString = gson.toJson(codeList);
        modelMap.put("purchsProgrsSttusList", jsonString);

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD004");
        List<CmmnDetailCode> codeList2 = cmmUseService.selectCmmCodeDetail(vo);

        jsonString = gson.toJson(codeList2);
        modelMap.put("refdResnCdList", jsonString);

        return new ModelAndView("/mng/prgm/prgmRefdList", modelMap);
    }

    /**
     * 프로그램환불 수정 화면
     * @param wcrfRefdDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/prgm/prgmRefdRegit.do")
    public ModelAndView goExprnRefdForm(@ModelAttribute("WcrfRefdForm") WcrfRefdDto wcrfRefdDto,
                                        HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        wcrfRefdDto = wcrfRefdService.getWcrfRefd(wcrfRefdDto);

        Map<String,Object> model = new HashMap<String, Object>();

        model.put("WcrfRefdForm", wcrfRefdDto);

        ReqDto reqDto = new ReqDto();
        reqDto.setExprnReqstId(wcrfRefdDto.getPurchsLstId());
        WcrfBuyDto wcrfBuyDto = reqService.getReqPay(reqDto);

        model.put("WcrfBuyForm", wcrfBuyDto);

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD008");
        List<CmmnDetailCode> codeList2 = cmmUseService.selectCmmCodeDetail(vo);

        Gson gson = new Gson();
        String jsonString = gson.toJson(codeList2);
        model.put("purchsProgrsSttusList", jsonString);

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD005");
        codeList2 = cmmUseService.selectCmmCodeDetail(vo);

        gson = new Gson();
        jsonString = gson.toJson(codeList2);
        model.put("refdSttusCdList", jsonString);

        return new ModelAndView("/mng/prgm/prgmRefdRegit", model);

    }

    /**
     * 프로그램환불 저장
     * @param wcrfRefdDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/prgm/prgmRefdSave.do" , method = RequestMethod.POST)
    public ModelAndView saveExprnRefd(@ModelAttribute("WcrfRefdForm") WcrfRefdDto wcrfRefdDto,
                                      HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        Map<String,Object> model = new HashMap<String, Object>();

        ReqDto reqDto = new ReqDto();
        reqDto.setExprnReqstId(wcrfRefdDto.getPurchsLstId());
        reqDto.setReqSttus(wcrfRefdDto.getPurchsProgrsSttus());
        reqDto.setUpdtrId(loginVO.getId());
        reqService.updateReq(reqDto);

        wcrfRefdDto.setRgstrId(loginVO.getId());
        wcrfRefdDto.setUpdtrId(loginVO.getId());
        wcrfRefdService.saveWcrfRefd(wcrfRefdDto);
        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/prgm/prgmRefdRegit", model);
    }

}
