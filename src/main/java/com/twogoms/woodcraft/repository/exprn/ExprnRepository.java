package com.twogoms.woodcraft.repository.exprn;

import com.twogoms.woodcraft.dto.exprn.CalendarDto;
import com.twogoms.woodcraft.dto.exprn.ExprnDto;
import com.twogoms.woodcraft.dto.exprn.ExprnLectureDto;
import com.twogoms.woodcraft.dto.exprn.ReqDto;
import com.twogoms.woodcraft.dto.exprn.criteria.ExprnCriteria;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("exprnRepository")
public interface ExprnRepository {

    /**
     * 목록
     * @param exprnCriteria
     * @return
     */
    List<ExprnDto> getExprnList(ExprnCriteria exprnCriteria);

    /**
     * 목록(프로그램구분)
     * @param exprnCriteria
     * @return
     */
    List<ExprnDto> getExprnPgmList(ExprnCriteria exprnCriteria);

    int getExprnPgmListCount(ExprnCriteria exprnCriteria);

    /**
     * 목록건수
     * @param exprnCriteria
     * @return
     */
    int getExprnListCount(ExprnCriteria exprnCriteria);

    /**
     * 상세
     * @param exprnDto
     * @return
     */
    ExprnDto getExprn(ExprnDto exprnDto);

    /**
     * 등록
     * @param exprnDto
     */
    void insertExprn(ExprnDto exprnDto);

    /**
     * 수정
     * @param exprnDto
     */
    void updateExprn(ExprnDto exprnDto);

    /**
     * 삭제
     * @param exprnDto
     */
    void deleteExprn(ExprnDto exprnDto);

    /**
     * 달력
     * @param calendarDto
     * @return
     */
    List<CalendarDto> getCalendarList(CalendarDto calendarDto);

    /**
     * 체험일정 목록
     * @param exprnCriteria
     * @return
     */
    List<ExprnLectureDto> getExprnLectureList(ExprnCriteria exprnCriteria);

    /**
     * 체험일정 목록(관리자화면)
     * @param exprnCriteria
     * @return
     */
    List<ExprnLectureDto> getExprnLectureListView(ExprnCriteria exprnCriteria);

    /**
     * 목록건수
     * @param exprnCriteria
     * @return
     */
    int getExprnLectureListCount(ExprnCriteria exprnCriteria);

    /**
     * 상세
     * @param exprnLectureDto
     * @return
     */
    ExprnLectureDto getExprnLecture(ExprnLectureDto exprnLectureDto);

    /**
     * 등록
     * @param exprnLectureDto
     */
    void insertExprnLecture(ExprnLectureDto exprnLectureDto);

    /**
     * 수정
     * @param exprnLectureDto
     */
    void updateExprnLecture(ExprnLectureDto exprnLectureDto);

    /**
     * 삭제
     * @param exprnLectureDto
     */
    void deleteExprnLecture(ExprnLectureDto exprnLectureDto);

    /** rayn.lee added
     * 2018.07.17
     * 일일체험 시간별 예약자 리스트
     * @param exprnLectureDto
     * @return
     */
    List<ReqDto> getExprnLectureReqList(ExprnLectureDto exprnLectureDto);

    /** rayn.lee added
     * 2018.07.17
     * 일일체험 시간별 예약자 리스트 건수
     * @param exprnLectureDto
     * @return
     */
    int getExprnLectureReqListCnt(ExprnLectureDto exprnLectureDto);

    /** david.cho added
     * 2019.05.30
     * 프로그램 시간별 예약자 리스트
     * @param prgmDto
     * @prgmDto
     */
    List<ReqDto> getExprnPrgmReqList(ExprnDto prgmDto);

    /** david.cho added
     * 2019.05.30
     * 프로그램 시간별 예약자 리스트 건수
     * @param prgmDto
     * @prgmDto
     */
    int getExprnPrgmReqListCnt(ExprnDto prgmDto);
}
