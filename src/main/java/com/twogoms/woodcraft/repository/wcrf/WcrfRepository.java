package com.twogoms.woodcraft.repository.wcrf;

import com.twogoms.woodcraft.dto.wcrf.WcrfDto;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfCriteria;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("wcrfRepository")
public interface WcrfRepository {

    /**
     * 목록
     * @param wcrfCriteria
     * @return
     */
    List<WcrfDto> getWcrfList(WcrfCriteria wcrfCriteria);

    /**
     * 목록건수
     * @param wcrfCriteria
     * @return
     */
    int getWcrfListCount(WcrfCriteria wcrfCriteria);

    /**
     * 상세
     * @param wcrfDto
     * @return
     */
    WcrfDto getWcrf(WcrfDto wcrfDto);

    /**
     * 등록
     * @param wcrfDto
     */
    void insertWcrf(WcrfDto wcrfDto);

    /**
     * 수정
     * @param wcrfDto
     */
    void updateWcrf(WcrfDto wcrfDto);

    /**
     * 삭제
     * @param wcrfDto
     */
    void deleteWcrf(WcrfDto wcrfDto);

}
