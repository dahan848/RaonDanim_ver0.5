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
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.model.User;

@Service
public class AccountsService {
	
	@Autowired
	private AccountsUserDAO dao;
	private User user;
	//dashboard 리스트를 위한 멤버변수 - 조현길
	// 댓글 가져올 개수
	private static final int REPLY_NUM = 5;
	// 한 페이지에 표시될 게시글의 개수
	private static final int NUM_OF_BOARD_PER_PAGE = 5;
	// 한 번에 표시될 네비게이션 개수
	private static final int NUM_OF_NAVI_PAGE = 10;
	//dashboard 멤버변수 end
	//갤러리 사진 삭제 ()
	public boolean deleteGalleryPic(String param) {
		StringTokenizer tokens = new StringTokenizer(param, ",");
		while(tokens.hasMoreElements()) {
			
		}
		return false;
	}
	
	//갤러리 정보를 반환하는 ()
	public List<Map<String, Object>> getGallery(String usernum){
		return dao.getUserGallery(usernum);
	}
	
	//더미 사용자 데이터 생성 서비스
	public void setDnmmyData() {

		for(int i = 1 ; i<51 ; i++) {
			user = new User();
			user.setUser_id("test@" + i);
			user.setUser_pw("1");
			user.setUser_fnm("스트" + i);
			user.setUser_lnm("테" + i);
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
		System.out.println("서비스 전달 받은 맵 확인 : " + param);
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
		int age;
		if(user.getUser_birth_date() != null) {
			age = getAgeFromBirthday(user.getUser_birth_date());
		}else {
			age = 0;
		}
		//관심사(좋아 하는 것)
		List<Map<String, Object>> interest = dao.getUserInterest(userNum);
		//사용가능 언어 
		List<Map<String, Object>> language = dao.getUserLanguage(userNum);

		result.put("profile", user.getUser_profile_pic());				//프로필 사진 : 디폴트n
		result.put("name", user_name); 			 						//이름
		//작성X															//거주지역 : 패스
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
		System.out.println("서비스 전달 받은 MAP : " + param);
		//반환 할 int 형 변수 선언 
		int result;
		
		//전달 받은 Map 에서 필요한 데이터 변수에 참조
		String user_pw = (String)param.get("user_pw"); //DB상 비밀번호 
		String old_pw = (String)param.get("old_user_pw"); //화면에 입력한 기존 비밀번호 
		String pw1 = (String)param.get("new_user_pw1"); //변경 비밀번호
		String pw2 = (String)param.get("new_user_pw2"); //변경 비밀번호 확인
		
		if(pw1.equals(pw2)) {
			System.out.println("새 비밀번호 동일");
			if(user_pw.equals(old_pw)) {
				//비밀번호 변경 성공
				result = 1;
				dao.passwordChange(param);
			}else {
				//입력한 현재 비밀번호가 틀렸을 때
				result = 2;
			}
		}else {
			//확인 비밀번호 틀림
			result = 0;
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
	
	private int getFirstRow(int page) {
		int result = (page - 1) * NUM_OF_BOARD_PER_PAGE + 1;
//		System.out.println("firstrow : " + result);
		return result;
	}
	private int getEndRow(int page) {
		int result = ((page - 1) + 1) * NUM_OF_BOARD_PER_PAGE;
		return result;
	}
	private int getStartPage(int page) {
		int result = ((page - 1) / NUM_OF_NAVI_PAGE) * NUM_OF_NAVI_PAGE + 1;
		System.out.println("getStartPage result : "+result);
		return result;
	}

	private int getEndPage(int page) {
		int result = getStartPage(page) + 9;
		return result;
	}
	//여행 게시글 total count
	private int getTotalPage(Map<String, Object> params) {
		// 총 페이지수 반환
		// 전체 게시글 개수 /페이지당 게시글 수 >>> 올림해서 반환
		int totalCount = dao.selectTotalCount(Integer.parseInt(params.get("num").toString()));
		int totalPage = (totalCount - 1) / NUM_OF_BOARD_PER_PAGE + 1;
		return totalPage;
	}
	
	//여행글 작성 리스트 불러올 메소드
	public Map<String, Object> getViewData(Map<String, Object> params) {
		// startPage, endPage, totalPage, boardList 반환
		System.out.println("서비스 호출");
		System.out.println(params);

		int page = (int) params.get("page");

		Map<String, Object> daoParam = new HashMap<String, Object>();

//		daoParam.put("firstRow", getFirstRow(page));
//		daoParam.put("endRow", getEndRow(page));
		Map<String, Object> viewData = new HashMap<String, Object>();
		


		
		/*Map<String, Object> daoParam = new HashMap<String,Object>();*/
		System.out.println(getFirstRow(page));
		System.out.println(getEndRow(page));
		daoParam.put("firstRow", getFirstRow(page));
		daoParam.put("endRow", getEndRow(page));
		daoParam.put("num", params.get("num"));
//		daoParam.put("startDate", params.get("startDate"));
//		daoParam.put("endDate", params.get("endDate"));

		

		
		
		/*Map<String, Object> viewData = new HashMap<String,Object>();*/
		
		System.out.println("service 파라미터 : "+daoParam);
		viewData.put("boardList", getBoardList(daoParam));
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getTotalPage(daoParam));
		viewData.put("page", page);

		return viewData;
	}
	
	//여행 댓글 리스트 불러올 메소드
	public Map<String, Object> getReplyViewData(Map<String, Object> params) {
		// startPage, endPage, totalPage, boardList 반환
		System.out.println("서비스 호출");
		System.out.println(params);

		int page = (int) params.get("page");

		Map<String, Object> daoParam = new HashMap<String, Object>();
		Map<String, Object> viewData = new HashMap<String, Object>();

		System.out.println(getFirstRow(page));
		System.out.println(getEndRow(page));
		daoParam.put("firstRow", getFirstRow(page));
		daoParam.put("endRow", getEndRow(page));
		daoParam.put("num", params.get("num"));

		System.out.println("service 파라미터 : "+daoParam);
		viewData.put("boardList", getReplyBoardList(daoParam));
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getReplyTotalPage(daoParam));
		viewData.put("page", page);

		return viewData;
	}
	//여행 게시글 리스트 불러올 메소드
	public List<Map<String, Object>> getBoardList(Map<String, Object> params) {
		// 페이지 번호 받아와서 해당하는 목록만 가져오기
		// 1. 페이지 번호에 해당하는 firstRow, endRow 구하기
		// 2. firstRow, endRow에 해당하는 목록 얻어오기
		// 3. 반환
		System.out.println(params);
		return dao.trip_list(params);
	}
	//여행 댓글 리스트 불러올 메소드
	public List<Map<String, Object>> getReplyBoardList(Map<String, Object> params) {
		// 페이지 번호 받아와서 해당하는 목록만 가져오기
		// 1. 페이지 번호에 해당하는 firstRow, endRow 구하기
		// 2. firstRow, endRow에 해당하는 목록 얻어오기
		// 3. 반환
		System.out.println(params);
		return dao.trip_reply_list(params);
	}
	private int getReplyTotalPage(Map<String, Object> params) {
		// 총 페이지수 반환
		// 전체 게시글 개수 /페이지당 게시글 수 >>> 올림해서 반환
		System.out.println("getReplyTotalPage : "+params);
		int totalCount = dao.selectReplyTotalCount(Integer.parseInt(params.get("num").toString()));
		int totalPage = (totalCount - 1) / NUM_OF_BOARD_PER_PAGE + 1;
		return totalPage;
	}
	
	
}
