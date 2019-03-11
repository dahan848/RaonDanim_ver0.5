package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.TripReply;

public interface TripReplyService {

	public boolean insertBasicReply(TripReply reply);
	public List<Map<String, Object>> getReplyList(int boardKey);
	public boolean insertReReply(TripReply reply);
	
	public Map<String, Object> getReplyListByTen(Map<String, Object> params);
	public int getStartPage(int pageNum);
	public int getEndPage(int pageNum);
	public int getTotalPage(int boardKey);
	public boolean deleteReply(int replyKey);
	public Map<String, Object> selectOneByreplyKey(int replyKey);
	public boolean checkPw(String userNum, String checkPw);
	
}
