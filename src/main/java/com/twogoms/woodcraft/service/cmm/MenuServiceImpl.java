package com.twogoms.woodcraft.service.cmm;

import com.twogoms.woodcraft.dto.cmm.MenuDto;
import com.twogoms.woodcraft.repository.cmm.MenuRepository;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.inject.Qualifier;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("menuService")
public class MenuServiceImpl implements MenuService {

    private final static Logger LOGGER = LoggerFactory.getLogger(MenuServiceImpl.class);

    @Resource(name="menuRepository")
    private MenuRepository menuRepository;

    @Override
    public List<MenuDto> getMenuInfoList(Map<String, Object> params) throws Exception {

        List<MenuDto> retList = null;

        List<String> authorities = EgovUserDetailsHelper.getAuthorities();

        params.put("authorCode", "ROLE_ANONYMOUS");
        if (authorities.contains("ROLE_ADMIN")) {
            params.put("authorCode", "ROLE_ADMIN");
        } else if (authorities.contains("ROLE_USER")) {
            params.put("authorCode", "ROLE_USER");
        }

        try {
            retList = menuRepository.getMenuInfoList(params);
        } catch (Exception ex) {
            LOGGER.error(ex.getMessage());
        }

        return retList;
    }
}
