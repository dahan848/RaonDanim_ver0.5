package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.User;

public interface ReviewReplyService {

	public List<Map<String, Object>> selectAll();
	
	public boolean insertReply(Map<String, Object> param);
	public boolean updateReply(Map<String, Object> param);
	public boolean deleteReply(Map<String, Object> params);
	
	//REPLY_NUM 으로  select
	public Map<String, Object> selectOne(int num);
	//USER_NUM 으로 select
	public Map<String, Object> selectByUserNum(int num);
	//REVIEW_NUM 으로  select
	public List<Map<String, Object>> getReviewReply(int num);
	
	//네비게이션 표시 위한 정보 받기
	public Map<String, Object> getViewData(Map<String, Object> params);
	//댓글 하나 정보 가져오기
	public Map<String, Object> getBoardByNum(int num);
	//페이지 번호 받아서 해당 목록 가져오기
	public List<Map<String, Object>> getBoardList(Map<String, Object> params);

}
