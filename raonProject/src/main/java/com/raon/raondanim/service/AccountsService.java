package com.raon.raondanim.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.model.User;

@Service
public class AccountsService {
	
	@Autowired
	private AccountsUserDAO dao;
	private User user;
	
	//갤러리 사진 삭제 ()
	public boolean deleteGalleryPic(String param) {
		System.out.println(param);
		StringTokenizer tokens = new StringTokenizer(param, ",");
		boolean result = false;
		try {
			while(tokens.hasMoreElements()) {
				//System.out.println(tokens.nextToken());
				dao.deleteGalleryPic(tokens.nextToken());
				//System.out.println("예외발생");
			}
			//System.out.println("삭제성공");
			result = true;
		} catch (Exception e) {
			//System.out.println("삭제실패");
			e.getMessage();
		}
		return result;
	}
	
	//갤러리 정보를 반환하는 ()
	public List<Map<String, Object>> getGallery(String usernum){
		return dao.getUserGallery(usernum);
	}
	
	//더미 사용자 데이터 생성 서비스
	public void setDnmmyData() {
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		
		for(int i = 0 ; i<50 ; i++) {
			user = new User();
			user.setUser_id("test@" + i);
			user.setUser_pw(encoder.encode("1")); //비밀번호 암호화 하여 저장 
			user.setUser_fnm("저" + i);
			user.setUser_lnm("유");
			dao.setDnmmyData(user);
		}
	}
	
	//프로필 사진 등록 ()
	public boolean setProfilePic(Map<String, Object> param) {
		//System.out.println("서비스 전달 받은 맵 확인 : " + param);
		
		if(dao.setProfilePic(param) > 0) {
			return true;
		}else {
			return false;
		}
	}
	
	//갤러리 사진 등록()
	public boolean setGalleryPic(List<Map<String, Object>> param) {
		//System.out.println("서비스 전달 받은 맵 확인 : " + param);
		//System.out.println("전달 받은 맵의 사이즈 : " + param.size());
		//여러개의 파일을 넣어야 하기 때문에 반복문을 돌면서 dao에 값을 insert 해야 한다.
		
		int dataAmount = param.size();
		
		//반복문 종료 후 insert 된 로우의 개수를 담을 count
		int count = 0;
		for(int i=0 ; i < dataAmount ; i++) {
			//System.out.println("반복문 진입 : " + i);
			//반복문을 돌면서 dao에 넘겨줄 새로운 Map을 생성한다. (매 바퀴마다 초기화)
			Map<String, Object> result = new HashMap<>();
			
			//해당 Map에 인자로 받은 List의 i 번째 Map을 넣어준다.
			result = param.get(i);
			
			//dao가 올바르게 작동하면 count를 ++ 하여, 최종적으로 입력 된 로우의 개수를 얻는다.
			if(dao.setGalleryPic(result) > 0) {
				count ++;
			}
			
			//System.out.println(i +"번 째 count : " + count);
		}
		
		if(count == param.size()) {
			//count가 인자로 받은 List의 데이터 개수와 같다면 모든 데이터 들어간 것 
			return true;
		}else {
			return false;
		}
	}
	
