package com.raon.raondanim.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raon.raondanim.model.User;
import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.AccountsService;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/accounts")
public class AccountsController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private AccountsService service;
	
	//로그인 화면 요청
	@RequestMapping(value = "/loginForm")
	public String loginForm(@RequestParam(value = "error", defaultValue = "defalutValue") String error, Model model) {
		if(!error.equals("defalutValue")) {
			model.addAttribute("msg", error);			
		}
		//System.out.println("받은거 : " + error);
		logger.info("");
		return"accounts/loginForm";
	}
	
	//로그인 실패 
	@RequestMapping(value = "/loginError")
	public String loginError(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		String msg = (String) request.getAttribute("errormsgname");
		redirectAttributes.addAttribute("error", msg);
		//redirectAttributes.addFlashAttribute("error", msg);
		//System.out.println("실패 핸들러가 보낸 놈 : " + msg);
		return "redirect:/accounts/loginForm";
		//return "accounts/loginError";
	}
	
	//회원가입 화면 요청
	@RequestMapping(value ="/signupForm")
	public String signupForm() {
		return "accounts/signupForm";
	}
	
	//회원가입 요청
	@RequestMapping(value ="/signup", method = RequestMethod.POST)
	public String signup(@RequestParam Map<String, Object> param) { //가입요청
		if(service.join(param)) {
			return "redirect:/home"; //가입성공
		}else {
			return "redirect:accounts/signupForm"; //가입실패
		}
	}
	
	//이메일 인증 전송
	@RequestMapping(value = "/certify", method = RequestMethod.POST)
	public void emailVerifySuccess(@ModelAttribute User user, HttpServletResponse response) {
		service.email_verify(user, response);
	}
	
	//로그아웃 요청
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request,HttpServletResponse response) {
		service.logout(request, response);
		return "redirect:/home";
	}
	
	//비밀번호 찾기 (초기화 화면 요청)
	public String passwordResetForm() {
		return "";
	}
	
	//비밀번호 로직
	public String passwordReset() {
		return "";
	}
	
	//프로필 화면 요청 
	@RequestMapping("/profile")
	public String profile(Model model, @RequestParam(value="user") int userNum) {
		Map<String, Object> userData = service.getProfileData(userNum);
		//System.out.println("==============프로필 데이터==============");
		//System.out.println(userData);
		model.addAttribute("user", userData);
		model.addAttribute("profileUser", userNum);
		return "accounts/profile";
	}
	
	//프로필 화면 갤러리 정보 요청 
	@ResponseBody
	@RequestMapping(value="/gallery/{usernum}",method=RequestMethod.GET)
	public ResponseEntity<List<Map<String, Object>>> gallery(@PathVariable("usernum") String usernum){
		//System.out.println("gallery : " + usernum);
		ResponseEntity<List<Map<String, Object>>> entity = null;
		try{
			List<Map<String, Object>> replyList
			= service.getGallery(usernum);
			entity = new ResponseEntity<List<Map<String,Object>>>(replyList, HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/deletePic")
	public boolean deleteGalleryPic(@RequestParam String data) {
		//String [] data = request.getParameterValues("data[]");
		//System.out.println(data);
		if(data == null) {
			System.out.println("널이다!");
			return false;
		}
		return service.deleteGalleryPic(data);
	}
	
	//프로필 수정 화면 1
	@RequestMapping(value = "/update1Form")
	public String update1Form() {
		//나의 정보를 클릭하면, 추가 프로필 등록 1단계 화면이 나옴.
		//사용자의 정보를 추가 프로필 1단계 화면으로 넘겨주어야 한다.
		//1. 수정(입력)된 정보 발생
		//'다음'버튼 클릭 시 별도의 알림 창 없이 [저장]
		//'다른 탭'을 클릭 하려고 하면 수정된 정보가 있는데 저장 할 것인가를 물음.
		return "accounts/profile-update1";
	}
	
	//프로필 수정 화면 2
	@RequestMapping(value = "/update2Form")
	public String update2Form() {
		return "accounts/profile-update2";
	}
	
	//프로필 수정 화면 3
	@RequestMapping(value = "/update3Form")
	public String update3Form() {
		return "accounts/profile-update3";
	}
	
	
	//프로필 수정 화면 3
	@RequestMapping(value = "/gallerySettings")
	public String gallerySettings(Authentication authentication, Model model) {
		//현재 로그인 한 유저 (시큐리티 세션 이용)의 유저넘을 가지고 온다.
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String usernum = Integer.toString(user.getUser_num());
		//서비스를 이용 해당 유저의 갤러리 목록 얻어온다.
		List<Map<String, Object>> userGallery = service.getGallery(usernum);
		//Modle을 이용해서 화면으로 쏴준다
		model.addAttribute("userPic", userGallery);
		//해당 화면에 보내주어야 하는 것 : 프로필 사진, 갤러리 사진
		return "accounts/gallerySettings";
	}

	//개인정보 화면 요청
	@RequestMapping(value = "/personalForm")
	public String personalForm(Authentication authentication, Model model) {
		//시큐리티 세션에 저장 된 현재 접속한 user 정보 가져오기 
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String userId = user.getUser_id();
		Map<String, Object> userInfo = service.getPersonalInfo(userId);
		model.addAttribute("user",userInfo);
		return "accounts/profile-personal";
	}
	
	//개인정보 요청
	@ResponseBody
	@RequestMapping(value = "/personal" , method=RequestMethod.POST )
	public boolean personal(Authentication authentication,@RequestParam Map<String, Object> param) {
		//시큐리티 세션에 저장 된 현재 접속한 user 정보 가져오기 
		//System.out.println("컨트롤러 받은 MAP : " + param);
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String userNum = Integer.toString(user.getUser_num());
		//서비스 객체 이용해서 유저정보 (개인정보) 업데이트 하기
		boolean result;
		if(service.setPersonalInfo(param, userNum)) {
			//업데이트 성공
			result = true;
		}else {
			//업데이트 실패
			result = false;
		}
		return result;
	}
	
	//비밀번호 변경 화면 요청
	@RequestMapping(value ="/passwordchangeform", method=RequestMethod.GET)
	public String passwordChangeForm(Authentication authentication, Model model) {
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String usernum = Integer.toString(user.getUser_num());
		model.addAttribute("pass",service.getUserPass(usernum));
		return "accounts/password-change";
	}
	
	//비밀번호 변경 요청 
	@ResponseBody
	@RequestMapping(value = "/passwordChange" , method=RequestMethod.POST )
	public int passwordChange(Authentication authentication,@RequestParam Map<String, Object> param) {
		//System.out.println("비밀번호 변경 요청 받음 : " + param);
		//현재 로그인 한 사용자 정보 가져오기  : USER_NUM, USER_PW 
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String usernum = Integer.toString(user.getUser_num());
		//기존 Map에 usernum 추가하기 
		param.put("user_num", usernum);
		//서비스로 비밀번호 변경 요청 전송, service는 int를 반환 
		//0 : 변경 비밀번호 동일하지 않음
		//1 : 비밀번호 변경 성공 
		//2 : 비밀번호 변경 실패 
		return service.passwordChange(param);
	}
	
	//프로필 사진 업로드 요청  => 따로 파일 업로드 관련 컨트롤러로 처리
//	@RequestMapping(value ="/uploadprofile", method = RequestMethod.POST)
//	public String uploadProfilePic(MultipartFile file) {
//		System.out.println("프로필 픽 업로드 : " + file);
//		return "";
//	}
	
	///////더미 데이터(유저) 생성 요청
	@RequestMapping("/dnmmyData")
	public String dnmmyData() {
		service.setDnmmyData();
		System.out.println("=============더미데이터 생성완료============");
		return "accounts/setDnmmy";
	}
	
	//회원가입 이메일 중복 검사 
	@ResponseBody
	@RequestMapping(value = "/emailCheck")
	public boolean emailChange(@RequestParam String check) {
		return service.emailCheck(check);
	}
	
	//비밀번호 변경 요청 시 
	@ResponseBody
	@RequestMapping(value = "/passwordCheck")
	public boolean passwordCheck(@RequestParam String check, Authentication authentication) {
		//현재 로그인 한 사용자의 usernum을 변수에 참조하기 위해 Authentication 객체를 사용 필요한 데이터를 가져온다.
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		String usernum = Integer.toString(user.getUser_num());
		//System.out.println(check);
		return service.passwordCheck(check, usernum);
	}
}
