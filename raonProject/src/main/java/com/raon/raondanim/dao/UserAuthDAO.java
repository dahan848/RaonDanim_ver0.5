package com.raon.raondanim.dao;

import com.raon.raondanim.model.customUserDetails;

public interface UserAuthDAO {
	public customUserDetails getUserById(String username);
	public void updateFailureCount(String username); // 로그인 실패 회수 증가
	public int checkFailureCount(String username); // 로그인 실패 회수 체크
	public void updateDisabled(String username); // 활성화/비활성화
}
