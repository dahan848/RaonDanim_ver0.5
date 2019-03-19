package com.raon.raondanim.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import com.raon.raondanim.dao.MotelTbDAO;



@Service
public class MotelTbService{
	
	@Autowired
	private MotelTbDAO dao;
	
	//댓글 가져올 개수
	private static final int REPLY_NUM=3;
	//한 페이지에 표시될 게시글의 개수  
	private static final int NUM_OF_BOARD_PER_PAGE=9;
	//한 번에 표시될 네비게이션 개수
	private static final int NUM_OF_NAVI_PAGE=1;
	//파일을 저장하는 경로를 지니는 상수 선언
	//자바에서 경로 표시할 경우 \ 로 표시를 하는데, 하나만 표시를 하게 될 경우 적용이 안되고
	//두개를 붙여야 한다
	private static final String UPLOAD_PATH="c:\\tmp";
	
	public List<Map<String, Object>> getBoardList(Map<String, Object> params) {
		//페이지 번호 받아와서 해당하는 목록만 가져오기 
		//1. 페이지 번호에 해당하는 firstRow, endRow 구하기
		//2. firstRow, endRow에 해당하는 목록 얻어오기
		//3. 반환
		
		return dao.motelList(params);
	}
	

	public Map<String, Object> readBoard(int num) {
		//해당번호의 게시글의 조회수 1증가 시키고
		//db에서 직접 처리(dao에 메서드 선언) 또는 자바에서 처리하고 업데이트
		//해당게시글 내용 반환
		dao.plusReadCount(num);
		return dao.selectOne(num);
	}
	

	//1 11 21 31     2-1*10 + 1
	//10 20 30 40     ((10-1)/10 + 1)*10 
	private int getFirstRow(int page) {
		int result  = (page-1)*NUM_OF_BOARD_PER_PAGE+1;
//		System.out.println("firstrow : " + result);
		return result;
	}
	private int getReplyFirstRow(int page) {
		int result  = (page-1)*REPLY_NUM+1;
//		System.out.println("firstrow : " + result);
		return result;
	}
	private int getEndRow(int page) {
		int result =  ((page-1) + 1)*NUM_OF_BOARD_PER_PAGE ;
		return result;
	}
	private int getReplyEndRow(int page) {
		int result =  ((page-1) + 1)*REPLY_NUM ;
		return result;
	}
	private int getStartPage(int page) {
		int result  = ((page-1)/NUM_OF_BOARD_PER_PAGE)*NUM_OF_BOARD_PER_PAGE+1;
		
		return result;
	}
	private int getEndPage(int page) {
		int result = getStartPage(page)+9;
		return result;
	}
	private int getTotalPage(Map<String, Object> params) {
		//총 페이지수 반환
		// 전체 게시글 개수 /페이지당 게시글 수   >>> 올림해서 반환
		int totalCount = dao.selectTotalCount(params);
		int totalPage = (totalCount-1)/NUM_OF_BOARD_PER_PAGE+1;
		return totalPage;
	}
	
	//별점 인서트
	public boolean starAvg(Map<String, Object>params) {
		int result = dao.starAvg(params);
		if(result>0) {
			return true;
		}else {
			return false;
		}
		
	}
	//별점 업데이트
	public boolean starUpdate(Map<String, Object>params) {
		int result = dao.starUpdate(params);
		if(result>0) {
			return true;
		}else {
			return false;
		}
	}
	//별점 업데이트를 위해 셀렉해서 값이 있는지 확인
	public boolean starCheck(Map<String, Object>params) {
		if(dao.starCheck(params)==null) {
			return true;
		}else {		
			return false;
		}
	}
	
	public Map<String, Object> getViewData(Map<String, Object> params) {
		//startPage, endPage, totalPage, boardList  반환
		System.out.println("서비스 호출");
		System.out.println(params);
		int page = (int)params.get("page");
		int motel_type = (int)params.get("motel_type");
		
		Map<String, Object> daoParam = new HashMap<String,Object>();
		daoParam.put("firstRow", getFirstRow(page));
		daoParam.put("endRow", getEndRow(page));
		daoParam.put("motel_type", motel_type);
		daoParam.put("motel_category", params.get("motel_category"));
		daoParam.put("motel_people", params.get("motel_people"));
		daoParam.put("motel_price1", params.get("motel_price1"));
		daoParam.put("motel_price2", params.get("motel_price2"));
		daoParam.put("startDate", params.get("startDate"));
		daoParam.put("endDate", params.get("endDate"));
		daoParam.put("city", params.get("city"));
		

		
		
		Map<String, Object> viewData = new HashMap<String,Object>();
		
		viewData.put("boardList", getBoardList(daoParam));
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getTotalPage(daoParam));
		viewData.put("page", page);
		
