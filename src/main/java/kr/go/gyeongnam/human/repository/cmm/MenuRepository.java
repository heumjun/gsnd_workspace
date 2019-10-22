package kr.go.gyeongnam.human.repository.cmm;

import kr.go.gyeongnam.human.dto.cmm.MenuDto;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("menuRepository")
public interface MenuRepository {

    List<MenuDto> getMenuInfoList(Map<String, Object> params) throws Exception;
}
