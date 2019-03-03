package com.raon.raondanim.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
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
	
	private static final int NUM_OF_USER_PER_PAGE = 15;
	private static final int NUM_OF_NAVI_PAGE = 10;
	
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
	
	public List<Map<String, Object>> getUserList(Map<String, Object> params){
		return dao.userList(params);
	}
	
	private int getFirstRow(int page) {
		int result = (page - 1) * NUM_OF_USER_PER_PAGE + 1;
		return result;
	}
	
	private int getEndRow(int page) {
		int result = ((page - 1) + 1) * NUM_OF_USER_PER_PAGE;
		return result;
	}
	
	private int getStartPage(int page) {
		int result = ((page - 1) / NUM_OF_NAVI_PAGE) * NUM_OF_NAVI_PAGE + 1;
		return result;
	}
	
	private int getEndPage(int page) {
		int result = getStartPage(page) + 9;
		return result;
	}
	
	private int getTotalPage(Map<String, Object> params) {
		int totalCount = dao.selectTotalCount(params);
		int totalPage = (totalCount - 1) / NUM_OF_USER_PER_PAGE + 1;
		return totalPage;
	}
	
	public Map<String, Object> getViewData(Map<String, Object> params){
		int page = (int) params.get("page");

		Map<String, Object> daoParam = new HashMap<String, Object>();
		daoParam.put("firstRow", getFirstRow(page));
		daoParam.put("endRow", getEndRow(page));
		
		Map<String, Object> viewData = new HashMap<String, Object>();
		
		List<Map<String, Object>> userList = getUserList(daoParam);
		viewData.put("userList", userList);
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getTotalPage(daoParam));
		viewData.put("page", page);
		
		return viewData;
	}
	
}