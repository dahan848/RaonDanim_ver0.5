package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.TripReply;

public interface TripReplyService {

	public boolean insertBasicReply(TripReply reply);
	public List<Map<String, Object>> getReplyList(int boardKey);
	public boolean insertReReply(TripReply reply);
}
