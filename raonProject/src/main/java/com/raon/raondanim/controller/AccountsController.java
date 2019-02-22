package com.raon.raondanim.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.raondanim.service.AccountsService;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/accounts")
public class AccountsController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private AccountsService service;
	
	@RequestMapping(value = "/loginForm")
	public String loginForm() {
		logger.info("");
		return"accounts/loginForm";
	}
	
	@RequestMapping(value = "/loginError")
	public String loginError() {
		return "redirect:/accounts/loginForm";
	}
	
	@RequestMapping(value ="/signupForm")
	public String signupForm() {
		return "accounts/signupForm";
	}
	
	@RequestMapping(value ="/signup", method = RequestMethod.POST)
	public String signup(@RequestParam Map<String, Object> param) { //가입요청
		System.out.println(param);
		if(service.join(param)) {
			return "redirect:/home"; //가입성공
		}else {
			return "redirect:accounts/signupForm"; //가입실패
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request,HttpServletResponse response) {
		service.logout(request, response);
		return "redirect:/home";
	}
	
	public String passwordResetForm() {
		return "";
	}
	
	public String passwordReset() {
		return "";
	}
	
	
	public String profile() {
		return "";
	}
	@RequestMapping(value = "/update1")
	public String update1() {
		//나의 정보를 클릭하면, 추가 프로필 등록 1단계 화면이 나옴.
		//사용자의 정보를 추가 프로필 1단계 화면으로 넘겨주어야 한다.
		//1. 수정(입력)된 정보 발생
		//'다음'버튼 클릭 시 별도의 알림 창 없이 [저장]
		//'다른 탭'을 클릭 하려고 하면 수정된 정보가 있는데 저장 할 것인가를 물음.
		return "accounts/profile-update1";
	}
	
	@RequestMapping(value = "/update2")
	public String update2() {
		return "accounts/profile-update2";
	}
	
	@RequestMapping(value = "/update3")
	public String update3() {
		return "accounts/profile-update3";
	}

	@RequestMapping(value = "/personal")
	public String personal() {
		return "accounts/profile-personal";
	}
	

}
