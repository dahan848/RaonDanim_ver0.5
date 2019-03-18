package com.raon.raondanim.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminController {

	
	@RequestMapping("/main")
	public String main() {
		System.out.println("관리자 메인화면 요청받음");
		
		return "admin/main";
		
	}
}
