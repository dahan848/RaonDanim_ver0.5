package com.raon.raondanim.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		//System.out.println("관리자/컨트롤러/월별 유저 가입수 : "+accountsService.getUserRegDate());
	
		
		model.addAttribute("boardList", tripService.getMonthWriteData());
		model.addAttribute("boardAndDeclaration", tripService.getBoardAndDeclatation());
		model.addAttribute("userRegList", accountsService.getUserRegDate());
		model.addAttribute("motelList", tripService.getMotelMonthWriteData());
		return "admin/main";
		
	}
	@RequestMapping("/user")
	public String user() {
		System.out.println("유저 관리 화면 요청");
		
		return "admin/user";
		
	}
	
	@RequestMapping("/board")
	public String tripBoard(Model model) {
		System.out.println("여행 게시글 관리 화면 요청");
		
		//System.out.println("관리자/컨트롤러/ 신고당한 게시글 목록 데이터 확인 : "+model.addAttribute("dBoardList", tripService.getDeclarationBoard()));
		model.addAttribute("dBoardList", tripService.getDeclarationBoard());
		return "admin/board";
		
	}
	
	@RequestMapping("/motelBoard")
	public String motelBoard(Model model) {
		System.out.println("숙박 게시글 관리 화면 요청");
		
		

		return "admin/motelBoard";
		
	}
	@ResponseBody
	@RequestMapping("/tripBoardDelete")
	public boolean tripBoardDelete(int boardKey) {
		System.out.println("관리자 여행게시글 삭제 요청");
		
		return tripService.totalDelete(boardKey);
		
	}
	
}
