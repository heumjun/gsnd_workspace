package kr.go.gyeongnam.human.repository.cmm;

import kr.go.gyeongnam.human.dto.cmm.CmnCodeDto;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository("cmnCodeRepository")
public interface CmnCodeRepository {
    List<CmnCodeDto> selectListCmnCodeDetl(HashMap<String, Object> searchMap) throws Exception;
}
