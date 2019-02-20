package com.raon.raondanim.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.model.User;

@Service
public class AccountsService {
	
	@Autowired
	private AccountsUserDAO dao;
	private User user;
	
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
	
	public boolean join(Map<String, Object> param) { //회원가입 
		//유저 객체 초기화
		user = new User();   
		//USER 객체에 파라미터로 받은 데이터 set
		user.setUSER_ID((String)param.get("user_id")); //아이디 : 이메일
		user.setUSER_PW((String)param.get("user_pw")); //비밀번호
		user.setUSER_LNM((String)param.get("user_lnm")); //성
		user.setUSER_FNM((String)param.get("user_fnm")); //이름
		//조건문을 통해서 boolean 값 반환  
		if(dao.joinUser(user) > 0) {
			return true;
		}else{
			return false;
		}
	}
}
