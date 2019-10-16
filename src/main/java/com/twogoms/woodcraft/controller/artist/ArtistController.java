package com.twogoms.woodcraft.controller.artist;

import com.twogoms.woodcraft.dto.artist.criteria.ArtistCriteria;
import com.twogoms.woodcraft.service.artist.ArtistService;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
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
import java.util.HashMap;
import java.util.Map;

/**
 * 작가 Controller
 */
@Controller
@RequestMapping("/artist")
public class ArtistController {

    @Resource(name="propertiesService")
    private EgovPropertyService propertyService;

    @Autowired
    private ArtistService artistService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    /**
     * 목공예인 소개
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/artistListBack.do")
    public ModelAndView getArtistListBack(@ModelAttribute("frmSearch")ArtistCriteria artistCriteria,
                                      @RequestParam(value="pageIndex",required = false) String pageIndex,
                                      HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        //LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

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

        return new ModelAndView("/artist/03_02", modelMap);

    }

    @RequestMapping(value="/artistList.do")
    public ModelAndView getArtistList(@ModelAttribute("frmSearch")ArtistCriteria artistCriteria,
                                      @RequestParam(value="pageIndex",required = false) String pageIndex,
                                      HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        if (pageIndex!= null)
            artistCriteria.setPageIndex(Integer.parseInt(pageIndex));


        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(artistCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(artistCriteria.getPageUnit());


        artistCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        artistCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        artistCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> retMap = artistService.getArtistAllListMap(artistCriteria);
        int totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", artistCriteria);
        modelMap.put("resultList", retMap.get("retList"));
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/artist/03_02", modelMap);

    }


}
