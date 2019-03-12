package com.raon.raondanim.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.ReviewReplyService;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	private ReviewReplyService reService;
	
	@ResponseBody
	@RequestMapping(value="/reply")
	public boolean insertReply(Model model,
			@RequestParam Map<String, Object> params,
			Authentication authentication) {
		System.out.println(params);
		
		
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int loginUserNum = user.getUser_num();
//		model.addAttribute("loginUserNum", loginUserNum);
		params.put("USER_NUM", loginUserNum);
		System.out.println("loginUserNum : " + loginUserNum);
		System.out.println("param : " + params);
		
		return reService.insertReply(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/all/{REVIEW_NUM}")
	public ResponseEntity<List<Map<String, Object>>> list (
			@PathVariable("REVIEW_NUM") int num) {
		System.out.println("댓글 리스트");
		ResponseEntity<List<Map<String, Object>>> entity = null;
		try {
			List<Map<String, Object>> replyList = reService.getReviewReply(num);
			System.out.println(replyList);
			entity = new ResponseEntity<List<Map<String,Object>>>(replyList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
