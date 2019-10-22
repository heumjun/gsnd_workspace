package kr.go.gyeongnam.human.service.wcrf;

import kr.go.gyeongnam.human.dto.wcrf.WcrfDto;
import kr.go.gyeongnam.human.dto.wcrf.criteria.WcrfCriteria;

import java.util.Map;

public interface WcrfService {

    /**
     * 목공예품 저장/수정
     * @param WcrfDto
     * @throws Exception
     */
    void saveWcrf(WcrfDto WcrfDto) throws Exception;

    /**
     * 목공예품 삭제
     * @param WcrfDto
     * @throws Exception
     */
    void deleteWcrf(WcrfDto WcrfDto) throws Exception;

    /**
     * 목공예품 리스트
     * @param wcrfCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getWcrfListMap(WcrfCriteria wcrfCriteria) throws Exception;

    /**
     * 목공예품 상세
     * @param WcrfDto
     * @return
     * @throws Exception
     */
    WcrfDto getWcrf(WcrfDto WcrfDto) throws Exception;

}
