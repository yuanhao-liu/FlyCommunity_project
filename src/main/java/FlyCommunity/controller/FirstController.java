package FlyCommunity.controller;

import FlyCommunity.domain.Tab_user;
import FlyCommunity.service.InService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class FirstController {
    @Autowired
    InService inService;
    @RequestMapping("/reg")
    public ModelAndView reg(Tab_user user){
        ModelAndView modelAndView = new ModelAndView();
        int i = inService.reg(user);
        modelAndView.setViewName("/WEB-INF/html/user/reg1.jsp");
        modelAndView.addObject("msg","注册成功");
        return modelAndView;
    }
    @RequestMapping("/checkEmail")
    public void checkEmail( String email, HttpServletResponse response) throws IOException {
        Tab_user user = inService.checkEmail(email);
        if(user==null){
            response.getWriter().print("{\"msg\":\"可以注册\"}");
        }else {
            response.getWriter().print("{\"msg\":\"该邮箱已被注册，请更换邮箱\"}");
        }
    }
}
