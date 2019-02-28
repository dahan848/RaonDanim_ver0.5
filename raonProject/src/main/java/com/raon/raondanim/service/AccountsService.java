package com.raon.raondanim.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.model.User;

@Service
public class AccountsService {
	
	@Autowired
	private AccountsUserDAO dao;
	private User user;
	
	//개인정보 수정 페이지에 출력 될 데이터 (Map) 반환하는 서비스 
	public Map<String, Object> getPersonalInfo(String userId){
		Map<String, Object> userInfo = new HashMap<String, Object>();
		user = dao.selectByUserId(userId);
		
		//생년월일 8자리 문자열로 만들어서 반환 하기
		String user_birth_day = null;
		Date birthDay; //데이트 객체 선언 
		
		//생일 칼럼이 Null이면 오늘 날짜를 담아서 보냄  
		if(user.getUser_birth_date() == null) {
			birthDay = new Date(); //오늘 날짜로 Date 객체 초기화 
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
			user_birth_day =transFormat.format(birthDay);			
		}else {
			//생일 칼럼에 값이 담겨져 있으면 해당 날짜를 문자열로 변환 후 전송 
			birthDay = user.getUser_birth_date(); //오늘 날짜로 Date 객체 초기화 
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
			user_birth_day =transFormat.format(birthDay);			
		}
		
		//Map에 담기
		userInfo.put("user_fnm", user.getUser_fnm()); //이름
		userInfo.put("user_lnm", user.getUser_lnm()); //성
		userInfo.put("user_gender", user.getUser_gender()); //성별
		userInfo.put("user_birth_date", user_birth_day); //생년월일
		userInfo.put("user_id", user.getUser_id()); //이메일
		return userInfo;
	}
	
	//개인설정 변경 된 데이터 저장하는 서비스 
	public boolean setPersonalInfo(Map<String, Object> param, String usernum) {
		//인자로 받은 Map에 User_num 추가하기
		param.put("user_num", usernum);
		//인자로 받은 Map에서 생년월일 문자열에 참조하기 
		String year = (String)param.get("birthday_year");
		String month = (String)param.get("birthday_month");
		String day = (String)param.get("birthday_day");
		//인자로 전달 받은 문자열 하나로 합치기  (8자리 문자열 완성)
		String birthDay = year+"-"+month+"-"+day;
		//String to date 
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date result = transFormat.parse(birthDay);
			//sql.Date 타입으로 변환 
			java.sql.Date sqlDate = new java.sql.Date(result.getTime());
			//인자로 받은 Map에 추가 정보 (생년월일) 넣어주기 
			param.put("user_birth_date", sqlDate);
			System.out.println("setPersonalInfo Map 확인 : " + param);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		//Dao 활용해서 유저 정보 업데이트 하기 및 결과 처리
		if(dao.updatePersonal(param) > 1) {
			return true; //업데이트 성공 
		}else {
			return false; //업데이트 실패 
		}
	}
	
	public User selectByUserId(String userid) {
		return dao.selectByUserId(userid);
	}
	
	public void logout(HttpServletRequest request,HttpServletResponse response) { //로그아웃
		//현재 서비스에서 권한부분을 삭제 
		//현재 서비스에서 권한을 얻어와서 권한이 null아니면, 
		//현재권한에 대해서 logout처리
		Authentication auth
		 = SecurityContextHolder.getContext().getAuthentication();
		if(auth != null) {
			new SecurityContextLogoutHandler()
			.logout(request, response, auth);
		}
	}
	
	public boolean join(Map<String, Object> param) { //회원가입 
		//유저 객체 초기화
		user = new User();   
		//USER 객체에 파라미터로 받은 데이터 set
		user.setUser_id((String)param.get("user_id")); //아이디 : 이메일
		user.setUser_pw((String)param.get("user_pw")); //비밀번호
		user.setUser_lnm((String)param.get("user_lnm")); //성
		user.setUser_fnm((String)param.get("user_fnm")); //이름
		
		//이메일 인증에 사용 될 key 넣기 
		user.setUser_verify_code(create_key());
		
		//조건문을 통해서 boolean 값 반환  
		if(dao.joinUser(user) > 0) {
			send_mail(user); //이메일 인증 메일 전송 하기 
			return true;
		}else{
			return false;
		}
	}
	
	///////////////////////////////회원 인증 및 이메일 관련 () 
	//회원가입시 전송 될 인증KEY
	public String create_key() { 
		String key ="";
		Random ran = new Random();
		
		for (int i = 0; i<8; i++) {
			key += ran.nextInt(10);
		}
		return key;
	}
	
	//이메일 발송 () 
	public void send_mail(User user){
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "hyeungil9143@naver.com";
		String hostSMTPpwd = "dkakwhs12!";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "hyeungil9143@naver.com";
		String fromName = "라온다님 ";
		String subject = "";
		String msg = "";

		// 회원가입 메일 내용
		String name = user.getUser_lnm() + user.getUser_fnm(); //유저 이름을 담는 변수
		
		subject = "라온다님 회원가입 인증 메일입니다.";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>";
		msg += name + "님 회원가입을 환영합니다.</h3>";
		msg += "<div style='font-size: 130%'>";
		msg += "하단의 인증 버튼 클릭 시 정상적으로 회원가입이 완료됩니다.</div><br/>";
		msg += "<form method='post' action='http://localhost:8081/accounts/certify'>";
		msg += "<input type='hidden' name='user_id' value='" + user.getUser_id() + "'>";
		msg += "<input type='hidden' name='user_verify_code' value='" + user.getUser_verify_code() + "'>";
		msg += "<input type='submit' value='인증'></form><br/></div>";

		// 받는 사람 E-Mail 주소
		String mail = user.getUser_id();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587);

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}
	
	//회원 인증 
	public void email_verify(User user, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out;
		try {
			out = response.getWriter();
			if (dao.email_verify(user) == 0) { // 이메일 인증에 실패하였을 경우
				out.println("<script>");
				out.println("alert('잘못된 접근입니다.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
			} else { // 이메일 인증을 성공하였을 경우
				out.println("<script>");
				out.println("alert('인증이 완료되었습니다. 로그인 후 이용하세요.');");
				out.println("location.href='../home';");
				out.println("</script>");
				out.close();
			}
		} catch (IOException e) {
			System.out.println("회원 인증 실패 : " + e);
		}
	
	}
	
	
}
