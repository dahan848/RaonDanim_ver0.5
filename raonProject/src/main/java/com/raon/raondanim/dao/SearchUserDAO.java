package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

public interface SearchUserDAO {
	
	// USER 리스트 불러오기
	public List<Map<String, Object>> userList(Map<String, Object> param);
	public List<Map<String, Object>> interestList();
	
	// USER 리스트 페이징 카운트 불러오기
	public int selectTotalCount(Map<String, Object> param);
	
}