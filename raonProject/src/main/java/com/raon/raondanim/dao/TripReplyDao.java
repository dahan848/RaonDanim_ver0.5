package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.TripReply;

public interface TripReplyDao {

	public int insertBasicReply(TripReply reply);
	public List<Map<String, Object>> getReplyList(int boardKey);
	
	
	
}
