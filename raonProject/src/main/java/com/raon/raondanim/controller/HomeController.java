package com.raon.raondanim.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.raon.raondanim.service.HomeService;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private HomeService service;
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Model model) {
		logger.info("");
		//home 요청이 들어오면, 메인화면에 뿌려줄 랜덤한 12명의 회원정보(Map)을 담은 List를 반환
		List<Map<String, Object>> result = service.getHomeUserList(); 
		//System.out.println("홈으로 넘어가는 LIST : " + result);
		model.addAttribute("userList", result);
		return "home/main";
	}
	
	@RequestMapping(value = "/introduction", method = RequestMethod.GET)
	public String introduction() {
		logger.info("");
		return "home/infrodcution";
	}
	
	@RequestMapping(value = "/inquiry", method = RequestMethod.GET)
	public String inquiry() {
		logger.info("");
		return "home/inquiry";
	}	
	
	@RequestMapping("/test")
	public String test() {
		System.out.println("home 테스트 요청 받음 ");
		return "test";
	}
	
	@RequestMapping("/test99")
	public String test99() {
		System.out.println("home 테스트 요청 받음 ");
		return "tset99";
	}
	
}
