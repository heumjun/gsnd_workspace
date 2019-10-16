package com.twogoms.woodcraft.controller.cmm;

import com.twogoms.woodcraft.dto.cmm.DropDownItem;
import com.twogoms.woodcraft.dto.cmm.PopupDto;
import com.twogoms.woodcraft.dto.cmm.criteria.PopupCriteria;
import com.twogoms.woodcraft.service.cmm.CmnCodeService;
import com.twogoms.woodcraft.service.cmm.PopupService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/mng")
public class PopupMngController {

    @Resource(name = "egovMessageSource")
    private EgovMessageSource messageSource;

    @Autowired
    private EgovFileMngService egovFileMngService;

    @Autowired
    private EgovFileMngUtil egovFileMngUtil;

    @Autowired
    private CmnCodeService cmnCodeService;

    @Resource(name="propertiesService")
    private EgovPropertyService propertyService;

    @Autowired
    private PopupService popupService;

    @ModelAttribute("popupType")
    public List<DropDownItem> getPopupType() throws Exception {
        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("codeId", "WOD011");
        searchMap.put("useAt", "Y");

        return cmnCodeService.selectListCmnCodeDetl(searchMap);
    }

    @ModelAttribute("useType")
    public List<DropDownItem> getUseYn() throws Exception {
        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("codeId", "WOD012");
        searchMap.put("useAt", "Y");

        return cmnCodeService.selectListCmnCodeDetl(searchMap);
    }


    /**
     * 팝업목록(관리자)
     * @param popupCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/popup/popupList.do")
    public ModelAndView getPopupList(@ModelAttribute("frmSearch")PopupCriteria popupCriteria,
                                         @RequestParam(value="pageIndex", required = false) String pageIndex,
                                            HttpServletRequest req,
                                                HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex != null)
            popupCriteria.setPageIndex(Integer.parseInt(pageIndex));

        popupCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        popupCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(popupCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(popupCriteria.getPageUnit());
        paginationInfo.setPageSize(popupCriteria.getPageSize());

        popupCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        popupCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        popupCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> retMap = popupService.getPopupListMap(popupCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", popupCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mng/common/popupList", modelMap);
    }

    /**
     * 팝업 상세
     * @param popupDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/popup/popupView.do")
    public ModelAndView getPopup(@ModelAttribute("PopupForm") PopupDto popupDto,
                                 HttpServletRequest req,
                                 HttpServletResponse rep) throws Exception{

        Map<String, Object> model = new HashMap<>();
        popupDto = popupService.getPopup(popupDto);

        if(popupDto.getAtchFileId() !=null){
            String file_id = popupDto.getAtchFileId();
            FileVO fvo;

            if(!file_id.equals("")){
                fvo = new FileVO();
                fvo.setAtchFileId(file_id);
                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                model.put("fileResult",fRS);
            }
        }

        model.put("PopupForm", popupDto);

        return new ModelAndView("/mng/common/popupRegit", model);
    }

    /**
     * 팝업 등록
     * @param popupDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/popup/popupRegit.do")
    public ModelAndView goPopupForm(@ModelAttribute("PopupForm") PopupDto popupDto,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        Map<String,Object> model = new HashMap<String, Object>();
        return new ModelAndView("/mng/common/popupRegit", model);
    }

    /**
     *
     * @param files
     * @param popupDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/popup/popupSave.do" , method = RequestMethod.POST)
    public ModelAndView savePopup(@RequestParam List<MultipartFile> files,
                                        @ModelAttribute("PopupForm") PopupDto popupDto,
                                            HttpServletRequest req,
                                                HttpServletResponse rep) throws Exception {
        int size = files.size();

        if(size >0 ){
            final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
            for(MultipartFile file : files) {
                uploadItems.put(file.getOriginalFilename(), file);
            }

            String atchFileId = popupDto.getAtchFileId();

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

            popupDto.setAtchFileId(atchFileId);

        }

        Map<String,Object> model = new HashMap<String, Object>();
        popupService.savePopup(popupDto);
        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");
        return new ModelAndView("/mng/popup/popupRegit", model);

    }

    /**
     * 삭제
     * @param popupDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/popup/popupDelete.do/")
    public ModelAndView deletePopup(@ModelAttribute("PopupForm") PopupDto popupDto,
                                        HttpServletRequest req,
                                            HttpServletResponse rep) throws Exception {
        popupService.deletePopup(popupDto);

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("message", messageSource.getMessage("success.common.delete"));
        model.put("result","OK");

        return new ModelAndView("/mng/popup/popupRegit", model);
    }

    /**
     *
     * @param data
     * @return
     */
    protected String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }

        String ret = data;

        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");

        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");

        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");

        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");

        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

        return ret;
    }

}
