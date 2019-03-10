package com.raon.raondanim.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raon.raondanim.model.TripReply;
import com.raon.raondanim.service.TripReplyService;

@Controller
@RequestMapping("/tripReply")
public class TripReplyController {
	
	@Autowired
	TripReplyService replyService;
	
	@ResponseBody
	@RequestMapping(value="/writeReply", method=RequestMethod.POST)
	public boolean insertBasicReply(TripReply reply) {
		System.out.println("첫번째 댓글용 요청받음");
		System.out.println("댓글 확인 : "+reply);
		
		return replyService.insertBasicReply(reply);
		
	}
	
	@ResponseBody
	@RequestMapping("/replyList")
	public List<Map<String, Object>> getReplyList(int boardKey){
		System.out.println("댓글 리스트 요청받음");
		System.out.println("댓글리스트 보드키 :"+boardKey);
		
		System.out.println("댓글 리스트 : "+replyService.getReplyList(boardKey));
		

		return replyService.getReplyList(boardKey);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/writeReReply", method=RequestMethod.POST)
	public boolean insertReReply(TripReply reply) {
		System.out.println("대댓글 입력 요청받음");
		
		System.out.println("대댓글 : "+reply);
		
		return false;
		
	}
	
	
	
	
}
