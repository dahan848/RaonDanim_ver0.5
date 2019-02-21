package com.raon.raondanim.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.raon.raondanim.service.securityUserService;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	 
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();
	
    private String loginidname;
    private String defaultUrl;
    
    @Autowired
    private securityUserService service;
 
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
    	resultRedirectStrategy(request, response, authentication);
    	clearAuthenticationAttributes(request); //로그인 실패 세션 삭제
    	
    	String username = request.getParameter("user_id");
    	service.updateFailureCountReset(username);
    }
    
    //로그인 성공 후 화면 이동시켜주는 ()
    protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        if(savedRequest!=null) { //인증권한이 필요한 페이지에 접근 했을 때...
            String targetUrl = savedRequest.getRedirectUrl(); //로그인 화면 이전의 url 정보를 얻음
            redirectStratgy.sendRedirect(request, response, targetUrl);
        } else { //직접 로그인 요청
            redirectStratgy.sendRedirect(request, response, defaultUrl);
        } 
    }
    
    //로그인 실패에러 세션 지우는 ()
    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if(session==null) return;
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }




    public String getLoginidname() {
        return loginidname;
    }
 
    public void setLoginidname(String loginidname) {
        this.loginidname = loginidname;
    }
 
    public String getDefaultUrl() {
        return defaultUrl;
    }
 
    public void setDefaultUrl(String defaultUrl) {
        this.defaultUrl = defaultUrl;
    }
}
