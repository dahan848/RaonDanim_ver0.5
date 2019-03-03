package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.User;

public interface AccountsUserDAO {
	public int joinUser (User user);
	public User selectByUserId (String UserId);
	public int email_verify (User user);
	
	public List<User> selectAll();
	public List<Map<String, Object>> userList(Map<String, Object> param);
	public int selectTotalCount(Map<String, Object> param);
}