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
import com.raon.raondanim.service.ReviewReplyService;

@Controller
@RequestMapping("/reply")
public class ReviewReplyController {
	
	@Autowired
	private ReviewReplyService reService;
	
	
	///////////////////댓글 입력///////////////////
	@ResponseBody
	@RequestMapping(value="/reply")
	public boolean insertReply(Model model,
			@RequestParam Map<String, Object> params,
			Authentication authentication) {		
		
		//로그인한 USER_NUM
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int loginUserNum = user.getUser_num();
		params.put("USER_NUM", loginUserNum);
				
//		System.out.println("loginUserNum : " + loginUserNum);
//		System.out.println("여행 후기 댓글 param : " + params);
		
		return reService.insertReply(params);
	}
	
	///////////////////댓글 리스트///////////////////
	@ResponseBody
	@RequestMapping(value="/all/{REVIEW_NUM}")
	public ResponseEntity<Map<String, Object>> list (
			Model model,
			@PathVariable("REVIEW_NUM") int num,
			@RequestParam(value="page", defaultValue="1")int page,
			@RequestParam Map<String, Object> param) {
		
		//param -> {page=1}   ==>> param에 startPage 들어있음
		//num = REVIEW_NUM
		
		System.out.println("댓글 리스트 출력");
		
		//params -> {page=1}   ==>> params에 startPage 들어있음
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("page", page);
		
		//페이징 관련
		//viewData -> startPage, totalPage, endPage, page, boardList(리스트 맵)
		Map<String, Object> viewData = reService.getViewData(params);
		
		//rev ==>> 댓글 정보 들어있음		//getReviewReply ==>> REVIWE_NUM 을 기준으로 댓글 뽑아야 함(댓글 정보, 유저정보)
									//		REVIEW_NUM이 게시글 번호인 댓글만 잘 뽑힘
		List<Map<String, Object>> rev = reService.getReviewReply(num);
		model.addAttribute("reply", rev);
		
		//모든 댓글 정보 다 나옴
		ResponseEntity <Map<String, Object>> entity = new ResponseEntity<Map<String,Object>>(viewData,HttpStatus.OK);		
	
		return entity;
	}

	
	
	///////////////////댓글 삭제///////////////////
	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public boolean deleteReply(
			@RequestParam(value="input_reply_pass") int input_reply_pass,
			@RequestParam(value="userNum") int userNum,
			@RequestParam(value="num") int num,
			@RequestParam(value="re_Reply_Num") int re_Reply_Num
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
		replyDelete.put("re_Reply_Num", re_Reply_Num);
		
		return reService.deleteReply(replyDelete);
	}
}
