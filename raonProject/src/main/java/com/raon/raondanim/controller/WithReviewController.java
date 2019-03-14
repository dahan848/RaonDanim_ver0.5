package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.WithReviewBoardService;

@Controller
@RequestMapping("/with")
public class WithReviewController {
	
	@Autowired
	private WithReviewBoardService wiService;
	
	@RequestMapping(value="/withMain", method = RequestMethod.GET)
	public String main(Model model) {
		System.out.println("동행후기 메인");
		model.addAttribute("with", wiService.selectAll());
		return "review/withMain";
	}
	
	@RequestMapping("/withList")
	public String withList(Model model,
			@RequestParam(value="num") int num) {
		System.out.println(num + "번 회원의 타임라인");
		Map<String, Object> rev = wiService.selectWithOne(num);
		model.addAttribute("with", rev);
		System.out.println(rev);
		Map<String, Object> rev2 = wiService.selectOne(num);
		model.addAttribute("withBoard", rev2);
		System.out.println(rev2);
		return "review/withList";
	}
	
	@RequestMapping("/withWriteForm")
	public String withWriteForm(Model model,
			Authentication authentication) {
		System.out.println("동행 후기 작성");
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int userNum = user.getUser_num();
		model.addAttribute("userNum", userNum);
		System.out.println(userNum);
		return "review/withWrite";
	}
	
	@RequestMapping("/withWrite")
	public String withWrite(
			@RequestParam(required=false) int WITH_GPA,
			@RequestParam(value="WITH_CONTENT") String WITH_CONTENT,
			@RequestParam(value="USER_NUM") int USER_NUM,
			RedirectAttributes ra) {
		System.out.println("동행후기 저장 중...");
		
		Map<String, Object> review = new HashMap<>();
		review.put("USER_NUM", USER_NUM);
		review.put("WITH_GPA", WITH_GPA);
		review.put("WITH_CONTENT", WITH_CONTENT);
		
		System.out.println("후기내용 : " + review);
		
		if(wiService.insertWith(review)) {
			System.out.println("동행후기 작성 성공");
			ra.addAttribute("USER_NUM", review.get("USER_NUM"));
		} else {
			System.out.println("동행후기 작성 실패");
		}
		return "review/withList";
	}
	
	
}
