package kr.go.gyeongnam.human.service.exprn;

import kr.go.gyeongnam.human.dto.exprn.CalendarDto;
import kr.go.gyeongnam.human.dto.exprn.ExprnDto;
import kr.go.gyeongnam.human.dto.exprn.ExprnLectureDto;
import kr.go.gyeongnam.human.dto.exprn.criteria.ExprnCriteria;

import java.util.List;
import java.util.Map;

public interface ExprnService {

    /**
     * 일일체험 저장/수정
     * @param ExprnDto
     * @throws Exception
     */
    void saveExprn(ExprnDto ExprnDto) throws Exception;

    /**
     * 일일체험 삭제
     * @param ExprnDto
     * @throws Exception
     */
    void deleteExprn(ExprnDto ExprnDto) throws Exception;

    /**
     * 일일체험 리스트
     * @param exprnCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getExprnListMap(ExprnCriteria exprnCriteria) throws Exception;

    /**
     * ryan.lee added
     * 프로그램 안내 리스트
     * @param exprnCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getExprnPgmListMap(ExprnCriteria exprnCriteria) throws Exception;

    /**
     * 일일체험 정보
     * @param ExprnDto
     * @return
     * @throws Exception
     */
    ExprnDto getExprn(ExprnDto ExprnDto) throws Exception;

    /**
     * 달력 리스트
     * @param calendarDto
     * @return
     * @throws Exception
     */
    List<CalendarDto> getCalendarList(CalendarDto calendarDto) throws Exception;

    List<ExprnLectureDto> getExprnLectureList(ExprnCriteria exprnCriteria) throws Exception;

    /**
     * 일일체험일정 저장/수정
     * @param ExprnLectureDto
     * @throws Exception
     */
    void saveExprnLecture(ExprnLectureDto ExprnLectureDto) throws Exception;

    /**
     * 일일체험일정 삭제
     * @param ExprnLectureDto
     * @throws Exception
     */
    void deleteExprnLecture(ExprnLectureDto ExprnLectureDto) throws Exception;

    /**
     * 일일체험일정 리스트
     * @param exprnCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getExprnLectureListMap(ExprnCriteria exprnCriteria) throws Exception;

    /**
     * 일일체험일정 정보
     * @param ExprnLectureDto
     * @return
     * @throws Exception
     */
    ExprnLectureDto getExprnLecture(ExprnLectureDto ExprnLectureDto) throws Exception;


    /** rayn.lee added
     * 2018.07.17
     * 일일체험 시간별 예약자 리스트
     * @param ExprnLectureDto
     * @throws Exception
     */
    Map<String, Object> getExprnLectureReqListMap(ExprnLectureDto ExprnLectureDto) throws Exception;

    /** david.cho add
     * 2019.05.30
     * 프로그램 시간별 예약자 리스트
     * @param prgmDto
     * @throws Exception
     */
    Map<String, Object> getExprnPrgmReqListMap(ExprnDto prgmDto) throws Exception;

}
