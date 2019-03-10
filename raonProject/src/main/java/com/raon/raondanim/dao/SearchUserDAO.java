package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

public interface SearchUserDAO {

	public List<Map<String, Object>> userList(Map<String, Object> param);
	public int selectTotalCount(Map<String, Object> param);
	
}