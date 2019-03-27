package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.User;

public interface SearchUserDAO {
	
	// 전체 유저 리스트 불러오기 
	public List<Map<String, Object>> getUserList(Map<String, Object> params);
	public User selectByUserNum (String userNum);
	public int selectTotalCount(Map<String, Object> param);
	public Map<String, Object> getUserCity(String userNum);
	public List<Map<String, Object>> getUserLanguages(String userNum);
	public List<Map<String, Object>> getUserTravlestyles(String userNum);
	public String getUserNationality(String userNum);
	public List<Map<String, Object>> getUserInterests(String userNum);

}