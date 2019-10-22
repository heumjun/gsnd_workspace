package kr.go.gyeongnam.human.service.mypage;

import kr.go.gyeongnam.human.dto.mypage.BsktDto;
import kr.go.gyeongnam.human.dto.mypage.criteria.BsktCriteria;
import kr.go.gyeongnam.human.dto.wcrf.WcrfDto;
import kr.go.gyeongnam.human.dto.wcrf.criteria.WcrfBuyCriteria;

import java.util.List;
import java.util.Map;

public interface BsktService {

    /**
     * 장바구니 저장/수정
     * @param bsktDto
     * @throws Exception
     */
    void saveBskt(BsktDto bsktDto) throws Exception;

    /**
     * 장바구니 삭제
     * @param bsktDto
     * @throws Exception
     */
    void deleteBskt(BsktDto bsktDto) throws Exception;

    /**
     * 장바구니 리스트
     * @param bsktCriteria
     * @return
     * @throws Exception
     */
    List<BsktDto> getBsktList(BsktCriteria bsktCriteria) throws Exception;

    /**
     * 장바구니 아이템
     * @param bsktDto
     * @return
     * @throws Exception
     */
    WcrfDto getBskt(BsktDto bsktDto) throws Exception;

    /**
     * 목공예품 리스트
     * @param wcrfBuyCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getWcrfBuyListMap(WcrfBuyCriteria wcrfBuyCriteria) throws Exception;

    /**
     * 일일체험 리스트
     * @param wcrfBuyCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getExprnReqListMap(WcrfBuyCriteria wcrfBuyCriteria) throws Exception;

}
