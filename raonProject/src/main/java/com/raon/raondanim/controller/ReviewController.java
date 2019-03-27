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

		model.addAttribute("review", reService.selectAll());
		
		logger.info("");
		return "review/reviewMain";
	}
	
	//여행후기 작성 FORM
	@RequestMapping("/writeForm")
	public String writeForm(Model model,
			Authentication authentication) {

		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int userNum = user.getUser_num();
		model.addAttribute("userNum", userNum);
		
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
		
		Map<String, Object> review = new HashMap<>();
		review.put("REV_TITLE", REV_TITLE);
		review.put("REV_DESTINATION", REV_DESTINATION);	
		review.put("RE_CONTENT", RE_CONTENT);
		review.put("USER_NUM", userNum);
		
		model.addAttribute("national", moService.getAllNational());
		
		if(reService.insertReview(review)) {
			ra.addFlashAttribute("msg", "작성 성공 했습니다.");
			ra.addAttribute("num", review.get("NUM"));
		} else {
			ra.addFlashAttribute("msg", "작성 실패 했습니다.");
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
		
		String num = request.getParameter("num");
		int intNum = Integer.parseInt(num);
		
		Map<String, Object> rev = reService.selectReviewOne(intNum);
		model.addAttribute("review", rev);
		
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int userNum = user.getUser_num();
		model.addAttribute("userNum", userNum);
		
		model.addAttribute("plus", reService.plusReadCount(intNum));
		
		return "review/reviewView"; 
	}
	
	//여행후기 삭제 (모달)
	@ResponseBody
	@RequestMapping("/delete")
	public boolean delete(
			@RequestParam Map<String, Object> param) {

		return reService.deleteReview(param);
	}
	
	//여행후기 수정 FORM

	@RequestMapping("/updateForm")
	public String UpdateForm(Model model,
			HttpServletRequest request,
			Authentication authentication) {
		
		String num = request.getParameter("num");
		int intNum = Integer.parseInt(num);
		
		Map<String, Object> rev = reService.selectReviewOne(intNum);
		model.addAttribute("review", rev);
		
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String userNum = String.valueOf(user.getUser_num());
		model.addAttribute("userNum", userNum);
		
		String user_Num = String.valueOf(rev.get("USER_NUM"));
		
		model.addAttribute("national", moService.getAllNational());
		
		if(user_Num.equals(userNum)) {
			return "review/reviewUpdate";
		} else {
			return "redirect:reviewMain";
		}
		
	}
	
	//여행후기 수정
	@RequestMapping("/update")
	public String modify(
			@RequestParam Map<String, Object> param,
			RedirectAttributes ra) {
	
		int num = Integer.parseInt(String.valueOf(param.get("num"))) ;
		if(reService.updateReview(param)) {
			ra.addFlashAttribute("msg", "수정 성공 했습니다.");
		}else {
			ra.addFlashAttribute("msg", "수정 실패 했습니다. 다시 시도해 주세요.");
		}

		return "redirect:reviewView?num="+num;
	}
	
	@ResponseBody
	@RequestMapping("/DB_nation")
	public List<Map<String, Object>> DB_nation() {
		return moService.getAllNational();
	}
	
}
