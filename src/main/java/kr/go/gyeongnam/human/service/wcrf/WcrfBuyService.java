package kr.go.gyeongnam.human.service.wcrf;

import egovframework.com.cmm.LoginVO;
import kr.go.gyeongnam.human.dto.wcrf.WcrfBuyDto;
import kr.go.gyeongnam.human.dto.wcrf.WcrfDto;

import java.util.List;

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
