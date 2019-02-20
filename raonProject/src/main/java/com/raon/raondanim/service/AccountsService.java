package com.raon.raondanim.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Service;

@Service
public class AccountsService {
	public void logout(HttpServletRequest request,HttpServletResponse response) { //로그아웃
		//현재 서비스에서 권한부분을 삭제 
		//현재 서비스에서 권한을 얻어와서 권한이 null아니면, 
		//현재권한에 대해서 logout처리
		Authentication auth
		 = SecurityContextHolder.getContext().getAuthentication();
		if(auth != null) {
			new SecurityContextLogoutHandler()
			.logout(request, response, auth);
		}
	}
}
