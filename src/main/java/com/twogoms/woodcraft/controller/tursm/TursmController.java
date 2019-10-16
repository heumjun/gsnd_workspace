package com.twogoms.woodcraft.controller.tursm;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 관광정보
 */
@Controller
@RequestMapping("/tursm")
public class TursmController {

    /**
     * 진주시 소개
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/jinjuIntro.do")
    public ModelAndView getJinjuIntro(HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        String redirect_url = "";

        return new ModelAndView(redirect_url, model);
    }

    /**
     * 문화관광
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/cultureInfo.do")
    public ModelAndView getCultureInfo(HttpServletRequest req,
                                      HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        String redirect_url = "";

        return new ModelAndView(redirect_url, model);
    }

    /**
     * 숙박시설
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/hotelInfo.do")
    public ModelAndView getHotelInfo(HttpServletRequest req,
                                       HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        String redirect_url = "";

        return new ModelAndView(redirect_url, model);
    }

    /**
     * 숙박시설
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/foodInfo.do")
    public ModelAndView getFoodInfo(HttpServletRequest req,
                                     HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        String redirect_url = "";

        return new ModelAndView(redirect_url, model);
    }

    /**
     * 교통정보
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/trafficInfo.do")
    public ModelAndView getTrafficInfo(HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        String redirect_url = "";

        return new ModelAndView(redirect_url, model);
    }

    /**
     * 오시는길
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/jinjuRoad.do")
    public ModelAndView getJinjuRoad(HttpServletRequest req,
                                       HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();
        String redirect_url = "";

        return new ModelAndView(redirect_url, model);
    }
}
