package com.raon.raondanim.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raon.raondanim.model.User;
import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.AccountsService;

import java.security.Principal;
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
		if(service.join(param)) {
			return "redirect:/home"; //가입성공
		}else {
			return "redirect:accounts/signupForm"; //가입실패
		}
	}
	
	@RequestMapping(value = "/certify", method = RequestMethod.POST)
	public void emailVerifySuccess(@ModelAttribute User user, HttpServletResponse response) {
		service.email_verify(user, response);
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
	@RequestMapping(value = "/update1Form")
	public String update1Form(Authentication authentication, Model model) {

		//나의 정보를 클릭하면, 추가 프로필 등록 1단계 화면이 나옴.
		//사용자의 정보를 추가 프로필 1단계 화면으로 넘겨주어야 한다.
		//1. 수정(입력)된 정보 발생
		//'다음'버튼 클릭 시 별도의 알림 창 없이 [저장]
		//'다른 탭'을 클릭 하려고 하면 수정된 정보가 있는데 저장 할 것인가를 물음.
		return "accounts/profile-update1";
	}
	
	@RequestMapping(value = "/update2Form")
	public String update2Form() {
		return "accounts/profile-update2";
	}
	
	@RequestMapping(value = "/update3Form")
	public String update3Form() {
		return "accounts/profile-update3";
	}

	@RequestMapping(value = "/personalForm")
	public String personalForm(Authentication authentication, Model model) {
		//시큐리티 세션에 저장 된 현재 접속한 user 정보 가져오기 
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String userId = user.getUser_id();
		Map<String, Object> userInfo = service.getPersonalInfo(userId);
		model.addAttribute("user",userInfo);
		System.out.println("보낸 유저 맵  : " + userInfo);
		return "accounts/profile-personal";
	}
	
	@ResponseBody
	@RequestMapping(value = "/personal")
	public String personal(Authentication authentication,@RequestParam Map<String, Object> param) {
		System.out.println("받은 유저 맵 "+ param);
		//시큐리티 세션에 저장 된 현재 접속한 user 정보 가져오기 
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String userNum = Integer.toString(user.getUser_num());
		//서비스 객체 이용해서 유저정보 (개인정보) 업데이트 하기
		String msg = "";
		if(service.setPersonalInfo(param, userNum)) {
			//업데이트 성공
			msg = "업데이트 성공";
		}else {
			//업데이트 실패
			msg = "업데이트 실패";
		}
		return "msg";
	}
	

}
