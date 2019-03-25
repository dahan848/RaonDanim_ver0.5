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

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	private static final String FILE_PATH = "d:/project_img/";

	
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
			Model model,String city, String startDate, @RequestParam(required=false)String endDate, @RequestParam(required=false)int adults) {
		
		System.out.println("리스트 요청");
		System.out.println("체크인 : "+startDate);
		System.out.println("체크아웃 : "+endDate);
		System.out.println("인원 : "+adults);
		System.out.println("도시 : "+city);
		System.out.println("여행 일수 : "+startEnd(startDate,endDate));
		model.addAttribute("date",startEnd(startDate,endDate));
		model.addAttribute("startDate",startDate);
		model.addAttribute("endDate",endDate);
		model.addAttribute("adults",adults);
		model.addAttribute("city",city);
		
		
		return "motel/motelList";
	}
	
	@RequestMapping(value="/replyList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyList(@RequestParam(value="page",defaultValue="1")int page,
			Model model, int num, HttpSession session, HttpServletRequest req) {
		System.out.println("댓글 요청");
		CsrfToken _csrf1 = (CsrfToken) req.getAttribute("CsrfToken");
		CsrfToken _csrf2 = (CsrfToken) req.getAttribute("_csrf");
		
		System.out.println("token1 : " + _csrf1);
		System.out.println("token2 :" + _csrf2);
		
		
		Map<String, Object>params = new HashMap<String, Object>();
		params.put("page", page);
		params.put("num", num);
		System.out.println(params);
		Map<String, Object>result = new HashMap<String, Object>();
		result.put("board", service.getReplyData(params));
		System.out.println("댓글이 뭘 가지고 있지");
		System.out.println(result);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/list", method=RequestMethod.POST)
	public Map<String, Object> test1(@RequestParam(value="page",defaultValue="1")int page,
			@RequestParam(defaultValue="0")int motel_type,
			@RequestParam(defaultValue="0")int motel_category,
			@RequestParam(defaultValue="1")int motel_people,
			@RequestParam(defaultValue="0")int motel_price1,
			@RequestParam(defaultValue="0")int motel_price2,
			String startDate,
			String endDate,
			String city,
			Model model) {
		System.out.println("ajax 요청");
		System.out.println("motel_type : "+motel_type);
		System.out.println("motel_category : "+motel_category);
		System.out.println("motel_people : "+motel_people);
		System.out.println("motel_price1 : "+motel_price1);
		System.out.println("motel_price2 : "+motel_price2);
		System.out.println("startDate : "+startDate);
		System.out.println("endDate : "+endDate);
		System.out.println("city : "+city);
		String tmpStartDate = startDate.substring(2,10);
		System.out.println("tmpStartDate : "+tmpStartDate);
		String tmpendDate = endDate.substring(2, 10);
		System.out.println(tmpendDate);
		Map<String, Object>params = new HashMap<String, Object>();
		params.put("page", page);
		params.put("motel_type", motel_type);
		params.put("motel_category", motel_category);
		params.put("motel_people", motel_people);
		params.put("motel_price1", motel_price1);
		params.put("motel_price2", motel_price2);
		params.put("startDate", tmpStartDate);
		params.put("endDate", tmpendDate);
		params.put("city", city);
		Map<String, Object>result = new HashMap<String, Object>();
		result.put("board", service.getViewData(params));
		System.out.println(result);
		
		return result;
	}
	
	@RequestMapping(value="/write_reply", method=RequestMethod.POST)
	   public String writeReply(@RequestParam Map<String, Object> params, Model model) {
	      System.out.println("댓글작성");
	      System.out.println(params);
	      String tmpUserNum = (String)params.get("host");
	      String tmpNum = (String)params.get("motel_num");
	      
	      //별점 남긴적이 있는지 확인
	      if(service.starCheck(params)) {
	    	  System.out.println(service.starCheck(params));
	    	  //params에 star-input key가 있는지 확인
	    	  if(params.containsKey("star-input")) {
		    	  service.starAvg(params);
		      }
	      }else {
	    	  System.out.println(service.starCheck(params));
	    	  if(params.containsKey("star-input")) {
		    	  service.starUpdate(params);
		    	  System.out.println(service.starUpdate(params));
		      }
	      }
	      
    	  
	      
	      
	      
	      int userNum = Integer.parseInt(tmpUserNum);
	      int num = Integer.parseInt(tmpNum);
	      
	      System.out.println("댓글 등록 파라미터"+params);
	      if(service.write_reply(params)) {
	         model.addAttribute("result",true);
	         model.addAttribute("msg","댓글을 등록했습니다.");
	         model.addAttribute("url","/motel/view?num="+num+"&host="+userNum+"&checkIn="+params.get("checkIn")+"&checkOut="+params.get("checkOut")+"&tripDate="+params.get("tripDate")+"&people="+params.get("people"));
	         
	      }else {
	         model.addAttribute("result",false);
	         model.addAttribute("msg","댓글 등록에 실패하였습니다.");
	         model.addAttribute("url","/motel/view?num="+num+"&host="+userNum+"&checkIn="+params.get("checkIn")+"&checkOut="+params.get("checkOut")+"&tripDate="+params.get("tripDate")+"&people="+params.get("people"));
	      }
	      
	      return "motel/result";
	   }

	@RequestMapping("/search")
	public String aaaaaaaaaaaa() {
		System.out.println("검색화면 요청");
		return "motel/search";
	}
	
	
	
	
	@RequestMapping("/view")
	public String view(int num, int host,@RequestParam(required=false, value="checkIn") String checkIn, @RequestParam(required=false,value="checkOut") String checkOut, @RequestParam(required=false,value="tripDate") int tripDate,@RequestParam(required=false,value="people") int people, Model model) {
		System.out.println("뷰 요청");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("num", num);
		params.put("host", host);
		System.out.println("상세페이지 넘어가는 파라미터");
		
		
		Map<String, Object> motel = new HashMap<String, Object>();
		motel=service.viewSelect(params);
		motel.put("checkIn", checkIn);
		motel.put("checkOut", checkOut);
		motel.put("tripDate", tripDate);
		motel.put("people", people);
		motel.put("image", service.getImage(num));
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
	
	@RequestMapping("/view_host")
	public String view(int num, int host, Model model) {
		System.out.println("뷰 요청");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("num", num);
		params.put("host", host);
		System.out.println("상세페이지 넘어가는 파라미터");
		
		
		Map<String, Object> motel = new HashMap<String, Object>();
		motel=service.viewSelect(params);
		motel.put("image", service.getImage(num));
		
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

	
	
	
	@RequestMapping(value="/checkout",method=RequestMethod.POST)
	public String checkoutPage(@RequestParam Map<String,Object> paramMap, Model model,HttpSession session, HttpServletRequest req) {
		System.out.println(paramMap);
		CsrfToken _csrf1 = (CsrfToken) req.getAttribute("CsrfToken");
		CsrfToken _csrf2 = (CsrfToken) req.getAttribute("_csrf");
		
		System.out.println("token1 : " + _csrf1);
		System.out.println("token2 :" + _csrf2.getParameterName() + " " + _csrf2.getToken());
		model.addAttribute("_csrf", _csrf2);
		if(service.checkDate(paramMap)) {
			model.addAllAttributes(paramMap);
			System.out.println("체크아웃 파라미터 확인");
			System.out.println(paramMap);
			return "motel/pay_checkout";
		}else {
		model.addAttribute("msg","이미 예약된 숙소 입니다.");
		model.addAttribute("doubleResult","false");
		model.addAttribute("url","/motel/search");
		
		return "motel/pay_result";
		}
		
	}
	
	@RequestMapping(value="/pay_paypal", method=RequestMethod.POST)
	public String payment(@RequestParam Map<String,Object> paramMap, Model model) {
		System.out.println(paramMap);
		System.out.println("페이팔 요청");
		model.addAllAttributes(paramMap);
		return "motel/pay_paypal";
	}
	@RequestMapping(value="/pay_result",method=RequestMethod.POST)
	public String pay_result_free(@RequestParam Map<String, Object>params,Model model) {
		System.out.println("무료 숙소 파라미터");
		System.out.println(params);
		int num = Integer.parseInt((String)params.get("motel_num"));
		int host = Integer.parseInt((String)params.get("host"));
		String checkIn = params.get("checkIn").toString();
		String checkOut = params.get("checkOut").toString();
		int tripDate = Integer.parseInt((String)params.get("tripDate"));
		int people = Integer.parseInt((String)params.get("people"));
		params.remove("motel_num");
		params.put("num", num);
		if(date_tb_update(params)) {
			if(service.add_point(params)&&service.pay_history_insert(params)) {
				model.addAttribute("msg","결제가 완료 되었습니다.");
				model.addAttribute("result_free","true");
				model.addAttribute("url","/motel/view?num="+num+"&host="+host+"&checkIn="+checkIn+"&checkOut="+checkOut+"&tripDate="+tripDate+"&people="+people);
			}
		}
		return "motel/pay_result";
	}
	
	@RequestMapping("/pay_result")
	public String paypal(@RequestParam Map<String, Object> paramMap, Model model) {
		/*System.out.println(paramMap);*/
		int num = Integer.parseInt((String)paramMap.get("num"));
		int host = Integer.parseInt((String)paramMap.get("host"));
		String checkIn = paramMap.get("checkIn").toString();
		String checkOut = paramMap.get("checkOut").toString();
		int tripDate = Integer.parseInt((String)paramMap.get("tripDate"));
		int people = Integer.parseInt((String)paramMap.get("people"));
		boolean imp_success;
		System.out.println("페이 리절트 파라미터 체크");
		System.out.println(paramMap);
		
		
			if(paramMap.get("imp_success").equals("true")&&date_tb_update(paramMap)) {
				if(service.add_point(paramMap)&&service.pay_history_insert(paramMap)) {
					model.addAttribute("msg","결제가 완료 되었습니다.");
					model.addAttribute("result","true");
					model.addAttribute("url","/motel/view?num="+num+"&host="+host+"&checkIn="+checkIn+"&checkOut="+checkOut+"&tripDate="+tripDate+"&people="+people);
				}
			}else {
				model.addAttribute("msg","잔액이 부족합니다.");
				model.addAttribute("result","false");
				model.addAttribute("url","/motel/view?num="+num+"&host="+host+"&checkIn="+checkIn+"&checkOut="+checkOut+"&tripDate="+tripDate+"&people="+people);
			}
		
		
		model.addAllAttributes(paramMap);
		return "motel/pay_result";
	}
	
	//숙소 예약시 motel_date_tb 상태값 N으로 변경 
	public boolean date_tb_update(Map<String, Object>params) {
		if(service.date_tb_update(params)) {
			return true;
		}else {
			return false;
		}
	}
	//댓글 상태값 삭제로 변경
	@RequestMapping(value="/deleteReply",method=RequestMethod.POST)
	@ResponseBody
	public boolean deleteReply(@RequestParam Map<String, Object>param) {
		System.out.println("댓글 삭제요청(ajax)");
		System.out.println(param);
		return service.deleteReply(param);	
	}
	
	//댓글 신고 데이터 불러오기
	@RequestMapping(value="/getDeclaration", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> declaration(){
		System.out.println("신고 데이터 가져와");
		return service.declaration();
	}
	//댓글 신고
	@RequestMapping(value="/declaration", method=RequestMethod.POST)
	@ResponseBody
	public boolean declarationSubmit(@RequestParam Map<String, Object>params) {
		String tmpReply_num = (String) params.get("type");
		if(tmpReply_num.equals("reply")) {
			System.out.println("신고페이지 진입");
			System.out.println(params);
			if(service.insertDeclaration_check(params)) {
				System.out.println("중복신고 체크 - 중복 신고 없음");
				return service.insertDeclaration(params);
			}else {
				System.out.println("중봏ㄱ신고 체크 - 중복 신고 있음");
				return false;
			}
			
			
		}else {
			System.out.println("게시글 신고 파라미터 체크");
			System.out.println(params);
			if(service.insert_motel_Declaration_check(params)) {
				System.out.println("숙박글 중복신고 체크 - 중복신고 없음");
				return service.insert_motel_Declaration(params);
			}else {
				System.out.println("숙박글 중복신고 체크 - 중복신고 있음");
				return false;
			}
		}
	}
	
	//숙박글 삭제
	@RequestMapping(value="/delete_motel",method=RequestMethod.POST)
	@ResponseBody
	public boolean delete_motel(@RequestParam Map<String, Object>params) {
		System.out.println("삭제요청 파라미터 확인");
		System.out.println(params);
		
		return service.delete_motel(params);
	}
	
	//이미지 가져오기 테스트
	@RequestMapping("/image")
	@ResponseBody
	public byte[] getImage(String fileName) {
		System.out.println("이미지 요청 받음");
		
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
	public String registor_step1(HttpSession session) {
		System.out.println("숙소 등록 진입 ");
		System.out.println("session motel_photo : " + session.getAttribute("motel_photo"));
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
			List<MultipartFile> files, HttpSession session) {
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
		
		
		session.setAttribute("motel_photo", files);
//		System.out.println("=======================================================");
//		System.out.println(session.getAttributeNames());
//		
//		System.out.println(session.getAttribute("motel_photo"));
		
		model.addAttribute("registor", param);
//		System.out.println("cma_file : " + cma_file);
//		System.out.println("cma_file1 : " + cma_file1);
//		System.out.println("cma_file2 : " + cma_file2);
//		System.out.println("cma_file3 : " + cma_file3);
//		System.out.println("cma_file4 : " + cma_file4);
		
		return "motel/registor_intro";
	}
	
	@RequestMapping(value="/registor_complete", method = RequestMethod.POST)
	public String registor_complete(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		System.out.println("registor_complete 진입");
		System.out.println("complete : " + param);
		System.out.println("complete motel_photo : " + session.getAttribute("motel_photo"));
		System.out.println("complete motel_photo : " + session.getAttribute("motel_photo").getClass());
		List<MultipartFile> files = (List<MultipartFile>) session.getAttribute("motel_photo");
		int motel_num = service.write_Motel1(param, files);
		if(motel_num!=0) {
			//숙박 글 정상 등록
			System.out.println("숙박글 등록 성공");
			System.out.println(motel_num);
		}else {
			//숙박 글 등록 실패
			System.out.println("숙박글 등록 실패");
			
		}
		
		return "redirect:/motel/view_host?num="+motel_num+"&host="+param.get("user_num");
	}
	
	//ajax로 DB에서 국가목록 데이터 화면단으로 전송
	@ResponseBody
	@RequestMapping(value = "/DB_nation", method = RequestMethod.GET)
	public List<Map<String, Object>> DB_nation(){
		System.out.println("DB_nation 입장!!!");
		System.out.println("DB_nation 입장!!!" + service.getAllNational());
		return service.getAllNational();
	}
	@ResponseBody
	@RequestMapping(value = "/DB_city", method = RequestMethod.GET)
	public List<Map<String, Object>> DB_city(){
		System.out.println("DB_city 입장 !! : " + service.getAllCity());
		return service.getAllCity();
	}
	

}
