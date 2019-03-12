package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.ReviewBoardService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private ReviewBoardService reService;
	
	//여행 후기 메인화면  
	@RequestMapping(value = "/reviewMain", method = RequestMethod.GET)
	public String reviewMain(
			Model model){
		System.out.println("여행후기 메인");
		model.addAttribute("review", reService.selectAll());
		logger.info("");
		return "review/reviewMain";
	}
	
	//여행후기 작성 FORM
	@RequestMapping("/writeForm")
	public String writeForm(Model model,
			Authentication authentication) {
		System.out.println("여행후기작성");
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int userNum = user.getUser_num();
		model.addAttribute("userNum", userNum);
		return "review/reviewWrite";
	}
	
	//여행후기 작성
	@RequestMapping("/write")
	public String writeReview(Model model,
			@RequestParam(value="REV_TITLE") String REV_TITLE,
			@RequestParam(value="REV_DESTINATION") String REV_DESTINATION,
			@RequestParam(value="RE_CONTENT") String RE_CONTENT,
//			@PathVariable("USER_NUM") int USER_NUM,
			@RequestParam(value="userNum") int userNum,
//			@RequestParam(value="RE_ST") int RE_ST,
//			@RequestParam(value="RE_COUNT") int RE_COUNT,
//			@RequestParam(value="RE_REG_DATE") int RE_REG_DATE,
			RedirectAttributes ra
			) {
		System.out.println("여행 후기 작성 중...");
		
		Map<String, Object> review = new HashMap<>();
		review.put("REV_TITLE", REV_TITLE);
		review.put("REV_DESTINATION", REV_DESTINATION);	
		review.put("RE_CONTENT", RE_CONTENT);
		review.put("USER_NUM", userNum);
		
		System.out.println("후기 내용 : " + review);
		
		if(reService.insertReview(review)) {
			System.out.println("작성 성공");
			ra.addAttribute("num", review.get("NUM"));
		} else {
			System.out.println("작성 실패");
		}
		return "redirect:reviewMain";
	}
	
	//여행 후기 상세 페이지
	@RequestMapping("/reviewView")
		public String reviewView(
				Model model,
//				@RequestParam(value="num") int num,
//				int num,
				HttpServletRequest request
				) {
			System.out.println("여행 후기 상세 보기");
			String num = request.getParameter("num");
			int intNum = Integer.parseInt(num);
//			System.out.println(num);
			Map<String, Object> rev = reService.selectReviewOne(intNum);
//			System.out.println(rev);
			model.addAttribute("review", rev);
			return "review/reviewView"; 
		}
	
}