		return viewData;
	}
	public Map<String, Object> getReplyData(Map<String, Object> params) {
		//startPage, endPage, totalPage, boardList  반환
		System.out.println("댓글을 부르자");
		System.out.println(params);
		int page = (int)params.get("page");
		int num = (int)params.get("num");
		
		
		Map<String, Object> daoParam = new HashMap<String,Object>();
		daoParam.put("num", num);
		daoParam.put("firstRow", getReplyFirstRow(page));
		daoParam.put("endRow", getReplyEndRow(page));
		Map<String, Object> viewData = new HashMap<String,Object>();
		viewData.put("boardList", viewReply(daoParam));
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getTotalPage(daoParam));
		viewData.put("page", page);
		
		return viewData;
	}

	
	public Map<String, Object> getBoardByNum(int num) {
		// TODO Auto-generated method stub
		return dao.selectOne(num);
	}

	
	public List<Map<String, Object>> replyCount() {
		// TODO Auto-generated method stub
		return dao.replyCount();
	}
	
	public boolean write_reply(Map<String, Object>params) {
		int result = dao.write_reply(params);
		if(result>0) {
			return true;
		}else {
			return false;
		}
	}

	

	
	
	//숙박 게시글 상세정보(view화면용)
	public Map<String, Object> viewSelect(Map<String, Object> params){
		
		return dao.viewSelect(params);
	}
	//숙박 게시글 댓글(view화면용)
	public List<Map<String, Object>> viewReply(Map<String,Object> params){
		
		return dao.viewReply(params);
	}
	//숙소 예약시 motel_date_tb 상태값 N으로 변경 
	public boolean date_tb_update(Map<String, Object>params) {
		if(dao.date_tb_update(params)>0) {
			return true;
		}else {
			return false;			
		}
		
	}
	//motel_date_tb 업데이트 후 중복 예약 방지 체크
	public boolean checkDate(Map<String, Object>params) {
		if(dao.checkDate(params)>0) {
			return true;
		}else {
			return false;
		}
	}
	//댓글 상태값 삭제로 변경
	public boolean deleteReply(Map<String, Object>params) {
		if(dao.deleteReply(params)>0) {
			return true;
		}else {
			return false;
		}
	}
	//댓글 신고 데이터 불러오기
	public List<Map<String, Object>> declaration(){
		
		return dao.declaration();
	}
	
	//신고테이블 insert(reply)
	public boolean insertDeclaration(Map<String, Object>params) {
		if(dao.insertDeclaration(params)>0) {
			return true;
		}else {
			return false;
		}
	}
	//신고테이블 insert(motel)
	public boolean insert_motel_Declaration(Map<String, Object>params) {
		if(dao.insert_motel_Declaration(params)>0) {
			return true;
		}else {
			return false;
		}
	}
	
	//댓글 중복신고 방지 체크
	public boolean insertDeclaration_check(Map<String, Object>params) {
		if(dao.insertDeclaration_check(params)==null) {
			return true;
		}else {
			return false;
		}
	}
	//숙박글 중복신고 방지 체크
	public boolean insert_motel_Declaration_check(Map<String, Object>params) {
		if(dao.insert_motel_Declaration_check(params)==null) {
			return true;
		}else {
			return false;
		}
	}
	//숙박글 삭제
	public boolean delete_motel(Map<String, Object>params) {
		if(dao.delete_motel(params)>0) {
			return true;
		}else {
			return false;
		}
	}
	
	
	//모텔 서비스 병합중
	
	public List<Map<String, Object>> getAllNational() {
		//System.out.println("service : " + dao.National_selectAll());
		return dao.National_selectAll();
	}

	
	public List<Map<String, Object>> getAllCity() {
		// TODO Auto-generated method stub
		return dao.City_selectAll();
	}

	
	public int write_Motel(Map<String, Object> param) {
		int motel_num =0;
		if(dao.motel_insert(param) > 0) {
			motel_num = (int)param.get("MOTEL_NUM");
			System.out.println("service_motel_num : "+motel_num);
			return motel_num;
		}else {
			return motel_num;			
		}
	}


	public String wirte_motel_Photo(MultipartFile file) {
		String fullName = null;
		//1. UUID만들어내서 원래 파일이름에 붙여서 fullName을 만들어냄
		//2. 만들어낸 fullName으로 파일 저장(지정한 경로에 복사)
		//3. fullName 반환
		
		//1. UUID만들어내서 원래 파일이름에 붙여서 fullName을 만들어냄
		UUID uuid = UUID.randomUUID();
		fullName = uuid.toString()+"_" + file.getOriginalFilename();
		
		//2. 만들어낸 fullName으로 파일 저장(지정한 경로에 복사)
		File target = new File(UPLOAD_PATH, fullName);
		
		try {
			FileCopyUtils.copy(file.getBytes(), target);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fullName;
	}
	
	
	
	
	
	
}
