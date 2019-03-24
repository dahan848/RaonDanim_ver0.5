package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

public interface AdminDAO {
	public List<Map<String, Object>> getLockoutUserList(); //계정 비활성화  (enabled 칼럼 값이 0) 인 유저 목록
	public int userUnlock(int usernum); //비활성화 된 계정을 활성화 시키는 dao
}
