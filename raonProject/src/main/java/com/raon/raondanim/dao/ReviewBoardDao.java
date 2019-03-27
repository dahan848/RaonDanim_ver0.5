package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

public interface ReviewBoardDao {
	public List<Map<String, Object>> selectAll();
	public int insertReview(Map<String, Object> param);
	public int updateReview(Map<String, Object> param);
	public int deleteReview(int num);
	//USER_NUM 으로 select
	public Map<String, Object> selectOne(int num);
	//REVIEW_NUM 으로  select
	public Map<String, Object> selectReviewOne(int num);
	
	public List<Map<String, Object>> selectByUserNum(int USER_NUM);
	
	//조회수 +1
	public int plusReadCount(int num);
	
}
