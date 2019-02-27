package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.User;

public interface AccountsUserDAO {
	public int joinUser (User user);
	public User selectByUserId (String UserId);
	
	// 요셉 작성중
	public List<Map<String, Object>> userList(Map<String, Object> param);
	
	
	public int email_verify (User user);
}