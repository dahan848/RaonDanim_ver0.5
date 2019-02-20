package com.raon.raondanim.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.raon.raondanim.service.securityUserService;
import com.raon.raondanim.util.MessageUtils;


public class LoginFailureHandler implements AuthenticationFailureHandler {

    private String Loginidname;
    private String Loginpwdname;
    private String errormsgname;
    private String defaultFailureUrl;
    
    @Autowired
    private securityUserService userSer;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		System.out.println("로그인 실패 핸들러 동작!");
		//로그인 실패시 사용자가 입력한 아이디와 비밀번호 변수에 참조 
		String userId = request.getParameter(Loginidname);
		String userPw = request.getParameter(Loginpwdname);
		
		//로그인 실패 정보 담기 
		request.setAttribute(Loginidname, userId);
		request.setAttribute(Loginpwdname, userPw);
		//에러 메시지를 담기 위한 변수 선언
		String errormsg = null;
		//조건문으로 에러메시지 구분
        if(exception instanceof BadCredentialsException) { //비밀번호가 일치하지 않음
        	System.out.println("비번 틀림 : " + userPw);
        	loginFailureCount(userId); //비밀번호가 틀리면 사용자가 입력한 아이디를 해당 메서드로 넘겨줌 
            errormsg = MessageUtils.getMessage("error.BadCredentials");
        } else if(exception instanceof InternalAuthenticationServiceException) { //아이디 존재 하지 않음.
        	System.out.println("아이디");
            errormsg = MessageUtils.getMessage("error.BadCredentials");
        } else if(exception instanceof DisabledException) { //비활성화 계정
            errormsg = MessageUtils.getMessage("error.Disaled");
        } else if(exception instanceof CredentialsExpiredException) { //비밀번호 유효기간 만료 
            errormsg = MessageUtils.getMessage("error.CredentialsExpired");
        }
		//에러 메시지 담기
		request.setAttribute("errormsgname", errormsg);
		System.out.println(errormsg);
		//보내기
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
	}
	
	public void loginFailureCount(String username) { //비밀번호 입력 회수에 따른 계정 잠금하는 ()
		userSer.countFailure(username); //로그인 실패한 계정의 비밀번호 회수를 1 증가 시킴
		int count = userSer.checkFailureCount(username); // 해당 유저의 로그인 실패 회수를 변수에 참조 
		if(count ==3) {
			userSer.disabledUsername(username); //비밀번호 회수가 3회 되면 계정 비활성화 
		}
	}

	public String getLoginidname() {
		return Loginidname;
	}

	public void setLoginidname(String Loginidname) {
		this.Loginidname = Loginidname;
	}

	public String getLoginpwdname() {
		return Loginpwdname;
	}

	public void setLoginpwdname(String Loginpwdname) {
		this.Loginpwdname = Loginpwdname;
	}

	public String getErrormsgname() {
		return errormsgname;
	}

	public void setErrormsgname(String errormsgname) {
		this.errormsgname = errormsgname;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}
	
	

}

