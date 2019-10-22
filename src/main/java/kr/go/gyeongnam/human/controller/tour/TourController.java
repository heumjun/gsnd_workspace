package kr.go.gyeongnam.human.controller.tour;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 전수관 둘러보기 Controller
 */
@Controller
@RequestMapping("/tour")
public class TourController {

    /**
     * 주요시설
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/buildingInfo.do")
    public ModelAndView getBuildingInfo(HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/tour/02_01", model);
    }

    /**
     * 부대시설
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/sideFacility.do")
    public ModelAndView getSideFacility(HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/tour/02_02", model);
    }

    /**
     * 시설물(장비) 안내
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/equipInfo.do")
    public ModelAndView getEquipInfo(HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/tour/02_03", model);
    }

    /**
     * 시설물 사용신청
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/equipRegit.do")
    public ModelAndView getEquipRegit(HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/tour/02_04", model);
    }
}
