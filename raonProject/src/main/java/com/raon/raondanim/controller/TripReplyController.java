package com.raon.raondanim.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raon.raondanim.model.TripReply;
import com.raon.raondanim.service.TripReplyService;

@Controller
@RequestMapping("/tripreply")
public class TripReplyController {
	
	@Autowired
	TripReplyService replyService;
	
	@ResponseBody
	@RequestMapping("/writeReply")
	public boolean insertBasicReply(TripReply reply) {
		
		
		
		return false;
		
	}
	
	@ResponseBody
	@RequestMapping("/ReplyList")
	public List<Map<String, Object>> getReplyList(){
		
		return null;
		
	}
	
}
