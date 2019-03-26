package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raon.raondanim.model.User;
import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.WithReviewBoardService;

@Controller
@RequestMapping("/with")
public class WithReviewController {
	
	@Autowired
	private WithReviewBoardService wiService;
	
	@RequestMapping(value="/withMain", method = RequestMethod.GET)
	public String main(
			Model model,
			@RequestParam(required = false) String keyword) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("keyword", keyword);
		
		model.addAttribute("with",wiService.getViewData(params));
		model.addAllAttributes(wiService.getViewData(params));
			
		return "review/withMain";
	}
	
	
	@RequestMapping("/withList")
	public String withList(
			Model model,
			Authentication authentication,
			HttpServletRequest req,
			@RequestParam(value="num") int num,		
			@RequestParam Map<String, Object> param,
			@RequestParam(value = "page", defaultValue = "1") int page
			) {
		
		//num = TL_USER_NUM
		//param ==>> {num=} TL_USER_NUM 들어감
		
		System.out.println("num" + num);
		System.out.println("param : " + param);
		
		
		
		//로그인한 USER_NUM
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int userNum = user.getUser_num();	
		
		//타임라인 USER 정보 
		String strNum = String.valueOf(num);
		User rev = wiService.selectByUserNum(strNum);
		Map<String, Object> revrev = new HashMap<>();
		revrev.put("User", rev);
		revrev.put("userNum",userNum);
		model.addAttribute("withBoard", revrev);
		
		//리스트 부분
		List<Map<String, Object>> rev2 = wiService.getWithBoard(num);
		model.addAttribute("withList", rev2);
		
		//페이징 부분(page=1) ==> startPage 들어있음
		Map<String, Object> paging = new HashMap<String, Object>();
		paging.put("page", page);
		paging.put("num", num);
		
		
		
		//startPage, totalPage, endPage, page, boardList(리스트 맵)
		model.addAllAttributes(wiService.getViewPagingData(paging));
		System.out.println("wiService.getViewPagingData(paging) : " + wiService.getViewPagingData(paging));
		
		
		return "review/withList";
	}
	
	@RequestMapping("/withWriteForm")
	public String withWriteForm(
			Model model,
			Authentication authentication,
			@RequestParam(value="num") int num
			) {
		
//		System.out.println("동행 후기 작성");
		
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int WR_USER_NUM = user.getUser_num();
		model.addAttribute("userNum", WR_USER_NUM);
//		System.out.println("로그인한 USER_NUM : " + WR_USER_NUM);
		
		String strNum = String.valueOf(num);
		User rev = wiService.selectByUserNum(strNum);
//		Map<String, Object> rev = wiService.selectOne(num);		//num = 타임라인 주인 USER_NUM
		model.addAttribute("withBoard", rev);
//		System.out.println("writeForm 타임라인 주인 : " + num);
		
		return "review/withWrite";
	}
	
	@RequestMapping("/withWrite")
	public String withWrite(
			Model model,
			@RequestParam Map<String, Object> param,
			RedirectAttributes ra,
			@RequestParam(value="TL_USER_NUM") int TL_USER_NUM) {
		
//		System.out.println("동행후기 저장 중...");
	
//		System.out.println("param : " + param);		
		//WR_USER_NUM -> 현재 로그인 되어있는 user_num
		//TL_USER_NUM이 필요 -> url에 num 으로 받아오는 애
		
		
//		Map<String, Object> rev = wiService.selectOne(TL_USER_NUM);		//num = TL_USER_NUM
//		model.addAttribute("withBoard", rev);
		System.out.println("write 타임라인 주인 : " + TL_USER_NUM);
		
		if(wiService.insertWith(param)) {
			System.out.println("동행후기 작성 성공");
		} else {
			System.out.println("동행후기 작성 실패");
		}
		return "redirect:withList?num="+TL_USER_NUM;
	}
	
	@RequestMapping("/withView")
	public String withView(
			Model model,
			HttpServletRequest request,
			Authentication authentication,
			@RequestParam Map<String, Object> param) {
		
		System.out.println("동행 후기 상세 보기");
//		System.out.println("param : " + param);
		
//		String num = request.getParameter("wrUser");
//		int WR_USER_NUM = Integer.parseInt(num);
//		System.out.println("게시글 작성자 번호 : " + WR_USER_NUM);
		
		
		String withNum = request.getParameter("withNum");
		int WITH_NUM = Integer.parseInt(withNum);
				
		String loginUserNum = request.getParameter("userNum");
		int userNum = Integer.parseInt(loginUserNum);
		model.addAttribute("userNum", userNum);
		
		Map<String, Object> rev = wiService.selectWithOne(WITH_NUM);
//		System.out.println("컨트롤러 데이터 확인-----------------");
//		System.out.println(WITH_NUM);
//		System.out.println(wiService.selectWithOne(WITH_NUM));
		model.addAttribute("withBoard", rev);
		
//		System.out.println("게시글 정보 : " + rev);
	
		
//		model.addAttribute("withBoard", wiService.plusReadCount(WITH_NUM));
//		System.out.println("withBoard 데이터 확인:"+wiService.plusReadCount(WITH_NUM));
		String TL_USER_NUM = request.getParameter("tlUser");
		User rev2 = wiService.selectByUserNum(TL_USER_NUM);
		model.addAttribute("tlUser", rev2);
//		System.out.println("타임라인 주인 번호 : " +  TL_USER_NUM);		
				
		return "review/withView";
	}
	
	//여행후기 삭제 (모달)
	@ResponseBody
	@RequestMapping("/delete")
	public boolean delete(
			@RequestParam Map<String, Object> param) {
		System.out.println("동행 후기 삭제");
		return wiService.deleteWith(param);
	}
	
	@RequestMapping("/updateForm")
	public String updateForm(Model model,
			HttpServletRequest request,
			Authentication authentication) {
		
		System.out.println("여행 후기 수정");
		
		//intNum = WITH_NUM
		String withNum = request.getParameter("withNum");
		int intNum = Integer.parseInt(withNum);
		
		//WITH_NUM으로 게시글 내용 select
		Map<String, Object> rev = wiService.selectWithOne(intNum);
		model.addAttribute("withModify", rev);
		
		//로그인한 USER_NUM
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String userNum = String.valueOf(user.getUser_num());
		model.addAttribute("userNum", userNum);
		
		//글 쓴 사람 WR_USER_NUM
		String user_Num = String.valueOf(rev.get("WR_USER_NUM"));
		
		if(user_Num.equals(userNum)) {
			System.out.println("동행 후기 수정 FORM 으로 이동");
			return "review/withUpdate";
		} else {
			System.out.println("동행 후기 수정 권한 없음");
			return "redirect:withMain";
		}
	}
	
	@RequestMapping("/update")
	public String modify(
			@RequestParam Map<String, Object> param,
			RedirectAttributes ra
			) {
		
		System.out.println("동행 후기 수정 중...");
		//param ==>> userNum(로그인 한 USER_NUM), WITH_GPA(별점), WITH_CONTENT
		System.out.println("동행 후기 수정 : " + param);
		
		int userNum = Integer.parseInt(String.valueOf(param.get("userNum")));
		int withNum = Integer.parseInt(String.valueOf(param.get("num")));
		
		
		if(wiService.updateWith(param)) {
			ra.addFlashAttribute("msg", "수정 성공 했습니다.");
		} else {
			ra.addFlashAttribute("msg", "수정 실패 했습니다. 다시 시도해 주세요.");
		}
		
		System.out.println("동행 후기 수정 성공");
		
		return "redirect:withView?withNum="+withNum;
	}
	
}
