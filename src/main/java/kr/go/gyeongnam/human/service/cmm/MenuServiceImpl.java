package kr.go.gyeongnam.human.service.cmm;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import kr.go.gyeongnam.human.dto.cmm.MenuDto;
import kr.go.gyeongnam.human.repository.cmm.MenuRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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
