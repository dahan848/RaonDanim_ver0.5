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
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.raon.raondanim.service.SearchService;

@Controller
@RequestMapping("/search")
public class SearchController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SearchService service;
	
	@RequestMapping("/home")
	public String search(Model model, @RequestParam(value= "page", defaultValue = "1") int page, @RequestParam(required = false) String city,
			@RequestParam(required = false) String language, @RequestParam(required = false) String travlestyle, @RequestParam(required = false) String name,
			@RequestParam(required = false) String nationality, @RequestParam(required = false) String gender, @RequestParam(required = false) String interest){
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("page", page);
		params.put("city", city);
		params.put("language", language);
		params.put("travlestyle", travlestyle);
		params.put("name", name);
		params.put("nationality", nationality);
		params.put("gender", gender);
		params.put("interest", interest);
		
		model.addAllAttributes(service.getViewData(params));
		
		logger.info("search : 화면 요청받음");
		return "search/main";
	}
}