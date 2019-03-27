package com.raon.raondanim.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.dao.AdminDAO;
import com.raon.raondanim.dao.MotelTbDAO;
import com.raon.raondanim.model.User;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO dao;
	
	@Autowired
	private AccountsUserDAO userDao;
	
	@Autowired
	private MotelTbDAO motelDao;
	
	/*
	 	문의글 페이징 처리를 위한 변수 및 () 선언
	*/  
    private static final int NUM_OF_INQUIRY_PER_PAGE=10; //한 페이지에 표시 될 문의글 개수
    private static final int NUM_OF_NAVI_PAGE=10;		 //한 번에 표시 될 네비게이션 개수 
    
    public List<Map<String, Object>> getInquiryList(Map<String, Object> params) {         
        return dao.InquiryList(params);
    }
    
    private int getInquiryFirstRow(int page) {
	    int result  = (page-1)*NUM_OF_INQUIRY_PER_PAGE+1;
	    return result;
    }
    
    private int getInquiryEndRow(int page) {
        int result =  ((page-1) + 1)*NUM_OF_INQUIRY_PER_PAGE ;
        return result;
    }
    
    private int getInquiryStartPage(int page) {
        int result  = ((page-1)/NUM_OF_INQUIRY_PER_PAGE)*NUM_OF_INQUIRY_PER_PAGE+1;
        return result;
    }
    
    private int getInquiryEndPage(int page) {
        int result = getInquiryStartPage(page)+9;
        return result;
    }
    
    private int getInquiryTotalPage(Map<String, Object> params) {
        int totalCount = dao.selectInquiryTotalCount(params);
        int totalPage = (totalCount-1)/NUM_OF_INQUIRY_PER_PAGE+1;
        return totalPage;
    }
    
    public Map<String, Object> getInquiryViewData(Map<String, Object> params) {
        int page = (int)params.get("page");
        int type = (int)params.get("type");
        
        String keyword = (String)params.get("keyword");
        Map<String, Object> daoParam = new HashMap<String,Object>();
        
        /*
			전체검색 	type 0 
			일반문의 	type 1
			회원문의	type 2
			탈퇴문의	type 3
			미답변 문의 	type 4
         */        
        daoParam.put("type", type);
        
        daoParam.put("firstRow", getInquiryFirstRow(page));
        daoParam.put("endRow", getInquiryEndRow(page));
         
        Map<String, Object> viewData = new HashMap<String,Object>();
 
        List<Map<String, Object>> InquiryList = getInquiryList(daoParam);
        viewData.put("InquiryList", InquiryList);
        viewData.put("startPage", getInquiryStartPage(page));
        viewData.put("endPage", getInquiryEndPage(page));
        viewData.put("totalPage", getInquiryTotalPage(daoParam));
        viewData.put("page", page);
        return viewData;
    }
    
	
	
	
	//잠금 상태의 계정 목록을 반환하는 ()
	public List<Map<String, Object>>getLockoutUserList() {
		//System.out.println(dao.getLockoutUserList());
		return dao.getLockoutUserList(); 
	}
	
	//잠금 상태의 유저의 잠금을 해제하는 ()
	public boolean userUnlock(int usernum) {
		if(dao.userUnlock(usernum) > 0) {
			return true;
		}else {
			return false;			
		}
	}
	
	//문의글 DB에 데이터를 넣는 ()
	public boolean insertInquiry(Map<String, Object> param) {
		// 회원/비회원 타입 구별을 위한 조건문 
		if(userDao.selectByUserId ((String)param.get("inquiry_reg_id")) != null) {
			//inquiry_rge_type : 비회원0, 회원1
			param.put("inquiry_rge_type", 1);
		}else {
			param.put("inquiry_rge_type", 0);
		}
		
		//DAO에 param을 넣는 작업
		if(dao.insertInquiry(param) > 0) {
			return true;
		}else {
			return false;			
		}
	}
	
	//문의글 더미 데이터 생성()
	public void insertDummyInquiry() {
		//반복문을 통한 더미 데이터 작성 
		int count = 0;
		for(int i=0 ; i < 50 ; i++) {
			//반복문이 돌 때 마다 새로운 MAP을 생성하고 데이터를 넣어준다
			Map<String, Object> param = new HashMap<String, Object>();
			//각 종 타입값의 랜덤성을 위해 랜덤함수 선언 
			Random ran = new Random();
			param.put("inquiry_type", ran.nextInt(3));
			param.put("inquiry_rge_type", ran.nextInt(2));
			param.put("inquiry_reg_id", "dummy"+i+"@inquiry.com");
			param.put("inquiry_subject", "문의 더미 데이터" + i);
			param.put("inquiry_content", "문의 더미 데이터" + i);
			if(dao.insertDummyInquiry(param) > 0) {
				count ++;
			}
		}
		System.out.println("문의 게시글 더미데이터 " + count + "개 생성 완료");
	}
	
	//특정 문의글에 대한 답변 DB 저장 
	public boolean insertAnswer(Map<String, Object> param) {
		if(dao.insertAnswer(param) > 0) {
			//등록에 성공하면 해당 문의글의 답변 상태를 업데이트 해준다.
			dao.updateInquiryAnswer((String)param.get("inquiry_num"));
			//메일 전송 을 위해 해당 글에 대한 정보를 Map에 담는다. 
			Map<String, Object> data = dao.selectInquiry((String)param.get("inquiry_num"));
			//해당 글에 대한 답변도 put 해준다
			data.put("ANSWER_CONTENT", (String)param.get("content"));
			//메일 전송을 위한 메서드로 해당 data를 넘겨 준다.
			send_answer_mail(data);
			return true;
		}else {
			return false;			
		}
	}
	
	//답변 글 메일 전송 ()
	//이메일 발송 () 
	public void send_answer_mail(Map<String, Object> data){
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

		//전달 받은 Map에서 필요한 데이터 변수에 참조 시키기
		String mail = (String)data.get("INQUIRY_REG_ID"); //질문자의 메일주소
		String inquiry_subject = (String)data.get("INQUIRY_SUBJECT"); //문의글 제목
		String inquiry_content = (String)data.get("INQUIRY_CONTENT"); //문의글 내용
		String answer_content = (String)data.get("ANSWER_CONTENT"); //답변내용
		//작성일 DATE > STRING 형 변환 
		Date from = (Date) data.get("INQUIRY_REG_DATE");
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String to = transFormat.format(from);
		String inquiry_reg_date = to; //문의글 작성일
		subject = "라온다님 : 문의하신 내용에 대한 답변입니다.";
		msg += "<table border='0'cellpadding='0'cellspacing='0'width='100%'style='table-layout: fixed;'><tr><td bgcolor='#ffffff'align='center'style='padding: 70px 15px 70px 15px;'class='section-padding'><table border='0'cellpadding='0'cellspacing='0'width='500'class='responsive-table'><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'><tbody><tr><td class='padding-copy'><table width='100%'border='0'cellspacing='0'cellpadding='0'><tr><td><a target='_blank'><img src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/48935/responsive-email.jpg'width='500'height='200'border='0'alt='Can an email really be responsive?'style='display: block; padding: 0; color: #666666; text-decoration: none; font-family: Helvetica, arial, sans-serif; font-size: 16px; width: 500px; height: 200px;'class='img-max'></a></td></tr></table></td></tr></tbody></table></td></tr><tr><td align='center'style='padding: 20px 0 0 0; font-size: 16px; line-height: 25px; font-family: Helvetica, Arial, sans-serif; color: #666666;'class='padding-copy'><strong>제목</strong><br>"+inquiry_subject+"<br><strong>작성일</strong><br>"+inquiry_reg_date+"<br><strong>문의내용</strong><br>"+inquiry_content+"<br></td></tr><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'><tr><td align='center'style='font-size: 25px; font-family: Helvetica, Arial, sans-serif; color: #333333; padding-top: 30px;'class='padding-copy'><hr>문의하신 글에 대한 답변입니다.<hr></td></tr><tr><td align='center'style='padding: 20px 0 0 0; font-size: 16px; line-height: 25px; font-family: Helvetica, Arial, sans-serif; color: #666666;'class='padding-copy'>"+answer_content+"<br><br>해당 답변이 도움이 되셨길 바랍니다.<br>사이트 이용을 원하실 경우<br>아래 버튼을 통해 손쉽게 접속이 가능합니다.</td></tr></table></td></tr><tr><td><table width='100%'border='0'cellspacing='0'cellpadding='0'class='mobile-button-container'><tr><td align='center'style='padding: 25px 0 0 0;'class='padding-copy'><table border='0'cellspacing='0'cellpadding='0'class='responsive-table'><tr><td align='center'><a href='http://localhost:8081/home'target='_blank'style='font-size: 16px; font-family: Helvetica, Arial, sans-serif; font-weight: normal; color: #ffffff; text-decoration: none; background-color: #5D9CEC; border-top: 15px solid #5D9CEC; border-bottom: 15px solid #5D9CEC; border-left: 25px solid #5D9CEC; border-right: 25px solid #5D9CEC; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; display: inline-block;'class='mobile-button'>라온다님&rarr;</a></td></tr></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table>";

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
	
	public Map<String, Object> getTripDeclarationData(Map<String, Object> params){
		//여행 게시글 신고 데이터
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		
		params.put("start", getInquiryFirstRow(page));
		params.put("end", getInquiryEndRow(page));
		
		Map<String, Object>tripData = new HashMap<>();
		
		
		tripData.put("dBoardList", dao.getDeclarationBoard(params));
		tripData.put("start", getInquiryStartPage(page));
		tripData.put("end", getInquiryEndPage(page));
		tripData.put("total", getTripBoardTotalCount());
		tripData.put("page", page);
		
		
		return tripData;
	
		
		
	}
	public int getTripBoardTotalCount() {
		//여행게시글 신고 글 토탈 
		int totalPage = 0;
		int boardCount = dao.getTripboardTotalCount();

		totalPage = (boardCount - 1) / NUM_OF_INQUIRY_PER_PAGE + 1;

		return totalPage;
		
	}
	
	public Map<String, Object> getMotelDeclarationList(Map<String, Object> params){
		
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		
		params.put("start", getInquiryFirstRow(page));
		params.put("end", getInquiryEndRow(page));
		
		Map<String, Object>motelData = new HashMap<>();
		
		
		motelData.put("dMotelList", dao.getMotelDeclarationList(params));
		motelData.put("start", getInquiryStartPage(page));
		motelData.put("end", getInquiryEndPage(page));
		motelData.put("total",getMotelTotalCount());
		motelData.put("page", page);
		
		
		return motelData;
	}
	
	public int getMotelTotalCount() {
		
		int totalPage = 0;
		int boardCount = dao.getMotelTotalCount();

		totalPage = (boardCount - 1) / NUM_OF_INQUIRY_PER_PAGE + 1;

		return totalPage;
		
	}
	
	
	public boolean deleteMotel(Map<String, Object> params) {
		
		if(motelDao.delete_motel(params)>0) {
			return true;
		}else {
			return false;
		}
		
		
		
		
	}
	
	
	public Map<String, Object> getMotelReplyDeclarationList(Map<String, Object> params){
		
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		
		params.put("start", getInquiryFirstRow(page));
		params.put("end", getInquiryEndRow(page));
		
		Map<String, Object>motelReplyData = new HashMap<>();
		
		
		motelReplyData.put("dreplyList", dao.getMotelReplyDeclarationList(params));
		motelReplyData.put("start", getInquiryStartPage(page));
		motelReplyData.put("end", getInquiryEndPage(page));
		motelReplyData.put("total",getMotelTotalCount());
		motelReplyData.put("page", page);
		
		
		return motelReplyData;
		
	}
	public int getMotelReplyTotalCount() {
		int totalPage = 0;
		int boardCount = dao.getMotelReplyTotalCount();

		totalPage = (boardCount - 1) / NUM_OF_INQUIRY_PER_PAGE + 1;

		return totalPage;
		
		
	}
	
	
	
	public boolean motelReplyDelete(Map<String, Object> params) {
		
		if(motelDao.deleteReply(params)>0) {
			return true;
		}else {
			return false;
		}
		
		
		
	}
	
	
	
}
