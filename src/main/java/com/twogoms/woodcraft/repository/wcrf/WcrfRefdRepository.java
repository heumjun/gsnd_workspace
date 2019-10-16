package com.twogoms.woodcraft.repository.wcrf;

import com.twogoms.woodcraft.dto.wcrf.WcrfRefdDto;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfRefdCriteria;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("wcrfRefdRepository")
public interface WcrfRefdRepository {

    /**
     * 목록
     * @param wcrfRefdCriteria
     * @return
     */
    List<WcrfRefdDto> getWcrfRefdList(WcrfRefdCriteria wcrfRefdCriteria);

    /**
     * 목록건수
     * @param wcrfRefdCriteria
     * @return
     */
    int getWcrfRefdListCount(WcrfRefdCriteria wcrfRefdCriteria);

    /**
     * 상세
     * @param wcrfRefdDto
     * @return
     */
    WcrfRefdDto getWcrfRefd(WcrfRefdDto wcrfRefdDto);

    /**
     * 등록
     * @param wcrfRefdDto
     */
    void insertWcrfRefd(WcrfRefdDto wcrfRefdDto);

    /**
     * 수정
     * @param wcrfRefdDto
     */
    void updateWcrfRefd(WcrfRefdDto wcrfRefdDto);

    /**
     * 삭제
     * @param wcrfRefdDto
     */
    void deleteWcrfRefd(WcrfRefdDto wcrfRefdDto);

    /**
     * 목록
     * @param wcrfRefdCriteria
     * @return
     */
    List<WcrfRefdDto> getExprnRefdList(WcrfRefdCriteria wcrfRefdCriteria);

    /**
     * 목록건수
     * @param wcrfRefdCriteria
     * @return
     */
    int getExprnRefdListCount(WcrfRefdCriteria wcrfRefdCriteria);
}
