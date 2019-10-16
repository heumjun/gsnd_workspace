package com.twogoms.woodcraft.repository.wcrf;

import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfDto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("wcrfBuyRepository")
public interface WcrfBuyRepository {

    /**
     * 등록
     * @param wcrfBuyDto
     */
    void insertWcrfBuyMst(WcrfBuyDto wcrfBuyDto);

    /**
     * 등록
     * @param wcrfBuyDto
     */
    void insertWcrfBuy(WcrfBuyDto wcrfBuyDto);

    /**
     * 등록
     * @param wcrfBuyDto
     */
    void insertWcrfBuyTot(WcrfBuyDto wcrfBuyDto);

    /**
     * 등록
     * @param wcrfBuyDto
     */
    void insertWcrfBuyAddr(WcrfBuyDto wcrfBuyDto);

    /**
     * 등록
     * @param wcrfBuyDto
     */
    void insertWcrfPay(WcrfBuyDto wcrfBuyDto);


    /**
     * 상세
     * @param wcrfBuyDto
     * @return
     */
    WcrfBuyDto getWcrfBuyTot(WcrfBuyDto wcrfBuyDto);

    /**
     * 수정
     * @param wcrfBuyDto
     */
    void updateWcrfBuyTot(WcrfBuyDto wcrfBuyDto);

    /**
     * 수정
     * @param wcrfBuyDto
     */
    void updateWcrfPay(WcrfBuyDto wcrfBuyDto);

    /**
     * 목록
     * @param wcrfBuyDto
     * @return
     */
    List<WcrfDto> getWcrfBuyList(WcrfBuyDto wcrfBuyDto);
}
