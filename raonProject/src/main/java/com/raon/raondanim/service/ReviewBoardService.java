package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

public interface ReviewBoardService {	
	public boolean insertReview(Map<String, Object> param);
	public boolean updateReview(Map<String, Object> params);
	public boolean deleteReview(Map<String, Object> param);
	//USER_NUM 으로 select
	public Map<String, Object> selectOne(int num);
	//REVIEW_NUM 으로 select
	public Map<String, Object> selectReviewOne(int num);
	public List<Map<String, Object>> selectAll();
	//조회수 증가
	public Map<String, Object> plusReadCount(int num);
	public List<Map<String, Object>> getReviewBoard(int USER_NUM);
	
	
	
}
