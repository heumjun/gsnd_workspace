package com.twogoms.woodcraft.service.cmm;

import com.twogoms.woodcraft.dto.cmm.MenuDto;

import java.util.List;
import java.util.Map;

public interface MenuService {

    List<MenuDto> getMenuInfoList(Map<String, Object> params) throws Exception;
}
