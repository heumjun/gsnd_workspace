package com.twogoms.woodcraft.controller.wcrf;

import com.google.gson.Gson;
import com.twogoms.woodcraft.dto.cmm.DropDownItem;
import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfRefdDto;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfBuyCriteria;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfCriteria;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfRefdCriteria;
import com.twogoms.woodcraft.service.cmm.CmnCodeService;
import com.twogoms.woodcraft.service.mypage.BsktService;
import com.twogoms.woodcraft.service.wcrf.WcrfBuyService;
import com.twogoms.woodcraft.service.wcrf.WcrfRefdService;
import com.twogoms.woodcraft.service.wcrf.WcrfService;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.*;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 목공예품 관리자 Controller
 */
@Controller
@RequestMapping("/mng")
@SessionAttributes(value = "{purchsProgrsSttus}")
public class WcrfMngController {

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
    private WcrfService wcrfService;

    @Autowired
    private WcrfBuyService wcrfBuyService;

    @Autowired
    private BsktService bsktService;

    @Autowired
    private WcrfRefdService wcrfRefdService;

    @Autowired
    private CmnCodeService cmnCodeService;

    @ModelAttribute("purchsProgrsSttus")
    public List<DropDownItem> getPurchsProgrsSttus() throws Exception {
        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("codeId", "WOD002");
        searchMap.put("useAt", "Y");

        return cmnCodeService.selectListCmnCodeDetl(searchMap);
    }

