package kr.go.gyeongnam.human.controller.cmm;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.uss.umt.service.EgovUserManageService;
import egovframework.com.uss.umt.service.UserManageVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 회원 관리자 Controller
 */
@Controller
@RequestMapping("/mng")
public class UserMngController {

    @Resource(name = "egovMessageSource")
    private EgovMessageSource messageSource;

    @Resource(name="propertiesService")
    private EgovPropertyService propertyService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    /** userManageService */
    @Resource(name = "userManageService")
    private EgovUserManageService userManageService;

    @RequestMapping(value="/user/userList.do")
    public ModelAndView getUserList(@ModelAttribute("frmSearch")UserManageVO userManageVO,
                                    @RequestParam(value="pageIndex",required = false) String pageIndex,
                                    HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (pageIndex!= null)
            userManageVO.setPageIndex(Integer.parseInt(pageIndex));

        userManageVO.setPageUnit(propertyService.getInt("pageUnit"));
        userManageVO.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(userManageVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(userManageVO.getPageUnit());
        paginationInfo.setPageSize(userManageVO.getPageSize());

        userManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        userManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
        userManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        userManageVO.setSearchCondition("1");

        List<?> list = userManageService.selectUserList(userManageVO);
        int totalCnt = userManageService.selectUserListTotCnt(userManageVO);

        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String, Object> modelMap = new HashMap<String, Object>();

        modelMap.put("frmSearch", userManageVO);
        modelMap.put("resultList", list);
        modelMap.put("resultCnt", totalCnt);
        modelMap.put("paginationInfo", paginationInfo);

        return new ModelAndView("/mng/common/userMngList", modelMap);
    }

    /** create Form */
    @RequestMapping(value = "/user/userRegit.do")
    public ModelAndView goUserForm(HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("userManageForm", new UserManageVO());

        return new ModelAndView("/mng/common/userMngRegit", model);

    }

    @RequestMapping(value = "/user/userSave.do" , method = RequestMethod.POST)
    public ModelAndView saveUser(@ModelAttribute("userManageForm") UserManageVO userManageVO,
                                   HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        Map<String,Object> model = new HashMap<String, Object>();

        if (EgovStringUtil.isEmpty(userManageVO.getUniqId())) {

            userManageVO.setPassword("ahrrhd12");

            // 필수값 공백으로 설정
            // AREA_NO
            userManageVO.setAreaNo(" ");
            // HOUSE_MIDDLE_TELNO
            userManageVO.setHomemiddleTelno(" ");
            // HOUSE_END_TELNO
            userManageVO.setHomeendTelno(" ");
            // PASSWORD_HINT
            userManageVO.setPasswordHint(" ");
            // PASSWORD_CNSR
            userManageVO.setPasswordCnsr(" ");
            // EMPLYR_STTUS_CODE
            userManageVO.setEmplyrSttusCode("P");
            userManageVO.setOrgnztId("ORGNZT_0000000000000");
            userManageVO.setGroupId("GROUP_00000000000000");

            userManageService.insertUser(userManageVO);
        } else {

            UserManageVO userManageVO2 = userManageService.selectUser(userManageVO.getUniqId());
            userManageVO2.setEmailAdres(userManageVO.getEmailAdres());
            userManageVO2.setDetailAdres(userManageVO.getDetailAdres());
            userManageVO2.setHomeadres(userManageVO.getHomeadres());
            userManageVO2.setZip(userManageVO.getZip());
            userManageVO2.setMoblphonNo(userManageVO.getMoblphonNo());
            userManageVO2.setEmplyrNm(userManageVO.getEmplyrNm());

            userManageService.updateUser(userManageVO2);
        }

        model.put("message", messageSource.getMessage("success.request.msg"));
        model.put("result","OK");

        return new ModelAndView("/mng/common/userMngRegit", model);
    }

    /**
     * 상세
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/user/userView.do")
    public ModelAndView getWcrf(@RequestParam Map<String, String> commandMap,
                                  HttpServletRequest req,
                                  HttpServletResponse rep) throws Exception {

        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        Map<String,Object> model = new HashMap<String, Object>();

        String uniqId = (String)commandMap.get("uniqId");
        UserManageVO userManageVO = userManageService.selectUser(uniqId);

        model.put("userManageForm", userManageVO);

        return new ModelAndView("/mng/common/userMngRegit", model);

    }

    /**
     * 삭제
     * @param userManageVO
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/user/userDelete.do")
    public ModelAndView deleteArtist(@ModelAttribute("userManageForm") UserManageVO userManageVO,
                                     HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        userManageService.deleteUser("USR03:" + userManageVO.getUniqId());

        Map<String,Object> model = new HashMap<String, Object>();
        model.put("message", messageSource.getMessage("success.common.delete"));
        model.put("result","OK");

        return new ModelAndView("/mng/common/userMngRegit", model);

    }

}
