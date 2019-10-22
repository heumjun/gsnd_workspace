package kr.go.gyeongnam.human.repository.wcrf;

import kr.go.gyeongnam.human.dto.wcrf.WcrfDto;
import kr.go.gyeongnam.human.dto.wcrf.criteria.WcrfCriteria;
import org.springframework.stereotype.Repository;

import java.util.List;

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
