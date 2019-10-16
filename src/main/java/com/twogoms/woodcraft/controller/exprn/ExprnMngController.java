package com.twogoms.woodcraft.controller.exprn;

import com.google.gson.Gson;
import com.twogoms.woodcraft.dto.cmm.DropDownItem;
import com.twogoms.woodcraft.dto.exprn.ExprnDto;
import com.twogoms.woodcraft.dto.exprn.ExprnLectureDto;
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
import org.springframework.web.bind.annotation.*;
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
 * 체험 관리자 Controller
 */
@Controller
@RequestMapping("/mng")
public class ExprnMngController {

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
    private ExprnService exprnService;

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
    public List<DropDownItem> getExprnSttus() throws Exception {
        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("codeId", "WOD007");
        searchMap.put("useAt", "Y");

        return cmnCodeService.selectListCmnCodeDetl(searchMap);
    }

    @ModelAttribute("exprnSe")
    public List<DropDownItem> getExprnSe() throws Exception {
        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("codeId", "WOD010");
        searchMap.put("useAt", "Y");

        return cmnCodeService.selectListCmnCodeDetl(searchMap);
    }

    @ModelAttribute("exprnList")
    public List<DropDownItem> getExprnList() throws Exception {

        ExprnCriteria exprnCriteria = new ExprnCriteria();
        exprnCriteria.setTypeCd("01");

        exprnCriteria.setPageUnit(1000);
        exprnCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(exprnCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(exprnCriteria.getPageUnit());
        paginationInfo.setPageSize(exprnCriteria.getPageSize());

        exprnCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        exprnCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        exprnCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> retMap = exprnService.getExprnListMap(exprnCriteria);

        List<ExprnDto> list2 = (List<ExprnDto>)retMap.get("retList");
        List<DropDownItem> list = new ArrayList<DropDownItem>();

        for (ExprnDto exprnDto : list2) {
            DropDownItem item = new DropDownItem();
            item.setText(exprnDto.getExprnNm());
            item.setValue(exprnDto.getExprnId());
            list.add(item);
        }

        return list;
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

    @RequestMapping(value="/exprn/exprnList.do")
    public ModelAndView getExprnList(@ModelAttribute("frmSearch")ExprnCriteria exprnCriteria,
                                    @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            exprnCriteria.setPageIndex(Integer.parseInt(pageIndex));

        exprnCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        exprnCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(exprnCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(exprnCriteria.getPageUnit());
        paginationInfo.setPageSize(exprnCriteria.getPageSize());

        exprnCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        exprnCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        exprnCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        //일일체험
        exprnCriteria.setTypeCd("01");

        Map<String, Object> retMap = exprnService.getExprnListMap(exprnCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", exprnCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mng/exprn/exprnList", modelMap);
    }

    /** create Form */
    @RequestMapping(value = "/exprn/exprnRegit.do")
    public ModelAndView goExprnForm(@ModelAttribute("ExprnForm") ExprnDto exprnDto,
                                      HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        Map<String,Object> model = new HashMap<String, Object>();
        return new ModelAndView("/mng/exprn/exprnRegit", model);

    }

    @RequestMapping(value = "/exprn/exprnSave.do" , method = RequestMethod.POST)
    public ModelAndView saveExprn(@RequestParam List<MultipartFile> files,
                                  @RequestParam List<MultipartFile> files2,
                                @ModelAttribute("ExprnForm") ExprnDto exprnDto,
                                   HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        int size = files.size();
        if (size > 0) {

            final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
            for(MultipartFile file : files) {
                uploadItems.put(file.getOriginalFilename(), file);
            }

            String atchFileId = exprnDto.getAtchFileId();

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

            exprnDto.setAtchFileId(atchFileId);
        }

        size = files2.size();
        if (size > 0) {

            final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
            for(MultipartFile file : files2) {
                uploadItems.put(file.getOriginalFilename(), file);
            }

            String atchFileId = exprnDto.getAtchFileId2();

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

            exprnDto.setAtchFileId2(atchFileId);
        }

        Map<String,Object> model = new HashMap<String, Object>();

        //일일체험
        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        exprnDto.setRgstrId(loginVO.getId());
        exprnDto.setUpdtrId(loginVO.getId());
        exprnDto.setTypeCd("01");
        exprnService.saveExprn(exprnDto);
        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/exprn/exprnRegit", model);
    }

    /**
     * 상세
     * @param exprnDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/exprn/exprnView.do")
    public ModelAndView getExprn(@ModelAttribute("ExprnForm")  ExprnDto exprnDto,
                                  HttpServletRequest req,
                                  HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        Map<String,Object> model = new HashMap<String, Object>();
        exprnDto = exprnService.getExprn(exprnDto);

        if(exprnDto.getAtchFileId() !=null){
            String file_id = exprnDto.getAtchFileId();
            FileVO fvo;

            if(!file_id.equals("")){
                fvo = new FileVO();
                fvo.setAtchFileId(file_id);
                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                model.put("fileResult",fRS);
            }
        }

        if(exprnDto.getAtchFileId2() !=null){
            String file_id = exprnDto.getAtchFileId2();
            FileVO fvo;

            if(!file_id.equals("")){
                fvo = new FileVO();
                fvo.setAtchFileId(file_id);
                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                model.put("fileResult2",fRS);
            }
        }

        model.put("ExprnForm", exprnDto);

        return new ModelAndView("/mng/exprn/exprnRegit", model);

    }

    /**
     * 삭제
     * @param exprnDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/exprn/exprnDelete.do")
    public ModelAndView deleteExprn(@ModelAttribute("ExprnForm") ExprnDto exprnDto,
                                     HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        exprnService.deleteExprn(exprnDto);

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("message", messageSource.getMessage("success.common.delete"));
        model.put("result","OK");

        return new ModelAndView("/mng/exprn/exprnRegit", model);

    }

    @RequestMapping(value="/exprn/exprnReqList.do")
    public ModelAndView getExprnReqList(@ModelAttribute("frmSearch")WcrfBuyCriteria wcrfBuyCriteria,
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

        wcrfBuyCriteria.setTypeCd("01");

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

        return new ModelAndView("/mng/exprn/exprnReqList", modelMap);
    }

    /** create Form */
    @RequestMapping(value = "/exprn/exprnReqRegit.do")
    public ModelAndView goWcrfReqForm(@ModelAttribute("ReqForm") ReqDto reqDto,
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

        return new ModelAndView("/mng/exprn/exprnReqRegit", model);

    }

    @RequestMapping(value = "/exprn/exprnReqSave.do" , method = RequestMethod.POST)
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

                    return new ModelAndView("/mng/exprn/exprnReqRegit", model);

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

        return new ModelAndView("/mng/exprn/exprnReqRegit", model);
    }

    @RequestMapping(value="/exprn/exprnRefdList.do")
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

        exprnRefdCriteria.setTypeCd("01");

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

        return new ModelAndView("/mng/exprn/exprnRefdList", modelMap);
    }

    /** create Form */
    @RequestMapping(value = "/exprn/exprnRefdRegit.do")
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

        return new ModelAndView("/mng/exprn/exprnRefdRegit", model);

    }

