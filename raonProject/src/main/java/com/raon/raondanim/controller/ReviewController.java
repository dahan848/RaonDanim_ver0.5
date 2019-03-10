package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
			Model model,
			int num){
		System.out.println("여행후기 메인입니다");
		model.addAttribute("review", reService.selectOne(num));
		logger.info("");
		return "review/reviewMain";
	}
	
	//여행후기 작성 FORM
	@RequestMapping("/writeForm")
	public String writeForm() {
		System.out.println("여행후기작성");
		return "review/reviewWrite";
	}
	
	//여행후기 작성
	@RequestMapping("/write")
	public String writeReview(
//			@RequestParam(value="title") String title,
//			@RequestParam(value="travle") String travle,
//			@RequestParam(value="content") String content,
//			RedirectAttributes ra
			) {
		System.out.println("여행 후기 작성 중...");
		
//		Map<String, Object> review = new HashMap<>();
//		review.put("title", title);
//		review.put("travle", travle);	
//		review.put("content", content);
		
//		if(service.insertReview(review)) {
//			System.out.println("작성 성공");
//			ra.addAttribute("num", review.get("NUM"));
//		} else {
//			System.out.println("작성 실패");
//		}
		return "redirect:reviewView";
	}
	
	//여행 후기 상세 페이지
	@RequestMapping("/reviewView")
		public String reviewView(
//				Model model,
//				int num
				) {
			System.out.println("리뷰보기");
//			Map<String, Object> rev = service.selectOne(num);
//			System.out.println(rev);
//			model.addAttribute("review", rev);
			return "review/reviewView"; 
		}
	
}
