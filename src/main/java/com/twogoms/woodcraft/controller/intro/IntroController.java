package com.twogoms.woodcraft.controller.intro;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 전수관 소개 ... 소스변경 테스트
 */
@Controller
@RequestMapping("/intro")
public class IntroController {

    /**
     * 인사말
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/greeting.do")
    public ModelAndView getGreeting(HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/intro/01_01", model);
    }

    /**
     * 주요연혁
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/history.do")
    public ModelAndView getHistory(HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/intro/01_02", model);
    }

    /**
     * 이념 및 목표
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/ideology.do")
    public ModelAndView getIdeology(HttpServletRequest req,
                                   HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/intro/01_03", model);
    }

    /**
     * 시설 운영 안내
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfFacility.do")
    public ModelAndView getWcrfFacility(HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/intro/01_04", model);
    }

    /**
     * 오시는 길
     * @param req
     * @param rep
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/wcrfRoad.do")
    public ModelAndView getWcrfRoad(HttpServletRequest req,
                                        HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/intro/01_05", model);
    }
}
