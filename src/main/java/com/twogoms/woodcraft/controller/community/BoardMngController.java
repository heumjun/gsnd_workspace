package com.twogoms.woodcraft.controller.community;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.*;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/mng/community/")
public class BoardMngController {

    @Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;

    @Resource(name = "EgovBBSAttributeManageService")
    private EgovBBSAttributeManageService bbsAttrbService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    //---------------------------------
    // 2009.06.29 : 2단계 기능 추가
    // 2011.07.01 : 댓글, 스크랩, 만족도 조사 기능의 종속성 제거
    //---------------------------------
    @Autowired(required=false)
    private EgovBBSCommentService bbsCommentService;

    @Autowired(required=false)
    private EgovBBSSatisfactionService bbsSatisfactionService;

    @Autowired(required=false)
    private EgovBBSScrapService bbsScrapService;
    ////-------------------------------

    @Autowired
    private EgovFileMngService egovFileMngService;

    @Autowired
    private EgovFileMngUtil egovFileMngUtil;

    /**
     * XSS 방지 처리.
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

    /**
     * 공통게시판 리스트  (임시)
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/list/{Id}.do")
    public ModelAndView pageBoardList(@PathVariable("Id") String boardId,
                                      @ModelAttribute("searchVO") BoardVO boardVO,
                                     HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        String page = "boardList";
        String menuNo = "11501000";

        if ("000000000012".equalsIgnoreCase(boardId)) {
            menuNo = "11502000";
        } else if ("000000000022".equalsIgnoreCase(boardId)) {
            menuNo = "11504000";
        } else if ("000000000021".equalsIgnoreCase(boardId)) {
            menuNo = "11503000";
        }

        String bbsId = "BBSMSTR_" + boardId;
        boardVO.setBbsId(bbsId);

        model.put("bbsId", bbsId);
        model.put("boardId", boardId);
        model.put("menuNo", menuNo);

        //LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        //log.debug(this.getClass().getName() + " user.getId() "+ user.getId());
        //log.debug(this.getClass().getName() + " user.getName() "+ user.getName());
        //log.debug(this.getClass().getName() + " user.getUniqId() "+ user.getUniqId());
        //log.debug(this.getClass().getName() + " user.getOrgnztId() "+ user.getOrgnztId());
        //log.debug(this.getClass().getName() + " user.getUserSe() "+ user.getUserSe());
        //log.debug(this.getClass().getName() + " user.getEmail() "+ user.getEmail());

        //String attrbFlag = "";

        boardVO.setBbsId(boardVO.getBbsId());
        boardVO.setBbsNm(boardVO.getBbsNm());

        BoardMasterVO vo = new BoardMasterVO();

        vo.setBbsId(boardVO.getBbsId());
        //vo.setUniqId(user.getUniqId());

        BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);

        //-------------------------------
        // 방명록이면 방명록 URL로 forward
        //-------------------------------
        //if (master.getBbsTyCode().equals("BBST04")) {
        //    return "forward:/cop/bbs/selectGuestList.do";
        //}
        ////-----------------------------

        boardVO.setPageUnit(propertyService.getInt("pageUnit"));
        boardVO.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());

        boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
        boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        //Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
        Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, master.getBbsAttrbCode());//2011.09.07
        int totCnt = Integer.parseInt((String)map.get("resultCnt"));

        paginationInfo.setTotalRecordCount(totCnt);

        //-------------------------------
        // 기본 BBS template 지정
        //-------------------------------
        if (master.getTmplatCours() == null || master.getTmplatCours().equals("")) {
            master.setTmplatCours("/css/egovframework/com/cop/tpl/egovBaseTemplate.css");
        }
        ////-----------------------------

        model.put("resultList", map.get("resultList"));
        model.put("resultCnt", map.get("resultCnt"));
        model.put("boardVO", boardVO);
        model.put("brdMstrVO", master);
        model.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mng/community/" + page,  model);
    }

    /**
     * 공통게시판 등록 (임시)
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/regist/{Id}.do")
    public ModelAndView pageRegist(@PathVariable("Id") String boardId,
                                   @RequestParam Map<String, String> commandMap,
                                      HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        String page = "boardRegit";
        String menuNo = "11501000";

        if ("000000000012".equalsIgnoreCase(boardId)) {
            menuNo = "11502000";
        } else if ("000000000022".equalsIgnoreCase(boardId)) {
            menuNo = "11504000";
        } else if ("000000000021".equalsIgnoreCase(boardId)) {
            menuNo = "11503000";
        }

        String bbsId = "BBSMSTR_" + boardId;

        model.put("bbsId", bbsId);
        model.put("boardId", boardId);
        model.put("menuNo", menuNo);

        String nttId = (String)commandMap.get("nttId");

        if (!EgovStringUtil.isEmpty(nttId)) {

            BoardVO boardVO = new BoardVO();
            boardVO.setBbsId(bbsId);
            boardVO.setNttId(Integer.parseInt(nttId));

            BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

            model.put("board", vo);

            if(vo.getAtchFileId() !=null){
                String file_id = vo.getAtchFileId();
                FileVO fvo;

                if(!file_id.equals("")){
                    fvo = new FileVO();
                    fvo.setAtchFileId(file_id);
                    List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                    model.put("fileResult",fRS);
                }
            }

        } else {
            model.put("board", new BoardVO());
        }

        return new ModelAndView("/mng/community/" + page, model);
    }

    /**
     * 답글 페이지로 이동
     * @param boardId
     * @param commandMap
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/reply/{Id}.do")
    public ModelAndView pageReplyRegist(@PathVariable("Id") String boardId,
                                        @RequestParam Map<String, String> commandMap,
                                        HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        String page = "boardReplyRegit";
        String menuNo = "11501000";

        if ("000000000012".equalsIgnoreCase(boardId)) {
            menuNo = "11502000";
        } else if ("000000000022".equalsIgnoreCase(boardId)) {
            menuNo = "11504000";
        } else if ("000000000021".equalsIgnoreCase(boardId)) {
            menuNo = "11503000";
        }

        String bbsId = "BBSMSTR_" + boardId;

        model.put("bbsId", bbsId);
        model.put("boardId", boardId);
        model.put("menuNo", menuNo);

        String nttId = (String)commandMap.get("nttId");

        if (!EgovStringUtil.isEmpty(nttId)) {

            BoardVO boardVO = new BoardVO();
            boardVO.setBbsId(bbsId);
            boardVO.setNttId(Integer.parseInt(nttId));

            BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

            model.put("board", vo);

            if(vo.getAtchFileId() !=null){
                String file_id = vo.getAtchFileId();
                FileVO fvo;

                if(!file_id.equals("")){
                    fvo = new FileVO();
                    fvo.setAtchFileId(file_id);
                    List<FileVO> fRS = egovFileMngService.selectFileInfs(fvo);
                    model.put("fileResult",fRS);
                }
            }

        } else {
            model.put("board", new BoardVO());
        }

        return new ModelAndView("/mng/community/" + page, model);

    }


    @RequestMapping(method = RequestMethod.POST, value="/replySave/{Id}.do")
    public ModelAndView procBoardReplySave(@PathVariable("Id") String boardId,
                                           @ModelAttribute("board") Board board,
                                           @RequestParam List<MultipartFile> files,
                                           HttpServletRequest req,
                                           HttpServletResponse rep) throws Exception {

        String page = "05_08";
        String menuNo = "11501000";

        if ("000000000012".equalsIgnoreCase(boardId)) {
            menuNo = "11502000";
        } else if ("000000000022".equalsIgnoreCase(boardId)) {
            menuNo = "11504000";
        } else if ("000000000021".equalsIgnoreCase(boardId)) {
            menuNo = "11503000";
        }

        String bbsId = "BBSMSTR_" + boardId;

        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

        Map<String, Object> model = new HashMap<String, Object>();

        //오류처리...

        if (isAuthenticated) {
            int size = files.size();
            if (size > 0) {

                final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
                for(MultipartFile file : files) {
                    uploadItems.put(file.getOriginalFilename(), file);
                }

                String atchFileId = board.getAtchFileId();

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

                board.setAtchFileId(atchFileId);
            }

            // if (board.getNttId() == 0L) {
                board.setFrstRegisterId(user.getUniqId());
                board.setBbsId(bbsId);
                board.setParnts(Long.toString(board.getNttId()));
                board.setSortOrdr(board.getSortOrdr());
                board.setReplyLc(Integer.toString(Integer.parseInt(board.getReplyLc()) + 1));
                board.setReplyAt("Y");
                board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)

                board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
                board.setNtcrNm(user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장

                board.setNttCn(unscript(board.getNttCn()));	// XSS 방지

                bbsMngService.insertBoardArticle(board);

        }

        model.put("bbsId", bbsId);
        model.put("boardId", boardId);
        model.put("menuNo", menuNo);

        //model.put("message", "저장되었습니다.");

        return new ModelAndView("redirect:/mng/community/list/"+boardId+".do", model);
    }



        /**
         * 공통게시판 등록/수정  (임시)
         * @param boardId
         * @param board
         * @return
         * @throws Exception
         */
    @RequestMapping(method = RequestMethod.POST, value="/save/{Id}.do")
    public ModelAndView procBoardSave(@PathVariable("Id") String boardId,
                                      @ModelAttribute("board") Board board,
                                      @RequestParam List<MultipartFile> files,
                                      HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        String page = "05_08";
        String menuNo = "11501000";

        if ("000000000012".equalsIgnoreCase(boardId)) {
            menuNo = "11502000";
        } else if ("000000000022".equalsIgnoreCase(boardId)) {
            menuNo = "11504000";
        } else if ("000000000021".equalsIgnoreCase(boardId)) {
            menuNo = "11503000";
        }

        String bbsId = "BBSMSTR_" + boardId;

        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

        Map<String, Object> model = new HashMap<String, Object>();

        //오류처리...

        if (isAuthenticated) {
            int size = files.size();
            if (size > 0) {

                final Map<String, MultipartFile> uploadItems = new HashMap<String, MultipartFile>();
                for(MultipartFile file : files) {
                    uploadItems.put(file.getOriginalFilename(), file);
                }

                String atchFileId = board.getAtchFileId();

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

                board.setAtchFileId(atchFileId);
            }

            if (board.getNttId() == 0L) {
                board.setFrstRegisterId(user.getUniqId());
                board.setBbsId(bbsId);

                //board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
                board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)

                board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
                board.setNtcrNm(user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장

                board.setNttCn(unscript(board.getNttCn()));	// XSS 방지

                bbsMngService.insertBoardArticle(board);
            } else {

                board.setLastUpdusrId(user.getId());

                board.setBbsId(bbsId);
                board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
                bbsMngService.updateBoardArticle(board);
            }

        }

        model.put("bbsId", bbsId);
        model.put("boardId", boardId);
        model.put("menuNo", menuNo);

        //model.put("message", "저장되었습니다.");

        return new ModelAndView("redirect:/mng/community/list/"+boardId+".do", model);
    }

    /**
     * 공통게시판 삭제 (임시)
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/delete/{Id}.do")
    public ModelAndView procBoardDelete(@PathVariable("Id") String boardId,
                                        @RequestParam Map<String, String> commandMap,
                                        HttpServletRequest req,
                                       HttpServletResponse rep) throws Exception {

        String nttId = (String)commandMap.get("nttId");

        String bbsId = "BBSMSTR_" + boardId;

        BoardVO boardVO = new BoardVO();
        boardVO.setBbsId(bbsId);
        boardVO.setNttId(Integer.parseInt(nttId));

        bbsMngService.deleteBoardArticle(boardVO);

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("redirect:/mng/community/list/"+boardId+".do", model);
    }


}
