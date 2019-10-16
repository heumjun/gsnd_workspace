package com.twogoms.woodcraft.controller.mng;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/mng/include")
public class MngIncludeController {


    @RequestMapping("/header.do")
    public ModelAndView headerAction(HttpServletRequest req,
                                     HttpServletResponse rep) {

        Map<String, Object> model = new HashMap<String, Object>();
        model.put("title", req.getParameter("pageTitle"));

        return new ModelAndView("/mng/include/header", model);
    }

    @RequestMapping("/footer.do")
    public ModelAndView footerAction(HttpServletRequest req,
                                     HttpServletResponse rep) {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/mng/include/footer", model);
    }

    @RequestMapping("/top_nav.do")
    public ModelAndView topNavAction(HttpServletRequest req,
                                     HttpServletResponse rep) {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/mng/include/top_nav", model);
    }

    @RequestMapping("/sidebar.do")
    public ModelAndView sidebarAction(HttpServletRequest req,
                                      HttpServletResponse rep)  {
        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/mng/include/sidebar", model);
    }

}
