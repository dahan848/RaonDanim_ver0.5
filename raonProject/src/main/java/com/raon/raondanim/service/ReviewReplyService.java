package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

public interface ReviewReplyService {

	public List<Map<String, Object>> selectAll();
	
	public boolean insertReply(Map<String, Object> param);
	public boolean updateReply(Map<String, Object> param);
	public boolean deleteReply(int num);
	
	//REPLY_NUM 으로  select
	public Map<String, Object> selectOne(int num);
	//USER_NUM 으로 select
	public Map<String, Object> selectByUserNum(int num);
	//REVIEW_NUM 으로  select
	public List<Map<String, Object>> getReviewReply(int num);
	
	
	public List<Map<String, Object>> getReviewReplyList(Map<String, Object> params);

}
