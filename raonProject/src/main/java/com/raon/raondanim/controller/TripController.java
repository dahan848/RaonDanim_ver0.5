package com.raon.raondanim.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.raon.raondanim.dao.TripBoardDao;
import com.raon.raondanim.model.TripBoard;
import com.raon.raondanim.model.TripCity;
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
	public String boardList(@RequestParam(defaultValue="1")int pageNum,
			@RequestParam(defaultValue="0") int type,
			@RequestParam(required=false) String keyword,
			Model model) {
		System.out.println("list 요청받음");
		Map<String, Object> params = new HashMap<>();
		
		System.out.println("페이지 번호 : "+pageNum);
		System.out.println("타입 : "+type);
		System.out.println("키워드 : "+keyword);
		
		
		params.put("pageNum", pageNum);
		params.put("type", type);
		params.put("keyword", keyword);
		Map<String, Object> tripData = tripService.getTenBoardPage(params);
		System.out.println("list요청  tripdata 검사:"+tripData);
		model.addAttribute("tripData", tripData);
		//지도 찍을 위도경도인데 컬럼이 구글에서 받는 형식과 다르고 자바 객체형태는 = 으로 되있다 보니까 json으로 일단 변환시켜서 보내봄
//		JSONArray tripLatLng = new JSONArray(tripService.getListlatlng());
		
		//list<map> 구조를 jsonarr 로 변경하는건 안되는데 list<map>을 json객체로 바꿔서 보내니까 됨 뭔차이가 
		Gson gson = new Gson();
		String tripLatLng = gson.toJson(tripService.getListlatlng());

		/*customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int user_Num = user.getUser_num();
		
		model.addAttribute("user_Num", user_Num);*/
		model.addAttribute("tripLatLng", tripLatLng);
		//System.out.println(tripLatLng);
		
		return "trip/TripBoardList";
	}

	@RequestMapping("/view")
	public String boardView(@RequestParam(required=false) int boardKey, Model model) {
		System.out.println(" view 요청받음");

		
		model.addAttribute("boardInfo", tripService.getTripBoardOneInfo(boardKey));
		model.addAttribute("cityInfo", tripService.getTripBoardCityOneInfo(boardKey));
	
//		System.out.println("뷰 요청 테스트 게시판 정보: "+tripService.getTripBoardOneInfo(boardKey));
		System.out.println("뷰 요청 테스트 도시 정보: "+tripService.getTripBoardCityOneInfo(boardKey));

		return "trip/TripBoardView";
	}

	@RequestMapping("/write1")
	public String boardWrite1(Authentication authentication, Model model) {
		System.out.println("write1 요청받음");

		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int user_Num = user.getUser_num();
		
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

	
		  if(tripService.totalWrite(tripBoard, tripCity)) {
			  System.out.println("성공");
			  return "redirect:list";
		  }else {
			  System.out.println("실패");
			  return "redirect:list";
		  }
	
	}
	
	@RequestMapping("/boardDelete")
	public String boardDelete(int boardKey, Model model,RedirectAttributes ra) {
		System.out.println("삭제요청 받음 ");
		System.out.println(boardKey);
		if(tripService.totalDelete(boardKey)) {
			ra.addAttribute("msg", "게시글 삭제 성공하였습니다.");
			return "redirect:list";
		}else {
			ra.addAttribute("msg", "게시글 삭제 실패 하였습니다 다시 시도해주세요.");
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
	public String modifyForm(int boardKey,Model model) {
		System.out.println("수정화면1요청 받음");
		//수정화면 1로 가는 메소드 기존 정보 가지고 이동 
		model.addAttribute("boardInfo", tripService.getTripBoardOneInfo(boardKey));
		model.addAttribute("cityNames", tripService.getTripBoardCityOneInfo(boardKey));
		//System.out.println("수정1 :"+tripService.getTripBoardOneInfo(boardKey));
		return "trip/TripBoardModifyForm1";
		
	}

	@RequestMapping("/modify2")
	public String modifyForm2(TripBoard tripBoard,Model model) {
		System.out.println("수정화면2요청 받음");
		System.out.println(tripBoard);
		
		model.addAttribute("tripBoard", tripBoard);
		return "trip/TripBoardModifyForm2";
		
	}
	
	@RequestMapping("/modify3")
	public String modifyBoard(TripBoard tripBoard, String tripCity,RedirectAttributes ra) {
		System.out.println("수정3요청 받음");
		//System.out.println("수정요청3: "+tripBoard);
		//System.out.println("수정요청3: "+tripCity);
		
		if(tripService.totalUpdate(tripBoard, tripCity)) {
			ra.addAttribute("msg", "게시글 수정 성공하였습니다.");
			return "redirect:list";
		}else {
			ra.addAttribute("msg", "게시글 수정 실패하였습니다.");
			return "redirect:list";
		}
		
		
	
		
	}
	
	
	
}
