package com.twogoms.woodcraft.repository.mypage;

import com.twogoms.woodcraft.dto.mypage.BsktDto;
import com.twogoms.woodcraft.dto.mypage.criteria.BsktCriteria;
import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfDto;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfBuyCriteria;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfCriteria;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("bsktRepository")
public interface BsktRepository {

    /**
     * 목록
     * @param bsktCriteria
     * @return
     */
    List<BsktDto> getBsktList(BsktCriteria bsktCriteria);

    /**
     * 상세
     * @param bsktDto
     * @return
     */
    WcrfDto getBskt(BsktDto bsktDto);

    /**
     * 등록
     * @param bsktDto
     */
    void insertBskt(BsktDto bsktDto);

    /**
     * 수정
     * @param bsktDto
     */
    void updateBskt(BsktDto bsktDto);

    /**
     * 삭제
     * @param bsktDto
     */
    void deleteBskt(BsktDto bsktDto);

    /**
     * 목록
     * @param wcrfBuyCriteria
     * @return
     */
    List<WcrfBuyDto> getWcrfBuyList(WcrfBuyCriteria wcrfBuyCriteria);

    /**
     * 목록건수
     * @param wcrfBuyCriteria
     * @return
     */
    int getWcrfBuyListCount(WcrfBuyCriteria wcrfBuyCriteria);

    /**
     * 목록
     * @param wcrfBuyCriteria
     * @return
     */
    List<WcrfBuyDto> getExprnReqList(WcrfBuyCriteria wcrfBuyCriteria);

    /**
     * 목록건수
     * @param wcrfBuyCriteria
     * @return
     */
    int getExprnReqListCount(WcrfBuyCriteria wcrfBuyCriteria);
}
