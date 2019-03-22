package com.raon.raondanim.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.raon.raondanim.model.customUserDetails;


public class CustomAuthenticationProvider implements AuthenticationProvider  {
	  
	@Autowired
	private UserDetailsService userService;


	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		System.out.println("AuthenticationProvider 요청 받음");
		//String 변수에 화면단에서 입력 된 아이디와 비밀번호를 입력
        String userid = (String) authentication.getPrincipal(); //화면단에서 입력 한 아이디
        String password = (String) authentication.getCredentials(); //화면단에서 입력 한 비밀번호 
        //화면에서 입력 한 아이디로 user 선택 (시큐리티 모델)
        customUserDetails user = (customUserDetails) userService.loadUserByUsername(userid);

        System.out.println("선택 된 유저 : " + user);

		return null;
	}

	@Override
	public boolean supports(Class<?> authentication) {

		return false;
	}

}
