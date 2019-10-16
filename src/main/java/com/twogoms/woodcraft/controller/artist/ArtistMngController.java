package com.twogoms.woodcraft.controller.artist;

import com.twogoms.woodcraft.dto.artist.ArtistDto;
import com.twogoms.woodcraft.dto.artist.criteria.ArtistCriteria;
import com.twogoms.woodcraft.service.artist.ArtistService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.EgovUserDetailsService;
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

/**
 * 작가 관리자 Controller
 */
@Controller
@RequestMapping("/mng")
public class ArtistMngController {

    @Resource(name = "egovMessageSource")
    private EgovMessageSource messageSource;

    @Autowired
    private EgovFileMngService egovFileMngService;

    @Autowired
    private EgovFileMngUtil egovFileMngUtil;

    @Resource(name="propertiesService")
    private EgovPropertyService propertyService;

    @Autowired
    private ArtistService artistService;


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

    /**
     * 목공예인 리스트(조회)
     * @param artistCriteria
     * @param pageIndex
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/artist/artistList.do")
    public ModelAndView getArtistList(@ModelAttribute("frmSearch")ArtistCriteria artistCriteria,
                                         @RequestParam(value="pageIndex",required = false) String pageIndex,
                                           HttpServletRequest req,
                                             HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            artistCriteria.setPageIndex(Integer.parseInt(pageIndex));

        artistCriteria.setPageUnit(propertyService.getInt("pageUnit"));
        artistCriteria.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(artistCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(artistCriteria.getPageUnit());
        paginationInfo.setPageSize(artistCriteria.getPageSize());

        artistCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        artistCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        artistCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> retMap = artistService.getArtistListMap(artistCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", artistCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mng/artist/artistList", modelMap);
    }


    /** create Form */
    @RequestMapping(value = "/artist/artistRegit.do")
    public ModelAndView goArtistForm(@ModelAttribute("ArtistForm") ArtistDto artistDto,
                                      HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {
        Map<String,Object> model = new HashMap<String, Object>();
        return new ModelAndView("/mng/artist/artistRegit", model);

    }

    /**
     * 등록/수정
     * @param artistDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/artist/artistSave.do" , method = RequestMethod.POST)
    public ModelAndView saveArtist(@RequestParam List<MultipartFile> files,
                                   @RequestParam List<MultipartFile> files2,
                                   @ModelAttribute("ArtistForm") ArtistDto artistDto,
                                   HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        int size = files.size();
        if(size > 0) {

            final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
            for(MultipartFile file : files) {
                uploadItems.put(file.getOriginalFilename(), file);
            }

            String atchFileId = artistDto.getAtchFileId();

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

            artistDto.setAtchFileId(atchFileId);
        }

        size = files2.size();
        if(size > 0) {

            final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
            for(MultipartFile file : files2) {
                uploadItems.put(file.getOriginalFilename(), file);
            }

            String atchFileId = artistDto.getAtchFileId2();

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

            artistDto.setAtchFileId2(atchFileId);
        }

        Map<String,Object> model = new HashMap<String, Object>();
        artistService.saveArtist(artistDto);
        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/artist/artistRegit", model);
    }

    /**
     * 상세
     * @param artistDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/artist/artistView.do")
    public ModelAndView getArtist(@ModelAttribute("ArtistForm")  ArtistDto artistDto,
                                     HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        Map<String,Object> model = new HashMap<String, Object>();

        artistDto = artistService.getArtist(artistDto);

        if(artistDto.getAtchFileId() !=null){
            String file_id = artistDto.getAtchFileId();
            FileVO fvo;

            if(!file_id.equals("")){
                fvo = new FileVO();
                fvo.setAtchFileId(file_id);
                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                model.put("fileResult",fRS);
            }
        }

        if(artistDto.getAtchFileId2() !=null){
            String file_id = artistDto.getAtchFileId2();
            FileVO fvo;

            if(!file_id.equals("")){
                fvo = new FileVO();
                fvo.setAtchFileId(file_id);
                List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                model.put("fileResult2",fRS);
            }
        }

        model.put("ArtistForm", artistDto);

        return new ModelAndView("/mng/artist/artistRegit", model);

    }

    /**
     * 삭제
     * @param artistDto
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/artist/artistDelete.do")
    public ModelAndView deleteArtist(@ModelAttribute("ArtistForm") ArtistDto artistDto,
                                        HttpServletRequest req,
                                            HttpServletResponse rep) throws Exception {

        artistService.deleteArtist(artistDto);

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("message", messageSource.getMessage("success.common.delete"));
        model.put("result","OK");

        return new ModelAndView("/mng/artist/artistRegit", model);

    }

}
