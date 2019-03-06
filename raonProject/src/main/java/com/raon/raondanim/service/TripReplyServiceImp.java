package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.TripReplyDao;
import com.raon.raondanim.model.TripReply;

@Service
public class TripReplyServiceImp implements TripReplyService {

	@Autowired
	TripReplyDao replyDao;
	
	
	@Override
	public boolean insertBasicReply(TripReply reply) {
		
		if(replyDao.insertBasicReply(reply)>0) {
			return true;
		}else {
			return false;
		}
		
		
	}

	@Override
	public List<Map<String, Object>> getReplyList(int boardKey) {
		
		return replyDao.getReplyList(boardKey);
	}

}
