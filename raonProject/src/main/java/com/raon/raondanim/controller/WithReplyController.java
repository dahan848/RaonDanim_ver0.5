package com.raon.raondanim.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.WithReplyService;

@Controller
@RequestMapping("/wiReply")
public class WithReplyController {

	@Autowired
	private WithReplyService wiService;
	
	@ResponseBody
	@RequestMapping(value="/reply")
	public boolean insertReply(Model model,
			@RequestParam Map<String, Object> params,
			Authentication authentication) {
//		System.out.println(params);
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int loginUserNum = user.getUser_num();
		model.addAttribute("loginUserNum", loginUserNum);
		params.put("USER_NUM", loginUserNum);
//		System.out.println("loginUserNum : " + loginUserNum);
//		System.out.println("param : " + params);
		return wiService.insertReply(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/all/{WITH_NUM}")
	public ResponseEntity<Map<String, Object>> list (
			@PathVariable("WITH_NUM") int num,
			@RequestParam(value="page", defaultValue="1")int page) {
		System.out.println("댓글 리스트 출력");
		
//		System.out.println("start page : " + page);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("page", page);
		Map<String, Object> viewData = wiService.getViewData(params);
		
		
		ResponseEntity <Map<String, Object>> entity = null;
		try {
			List<Map<String, Object>> replyList = wiService.getWithReply(num);
			
//			System.out.println("댓글 replyList : " + replyList);
			//entity = new ResponseEntity<Map<String,Object>>(viewDate, HttpStatus.OK);
			entity = new ResponseEntity<Map<String,Object>>(viewData,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public boolean deleteReply(
			@RequestParam(value="input_reply_pass") int input_reply_pass,
			@RequestParam(value="userNum") int userNum,
			@RequestParam(value="num") int num,
			@RequestParam(value="wi_Reply_Num") int wi_Reply_Num
			) {
		System.out.println("댓글 삭제 컨트롤러 진입");

//		System.out.println("입력한 비밀번호 : " + input_reply_pass);
//		System.out.println("로그인된 USER_NUM : " + userNum);
//		System.out.println("게시글 번호 : " + num);
//		System.out.println("댓글 번호 : "+re_Reply_Num);
		
		Map<String, Object> replyDelete = new HashMap<>();
		replyDelete.put("input_reply_pass", input_reply_pass);
		replyDelete.put("userNum", userNum);
		replyDelete.put("num", num);
		replyDelete.put("wi_Reply_Num", wi_Reply_Num);
		
		return wiService.deleteReply(replyDelete);
	}
	
}
