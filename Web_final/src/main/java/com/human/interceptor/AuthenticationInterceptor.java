package com.human.interceptor;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
    		Object handler) throws Exception {
        System.out.println("pre handle");
        // check login user by interceptor
        HttpSession session = request.getSession();
        Object nowId = session.getAttribute("id");
        if(nowId == null) {
        	response.sendRedirect(request.getContextPath() + "/signIn");
        	return false;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
    		Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("Post handle");
        super.postHandle(request, response, handler, modelAndView);
    }
}
