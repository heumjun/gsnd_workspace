package kr.go.gyeongnam.human.repository.mypage;

import kr.go.gyeongnam.human.dto.mypage.BsktDto;
import kr.go.gyeongnam.human.dto.mypage.criteria.BsktCriteria;
import kr.go.gyeongnam.human.dto.wcrf.WcrfBuyDto;
import kr.go.gyeongnam.human.dto.wcrf.WcrfDto;
import kr.go.gyeongnam.human.dto.wcrf.criteria.WcrfBuyCriteria;
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
