package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import com.raon.raondanim.model.TripBoard;

import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.AccountsService;
import com.raon.raondanim.service.TripBoardService;

@Controller
@RequestMapping("/trip")
public class TripController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	TripBoardService tripService;

	@Autowired
	AccountsService userService;

	@RequestMapping("/list")
	public String boardList(@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "0") int type,
			@RequestParam(required = false) String keyword, Model model, @RequestParam(required = false) String lName,
			@RequestParam(required = false) String fName) {
		System.out.println("list 요청받음");
		Map<String, Object> params = new HashMap<>();

		System.out.println("페이지 번호 : " + pageNum);
		System.out.println("타입 : " + type);
		System.out.println("키워드 : " + keyword);
		System.out.println("성 : " + lName);
		System.out.println("이름 : " + fName);

		params.put("pageNum", pageNum);
		params.put("type", type);
		params.put("keyword", keyword);
		if (lName != "") {
			System.out.println("컨트롤러/리스트/검색테스트1");
			params.put("lName", lName);
		}
		if (fName != "") {
			System.out.println("컨트롤러/리스트/검색테스트2");
			params.put("fName", fName);
		}

		Map<String, Object> tripData = tripService.getTenBoardPage(params);
		// System.out.println("list요청 tripdata 검사:"+tripData);
		model.addAttribute("tripData", tripData);
		// 지도 찍을 위도경도인데 컬럼이 구글에서 받는 형식과 다르고 자바 리스트형태는 = 으로 되있다 보니까 json으로 일단 변환시켜서 보내봄
//		JSONArray tripLatLng = new JSONArray(tripService.getListlatlng());

		// list<map> 구조를 jsonarr 로 변경하는건 안되는데 list<map>을 json객체로 바꿔서 보내니까 됨 뭔차이가
		Gson gson = new Gson();
		String tripLatLng = gson.toJson(tripService.getListlatlng());


		model.addAttribute("tripLatLng", tripLatLng);
	

		return "trip/TripBoardList";
	}

	@RequestMapping("/view")
	public String boardView(@RequestParam(required = false) int boardKey, Model model, Authentication authentication,
			HttpServletRequest req, HttpServletResponse res) {
		System.out.println(" view 요청받음");

		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int user_Num = user.getUser_num();

		// 조회수 1 증가
		// 쿠키를 사용해서 조회수 무한증가 막음
		// 쿠키가 브라우저당 생성이라 같은 브라우저로 다른 계정 돌려써봤자 조회수가 안늘어나는 단점 이 있음
		Cookie[] cookies = req.getCookies();

		int viewsCount = 0;

		if (cookies != null) {

			for (int i = 0; i < cookies.length; i++) {

				if (cookies[i].getName().equals("boardKey" + boardKey)) {
					System.out.println(cookies[i].getName());
					viewsCount = 0;
					break;
				} else {

					Cookie cookie = new Cookie("boardKey" + boardKey, String.valueOf(boardKey));
					// 쿠키 수명 60초 60분 24시간
					cookie.setMaxAge(60 * 60 * 24);
					// /로 시작되는 모든 경로에서 쿠키 생성
					cookie.setPath("/");
					res.addCookie(cookie);

					viewsCount += 1;
				}
			}
		}

		/*
		 * System.out.println("쿠키배열 길이"+cookies.length); for(int
		 * i=0;i<cookies.length;i++) {
		 * System.out.println("쿠키배열 내용"+cookies[i].getName()); }
		 * System.out.println("컨트롤러/뷰/뷰카운트 :"+viewsCount);
		 */

		if (viewsCount > 0) {
			System.out.println("조회수 테스트");
			tripService.incrementViews(boardKey);
		}

		Map<String, Object> boardInfo = tripService.getTripBoardOneInfo(boardKey);

		// 유저 관심사 여행스타일 여행 희망도시 뽑기
		String userNum = String.valueOf(boardInfo.get("USER_NUM"));
		// System.out.println(userNum);
		Map<String, Object> userInfo = new HashMap<>();
		List<Map<String, Object>> UserInterest = tripService.getUserInterest(userNum);
		List<Map<String, Object>> UserTrStyle = tripService.getTrStyle(userNum);
		List<Map<String, Object>> UserTravleHope = tripService.getTravleHope(userNum);

		if (!UserInterest.isEmpty()) {
			userInfo.put("UserInterest", UserInterest);
		}
		if (!UserTrStyle.isEmpty()) {
			userInfo.put("UserTrStyle", UserTrStyle);
		}
		if (!UserTravleHope.isEmpty()) {
			userInfo.put("UserTravleHope", UserTravleHope);
		}

		model.addAttribute("userInfo", userInfo);//게시판 등록한 사람의 관심사 여행스타일 등등
		model.addAttribute("userNum", user_Num);//로그인한사람 유저 넘버
		model.addAttribute("boardInfo", boardInfo);//게시판 정보
		model.addAttribute("cityInfo", tripService.getTripBoardCityOneInfo(boardKey));

//		System.out.println("뷰 요청 테스트 게시판 정보: "+tripService.getTripBoardOneInfo(boardKey));
//		System.out.println("뷰 요청 테스트 도시 정보: "+tripService.getTripBoardCityOneInfo(boardKey));

		return "trip/TripBoardView";
	}

	@RequestMapping("/write1")
	public String boardWrite1(Authentication authentication, Model model) {
		System.out.println("write1 요청받음");

		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int user_Num = user.getUser_num();

		// 유저 관심사 여행스타일 여행 희망도시 뽑기
		String userNum = String.valueOf(user_Num);
		// System.out.println(userNum);
		Map<String, Object> userInfo = new HashMap<>();
		List<Map<String, Object>> UserInterest = tripService.getUserInterest(userNum);
		List<Map<String, Object>> UserTrStyle = tripService.getTrStyle(userNum);
		List<Map<String, Object>> UserTravleHope = tripService.getTravleHope(userNum);

		if (!UserInterest.isEmpty()) {
			userInfo.put("UserInterest", UserInterest);
		}
		if (!UserTrStyle.isEmpty()) {
			userInfo.put("UserTrStyle", UserTrStyle);
		}
		if (!UserTravleHope.isEmpty()) {
			userInfo.put("UserTravleHope", UserTravleHope);
		}

		System.out.println("컨트롤러/write1/유저프로필정보 확인:" + userInfo);
		/////////////////////////////////////

		model.addAttribute("userInfo", userInfo);
		model.addAttribute("user_Num", user_Num);
		return "trip/TripBoardWriteForm1";
	}

	@RequestMapping("/write2")
	public String boardWrite2(TripBoard tripBoard, Model model) {
		System.out.println("write2요청받음");
		System.out.println(tripBoard);
		model.addAttribute("tripBoard", tripBoard);
		return "trip/TripBoardWriteForm2";
	}

	@RequestMapping("/write3")
	public String boardWrite3(TripBoard tripBoard, String tripCity) {
		System.out.println("write3요청받음(글 db에 저장단계)");

		if (tripService.totalWrite(tripBoard, tripCity)) {
			System.out.println("성공");
			return "redirect:list";
		} else {
			System.out.println("실패");
			return "redirect:list";
		}

	}

	@RequestMapping("/boardDelete")
	public String boardDelete(int boardKey, Model model, RedirectAttributes ra) {
		System.out.println("삭제요청 받음 ");
		System.out.println(boardKey);
		if (tripService.totalDelete(boardKey)) {
			ra.addFlashAttribute("msg", "게시글 삭제 성공하였습니다.");
			return "redirect:list";
		} else {
			ra.addFlashAttribute("msg", "게시글 삭제 실패 하였습니다 다시 시도해주세요.");
			ra.addAttribute("boardKey", boardKey);
			return "redirect:view";
		}

	}

	@ResponseBody
	@RequestMapping(value = "/checkPw")
	public boolean checkPw(String user_pwCheck, int boardKey) {
		System.out.println("비밀번호 확인 요청 받음");

		return tripService.pwCheck(user_pwCheck, boardKey);

	}

	@RequestMapping("/modify1")
	public String modifyForm(int boardKey, Model model) {
		System.out.println("수정화면1요청 받음");

		Map<String, Object> boardInfo = tripService.getTripBoardOneInfo(boardKey);

		// 유저 관심사 여행스타일 여행 희망도시 뽑기
		String userNum = String.valueOf(boardInfo.get("USER_NUM"));

		Map<String, Object> userInfo = new HashMap<>();
		List<Map<String, Object>> UserInterest = tripService.getUserInterest(userNum);
		List<Map<String, Object>> UserTrStyle = tripService.getTrStyle(userNum);
		List<Map<String, Object>> UserTravleHope = tripService.getTravleHope(userNum);

		if (!UserInterest.isEmpty()) {
			userInfo.put("UserInterest", UserInterest);
		}
		if (!UserTrStyle.isEmpty()) {
			userInfo.put("UserTrStyle", UserTrStyle);
		}
		if (!UserTravleHope.isEmpty()) {
			userInfo.put("UserTravleHope", UserTravleHope);
		}

		// 수정화면 1로 가는 메소드 기존 정보 가지고 이동
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("boardInfo", boardInfo);
		model.addAttribute("cityNames", tripService.getTripBoardCityOneInfo(boardKey));
		// System.out.println("수정1 :"+tripService.getTripBoardOneInfo(boardKey));
		return "trip/TripBoardModifyForm1";

	}

	@RequestMapping("/modify2")
	public String modifyForm2(TripBoard tripBoard, Model model) {
		System.out.println("수정화면2요청 받음");
		System.out.println(tripBoard);

		model.addAttribute("tripBoard", tripBoard);
		return "trip/TripBoardModifyForm2";

	}

	@RequestMapping("/modify3")
	public String modifyBoard(TripBoard tripBoard, String tripCity, RedirectAttributes ra) {
		System.out.println("수정3요청 받음");
		// System.out.println("수정요청3: "+tripBoard);
		// System.out.println("수정요청3: "+tripCity);

		if (tripService.totalUpdate(tripBoard, tripCity)) {
			ra.addFlashAttribute("msg", "게시글 수정 성공하였습니다.");

			return "redirect:list";
		} else {
			ra.addFlashAttribute("msg", "게시글 수정 실패하였습니다.");
			return "redirect:list";
		}

	}

	@ResponseBody
	@RequestMapping("/getDeclaration")
	public List<Map<String, Object>> getDeclaration(){
		System.out.println("신고목록 불러오기 요청받음");
		
		
		List<Map<String, Object>> declaration = tripService.getDeclaration();
		//System.out.println("컨틀롤러/신고목록 데이터 확인 :"+declaration);
		
		return declaration;
		
	}
	
	@ResponseBody
	@RequestMapping("/insertDeclaration")
	public boolean insertDeclaration(int TRIP_BOARD_KEY,
									 int D_USER_NUM,
									 int USER_NUM,
									 int DECLARATION_KEY,
									 String TRIP_D_DETAILCONTENT) {
		System.out.println("신고 입력 요청 받음");
				
		Map<String, Object> params = new HashMap<>();
		params.put("TRIP_BOARD_KEY", TRIP_BOARD_KEY);
		params.put("D_USER_NUM", D_USER_NUM);
		params.put("USER_NUM", USER_NUM);
		params.put("DECLARATION_KEY", DECLARATION_KEY);
		params.put("TRIP_D_DETAILCONTENT", TRIP_D_DETAILCONTENT);
		
		//System.out.println("컨트롤러/신고입력/ 신고 파라메터 데이터 확인 : "+params);
		
		
		
		
		
		return tripService.insertDeclaration(params);
		
	}
	
	@ResponseBody
	@RequestMapping("/getMyDongHangList")
	public List<Map<String, Object>> getMyDongHangList(Authentication authentication){
		
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int user_Num = user.getUser_num();
		
		String userNum = String.valueOf(user_Num);
		

		return tripService.getMyDongHangList(userNum);
		
	}
	
	@RequestMapping("/insertDummy")
	public String insertDummyData(@RequestParam(defaultValue="2019-01-01")String writeDate,
			RedirectAttributes ra) {
		
		
		if(tripService.insertDummyData(writeDate)) {
			ra.addFlashAttribute("msg", "더미데이터 생성 성공");
			return "redirect:list";
		}else {
			ra.addFlashAttribute("msg", "더미데이터 생성 실패");
			return "redirect:list";
		}
		
		
		
	}
	
	
}
