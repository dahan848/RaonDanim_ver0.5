package com.raon.raondanim.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home() {
		logger.info("");
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
}
