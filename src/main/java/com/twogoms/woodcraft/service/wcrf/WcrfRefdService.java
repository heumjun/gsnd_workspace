package com.twogoms.woodcraft.service.wcrf;

import com.twogoms.woodcraft.dto.wcrf.WcrfRefdDto;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfRefdCriteria;

import java.util.Map;

public interface WcrfRefdService {

    /**
     * 목공예품환불 저장/수정
     * @param WcrfRefdDto
     * @throws Exception
     */
    void saveWcrfRefd(WcrfRefdDto WcrfRefdDto) throws Exception;

    /**
     * 목공예품환불 삭제
     * @param WcrfRefdDto
     * @throws Exception
     */
    void deleteWcrfRefd(WcrfRefdDto WcrfRefdDto) throws Exception;

    /**
     * 목공예품환불 리스트
     * @param wcrfRefdCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getWcrfRefdListMap(WcrfRefdCriteria wcrfRefdCriteria) throws Exception;

    /**
     * 목공예품환불 상세
     * @param WcrfRefdDto
     * @return
     * @throws Exception
     */
    WcrfRefdDto getWcrfRefd(WcrfRefdDto WcrfRefdDto) throws Exception;

    /**
     * 일일체험환불 리스트
     * @param wcrfRefdCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getExprnRefdListMap(WcrfRefdCriteria wcrfRefdCriteria) throws Exception;

}
