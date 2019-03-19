package com.raon.raondanim.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.raon.raondanim.service.AccountsService;
import com.raon.raondanim.service.TripBoardService;

@RequestMapping("/admin")
@Controller
public class AdminController {

	@Autowired
	TripBoardService tripService;
	
	@Autowired
	AccountsService accountsService;
	
	@RequestMapping("/main")
	public String main(Model model) {
		System.out.println("관리자 메인화면 요청받음");
		
		//System.out.println("관리자/컨트롤러/월별 게시글 작성수 확인  : "+tripService.getMonthWriteData());
		//System.out.println("관리자/컨트롤러/총게시글그리고신고글수 : "+tripService.getBoardAndDeclatation());
		System.out.println("관리자/컨트롤러/월별 유저 가입수 : "+accountsService.getUserRegDate());
	
		
		model.addAttribute("boardList", tripService.getMonthWriteData());
		model.addAttribute("boardAndDeclaration", tripService.getBoardAndDeclatation());
		model.addAttribute("userRegList", accountsService.getUserRegDate());
		return "admin/main";
		
	}
	
	
	
}
