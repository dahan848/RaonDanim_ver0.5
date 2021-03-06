package com.raon.raondanim.dao;

import com.raon.raondanim.model.customUserDetails;

public interface UserAuthDAO {
	public customUserDetails getUserById(String username);
	public void updateFailureCount(String username); // 로그인 실패 회수 증가
	public int checkFailureCount(String username); // 로그인 실패 회수 체크
	public void updateDisabled(String username); // 활성화/비활성화
	public void tryLoginData(String username); //로그인 실패 시간 기록 (실패 회수 체크 될 때 같이 구동)
	public void updateFailureCountReset(String username); //로그인 실패회수 초기화
	public void tryLoginDataReset(String username); //로그인 실패 시간 초기화 
	public void checkLastLoginTime(String username); //로그인 성공시 로그인 성공 시간 작성 
}
