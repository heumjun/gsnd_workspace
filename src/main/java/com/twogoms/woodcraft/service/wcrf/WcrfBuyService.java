package com.twogoms.woodcraft.service.wcrf;

import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfDto;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfCriteria;
import egovframework.com.cmm.LoginVO;

import java.util.List;
import java.util.Map;

public interface WcrfBuyService {

    /**
     * 목공예품구매 저장
     * @param wcrfBuyDto
     * @param loginVO
     * @throws Exception
     */
    WcrfBuyDto saveWcrfList(WcrfBuyDto wcrfBuyDto, LoginVO loginVO) throws Exception;

    /**
     * 목공예품구매 상세
     * @param wcrfBuyDto
     * @throws Exception
     */
    WcrfBuyDto getWcrfBuyTot(WcrfBuyDto wcrfBuyDto) throws Exception;

    /**
     * 목공예품구매 완료
     * @param wcrfBuyDto
     * @throws Exception
     */
    void savePayComplete(WcrfBuyDto wcrfBuyDto) throws Exception;

    /**
     * 목공예품구매 목록
     * @param wcrfBuyDto
     * @throws Exception
     */
    List<WcrfDto> getWcrfBuyList(WcrfBuyDto wcrfBuyDto) throws Exception;

    /**
     * 목공예품구매 수정
     * @param wcrfBuyDto
     * @throws Exception
     */
    void updateWcrfBuyTot(WcrfBuyDto wcrfBuyDto) throws Exception;

    /**
     * 목공예품구매 수정
     * @param wcrfBuyDto
     * @throws Exception
     */
    void updateWcrfPay(WcrfBuyDto wcrfBuyDto) throws Exception;

}
