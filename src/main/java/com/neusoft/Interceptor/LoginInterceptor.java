package com.neusoft.Interceptor;

import com.neusoft.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        HttpSession session = httpServletRequest.getSession();
        User userinfo = (User)session.getAttribute("userinfo");
        String s = httpServletRequest.getRequestURL().toString();
        session.setAttribute("referer",s);
        if(userinfo!=null){
            if(userinfo.getActiveState()==1){
                return true;
            }else {
                httpServletRequest.getRequestDispatcher("/WEB-INF/jsp/user/activate.jsp").forward(httpServletRequest,httpServletResponse);
                return false;
            }
        }else {
            httpServletRequest.getRequestDispatcher("/WEB-INF/jsp/user/login.jsp").forward(httpServletRequest,httpServletResponse);
            return false;
        }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
