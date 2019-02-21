package com.raon.raondanim.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.UserAuthDAO;


@Service
public class securityUserServiceImp implements securityUserService{

	@Autowired
	private UserAuthDAO userDAO;
	
	@Override
	public void countFailure(String username) { //로그인 실패회수 증가 및 실패시간 저장
		userDAO.tryLoginData(username);
		userDAO.updateFailureCount(username);
	}

	@Override
	public int checkFailureCount(String username) { //로그인 실패회수 체크
		return userDAO.checkFailureCount(username);
	}

	@Override
	public void disabledUsername(String username) { //사용자 계정 비활성화
		userDAO.updateDisabled(username);
	}

}