package kr.go.gyeongnam.human.service.cmm;

import kr.go.gyeongnam.human.dto.cmm.MenuDto;

import java.util.List;
import java.util.Map;

public interface MenuService {

    List<MenuDto> getMenuInfoList(Map<String, Object> params) throws Exception;
}
