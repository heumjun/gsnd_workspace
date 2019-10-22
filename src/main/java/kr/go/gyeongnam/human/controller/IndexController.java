package kr.go.gyeongnam.human.controller;

import egovframework.com.cop.bbs.service.BoardMasterVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.com.cop.bbs.service.EgovBBSManageService;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.go.gyeongnam.human.dto.artist.criteria.ArtistCriteria;
import kr.go.gyeongnam.human.dto.cmm.criteria.PopupCriteria;
import kr.go.gyeongnam.human.dto.exprn.criteria.ExprnCriteria;
import kr.go.gyeongnam.human.dto.wcrf.criteria.WcrfCriteria;
import kr.go.gyeongnam.human.service.artist.ArtistService;
import kr.go.gyeongnam.human.service.cmm.PopupService;
import kr.go.gyeongnam.human.service.exprn.ExprnService;
import kr.go.gyeongnam.human.service.wcrf.WcrfService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

@Controller
public class IndexController {

    @Autowired
    private ArtistService artistService;

    @Autowired
    private WcrfService wcrfService;

    @Autowired
    private ExprnService exprnService;

    @Autowired
    private PopupService popupService;

    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;

    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;

    /**
     * 메인화면
     * @param request
     * @param response
     * @param modelMap
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = "/index.do")
    public ModelAndView pageIndex(HttpServletRequest request,
                                  HttpServletResponse response,
                                  ModelMap modelMap) throws Exception {

        EgovSessionCookieUtil.removeSessionAttribute(request, "currentMenu");

        ArtistCriteria artistCriteria = new ArtistCriteria();

        artistCriteria.setPageIndex(1);
        artistCriteria.setPageUnit(100);
        artistCriteria.setPageSize(100);

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

        modelMap.put("artistList", retMap.get("retList"));

        //목공예품
        WcrfCriteria wcrfCriteria = new WcrfCriteria();
        wcrfCriteria.setPageUnit(8);
        wcrfCriteria.setPageSize(10);

        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(wcrfCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(wcrfCriteria.getPageUnit());
        paginationInfo.setPageSize(wcrfCriteria.getPageSize());

        wcrfCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        wcrfCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        wcrfCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        retMap = wcrfService.getWcrfListMap(wcrfCriteria);
        totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        modelMap.put("wcrfList", retMap.get("retList"));

        // 일일체험 / 프로그램
        ExprnCriteria exprnCriteria = new ExprnCriteria();
        exprnCriteria.setPageUnit(2);
        exprnCriteria.setPageSize(10);

        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(exprnCriteria.getPageIndex());
        paginationInfo.setRecordCountPerPage(exprnCriteria.getPageUnit());
        paginationInfo.setPageSize(exprnCriteria.getPageSize());

        exprnCriteria.setFirstIndex(paginationInfo.getFirstRecordIndex());
        exprnCriteria.setLastIndex(paginationInfo.getLastRecordIndex());
        exprnCriteria.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        retMap = exprnService.getExprnListMap(exprnCriteria);
        totalCnt = Integer.parseInt(retMap.get("retCnt").toString());
        paginationInfo.setTotalRecordCount(totalCnt);

        modelMap.put("exprnList", retMap.get("retList"));

        // 공지사항
        String bbsId = "BBSMSTR_000000000011";

        BoardVO boardVO = new BoardVO();
        boardVO.setPageUnit(1);
        boardVO.setPageSize(10);
        boardVO.setBbsId(bbsId);

        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());

        boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
        boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        BoardMasterVO vo = new BoardMasterVO();

        vo.setBbsId(boardVO.getBbsId());
        BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);

        // 유효한 게시물만 추출
        boardVO.setUseAt("Y");

        //Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
        Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, master.getBbsAttrbCode());
        int totCnt = Integer.parseInt((String)map.get("resultCnt"));
        paginationInfo.setTotalRecordCount(totCnt);

        modelMap.put("boardList", map.get("resultList"));


        // 팝업 존 가져오기
        PopupCriteria popupCriteria = new PopupCriteria();
        popupCriteria.setUseYn("Y");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());

        popupCriteria.setSearchStrtDe(strToday);
        popupCriteria.setSearchEndDe(strToday);

        retMap = popupService.getPopupListMap(popupCriteria);
        modelMap.put("popupList", retMap.get("retList"));

        return new ModelAndView("index", modelMap);
    }
}
