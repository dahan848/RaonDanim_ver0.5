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

	@Override
	public void updateFailureCountReset(String username) { //로그인 성공시 발생하는 로직
		userDAO.updateFailureCountReset(username); //로그인 시도 회수 초기화
		userDAO.tryLoginDataReset(username); //마지막 로그인 실패 시간 삭제 
		userDAO.checkLastLoginTime(username); //마지막 로그인 시간 기록 
		
	}

}