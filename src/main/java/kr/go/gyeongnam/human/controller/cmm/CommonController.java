package kr.go.gyeongnam.human.controller.cmm;

import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import kr.go.gyeongnam.human.constant.HumanConstant;
import kr.go.gyeongnam.human.dto.cmm.MenuDto;
import kr.go.gyeongnam.human.service.cmm.MenuService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CommonController {

    private final static Logger LOGGER = LoggerFactory.getLogger(CommonController.class);

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/inc/header.do")
    public ModelAndView pageHeader(HttpServletRequest request,
                                   HttpServletResponse response,
                                   ModelMap modelMap) throws Exception {

        Map<String, Object> params = new HashMap<>();

        List<MenuDto> menuList = null;
        List<MenuDto> allMenuList = null;

        if (EgovSessionCookieUtil.getSessionAttribute(request, HumanConstant.SessionAttribute.MENU_LIST) != null) {
            menuList = (List<MenuDto>)EgovSessionCookieUtil.getSessionAttribute(request, HumanConstant.SessionAttribute.MENU_LIST);
        } else {

            allMenuList = menuService.getMenuInfoList(params);

            params.put("menuType", "home");
            menuList = menuService.getMenuInfoList(params);

            EgovSessionCookieUtil.setSessionAttribute(request, HumanConstant.SessionAttribute.ALL_MENU_LIST, allMenuList);
            EgovSessionCookieUtil.setSessionAttribute(request, HumanConstant.SessionAttribute.MENU_LIST, menuList);
        }

        modelMap.put("menuList", menuList);

        return new ModelAndView("/cmm/header", modelMap);
    }

    @RequestMapping(value = "/inc/sidebar.do")
    public ModelAndView pageSidebar(HttpServletRequest request,
                                    HttpServletResponse response,
                                    ModelMap modelMap) throws Exception {

        List<MenuDto> menuList = (List<MenuDto>) EgovSessionCookieUtil.getSessionAttribute(request, HumanConstant.SessionAttribute.ALL_MENU_LIST);
        if (menuList == null) {

            List<MenuDto> allMenuList = null;
            Map<String, Object> params = new HashMap<>();
            allMenuList = menuService.getMenuInfoList(params);

            params.put("menuType", "home");
            menuList = menuService.getMenuInfoList(params);

            EgovSessionCookieUtil.setSessionAttribute(request, HumanConstant.SessionAttribute.ALL_MENU_LIST, allMenuList);
            EgovSessionCookieUtil.setSessionAttribute(request, HumanConstant.SessionAttribute.MENU_LIST, menuList);
        }

        long menuNo = Long.parseLong(request.getParameter("menuNo"));

        MenuDto currentMenu = getMenu(menuList, menuNo);
        MenuDto parentMenu = getMenu(menuList, currentMenu.getUpperMenuNo());

        List<MenuDto> siblingMenus = getSiblingMenu(menuList, parentMenu.getMenuNo());

        modelMap.put("menuItem", currentMenu);
        modelMap.put("siblingList", siblingMenus);
        modelMap.put("menuNm1", parentMenu.getMenuNm());

        String title = currentMenu.getMenuNm();
        if (request.getParameter("subTitle") != null) {
            title = title + "-" + request.getParameter("subTitle");
        }
        modelMap.put("menuNm2", title);

        EgovSessionCookieUtil.setSessionAttribute(request, "title1", parentMenu.getMenuNm());
        EgovSessionCookieUtil.setSessionAttribute(request, "title2", title);
        EgovSessionCookieUtil.setSessionAttribute(request, "currentMenu", currentMenu);

        if (request.getParameter("hideSidebar") != null) {
            EgovSessionCookieUtil.setSessionAttribute(request, "hideSidebar"
                    , request.getParameter("hideSidebar"));
        } else {
            EgovSessionCookieUtil.removeSessionAttribute(request, "hideSidebar");
        }

        if (request.getParameter("hideSocialMenu") != null) {
            EgovSessionCookieUtil.setSessionAttribute(request, "hideSocialMenu"
                    , request.getParameter("hideSocialMenu"));
        } else {
            EgovSessionCookieUtil.removeSessionAttribute(request, "hideSocialMenu");
        }

        return new ModelAndView("/cmm/sidebar", modelMap);
    }

    @RequestMapping(value = "/inc/footer.do")
    public String pageFooter() {
        return "/cmm/footer";
    }

    private MenuDto getMenu(List<MenuDto> menuList, long menuNo) {

        MenuDto parentMenu = null;
        for (MenuDto menuDto : menuList) {
            if (menuDto.getMenuNo() == menuNo) {
                parentMenu = menuDto;
                break;
            }
        }

        return parentMenu;
    }

    private List<MenuDto> getSiblingMenu(List<MenuDto> menuList, long menuNo) {

        List<MenuDto> retList = new ArrayList<>();

        for (MenuDto menuDto : menuList) {
            if (menuDto.getUpperMenuNo() == menuNo) {
                retList.add(menuDto);
            }
        }

        return retList;
    }

    @RequestMapping(value="/WoodPageLink.do")
    public ModelAndView moveToPage(@RequestParam("link") String linkPage, @RequestParam("qn") String qn){

        String link = linkPage;
        link = link.replace(";", "");
        link = link.replace(".", "");
        if (link.equals("1")) {
            link = "/community/05_13";
        } else {
            linkPage = null;
        }

        // service 사용하여 리턴할 결과값 처리하는 부분은 생략하고 단순 페이지 링크만 처리함
        if (linkPage==null || linkPage.equals("")){
            link="egovframework/com/cmm/egovError";
        }

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("qn", qn);

        return new ModelAndView(link, model);
    }
}
