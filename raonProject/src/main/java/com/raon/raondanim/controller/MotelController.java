package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.raon.raondanim.service.MotelService;

@Controller
@RequestMapping("/motel")
public class MotelController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private MotelService service;
	
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(){
		logger.info("");
		return "motel/NewFile";
	}
	
	@RequestMapping(value = "/registor_main")
	public String test1() {
		return "motel/registor_main";
	}
	
	@RequestMapping(value = "/write_registor_type_style", method = RequestMethod.GET)
	public String registor_step1() {
		System.out.println("숙소 등록 진입 ");
		return "motel/registor_type_style";
	}
	
	
	@RequestMapping(value = "/registor_city_address", method = RequestMethod.POST)
	public String registor_step2(@RequestParam Map<String, Object> param, Model model) throws Exception {
		
		System.out.println("step2 진입");
		//System.out.println(param);
		//System.out.println(service.getAllNational());
		System.out.println("도시 : " + service.getAllCity());
		model.addAttribute("city", service.getAllCity());
		model.addAttribute("national", service.getAllNational());
		model.addAttribute("motel_type", param.get("motel_type"));
		model.addAttribute("motel_category", param.get("motel_category"));
		model.addAttribute("motel_people", param.get("motel_people"));
		model.addAttribute("motel_room", param.get("motel_room"));
		model.addAttribute("motel_bath", param.get("motel_bathroom"));
		return "motel/registor_city_address";
	}
	@RequestMapping(value="/registor_photo", method = RequestMethod.POST)
	public String registor_step3(@RequestParam Map<String, Object> param, Model model) {
		System.out.println("setp3  진입");
		System.out.println(param);
		model.addAttribute("registor", param);
		return "motel/registor_photo";
	}
	
	@RequestMapping(value="/registor_intro", method = RequestMethod.POST)
	public String registor_step4(@RequestParam Map<String, Object> param, Model model, MultipartFile cma_file,MultipartFile cma_file1) {
		System.out.println("step4 진입");
		System.out.println(param);
		model.addAttribute("registor", param);
		System.out.println("cma_file : " + cma_file);
		System.out.println("cma_file1 : " + cma_file1);
		
		return "motel/registor_intro";
	}
	
	@RequestMapping(value="/registor_complete", method = RequestMethod.POST)
	public String registor_complete(@RequestParam Map<String, Object> param, Model model) {
		System.out.println("registor_complete 진입");
		System.out.println(param);
		return "motel/test";
	}
}
