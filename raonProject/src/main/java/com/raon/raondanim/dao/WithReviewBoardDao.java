package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

public interface WithReviewBoardDao {
	public List<Map<String, Object>> selectAll();
	
	public int insertWith(Map<String, Object> param);
	public int updateWith(Map<String, Object> param);
	public int deleteWith(int num);
	
	//USER_NUM 으로 select
	public Map<String, Object> selectOne(int num);
	//WITH_NUM 으로  select
	public Map<String, Object> selectWithOne(int num);
	
	public List<Map<String, Object>> selectByUserNum(int USER_NUM);
	
	//조회수 +1
	public int plusReadCount(int num);
}
