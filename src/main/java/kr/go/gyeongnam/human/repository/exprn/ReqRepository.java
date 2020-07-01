package kr.go.gyeongnam.human.repository.exprn;

import kr.go.gyeongnam.human.dto.exprn.ReqDto;
import kr.go.gyeongnam.human.dto.exprn.criteria.ReqCriteria;
import kr.go.gyeongnam.human.dto.wcrf.WcrfBuyDto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("reqRepository")
public interface ReqRepository {

    /**
     * 목록
     * @param reqCriteria
     * @return
     */
    List<ReqDto> getReqList(ReqCriteria reqCriteria);

    /**
     * 목록건수
     * @param reqCriteria
     * @return
     */
    int getReqListCount(ReqCriteria reqCriteria);

    /**
     * 상세
     * @param reqDto
     * @return
     */
    ReqDto getReq(ReqDto reqDto);

    /**
     * 등록
     * @param reqDto
     */
    void insertReq(ReqDto reqDto);

    /**
     * 수정
     * @param reqDto
     */
    void updateReq(ReqDto reqDto);

    /**
     * 삭제
     * @param reqDto
     */
    void deleteReq(ReqDto reqDto);

    /**
     * 상세
     * @param reqDto
     * @return
     */
    WcrfBuyDto getReqPay(ReqDto reqDto);

    /**
     * 잔여예약가능수
     * @param reqCriteria
     * @return
     */
    int getReqSumByDay(ReqCriteria reqCriteria);

}