package kr.go.gyeongnam.human.controller.mng;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/mng")
public class MngMainController {
    @RequestMapping(value="/login.do")
    public ModelAndView loginAction(HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("/mng/login", model);
    }


    @RequestMapping(value={"","/index.do"})
    public ModelAndView indexAction(HttpServletRequest req,
                                    HttpServletResponse rep) throws Exception {


        Map<String, Object> model = new HashMap<String, Object>();
        String redirect_url = "redirect:/mng";
        String tempUrl = "/mng/index";

        return new ModelAndView(tempUrl, model);
    }
}