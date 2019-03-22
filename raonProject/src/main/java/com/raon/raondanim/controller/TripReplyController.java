package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public Map<String, Object> getReplyList(int boardKey,
			@RequestParam(defaultValue="1") int pageNum){
		System.out.println("댓글 리스트 요청받음");
		System.out.println("댓글리스트 보드키 :"+boardKey);
		
		//System.out.println("댓글 리스트 : "+replyService.getReplyList(boardKey));
		Map<String, Object> params = new HashMap<>();
		params.put("boardKey", boardKey);
		params.put("pageNum", pageNum);
		
		// 전체댓글 리스트만 뽑아오는 메소드 리스트<맵> 구조
		// return replyService.getReplyList(boardKey);

		return replyService.getReplyListByTen(params);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/writeReReply", method=RequestMethod.POST)
	public boolean insertReReply(TripReply reply) {
		System.out.println("대댓글 입력 요청받음");
		
		System.out.println("컨트롤러 대댓글 값 확인 : "+reply);
		
		
		
		
		
		return replyService.insertReReply(reply);
		
	}
	@ResponseBody
	@RequestMapping("/deleteReply")
	public boolean deleteReply(int replyKey) {
		System.out.println("댓글 삭제 요청 받음");
		System.out.println("댓글 컨틀롤러 /삭제/"+replyKey);
		
		return replyService.deleteReply(replyKey);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/checkPw", method=RequestMethod.POST)
	public boolean checkPw(int replyKey,String checkReplyPw) {
		System.out.println("댓글 수정/삭제 비밀번호 요청 받음");
		Map<String, Object> user =replyService.selectOneByreplyKey(replyKey);
		String userNum = String.valueOf(user.get("USER_NUM"));
		

		return replyService.checkPw(userNum, checkReplyPw);
		
		
	}
	
}
