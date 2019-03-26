package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.MotelTbService;
import com.raon.raondanim.service.ReviewBoardService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private ReviewBoardService reService;
	
	@Autowired
	private MotelTbService moService;
	
	//여행 후기 메인화면  
	@RequestMapping(value = "/reviewMain", method = RequestMethod.GET)
	public String reviewMain(
			Model model){
		System.out.println("여행후기 메인");
		model.addAttribute("review", reService.selectAll());
		
//		System.out.println("==========================");
//		System.out.println(reService.selectAll());
//		System.out.println("==========================");
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
		
//		System.out.println("여행후기 작성 나라 선택 : " + moService.getAllNational());
		
		model.addAttribute("national", moService.getAllNational());
		
		return "review/reviewWrite";
	}
	
	//여행후기 작성
	@RequestMapping("/write")
	public String writeReview(Model model,
			@RequestParam(value="REV_TITLE") String REV_TITLE,
			@RequestParam(value="REV_DESTINATION") String REV_DESTINATION,
			@RequestParam(value="RE_CONTENT") String RE_CONTENT,
			@RequestParam(value="userNum") int userNum,
			RedirectAttributes ra,
			@RequestParam Map<String, Object> param
			)throws Exception {
		System.out.println("여행 후기 작성 중...");
		
		
		
		Map<String, Object> review = new HashMap<>();
		review.put("REV_TITLE", REV_TITLE);
		review.put("REV_DESTINATION", REV_DESTINATION);	
		review.put("RE_CONTENT", RE_CONTENT);
		review.put("USER_NUM", userNum);
		
		model.addAttribute("national", moService.getAllNational());
		
//		System.out.println("후기 내용 : " + review);
		
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
			HttpServletRequest request,
			Authentication authentication
			) {
		System.out.println("여행 후기 상세 보기");
		
		String num = request.getParameter("num");
		int intNum = Integer.parseInt(num);
//		System.out.println("게시글 번호 : " + intNum);
		
		Map<String, Object> rev = reService.selectReviewOne(intNum);
		model.addAttribute("review", rev);
//		System.out.println("게시글 정보 : " + rev);
		
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int userNum = user.getUser_num();
		model.addAttribute("userNum", userNum);
//		System.out.println("로그인 한 USER_NUM : " + userNum);
		
		model.addAttribute("plus", reService.plusReadCount(intNum));
		
//		model.addAttribute("reply", replyService.getReviewReply(intNum));
//		model.addAttribute("reply", replyService.getReviewReply(intNum));
//		System.out.println("댓글 번호 뽑기 : " + replyService.getReviewReply(intNum));
		
		return "review/reviewView"; 
	}
	
	//여행후기 삭제 (모달)
	@ResponseBody
	@RequestMapping("/delete")
	public boolean delete(
			@RequestParam Map<String, Object> param) {
		System.out.println("동행 후기 삭제");
		return reService.deleteReview(param);
	}
	
	//여행후기 수정 FORM

	@RequestMapping("/updateForm")
	public String UpdateForm(Model model,
			HttpServletRequest request,
			Authentication authentication) {
		System.out.println("동행 후기 수정");
		
		String num = request.getParameter("num");
		int intNum = Integer.parseInt(num);
		
		Map<String, Object> rev = reService.selectReviewOne(intNum);
		model.addAttribute("review", rev);
		
//		System.out.println("rev : " + rev);
		
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String userNum = String.valueOf(user.getUser_num());
		model.addAttribute("userNum", userNum);
		
		String user_Num = String.valueOf(rev.get("USER_NUM"));
		
		model.addAttribute("national", moService.getAllNational());
		
//		System.out.println("글쓴 USER_NUM : " + user_Num);
//		System.out.println("로그인 한 USER_NUM : " + userNum);
		
		if(user_Num.equals(userNum)) {
			System.out.println("수정 FORM 으로 이동");
			return "review/reviewUpdate";
		} else {
			System.out.println("수정 권한 없음");
			return "redirect:reviewMain";
		}
		
	}
	
	//여행후기 수정
	@RequestMapping("/update")
	public String modify(
			@RequestParam Map<String, Object> param,
			RedirectAttributes ra) {
		
		System.out.println("여행 후기 수정 중...");
//		System.out.println("여행 후기 수정 : " + param);
		int num = Integer.parseInt(String.valueOf(param.get("num"))) ;
		if(reService.updateReview(param)) {
			ra.addFlashAttribute("msg", "수정 성공 했습니다.");
		}else {
			ra.addFlashAttribute("msg", "수정 실패 했습니다. 다시 시도해 주세요.");
		}
		
		System.out.println("여행후기 수정 성공");

		return "redirect:reviewView?num="+num;
	}
	
	@ResponseBody
	@RequestMapping("/DB_nation")
	public List<Map<String, Object>> DB_nation() {
		return moService.getAllNational();
	}
	
}