    /**
     * 목공예품 목록
     * @param wcrfCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrf/wcrfList.do")
    public ModelAndView getWcrfList(@ModelAttribute("frmSearch")WcrfCriteria wcrfCriteria,
                                    @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            wcrfCriteria.setPageIndex(Integer.parseInt(pageIndex));

        wcrfCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        wcrfCriteria.setPageSize(propertyService.getInt("pageSize"));

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

        return new ModelAndView("/mng/wcrf/wcrfList", modelMap);
    }

    /** create Form */
    @RequestMapping(value = "/wcrf/wcrfRegit.do")
    public ModelAndView goWcrfForm(@ModelAttribute("WcrfForm") WcrfDto wcrfDto,
                                      HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {
        Map<String,Object> model = new HashMap<String, Object>();
        return new ModelAndView("/mng/wcrf/wcrfRegit", model);

    }

    /**
     * 목공예품 등록수정
     * @param wcrfDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/wcrf/wcrfSave.do" , method = RequestMethod.POST)
    public ModelAndView saveWcrf(@RequestParam List<MultipartFile> files,
                                @ModelAttribute("WcrfForm") WcrfDto wcrfDto,
                                   HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        int size = files.size();
        if (size > 0) {

            final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
            for(MultipartFile file : files) {
                uploadItems.put(file.getOriginalFilename(), file);
            }

            String atchFileId = wcrfDto.getAtchFileId();

            if ( atchFileId.equals("")) {
                List<FileVO> result = egovFileMngUtil.parseFileInf(uploadItems, "FILE_", 0, atchFileId, "");
                atchFileId = egovFileMngService.insertFileInfs(result);
            } else {
                FileVO fileVO = new FileVO();
                fileVO.setAtchFileId(atchFileId);
                int cnt = egovFileMngService.getMaxFileSN(fileVO);
                List<FileVO> result = egovFileMngUtil.parseFileInf(uploadItems, "FILE_", cnt, atchFileId, "");
                egovFileMngService.updateFileInfs(result);
            }

            wcrfDto.setAtchFileId(atchFileId);
        }

        Map<String,Object> model = new HashMap<String, Object>();

        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        wcrfDto.setRgstrId(loginVO.getId());
        wcrfDto.setUpdtrId(loginVO.getId());

        wcrfService.saveWcrf(wcrfDto);
        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/wcrf/wcrfRegit", model);
    }

    /**
     * 목공예품 상세
     * @param wcrfDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/wcrf/wcrfView.do")
    public ModelAndView getWcrf(@ModelAttribute("WcrfForm")  WcrfDto wcrfDto,
                                  HttpServletRequest req,
                                  HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        Map<String,Object> model = new HashMap<String, Object>();
        wcrfDto = wcrfService.getWcrf(wcrfDto);

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

        model.put("WcrfForm", wcrfDto);

        return new ModelAndView("/mng/wcrf/wcrfRegit", model);

    }

    /**
     * 목공예품 삭제
     * @param wcrfDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/wcrf/wcrfDelete.do")
    public ModelAndView deleteArtist(@ModelAttribute("WcrfForm") WcrfDto wcrfDto,
                                     HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        wcrfService.deleteWcrf(wcrfDto);

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("message", messageSource.getMessage("success.common.delete"));
        model.put("result","OK");

        model.put("WcrfForm", wcrfDto);

        return new ModelAndView("/mng/wcrf/wcrfRegit", model);

    }

    /**
     * 목공예품주문 목록
     * @param wcrfBuyCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrf/wcrfReqList.do")
    public ModelAndView getWcrfReqList(@ModelAttribute("frmSearch")WcrfBuyCriteria wcrfBuyCriteria,
                                    @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

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

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD001");
        List<CmmnDetailCode> codeList = cmmUseService.selectCmmCodeDetail(vo);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", wcrfBuyCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        Gson gson = new Gson();
        String jsonString = gson.toJson(codeList);
        modelMap.put("setleSeList", jsonString);

        return new ModelAndView("/mng/wcrf/wcrfReqList", modelMap);
    }

    /**
     * 목공예품환불 등록수정화면
     * @param wcrfBuyDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/wcrf/wcrfReqRegit.do")
    public ModelAndView goWcrfReqForm(@ModelAttribute("WcrfBuyForm") WcrfBuyDto wcrfBuyDto,
                                   HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        wcrfBuyDto = wcrfBuyService.getWcrfBuyTot(wcrfBuyDto);

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD001");
        vo.setCode(wcrfBuyDto.getSetleSe());
        List<CmmnDetailCode> list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfBuyDto.setSetleSeNm(code.getCodeNm());
        }

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD002");
        vo.setCode(wcrfBuyDto.getPurchsProgrsSttus());
        list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfBuyDto.setPurchsProgrsSttusNm(code.getCodeNm());
        }

        Map<String,Object> model = new HashMap<String, Object>();

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD002");
        List<CmmnDetailCode> codeList2 = cmmUseService.selectCmmCodeDetail(vo);

        Gson gson = new Gson();
        String jsonString = gson.toJson(codeList2);
        model.put("purchsProgrsSttusList", jsonString);

        model.put("WcrfBuyForm", wcrfBuyDto);

        List<WcrfDto> retList = wcrfBuyService.getWcrfBuyList(wcrfBuyDto);
        model.put("wcrfBuyList", retList);

        return new ModelAndView("/mng/wcrf/wcrfReqRegit", model);

    }

    /**
     * 목공예품환불 저장
     * @param wcrfBuyDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/wcrf/wcrfReqSave.do" , method = RequestMethod.POST)
    public ModelAndView saveWcrfReq(@ModelAttribute("WcrfBuyForm") WcrfBuyDto wcrfBuyDto,
                                 HttpServletRequest req,
                                 HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        wcrfBuyDto.setUpdtrId(loginVO.getId());

        Map<String,Object> model = new HashMap<String, Object>();

        // 결제금액 체크
        WcrfBuyDto wcrfBuyDto2 = wcrfBuyService.getWcrfBuyTot(wcrfBuyDto);

        // 무통장입금
        if (wcrfBuyDto2.getSetleSe().equals("02")) {
            // 결제대기 -> 결제완료
            if (wcrfBuyDto2.getPurchsProgrsSttus().equals("02") && wcrfBuyDto.getPurchsProgrsSttus().equals("03")) {
                // 결제 금액과 입금 금액이 같은지
                if (!wcrfBuyDto2.getPurchsAllAmt().equals(wcrfBuyDto.getRcpmnyAmt())) {

                    model.put("message", "결제금액과 입금금액이 일치하지않습니다.");
                    model.put("result", "NG");

                    return new ModelAndView("/mng/wcrf/wcrfReqRegit", model);

                } else {
                    //결제 정보 갱신
                    wcrfBuyDto.setSetleAmt(wcrfBuyDto.getRcpmnyAmt());
                    wcrfBuyDto.setRcpmnyAmt(wcrfBuyDto.getRcpmnyAmt());
                    wcrfBuyService.updateWcrfPay(wcrfBuyDto);
                }
            }
        }

        wcrfBuyService.updateWcrfBuyTot(wcrfBuyDto);

        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/wcrf/wcrfReqRegit", model);
    }

    /**
     * 목공예품환불 목록
     * @param wcrfRefdCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrf/wcrfRefdList.do")
    public ModelAndView getWcrfRefdList(@ModelAttribute("frmSearch")WcrfRefdCriteria wcrfRefdCriteria,
                                       @RequestParam(value="pageIndex",required = false) String pageIndex,
                                       HttpServletRequest req,
                                       HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            wcrfRefdCriteria.setPageIndex(Integer.parseInt(pageIndex));

        wcrfRefdCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        wcrfRefdCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(wcrfRefdCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(wcrfRefdCriteria.getPageUnit());
        paginationInfo.setPageSize(wcrfRefdCriteria.getPageSize());

        wcrfRefdCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        wcrfRefdCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        wcrfRefdCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> retMap = wcrfRefdService.getWcrfRefdListMap(wcrfRefdCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", wcrfRefdCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD002");
        List<CmmnDetailCode> codeList = cmmUseService.selectCmmCodeDetail(vo);

        Gson gson = new Gson();
        String jsonString = gson.toJson(codeList);
        modelMap.put("purchsProgrsSttusList", jsonString);

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD004");
        List<CmmnDetailCode> codeList2 = cmmUseService.selectCmmCodeDetail(vo);

        jsonString = gson.toJson(codeList2);
        modelMap.put("refdResnCdList", jsonString);

        return new ModelAndView("/mng/wcrf/wcrfRefdList", modelMap);
    }

    /**
     * 목공예품환불 등록수정화면
     * @param wcrfRefdDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/wcrf/wcrfRefdRegit.do")
    public ModelAndView goWcrfRefdForm(@ModelAttribute("WcrfRefdForm") WcrfRefdDto wcrfRefdDto,
                                      HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        wcrfRefdDto = wcrfRefdService.getWcrfRefd(wcrfRefdDto);

        ComDefaultCodeVO vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD003");
        vo.setCode(wcrfRefdDto.getRefdSe());
        List<CmmnDetailCode> list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfRefdDto.setRefdSeNm(code.getCodeNm());
        }

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD004");
        vo.setCode(wcrfRefdDto.getRefdResnCd());
        list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfRefdDto.setRefdResnCdNm(code.getCodeNm());
        }

        Map<String,Object> model = new HashMap<String, Object>();

        model.put("WcrfRefdForm", wcrfRefdDto);

        WcrfBuyDto wcrfBuyDto = new WcrfBuyDto();
        wcrfBuyDto.setPurchsLstId(wcrfRefdDto.getPurchsLstId());
        wcrfBuyDto = wcrfBuyService.getWcrfBuyTot(wcrfBuyDto);

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD001");
        vo.setCode(wcrfBuyDto.getSetleSe());
        list = cmmUseService.selectCmmCodeDetail(vo);
        if (list != null && list.size() > 0) {
            CmmnDetailCode code = list.get(0);
            wcrfBuyDto.setSetleSeNm(code.getCodeNm());
        }

        model.put("WcrfBuyForm", wcrfBuyDto);

        List<WcrfDto> retList = wcrfBuyService.getWcrfBuyList(wcrfBuyDto);
        model.put("wcrfBuyList", retList);

        vo = new ComDefaultCodeVO();
        vo.setCodeId("WOD002");
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

        return new ModelAndView("/mng/wcrf/wcrfRefdRegit", model);

    }

    /**
     * 목공예품환불 저장
     * @param wcrfRefdDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/wcrf/wcrfRefdSave.do" , method = RequestMethod.POST)
    public ModelAndView saveWcrfRefd(@ModelAttribute("WcrfRefdForm") WcrfRefdDto wcrfRefdDto,
                                 HttpServletRequest req,
                                 HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        Map<String,Object> model = new HashMap<String, Object>();

        WcrfBuyDto wcrfBuyDto = new WcrfBuyDto();
        wcrfBuyDto.setPurchsLstId(wcrfRefdDto.getPurchsLstId());
        wcrfBuyDto.setPurchsProgrsSttus(wcrfRefdDto.getPurchsProgrsSttus());
        wcrfBuyDto.setUpdtrId(loginVO.getId());
        wcrfBuyService.updateWcrfBuyTot(wcrfBuyDto);

        wcrfRefdDto.setRgstrId(loginVO.getId());
        wcrfRefdDto.setUpdtrId(loginVO.getId());
        wcrfRefdService.saveWcrfRefd(wcrfRefdDto);
        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/wcrf/wcrfRefdRegit", model);
    }

}
