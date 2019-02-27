package com.raon.raondanim.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/motel")
public class MotelController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(){
		logger.info("");
		return "motel/NewFile";
	}
	
	@RequestMapping(value = "/registor_main")
	public String test1() {
		return "motel/registor_main";
	}
	
	@RequestMapping("/write_registor_type_style")
	public String registor_step1() {
		System.out.println("숙소 등록 진입 ");
		return "motel/registor_type_style";
	}
	@RequestMapping(value = "/registor_type_style", method = RequestMethod.POST)
	public String registor_step2(@RequestParam Map<String, Object> param, Model model) {
		System.out.println("step2 진입");
		System.out.println(param);
		model.addAttribute("registor", param);
		return "motel/registor_photo";
	}
}
