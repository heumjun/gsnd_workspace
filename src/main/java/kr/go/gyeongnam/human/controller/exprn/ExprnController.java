package kr.go.gyeongnam.human.controller.exprn;

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
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.go.gyeongnam.human.constant.HumanConstant;
import kr.go.gyeongnam.human.dto.exprn.*;
import kr.go.gyeongnam.human.dto.exprn.criteria.ExprnCriteria;
import kr.go.gyeongnam.human.dto.exprn.criteria.ReqCriteria;
import kr.go.gyeongnam.human.dto.wcrf.WcrfBuyDto;
import kr.go.gyeongnam.human.service.exprn.ExprnService;
import kr.go.gyeongnam.human.service.exprn.ReqService;
import kr.go.gyeongnam.human.service.wcrf.WcrfBuyService;
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
 * 체험 Controller
 */
@Controller
@RequestMapping("/exprn")
public class ExprnController {

    /** EgovMessageSource */
    @Resource(name = "egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Autowired
    private ExprnService exprnService;

    @Autowired
    private ReqService reqService;

    @Autowired
    private WcrfBuyService wcrfBuyService;

    @Resource(name = "wcrfOrerSeqGnrService")
    private EgovIdGnrService wcrfOrerSeqGnrService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    @Autowired
    private EgovFileMngService egovFileMngService;

    /**
     * 일일 체험 안내
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnIntro.do")
    public ModelAndView getExprnIntro(HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/exprn/04_05", model);
    }

    /**
     * 일일체험 리스트
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnList.do")
    public ModelAndView getExprnList(@ModelAttribute("frmSearch") ExprnCriteria exprnCriteria,
                                     @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        if (pageIndex!= null)
            exprnCriteria.setPageIndex(Integer.parseInt(pageIndex));

        exprnCriteria.setPageUnit(10);
        exprnCriteria.setPageSize(10);

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

        return new ModelAndView("/exprn/04_06", modelMap);
    }

    /**
     * 일일체험 상세
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnView.do")
    public ModelAndView getExprnView(@ModelAttribute("ExprnForm") ExprnDto exprnDto,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        exprnDto = exprnService.getExprn(exprnDto);

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("ExprnForm", exprnDto);

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

        return new ModelAndView("/exprn/04_07", model);
    }

    /**
     * 일일체험 예약
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnReqRegit.do")
    public ModelAndView getExprnReqRegit(@ModelAttribute("ExprnForm") ExprnDto exprnDto,
                                         @RequestParam Map<String, String> commandMap,
                                        HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        model.put("ExprnForm", exprnDto);

        long time = System.currentTimeMillis();
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
        String strDay = dayTime.format(new Date(time));

        String year = "";
        String yearMonth = "";
        if (!EgovStringUtil.isEmpty(commandMap.get("yearMonth"))) {
            year = commandMap.get("yearMonth").substring(0, 4);
            yearMonth = commandMap.get("yearMonth");
        } else {
            yearMonth = strDay.substring(0, 6);
            year = strDay.substring(0, 4);
        }

        CalendarDto calendarDto = new CalendarDto();
        calendarDto.setYear(year);
        calendarDto.setYearMonth(yearMonth);

        List<CalendarDto> list = exprnService.getCalendarList(calendarDto);
        model.put("calendarList", list);

        // 09:00-12:00 13:00-17:00 18:00-21:00
        // 현재의 형태 예약가능날짜만 등록
        String mode = "02";

        List<ExprnDetailDto> list2 = new ArrayList();

        // 기존 설계방식
        if (mode.equals("01")) {

            // 월요일은 휴관일
            for (CalendarDto calendarDto2 : list) {
                String day = calendarDto2.getMon();
                ExprnDetailDto detailDto = new ExprnDetailDto();
                detailDto.setDay(day);
                detailDto.setCode("01");
                detailDto.setStyle("st0");
                detailDto.setText2("휴관일");
                detailDto.setText3("휴");
                list2.add(detailDto);
            }

            String[] array = {"09:00-12:00", "13:00-17:00", "18:00-21:00"};

            int index = 0;
            // 공휴일 설정
            for (String str : array) {
                ExprnDetailDto detailDto = new ExprnDetailDto();
                detailDto.setDay("13");
                detailDto.setCode("04");
                detailDto.setText("지방선거");
                detailDto.setStyle("st4");
                detailDto.setText2("예약불가(운영 측 사정)");
                detailDto.setText3("불");
                detailDto.setIndex(String.valueOf(index));
                list2.add(detailDto);
                index++;
            }

            // 내일날짜까지 예약불가 설정
            for (int i=1; i<=13; i++) {

                index = 0;
                for (String str : array) {

                    if (!checkCal(list2, String.valueOf(i), index)) {
                        index++;
                        continue;
                    }

                    ExprnDetailDto detailDto = new ExprnDetailDto();
                    detailDto.setDay(String.valueOf(i));
                    detailDto.setCode("03");
                    detailDto.setText(str);
                    detailDto.setStyle("st2");
                    detailDto.setText2("예약기간종료");
                    detailDto.setText3("종");
                    detailDto.setIndex(String.valueOf(index));
                    list2.add(detailDto);
                    index++;
                }
            }

            // 내일날짜까지 예약불가 설정
            for (int i=14; i<=31; i++) {

                index = 0;
                for (String str : array) {

                    if (!checkCal(list2, String.valueOf(i), index)) {
                        index++;
                        continue;
                    }

                    ExprnDetailDto detailDto = new ExprnDetailDto();
                    detailDto.setDay(String.valueOf(i));
                    detailDto.setCode("02");
                    detailDto.setText(str);
                    detailDto.setStyle("st1");
                    detailDto.setText2("예약가능");
                    detailDto.setText3("예");
                    detailDto.setText4("(20명 예약가능)");
                    detailDto.setIndex(String.valueOf(index));
                    list2.add(detailDto);
                    index++;
                }
            }

        } else if (mode.equals("02")) {

            //휴관일 주석처리
            //월요일은 휴관일
            //for (CalendarDto calendarDto2 : list) {
            //    String day = calendarDto2.getMon();
            //    ExprnDetailDto detailDto = new ExprnDetailDto();
            //    detailDto.setDay(day);
            //    detailDto.setCode("01");
            //    detailDto.setStyle("st0");
            //    detailDto.setText2("휴관일");
            //    detailDto.setText3("휴");
            //    list2.add(detailDto);
            //}

            //예약가능 설정
            //int[] dayArray = {7,14,21,28};
            //String[] array = {"10:00-12:00"};

            ExprnCriteria exprnCriteria = new ExprnCriteria();
            exprnCriteria.setExprnId(exprnDto.getExprnId());
            exprnCriteria.setExprnDay(yearMonth);

            List<ExprnLectureDto> list3 = exprnService.getExprnLectureList(exprnCriteria);

            ExprnDto exprnDto2 = exprnService.getExprn(exprnDto);

            for (ExprnLectureDto exprnLectureDto : list3) {

                String day = exprnLectureDto.getExprnDay();
                int intDay2 = Integer.parseInt(day);
                //String day = String.valueOf(i);
                //if (day.length() == 1) {
                //    day = "0" + i;
                //}

                //날짜별 예약명수 취득
                int cnt = Integer.parseInt(exprnDto2.getExprnNmpr());

                //day = calendarDto.getYearMonth() + day;
                ReqCriteria reqCriteria = new ReqCriteria();
                reqCriteria.setExprnId(exprnDto.getExprnId());
                reqCriteria.setExprnDay(day);
                reqCriteria.setExprnTime(exprnLectureDto.getExprnTime());
                int sum = reqService.getReqSumByDay(reqCriteria);
                cnt = cnt - sum;
                //전화예약데이터
                int cnt2 = 0;
                if (!EgovStringUtil.isEmpty(exprnLectureDto.getReservationCnt())) {
                    cnt2 = Integer.parseInt(exprnLectureDto.getReservationCnt());
                }
                cnt = cnt - cnt2;

                int index = 0;
                //for (String str : array) {

                    if (!checkCal(list2, day, index)) {
                        index++;
                        continue;
                    }

                    ExprnDetailDto detailDto = new ExprnDetailDto();
                    detailDto.setDay(String.valueOf(Integer.parseInt(day.substring(6,8))));

                    //예약인원
                    int reqNum = sum + cnt2;

                    // 현재일
                    int intDay = Integer.parseInt(strDay);
                    //날짜가 경과된경우
                    if (intDay >= intDay2) {
                        detailDto.setCode("03");
                        detailDto.setStyle("st2");
                        detailDto.setText2("예약기간종료");
                        detailDto.setText3("종");
                    } else {
                        if (cnt > 0) {
                            detailDto.setCode("02");
                            detailDto.setStyle("st1");
                            detailDto.setText2("예약가능");
                            detailDto.setText3("예");
                            detailDto.setText4("("+reqNum + " / "+exprnDto2.getExprnNmpr()+")");
                        } else {
                            detailDto.setCode("04");
                            detailDto.setStyle("st3");
                            detailDto.setText2("예약완료");
                            detailDto.setText3("완");
                        }
                    }

                    detailDto.setText(exprnLectureDto.getExprnTime());
                    detailDto.setIndex(String.valueOf(index));
                    list2.add(detailDto);
                    index++;
                //}
            }

        }

        model.put("year", year);
        model.put("month", yearMonth.substring(4,6));
        model.put("dataList", list2);

        String msgCd = commandMap.get("msgCd");
        if (msgCd != null) {
            model.put("msgCd", msgCd);
        }

        return new ModelAndView("/exprn/04_08", model);
    }

    @RequestMapping(value="/exprnReqRegitAll.do")
    public ModelAndView getExprnReqRegitAll (@RequestParam Map<String, String> commandMap,
                                                HttpServletRequest req,
                                                   HttpServletResponse rep) throws Exception{

        Map<String, Object> model = new HashMap<String, Object>();

        long time = System.currentTimeMillis();
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
        String strDay = dayTime.format(new Date(time));

        String year = "";
        String yearMonth = "";
        if (!EgovStringUtil.isEmpty(commandMap.get("yearMonth"))) {
            year = commandMap.get("yearMonth").substring(0, 4);
            yearMonth = commandMap.get("yearMonth");
        } else {
            yearMonth = strDay.substring(0, 6);
            year = strDay.substring(0, 4);
        }

        CalendarDto calendarDto = new CalendarDto();
        calendarDto.setYear(year);
        calendarDto.setYearMonth(yearMonth);

        List<CalendarDto> list = exprnService.getCalendarList(calendarDto);
        model.put("calendarList", list);

        // 09:00-12:00 13:00-17:00 18:00-21:00
        // 현재의 형태 예약가능날짜만 등록
        String mode = "02";
        List<ExprnDetailDto> list2 = new ArrayList();

        ExprnCriteria exprnCriteria = new ExprnCriteria();
        // exprnCriteria.setExprnId(exprnDto.getExprnId());
        exprnCriteria.setExprnDay(yearMonth);

        List<ExprnLectureDto> list3 = exprnService.getExprnLectureList(exprnCriteria);

        for (ExprnLectureDto exprnLectureDto : list3) {

            // 신규추가
            ExprnDto exprnDto = new ExprnDto();
            exprnDto.setExprnId(exprnLectureDto.getExprnId());

            ExprnDto exprnDto2 = exprnService.getExprn(exprnDto);
            // 추가종료

            String day = exprnLectureDto.getExprnDay();
            int intDay2 = Integer.parseInt(day);


            //날짜별 예약명수 취득
            int cnt = 0;
            if(exprnLectureDto.getExprnNmlc() != null){
                cnt = Integer.parseInt(exprnLectureDto.getExprnNmlc());
            } else {
                cnt = Integer.parseInt(exprnDto2.getExprnNmpr());
            }
//            int cnt = Integer.parseInt(exprnDto2.getExprnNmpr());

            ReqCriteria reqCriteria = new ReqCriteria();
            reqCriteria.setExprnId(exprnDto.getExprnId());
            reqCriteria.setExprnDay(day);
            reqCriteria.setExprnTime(exprnLectureDto.getExprnTime());
            int sum = reqService.getReqSumByDay(reqCriteria);
            cnt = cnt - sum;
            //전화예약데이터
            int cnt2 = 0;
            if (!EgovStringUtil.isEmpty(exprnLectureDto.getReservationCnt())) {
                cnt2 = Integer.parseInt(exprnLectureDto.getReservationCnt());
            }
            cnt = cnt - cnt2;

            int index = 0;

            if (!checkCal(list2, day, index)) {
                index++;
                continue;
            }

            ExprnDetailDto detailDto = new ExprnDetailDto();
            detailDto.setDay(String.valueOf(Integer.parseInt(day.substring(6,8))));

            //예약인원
            int reqNum = sum + cnt2;

            // 현재일
            int intDay = Integer.parseInt(strDay);
            //날짜가 경과된경우
            if (intDay >= intDay2) {
                detailDto.setCode("03");
                detailDto.setStyle("st2");
                detailDto.setText2("예약기간종료");
                detailDto.setText3("종");
            } else {
                if (cnt > 0) {
                    detailDto.setCode("02");
                    detailDto.setStyle("st1");
                    detailDto.setText2("예약가능");
                    detailDto.setText3("예");
                    if(exprnLectureDto.getExprnNmlc() != null){
                        detailDto.setText4("("+reqNum + " / "+exprnLectureDto.getExprnNmlc()+")");
                    } else {
                        detailDto.setText4("("+reqNum + " / "+exprnDto2.getExprnNmpr()+")");
                    }
                } else {
                    detailDto.setCode("04");
                    detailDto.setStyle("st3");
                    detailDto.setText2("예약완료");
                    detailDto.setText3("완");
                }
            }

            detailDto.setText(exprnLectureDto.getExprnTime());
            detailDto.setIndex(String.valueOf(index));
            // 신규추가
            detailDto.setExprnId(exprnDto2.getExprnId());
            detailDto.setExprnNm(exprnDto2.getExprnNm());

            list2.add(detailDto);
            index++;
        }

        model.put("year", year);
        model.put("month", yearMonth.substring(4,6));
        model.put("dataList", list2);

        String msgCd = commandMap.get("msgCd");
        if (msgCd != null) {
            model.put("msgCd", msgCd);
        }

        return new ModelAndView("/exprn/04_08_01", model);

    }


    private boolean checkCal(List<ExprnDetailDto> list, String day, int index) {

        for (ExprnDetailDto dto : list) {

            String day2 = dto.getDay();
            String index2 = dto.getIndex();

            if (day.equals(day2)) {
                if (dto.getCode().equals("01")) {
                    return false;
                }
                if (day.equals(day2)) {
                    if (index2.equals(String.valueOf(index))) {
                        return false;
                    }
                }
            }
        }

        return true;
    }

    /**
     * 일일체험 결재
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnPay.do")
    public ModelAndView getExprnPay(@ModelAttribute("ExprnForm") ExprnDto exprnDto,
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

            req.getSession().setAttribute(HumanConstant.SessionAttribute.BEFORE_LOGIN_URL, beforeURL);

            mv.setViewName("redirect:/login.do");
            return mv;
        }

        //로그인유저
        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        String tempDay = commandMap.get("day");
        if (tempDay.length() == 1) {
            tempDay = "0" + tempDay;
        }

        String day = commandMap.get("yearMonth") + tempDay;
        String time = commandMap.get("time");

        // 본인 예약체크
        ReqCriteria reqCriteria = new ReqCriteria();
        reqCriteria.setExprnId(exprnDto.getExprnId());
        reqCriteria.setMberId(loginVO.getId());
        reqCriteria.setExprnDay(day);

        //7월 일일체험만 1인1회로 제한
//        if (!exprnDto.getExprnId().equals("EXPRN0000001364")) {
//            reqCriteria.setExprnDay(day);
//        }

        int sum = reqService.getReqSumByDay(reqCriteria);

        if (sum > 0) {

            Map<String, Object> modelMap = new HashMap<String, Object>();
            modelMap.put("msgCd", "ERR001");
            modelMap.put("exprnId", exprnDto.getExprnId());
            modelMap.put("yearMonth", commandMap.get("yearMonth"));
            return new ModelAndView("redirect:/exprn/exprnReqRegitAll.do", modelMap);
        }

        exprnDto = exprnService.getExprn(exprnDto);

        ReqDto reqDto = new ReqDto();

        reqDto.setReqNm(loginVO.getName());
        reqDto.setReqEmail(loginVO.getEmail());
        if (!EgovStringUtil.isEmpty(loginVO.getHp()) && loginVO.getHp().length() >= 12) {
            String[] array = loginVO.getHp().split("-");
            reqDto.setTelNo(array[0]);
            reqDto.setTelNoMid(array[1]);
            reqDto.setTelNoLast(array[2]);
        }

        reqDto.setExprnDay(day);
        reqDto.setExprnTime(time);

        model.put("ReqForm", reqDto);

        ExprnLectureDto ExprnLectureDto = new ExprnLectureDto();
        ExprnLectureDto.setExprnId(exprnDto.getExprnId());
        ExprnLectureDto.setExprnDay(day);
        ExprnLectureDto.setExprnTime(time);

        kr.go.gyeongnam.human.dto.exprn.ExprnLectureDto exprnLectureDto2 = exprnService.getExprnLecture(ExprnLectureDto);
        int cnt = 0;
        if (!EgovStringUtil.isEmpty(exprnLectureDto2.getExprnReqCnt())) {
            cnt = Integer.parseInt(exprnLectureDto2.getExprnReqCnt());
        }
        int cnt2 = 0;
        if (!EgovStringUtil.isEmpty(exprnLectureDto2.getReservationCnt())) {
            cnt2 = Integer.parseInt(exprnLectureDto2.getReservationCnt());
        }
        exprnDto.setReqCnt(String.valueOf(cnt + cnt2));

        model.put("ExprnForm", exprnDto);

        return new ModelAndView("/exprn/04_09", model);
    }

    /**
     * 일일체험 결재정보 저장(임시 페이지)
     * 결재모듈 확인 후 공통으로 변경 가능
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnListSave.do")
    public ModelAndView exprnListSave(@ModelAttribute("ReqForm") ReqDto reqDto,
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

        //reqDto.setReqNm(loginVO.getName());
        //reqDto.setReqEmail(loginVO.getEmail());
        //reqDto.setTelNo(loginVO.getHp());

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

        return new ModelAndView("/exprn/04_10", model);
    }

    /**
     * 목공예품 결재(임시 페이지)
     * 결재모듈 확인 후 공통으로 변경 가능
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exprnPaySave.do")
    public ModelAndView exprnPaySave(@ModelAttribute("ReqForm") ReqDto reqDto,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        WcrfBuyDto wcrfBuyDto = reqService.getReqPay(reqDto);

        // ryan.lee added
        // 2018.07.23
        // 현장결제 항목 추가 (제은정 주무관님 요청)
        // 주문확인 처리 (무통자입금의 경우 결제대기로 변경)
        if (wcrfBuyDto.getSetleSe().equals("02") || wcrfBuyDto.getSetleSe().equals("03")) {

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

        return new ModelAndView("/exprn/04_11", model);
    }

    /**
     * 일일체험 결제성공
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
