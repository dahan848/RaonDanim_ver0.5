package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.raondanim.service.SearchService;

@Controller
@RequestMapping("/search")
public class SearchController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SearchService service;
	
	@RequestMapping("/home")
	public String search(Model model, @RequestParam(value= "page", defaultValue = "1") int page) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("page", page);
		
		model.addAllAttributes(service.getViewData(params));
		System.out.println(model.addAllAttributes(service.getViewData(params)));
		
		logger.info("search : 화면 요청받음");
		return "search/main";
	}
	
	@RequestMapping("/test")
	public String test() {
		return "search/test";
	}
}