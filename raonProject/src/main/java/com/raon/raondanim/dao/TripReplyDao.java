package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.TripReply;

public interface TripReplyDao {

	public int insertBasicReply(TripReply reply);
	public List<Map<String, Object>> getReplyList(int boardKey);
	//아래로 내려가는건지 원본에 댓글 다는건지 정하는 메소드
	public int replyCondition(Map<String, Object> params);
	//원글에 댓글 분기를 타지 않고 내려가기만한다 / 댓글의 댓글 
	public int insertReply(int gId);
	public int insertReply2(TripReply reply);
	
	
	//아래로만 분기타서 내려가는 댓글의댓글의댓글 과정으로 진행되어야함
	public int insertReReply(Map<String, Object> params);
	public int insertReReply2(TripReply reply);
	
}
