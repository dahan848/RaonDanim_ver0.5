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
			return "redirect:/signupForm"; //가입실패
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
	
	public String update1() {
		return "";
	}

	public String personal() {
		return "";
	}
	
	public String gallery() {
		return "";
	}

}
