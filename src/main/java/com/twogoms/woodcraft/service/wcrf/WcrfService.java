package com.twogoms.woodcraft.service.wcrf;

import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfDto;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfCriteria;
import egovframework.com.cmm.LoginVO;

import java.util.List;
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