    @RequestMapping(value = "/exprn/exprnRefdSave.do" , method = RequestMethod.POST)
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

        return new ModelAndView("/mng/exprn/exprnRefdRegit", model);
    }

    @RequestMapping(value="/exprn/exprnLectureList.do")
    public ModelAndView getExprnLectureList(@ModelAttribute("frmSearch")ExprnCriteria exprnCriteria,
                                     @RequestParam(value="pageIndex",required = false) String pageIndex,
                                     HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            exprnCriteria.setPageIndex(Integer.parseInt(pageIndex));

        exprnCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        exprnCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(exprnCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(exprnCriteria.getPageUnit());
        paginationInfo.setPageSize(exprnCriteria.getPageSize());

        exprnCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        exprnCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        exprnCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        //일일체험
        exprnCriteria.setTypeCd("01");

        Map<String, Object> retMap = exprnService.getExprnLectureListMap(exprnCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", exprnCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mng/exprn/exprnLectureList", modelMap);
    }

    /** create Form */
    @RequestMapping(value = "/exprn/exprnLectureRegit.do")
    public ModelAndView goExprnLectureForm(@ModelAttribute("ExprnLectureForm") ExprnLectureDto exprnLectureDto,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        Map<String,Object> model = new HashMap<String, Object>();
        return new ModelAndView("/mng/exprn/exprnLectureRegit", model);

    }

    @RequestMapping(value = "/exprn/exprnLectureSave.do" , method = RequestMethod.POST)
    public ModelAndView saveExprn(@ModelAttribute("ExprnLectureForm") ExprnLectureDto exprnLectureDto,
                                  HttpServletRequest req,
                                  HttpServletResponse rep) throws Exception {


        Map<String,Object> model = new HashMap<String, Object>();

        //일일체험
        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        exprnLectureDto.setRgstrId(loginVO.getId());
        exprnLectureDto.setUpdtrId(loginVO.getId());
        exprnService.saveExprnLecture(exprnLectureDto);
        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/exprn/exprnLectureRegit", model);
    }

    /**
     * 상세
     * @param exprnLectureDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/exprn/exprnLectureView.do")
    public ModelAndView getExprnLecture(@ModelAttribute("ExprnForm")  ExprnLectureDto exprnLectureDto,
                                 HttpServletRequest req,
                                 HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        Map<String,Object> model = new HashMap<String, Object>();
        exprnLectureDto = exprnService.getExprnLecture(exprnLectureDto);
        Map<String, Object> retMap = exprnService.getExprnLectureReqListMap(exprnLectureDto);

        model.put("ExprnLectureForm", exprnLectureDto);
        model.put("retList", retMap.get("retList"));
        model.put("retCnt", retMap.get("retCnt"));

        return new ModelAndView("/mng/exprn/exprnLectureRegit", model);

    }

    /**
     * 삭제
     * @param exprnLectureDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/exprn/exprnLectureDelete.do")
    public ModelAndView deleteExprnLecture(@ModelAttribute("ExprnLectureForm") ExprnLectureDto exprnLectureDto,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        exprnService.deleteExprnLecture(exprnLectureDto);

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("message", messageSource.getMessage("success.common.delete"));
        model.put("result","OK");

        return new ModelAndView("/mng/exprn/exprnLectureRegit", model);

    }
}
