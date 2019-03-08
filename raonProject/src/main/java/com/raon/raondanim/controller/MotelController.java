package com.raon.raondanim.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.lang.ProcessBuilder.Redirect;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.raon.raondanim.service.MotelTbService;

import oracle.jdbc.proxy.annotation.GetDelegate;



@Controller
@RequestMapping("/motel")
public class MotelController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private MotelTbService service;
	
	private static final String FILE_PATH = "c:/tmp/";
	
	/*@RequestMapping("/motelList")
	public String motelList() {
		System.out.println("motel : 숙박 리스트 요청");
		System.out.println(service.getBoardByNum(261));
		return "";
	}*/
	
	public int startEnd(String checkin, String checkout) {
		if(checkin.equals("") && checkout.equals("")) {
			return 0;
		}else {
			
			String tmpCheckIn = checkin;
			tmpCheckIn = tmpCheckIn.replace("-", "");
			int startYear = Integer.parseInt(tmpCheckIn.substring(0, 4));
			int startMonth = Integer.parseInt(tmpCheckIn.substring(4,6));
			int startDate = Integer.parseInt(tmpCheckIn.substring(6,8));
			String tmpEndDate = checkout;
			tmpEndDate = tmpEndDate.replace("-", "");
			int endDate = Integer.parseInt(tmpEndDate);
			/*int endDate = Integer.parseInt(checkout);*/
			
			
			Calendar cal = Calendar.getInstance();
			
			cal.set(startYear, startMonth-1,startDate);
			int count = 0;
			while(true) {
				cal.add(Calendar.DATE, 1);
				count++;
				if(getDateByInteger(cal.getTime()) > endDate) {
					break;
				}
			}
			return count;
		}
		
	}
	 public static int getDateByInteger(Date date) {
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	        return Integer.parseInt(sdf.format(date));
	 }


	
	
	@RequestMapping("/searchList")
	public String boardList(@RequestParam(value="page",defaultValue="1")int page,
			Model model,String location, String checkin, @RequestParam(required=false)String checkout, @RequestParam(required=false)int adults) {
		System.out.println("리스트 요청");
		System.out.println(checkin);
		System.out.println(checkout);
		System.out.println(adults);
		System.out.println("여행 일수 : "+startEnd(checkin,checkout));
		model.addAttribute("date",startEnd(checkin,checkout));
		
		
		return "motel/motelList";
	}
	
	@RequestMapping(value="/replyList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyList(@RequestParam(value="page",defaultValue="1")int page,
			Model model, int num) {
		System.out.println("댓글 요청");
		Map<String, Object>params = new HashMap<String, Object>();
		params.put("page", page);
		params.put("num", num);
		System.out.println(params);
		Map<String, Object>result = new HashMap<String, Object>();
		result.put("board", service.getReplyData(params));
		System.out.println(result);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/list", method=RequestMethod.POST)
	public Map<String, Object> test1(@RequestParam(value="page",defaultValue="1")int page,
			@RequestParam(required=false)String keyword,
			@RequestParam(defaultValue="0")int type,
			Model model) {
		System.out.println("ajax 요청");
		Map<String, Object>params = new HashMap<String, Object>();
		params.put("page", page);
		params.put("keyword", keyword);
		params.put("type", type);
		Map<String, Object>result = new HashMap<String, Object>();
		result.put("board", service.getViewData(params));
		System.out.println(result);
		
		return result;
	}
	
	@RequestMapping(value="/write_reply", method=RequestMethod.POST)
	public String writeReply(@RequestParam Map<String, Object> params, Model model) {
		System.out.println("댓글작성");
		System.out.println(params);
		String tmpNum = (String)params.get("motel_num");
		
		int num = Integer.parseInt(tmpNum);
		
		System.out.println("댓글 등록 파라미터"+params);
		if(service.write_reply(params)) {
			model.addAttribute("result",true);
			model.addAttribute("msg","댓글을 등록했습니다.");
			model.addAttribute("url","/motel/view?num="+num);
		}else {
			model.addAttribute("result",false);
			model.addAttribute("msg","댓글 등록에 실패하였습니다.");
			model.addAttribute("url","/motel/view?num="+num);
		}
		
		return "motel/result";
	}
	
	//이미지를 가져오는 메서드
	@ResponseBody
	@RequestMapping("/image")
	public byte[] getImage(String fileName) {
		System.out.println("/image 요청 : "+fileName);
		File file = new File(FILE_PATH+fileName);
		InputStream in = null;
		try {
			in = new FileInputStream(file);
			return IOUtils.toByteArray(in);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//해당 이미지를 byte[]의 형태로 반환
 catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return null;
	}
	


	@RequestMapping("/search")
	public String aaaaaaaaaaaa() {
		System.out.println("검색화면 요청");
		return "motel/search";
	}
	
	@RequestMapping("/view")
	public String view(int num,int host, Model model) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("num", num);
		params.put("host", host);
		
		/*System.out.println(service.viewSelect(num));*/
		Map<String, Object> motel = new HashMap<String, Object>();
		motel=service.viewSelect(params);
		
		int motelType=Integer.parseInt(String.valueOf(service.viewSelect(params).get("MOTEL_TYPE")));
		int motelCategory = Integer.parseInt(String.valueOf(service.viewSelect(params).get("MOTEL_CATEGORY")));
		if(motelType==1) {
			motel.put("MOTEL_TYPE", "아파트");
			System.out.println(motel.get("MOTEL_TYPE"));
		}else if(motelType==2){
			motel.put("MOTEL_TYPE", "주택");
			System.out.println(motel.get("MOTEL_TYPE"));
		}else if(motelType==3) {
			motel.put("MOTEL_TYPE", "빌라");
			System.out.println(motel.get("MOTEL_TYPE"));
		}
		if(motelCategory==1) {
			motel.put("MOTEL_CATEGORY", "집 전체");
			System.out.println(motel.get("MOTEL_CATEGORY"));
		}else {
			motel.put("MOTEL_CATEGORY", "개인실");
			System.out.println(motel.get("MOTEL_CATEGORY"));
		}
		System.out.println(motel);
		model.addAllAttributes(motel);
		return "motel/view";
	}
	/*@RequestMapping(value="/replyList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyList(@RequestParam(value="page",defaultValue="1")int page){
		System.out.println("ajax 댓글 요청");
		return null;
	}*/
	
	
	
	@RequestMapping("/checkout")
	public String checkoutPage(@RequestParam Map<String,Object> paramMap, Model model) {
		model.addAllAttributes(paramMap);
		return "motel/pay_checkout";
	}
	
	@RequestMapping(value="/pay_paypal", method=RequestMethod.POST)
	public String payment(@RequestParam Map<String,Object> paramMap, Model model) {
		System.out.println(paramMap);
		System.out.println("페이팔 요청");
		model.addAllAttributes(paramMap);
		return "motel/pay_paypal";
	}
	
	@RequestMapping("/pay_result")
	public String paypal(@RequestParam Map<String,Object> paramMap, Model model) {
		System.out.println(paramMap);
		if(paramMap.get("imp_success").equals("true")) {
			System.out.println("결제 성공");
			model.addAttribute("result","true");
			model.addAttribute("msg","결제에 성공했습니다.");
			System.out.println(paramMap.get("num"));
			model.addAttribute("num",paramMap.get("num"));
		}else {
			model.addAttribute("result","false");
			model.addAttribute("msg","잔액이 부족합니다");
		}
		model.addAllAttributes(paramMap);
		return "motel/pay_result";
	}
	@RequestMapping(value="/write_star",method=RequestMethod.POST)
	@ResponseBody
	public double star(@RequestParam Map<String, Object>params, Model model) {
		System.out.println("평점 입장");
		System.out.println("데이터 : "+params);
		String tmpNum = (String)params.get("motel_num");
		
		int num = Integer.parseInt(tmpNum);
		service.starAvg(params);
		
		
		return 0;
	}
	@RequestMapping("/mapTest1")
	public String mapTest1() {
		return "motel/mapTest1";
	}
	@RequestMapping("/mapTest2")
	public String MapTest2(Model model) {
		model.addAttribute("ko","https://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc&callback=initMap&language=ko");
		model.addAttribute("en","https://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc&callback=initMap&language=en");
		return "motel/mapTest2";
	}
	
	
	
	
	
	//모텔 병합중
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
	
	@RequestMapping(value="/registor_intro", method = RequestMethod.GET)
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
		int motel_num = service.write_Motel(param);
		if(motel_num!=0) {
			//숙박 글 정상 등록
			System.out.println("숙박글 등록 성공");
			System.out.println(motel_num);
		}else {
			//숙박 글 등록 실패
			System.out.println("숙박글 등록 실패");
			
		}
		
		return "redirect:/motel/view?num="+motel_num+"&host="+param.get("user_num");
	}
	
	
	

}
