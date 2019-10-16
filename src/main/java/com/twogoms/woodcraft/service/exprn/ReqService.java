package com.twogoms.woodcraft.service.exprn;

import com.twogoms.woodcraft.dto.exprn.ReqDto;
import com.twogoms.woodcraft.dto.exprn.criteria.ReqCriteria;
import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;

import java.util.Map;

public interface ReqService {

    /**
     * 일일체험예약 저장/수정
     * @param reqDto
     * @throws Exception
     */
    void saveReq(ReqDto reqDto) throws Exception;

    /**
     * 일일체험예약 삭제
     * @param reqDto
     * @throws Exception
     */
    void deleteReq(ReqDto reqDto) throws Exception;

    /**
     * 일일체험예약 리스트
     * @param reqCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getReqListMap(ReqCriteria reqCriteria) throws Exception;

    /**
     * 일일체험예약 정보
     * @param reqDto
     * @return
     * @throws Exception
     */
    ReqDto getReq(ReqDto reqDto) throws Exception;

    /**
     * 일일체험예약 정보
     * @param reqDto
     * @return
     * @throws Exception
     */
    WcrfBuyDto getReqPay(ReqDto reqDto) throws Exception;

    /**
     * 일일체험예약 수정
     * @param reqDto
     * @throws Exception
     */
    void updateReq(ReqDto reqDto) throws Exception;

    /**
     * 일일체험예약 가능건수
     * @param reqCriteria
     * @return
     * @throws Exception
     */
    int getReqSumByDay(ReqCriteria reqCriteria) throws Exception;
}