	//프로필 화면에 넘길 데이터 (Map) 반환하는 서비스
	public Map<String, Object> getProfileData(int usernum){
		//System.out.println("프로필 화면 요청 받음 : " + usernum);
		//반환 할 Map 선언
		Map<String, Object> result = new HashMap<String, Object>();
		//인자로 받은 int 타입 usernum String으로 형 변환 
		String userNum = Integer.toString(usernum);
		//Dao를 이용 한 해당 유저 선택 
		user = dao.selectByUserNum(userNum);
		
		//name 만들기 
		String user_name = user.getUser_lnm() + user.getUser_fnm(); 
		//마지막 로그인 시간 구하기 및 변수에 참조 : 로그인 기록이 없으면 null 포인트 뜸 = 조건문으로 예외처리 
		Long lastLogin;
		if(user.getUser_last_login_time() != null) {
			lastLogin = getUserLastLoginTime(user.getUser_last_login_time());
		}else {
			lastLogin = (long) 666;
		}

		//나이 구하기 (if문으로 간단 예외처리)
		String age;
		if(user.getUser_birth_date() != null) {
			//System.out.println("나이 들어있음");
			age = Integer.toString(getAgeFromBirthday(user.getUser_birth_date())); 
		}else {
			age = null;
		}
		
		//거주도시 이름 만들기 
		String userCityCountry = null;
		if(dao.getUserCityCountry(userNum) != null) {
			Map<String, Object> CityCountry = dao.getUserCityCountry(userNum);
			String city = (String) CityCountry.get("CITY");
			String country = (String) CityCountry.get("COUNTRY");
			userCityCountry = city + "," + country;
		}
		//관심사(좋아 하는 것)
		List<Map<String, Object>> interest = null;
		if(!dao.getUserInterest(userNum).isEmpty()) {
			//System.out.println("좋아하는 것 null 아님 : " + dao.getUserInterest(userNum).toString());
			interest = dao.getUserInterest(userNum);			
		}
		//사용가능 언어
		List<Map<String, Object>> language = null;
		if(!dao.getUserLanguage(userNum).isEmpty()) {
			language = dao.getUserLanguage(userNum);
		}

		result.put("profile", user.getUser_profile_pic());				//프로필 사진 : 디폴트n
		result.put("name", user_name); 			 						//이름
		result.put("city", userCityCountry);							//거주지역
		result.put("gender", user.getUser_gender()); 					//성별
		result.put("lastLogin", lastLogin);								//마지막 로그인 시간
		result.put("with_avg", user.getUser_with_avg());				//후기 평점
		result.put("motel_avg", user.getUser_motel_avg());				//숙소 평점
		result.put("intro", user.getUser_intro());						//자기소개
		result.put("age", age);											//나이 : 따로 메서드로 구해야 됨.
		result.put("interest", interest);								//좋아하는 것 : 테이블 조인 해서 얻어와야 함
		result.put("language", language);								//사용가능 언어 : 테이블 조인 해서 얻어와야 함
		result.put("nationality", dao.getUserNationality(userNum));		//국적
		//나와의 거리 														//노답...
		result.put("accom_st", user.getUser_accom_st());				//숙박가능 여부 : 불가0, 가능1, 무료2, 유료3
		return result;
	}
	
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
			birthDay = user.getUser_birth_date(); //생일로 Date 객체 초기화 
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
		} catch (ParseException e) {
			e.printStackTrace();
		}
		//Dao 활용해서 유저 정보 업데이트 하기 및 결과 처리
		if(dao.updatePersonal(param) > 0) {
			return true; //업데이트 성공 
		}else {
			return false; //업데이트 실패 
		}
	}
	
	//사용자 비밀번호 반환 
	public String getUserPass(String usernum) {
		return dao.selectByUserNum(usernum).getUser_pw();
	}
	
	//비밀번호 변경 ()
	public int passwordChange(Map<String, Object> param) {
		//비밀번호 암호화에 사용 될 객체 선언 및 초기화
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		//DAO에 넘겨줄 때 사용 할 Map 선언
		Map<String, Object> user = new HashMap<String, Object>();
		
		//System.out.println("서비스 전달 받은 MAP : " + param);
		
		//반환 할 int 형 변수 선언 
		int result;
		
		//전달 받은 Map 에서 필요한 데이터 변수에 참조 : 생략가능
		String user_pw = (String)param.get("user_pw"); //DB상 비밀번호 
		String old_pw = (String)param.get("old_user_pw"); //화면에 입력한 기존 비밀번호 
		String pw1 = (String)param.get("new_user_pw1"); //변경 비밀번호
		String pw2 = (String)param.get("new_user_pw2"); //변경 비밀번호 확인
		
		//전달 받은 Map에서 DAO로 넘길 떄 사용 될 USERNUM put
		user.put("user_num", param.get("user_num"));
		
		if(pw1.equals(pw2)) {
			if(encoder.matches(old_pw,user_pw)) {
				result = 1; //비밀번호 변경 성공
				//DB에 저장 될 암호를 암호화 하여 Map에 Put 
				user.put("new_user_pw", encoder.encode(pw1));
				//DB에 새로운 비밀번호를 저장
				dao.passwordChange(user);
			}else {
				result = 2; //입력한 현재 비밀번호가 틀렸을 때
			}
		}else {
			result = 0; //확인 비밀번호 틀림
		}
		return result;
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
		//반환 할 boolean 변수 선언
		boolean result = false;
		//비밀번호 암호화를 위한 BCryptPasswordEncoder 선언 및 초기화 
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		
		//유저 객체 초기화
		user = new User();   
		//USER 객체에 파라미터로 받은 데이터 set
		user.setUser_id((String)param.get("user_id")); //아이디 : 이메일
		user.setUser_pw(encoder.encode((String)param.get("user_pw"))); //비밀번호를 암호화 하여 저장
		user.setUser_lnm((String)param.get("user_lnm")); //성
		user.setUser_fnm((String)param.get("user_fnm")); //이름
		
		//이메일 인증에 사용 될 key 넣기 
		user.setUser_verify_code(create_key());
		
		//사용자가 입력 한 아이디가 중복되지 않을 때에만 회원가입 로직 실행
		if(dao.selectByUserId((String)param.get("user_id")) == null) {
			result = false;
			//조건문을 통해서 boolean 변수의 참조 값 변경 
			if(dao.joinUser(user) > 0) { //가입 성공 시
				send_mail(user); //이메일 인증 메일 전송 하기 
				result = true;
			}else{ // 가입 실패시
				result = false;
			}			
		}
		return result;
	}
	
	//////////////////////////////////기타 메서드 
	//마지막 로그인 시간 구하는 () 
	private Long getUserLastLoginTime(Date param) {
		//현재 시간을 담을 변수 선언 
		Date toDay = new Date();
		//Date 객체 포맷 형식 
		SimpleDateFormat dateFormat = new SimpleDateFormat("YYYYMMddHHmm");
		//데이터를 담을 변수 선언 
		long lastLogin; //마지막 로그인 시간 
		long toDayTime; //현재 시간
		long minute = 0; //시간차이를 담을 변수 (0으로 초기화)
		
		try {
			//인자로 받은 Date 객체 포멧 후 time 얻기  
			param = dateFormat.parse(dateFormat.format(param));
			lastLogin = param.getTime();
			//현재 시간 Date 객체 포맷 후 time 얻기 
			toDay = dateFormat.parse(dateFormat.format(toDay));
			toDayTime = toDay.getTime();
			//시간 차이를 변수에 초기화 
			minute = (toDayTime - lastLogin) / 60000;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		//결과 값 반환
		return minute;
	}
	
	//나이를 구하는 ()
	private int getAgeFromBirthday (Date birthday) {
		//Calendar 객체 선언 
	    Calendar birth = new GregorianCalendar(); //인자로 받을 유저의 생일
	    Calendar today = new GregorianCalendar(); //오늘 날짜

	    birth.setTime(birthday);
	    today.setTime(new Date());

	    int factor = 0;
	    if (today.get(Calendar.DAY_OF_YEAR) < birth.get(Calendar.DAY_OF_YEAR)) {
	        factor = -1;
	    }
	    
	    return today.get(Calendar.YEAR) - birth.get(Calendar.YEAR) + factor;
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
		msg += "<table border='0'cellpadding='0'cellspacing='0'width='100%'style='table-layout: fixed;'><tr><td bgcolor='#ffffff'align='center'style='padding: 70px 15px 70px 15px;'class='section-padding'><table border='0'cellpadding='0'cellspacing='0'width='500'class='responsive-table'><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'><tbody><tr><td class='padding-copy'><table width='100%'border='0'cellspacing='0'cellpadding='0'><tr><td><a target='_blank'><img src='https://i.imgur.com/JhhrjFD.jpg'width='500'height='200'border='0'alt='Can an email really be responsive?'style='display: block; padding: 0; color: #666666; text-decoration: none; font-family: Helvetica, arial, sans-serif; font-size: 16px; width: 500px; height: 200px;'class='img-max'></a></td></tr></table></td></tr></tbody></table></td></tr><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'><tr><td align='center'style='font-size: 25px; font-family: Helvetica, Arial, sans-serif; color: #333333; padding-top: 30px;'class='padding-copy'><br><br>"+name+"님 라온다님 회원가입을 환영합니다.</td></tr><tr><td align='center'style='padding: 20px 0 0 0; font-size: 16px; line-height: 25px; font-family: Helvetica, Arial, sans-serif; color: #666666;'class='padding-copy'>하단의 인증 버튼 클릭 시<br>정상적으로 회원가입이 완료됩니다.<br></td></tr></table></td></tr><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'class='mobile-button-container'><tr><td align='center'style='padding: 25px 0 0 0;'class='padding-copy'><table border='0'cellspacing='0'cellpadding='0'class='responsive-table'></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table><div style='width: 100%; text-align:center;'><div style='margin: 0 auto; '><form method='post'action='http://localhost:8081/accounts/certify'><input type='hidden'name='user_id'value='" + user.getUser_id() + "'><input type='hidden'name='user_verify_code'value='" + user.getUser_verify_code() + "'><input type='submit'value='인증'style='font-size: 16px; font-family: Helvetica, Arial, sans-serif; font-weight: normal; color: #ffffff; text-decoration: none; background-color: #5D9CEC; border-top: 15px solid #5D9CEC; border-bottom: 15px solid #5D9CEC; border-left: 25px solid #5D9CEC; border-right: 25px solid #5D9CEC; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; display: inline-block;'class='mobile-button'></form></div></div>";

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
	
	//이메일 중복여부 
	public boolean emailCheck(String email) {
		if(dao.selectByUserId(email) != null) {
			return false;
		}else {
			return true;
		}
	}
	
	//비밀번호 체크 
	public boolean passwordCheck(String check, String usernum) {
		//반환 할 boolean 변수 선언 
		boolean result;
		//DB에 저장되어 있는 사용자의 비밀번호를 변수에 참조한다.
		String oldPw = dao.selectByUserNum(usernum).getUser_pw();
		//System.out.println(oldPw);
		//System.out.println(check);
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		//PasswordEncoder의 matches()를 이용해서 암호를 비교 
		result = encoder.matches(check, oldPw);
		//결과 반환 
		return result;
	}
	
	//비밀번호 초기화
	public boolean passwordReset(String email) {
		//DB에 저장 될 비밀번호를 암호화 하기 위한 객체 선언 
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		if(dao.selectByUserId(email) != null) {
			//아이디가 존재하면 새로운 비밀번호를 DB에 넣고 이메일 전송을 진행한다.
			//임시로 저장하고, 메일로 전송 할 비밀번호를 변수에 담는다 
			String reset_pw = create_key();
			//send_pwreset_mail()를 통해 사용자가 기입 한 메일로 메일을 보낸다.
			User user = dao.selectByUserId(email);
			send_pwreset_mail(user, reset_pw);
			//DAO에 넘길 Map 선언 및 데이터 put
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("reset_pw", encoder.encode(reset_pw)); //암호화 된 암호를 넘겨준다.
			param.put("userid", email);
			dao.passwordReset(param);
			return true;
		}else {
			return false;
		}
	}
	
	//이메일 발송 () 
	public void send_pwreset_mail(User user, String newpw){
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
		
		subject = "라온다님 임시 비밀번호 발급 메일입니다.";
		msg += "<table border='0'cellpadding='0'cellspacing='0'width='100%'style='table-layout: fixed;'><tr><td bgcolor='#ffffff'align='center'style='padding: 70px 15px 70px 15px;'class='section-padding'><table border='0'cellpadding='0'cellspacing='0'width='500'class='responsive-table'><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'><tbody><tr><td class='padding-copy'><table width='100%'border='0'cellspacing='0'cellpadding='0'><tr><td><a target='_blank'><img src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/48935/responsive-email.jpg'width='500'height='200'border='0'alt='Can an email really be responsive?'style='display: block; padding: 0; color: #666666; text-decoration: none; font-family: Helvetica, arial, sans-serif; font-size: 16px; width: 500px; height: 200px;'class='img-max'></a></td></tr></table></td></tr></tbody></table></td></tr><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'><tr><td align='center'style='font-size: 25px; font-family: Helvetica, Arial, sans-serif; color: #333333; padding-top: 30px;'class='padding-copy'>임시 비밀번호 발급 메일입니다.</td></tr><tr><td align='center'style='padding: 20px 0 0 0; font-size: 16px; line-height: 25px; font-family: Helvetica, Arial, sans-serif; color: #666666;'class='padding-copy'>하단에 표시된 임시 비밀번호로 로그인 후<br>반드시 비밀번호를 변경해주세요.<br><br><strong>"+newpw+"</strong></td></tr></table></td></tr><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'class='mobile-button-container'><tr><td align='center'style='padding: 25px 0 0 0;'class='padding-copy'><table border='0'cellspacing='0'cellpadding='0'class='responsive-table'><tr><td align='center'><a href='http://localhost:8081/accounts/loginForm'target='_blank'style='font-size: 16px; font-family: Helvetica, Arial, sans-serif; font-weight: normal; color: #ffffff; text-decoration: none; background-color: #5D9CEC; border-top: 15px solid #5D9CEC; border-bottom: 15px solid #5D9CEC; border-left: 25px solid #5D9CEC; border-right: 25px solid #5D9CEC; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; display: inline-block;'class='mobile-button'>로그인 페이지&rarr;</a></td></tr></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table>";

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
	
	//유저 월별 가입 숫자 뽑아오기 -
	public List<Map<String, Object>> getUserRegDate(){
		return dao.getUserRegDate();	
	};
	
	
}