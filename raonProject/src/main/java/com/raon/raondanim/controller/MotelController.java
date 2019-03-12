package com.raon.raondanim.controller;


import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

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
		//System.out.println("도시 : " + service.getAllCity());
		model.addAttribute("city", service.getAllCity());
		model.addAttribute("national", service.getAllNational());
		model.addAttribute("motel_type", param.get("motel_type"));
		model.addAttribute("motel_category", param.get("motel_category"));
		model.addAttribute("motel_people", param.get("motel_people"));
		model.addAttribute("motel_room", param.get("motel_room"));
		model.addAttribute("motel_bathroom", param.get("motel_bathroom"));
		return "motel/registor_city_address";
	}
	@RequestMapping(value="/registor_photo", method = RequestMethod.POST)
	public String registor_step3(@RequestParam Map<String, Object> param, Model model) {
		System.out.println("setp3  진입");
		System.out.println(param);
		
		//파라미터에 있는 nation, city 의 값을 영어/한글 값으로 나누어서 저장(테이블에 영문/한글 따로 컬럼에 저장됨)
		
		String nation = (String) param.get("motel_nation");
		
		StringTokenizer nation_div = new StringTokenizer(nation, ",");
		String nation_en = "";
		String nation_ko = "";
		while(nation_div.hasMoreTokens()) {
			//System.out.println("nation : " + nation_div.nextToken());
			nation_en =  nation_div.nextToken();
			nation_ko =  nation_div.nextToken();
		}
		// nation_ko 값에 첫글자에 공백이 들어가므로 공백을 버려준다.
		nation_ko = nation_ko.trim();
		param.put("motel_nation_en", nation_en);
		param.put("motel_nation_ko", nation_ko);
		
		//System.out.println("motel_nation_en : " + param.get("motel_nation_en"));
		//System.out.println("motel_nation_ko : " + param.get("motel_nation_ko"));
		String city = (String) param.get("motel_city");
		
		StringTokenizer city_div = new StringTokenizer(city, ",");
		
		
		String city_en = "";
		String city_ko = "";
		while(city_div.hasMoreTokens()) {
			city_en = city_div.nextToken();
			city_ko = city_div.nextToken();	
		}
		// city_ko 값 첫글자에 공백이 들어가므로 공백을 버려준다.
		city_ko = city_ko.trim();
		//System.out.println(city_ko);
		param.put("motel_city_en", city_en);
		param.put("motel_city_ko", city_ko);
		
		model.addAttribute("motel_city_en", param.get("motel_city_en"));
		model.addAttribute("motel_city_ko", param.get("motel_city_ko"));
		model.addAttribute("motel_nation_en", param.get("motel_nation_en"));
		model.addAttribute("motel_nation_ko", param.get("motel_nation_ko"));
		
		model.addAttribute("motel_type", param.get("motel_type"));
		model.addAttribute("motel_category", param.get("motel_category"));
		model.addAttribute("motel_people", param.get("motel_people"));
		model.addAttribute("motel_room", param.get("motel_room"));
		model.addAttribute("motel_bathroom", param.get("motel_bathroom"));
		model.addAttribute("motel_address", param.get("motel_address"));
		model.addAttribute("registor", param);
		return "motel/registor_photo";
	}
	
	@RequestMapping(value="/registor_intro", method = RequestMethod.POST)
	public String registor_step4(@RequestParam Map<String, Object> param, Model model, 
			List<MultipartFile> files) {
			//MultipartFile cma_file,MultipartFile cma_file1,MultipartFile cma_file2,MultipartFile cma_file3,MultipartFile cma_file4

		System.out.println("step4 진입");
		System.out.println("file : " + files);
		System.out.println(param);

		model.addAttribute("motel_city_en", param.get("motel_city_en"));
		model.addAttribute("motel_city_ko", param.get("motel_city_ko"));
		model.addAttribute("motel_nation_en", param.get("motel_nation_en"));
		model.addAttribute("motel_nation_ko", param.get("motel_nation_ko"));
		
		model.addAttribute("motel_type", param.get("motel_type"));
		model.addAttribute("motel_category", param.get("motel_category"));
		model.addAttribute("motel_people", param.get("motel_people"));
		model.addAttribute("motel_room", param.get("motel_room"));
		model.addAttribute("motel_bathroom", param.get("motel_bathroom"));
		model.addAttribute("motel_address", param.get("motel_address"));
		model.addAttribute("motel_photoFiles", files);
		
		model.addAttribute("registor", param);
//		System.out.println("cma_file : " + cma_file);
//		System.out.println("cma_file1 : " + cma_file1);
//		System.out.println("cma_file2 : " + cma_file2);
//		System.out.println("cma_file3 : " + cma_file3);
//		System.out.println("cma_file4 : " + cma_file4);
		
		return "motel/registor_intro";
	}
	
	@RequestMapping(value="/registor_complete", method = RequestMethod.POST)
	public String registor_complete(@RequestParam Map<String, Object> param, Model model) {
		System.out.println("registor_complete 진입");
		System.out.println("complete : " + param);
		if(service.write_Motel(param)) {
			//숙박 글 정상 등록
			System.out.println("숙박글 등록 성공");
		}else {
			//숙박 글 등록 실패
			System.out.println("숙박글 등록 실패");
			
		}
		
		return "motel/motel_result";
	}
}
