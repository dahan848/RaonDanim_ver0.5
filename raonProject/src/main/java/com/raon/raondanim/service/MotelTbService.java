package com.raon.raondanim.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import com.raon.raondanim.dao.MotelTbDAO;

@Service
public class MotelTbService {

	@Autowired
	private MotelTbDAO dao;

	// 댓글 가져올 개수
	private static final int REPLY_NUM = 3;
	// 한 페이지에 표시될 게시글의 개수
	private static final int NUM_OF_BOARD_PER_PAGE = 9;
	// 한 번에 표시될 네비게이션 개수
	private static final int NUM_OF_NAVI_PAGE = 1;
	// 파일을 저장하는 경로를 지니는 상수 선언
	// 자바에서 경로 표시할 경우 \ 로 표시를 하는데, 하나만 표시를 하게 될 경우 적용이 안되고
	// 두개를 붙여야 한다
	private static final String UPLOAD_PATH = "D:\\project_img";

	public List<Map<String, Object>> getBoardList(Map<String, Object> params) {
		// 페이지 번호 받아와서 해당하는 목록만 가져오기
		// 1. 페이지 번호에 해당하는 firstRow, endRow 구하기
		// 2. firstRow, endRow에 해당하는 목록 얻어오기
		// 3. 반환

		return dao.motelList(params);
	}

	public Map<String, Object> readBoard(int num) {
		// 해당번호의 게시글의 조회수 1증가 시키고
		// db에서 직접 처리(dao에 메서드 선언) 또는 자바에서 처리하고 업데이트
		// 해당게시글 내용 반환
		dao.plusReadCount(num);
		return dao.selectOne(num);
	}

	public Map<String, Object> readFile(int num) {
		System.out.println("readFile : " + num);
		return dao.selectAttach(num);
	}

	public boolean modifyBoard(Map<String, Object> params) {
		if (dao.updateMotel(params) > 0) {
			return true;
		} else {
			return false;
		}
	}

	public boolean deleteBoard(int num) {
		if (dao.deleteMotel(num) > 0) {
			return true;
		} else {
			return false;
		}
	}

	public boolean checkPass(int num, String pass) {
		// 하나 조회해서 비번이 같은지 확인하면 된다.
		Map<String, Object> board = dao.selectOne(num);
		if (board.get("pass").equals(pass)) {
			return true;
		} else {
			return false;
		}
	}

	// 1 11 21 31 2-1*10 + 1
	// 10 20 30 40 ((10-1)/10 + 1)*10
	private int getFirstRow(int page) {
		int result = (page - 1) * NUM_OF_BOARD_PER_PAGE + 1;
//		System.out.println("firstrow : " + result);
		return result;
	}

	private int getReplyFirstRow(int page) {
		int result = (page - 1) * REPLY_NUM + 1;
//		System.out.println("firstrow : " + result);
		return result;
	}

	private int getEndRow(int page) {
		int result = ((page - 1) + 1) * NUM_OF_BOARD_PER_PAGE;
		return result;
	}

	private int getReplyEndRow(int page) {
		int result = ((page - 1) + 1) * REPLY_NUM;
		return result;
	}

	private int getStartPage(int page) {
		int result = ((page - 1) / NUM_OF_BOARD_PER_PAGE) * NUM_OF_BOARD_PER_PAGE + 1;

		return result;
	}

	private int getEndPage(int page) {
		int result = getStartPage(page) + 9;
		return result;
	}

	private int getTotalPage(Map<String, Object> params) {
		// 총 페이지수 반환
		// 전체 게시글 개수 /페이지당 게시글 수 >>> 올림해서 반환
		int totalCount = dao.selectTotalCount(params);
		int totalPage = (totalCount - 1) / NUM_OF_BOARD_PER_PAGE + 1;
		return totalPage;
	}

	public boolean starAvg(Map<String, Object> params) {
		int result = dao.starAvg(params);
		if (result > 0) {
			return true;
		} else {
			return false;
		}

	}

	public Map<String, Object> getViewData(Map<String, Object> params) {
		// startPage, endPage, totalPage, boardList 반환
		System.out.println("서비스 호출");
		System.out.println(params);
		int page = (int) params.get("page");
		int type = (int) params.get("type");
		String keyword = (String) params.get("keyword");
		Map<String, Object> daoParam = new HashMap<String, Object>();
		daoParam.put("type", type);
		if (type == 1) {
			// 제목검사
			daoParam.put("title", keyword);
		} else if (type == 2) {
			// 작성자
			daoParam.put("name", keyword);
		} else if (type == 3) {
			// 제목 작성자
			daoParam.put("title", keyword);
			daoParam.put("name", keyword);
		} else if (type == 4) {
			// 내용
			daoParam.put("content", keyword);
		}
		daoParam.put("firstRow", getFirstRow(page));
		daoParam.put("endRow", getEndRow(page));
		Map<String, Object> viewData = new HashMap<String, Object>();

		viewData.put("boardList", getBoardList(daoParam));
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getTotalPage(daoParam));
		viewData.put("page", page);

		return viewData;
	}

	public Map<String, Object> getReplyData(Map<String, Object> params) {
		// startPage, endPage, totalPage, boardList 반환
		System.out.println("댓글을 부르자");
		System.out.println(params);
		int page = (int) params.get("page");
		int num = (int) params.get("num");

		Map<String, Object> daoParam = new HashMap<String, Object>();
		daoParam.put("num", num);
		daoParam.put("firstRow", getReplyFirstRow(page));
		daoParam.put("endRow", getReplyEndRow(page));
		Map<String, Object> viewData = new HashMap<String, Object>();
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

	public boolean write_reply(Map<String, Object> params) {
		int result = dao.write_reply(params);
		if (result > 0) {
			return true;
		} else {
			return false;
		}
	}

	

	public View getUploadFile(int num) {
		// TODO Auto-generated method stub
		// 게시글 번호에 해당하는 File 복사 후
		// View로 만들어 반환
		// 파일을 복사해오기 위해 파일의 정확한 이름을 알아야 한다

		String fileName = (String) dao.selectOne(num).get("FILENAME");
		// DownloadView 객체 만들어 반환
		File file = new File(UPLOAD_PATH, fileName);
		View view = new DownloadView(file);
		return view;
	}

	// 숙박 게시글 상세정보(view화면용)
	public Map<String, Object> viewSelect(Map<String, Object> params) {

		return dao.viewSelect(params);
	}

	// 숙박 게시글 댓글(view화면용)
	public List<Map<String, Object>> viewReply(Map<String, Object> params) {

		return dao.viewReply(params);
	}

	// 모텔 서비스 병합중

	public List<Map<String, Object>> getAllNational() {
		// System.out.println("service : " + dao.National_selectAll());
		return dao.National_selectAll();
	}

	public List<Map<String, Object>> getAllCity() {
		// TODO Auto-generated method stub
		return dao.City_selectAll();
	}

	public int write_Motel(Map<String, Object> param) {
		int motel_num = 0;
		if (dao.motel_insert(param) > 0) {
			motel_num = (int) param.get("MOTEL_NUM");
			System.out.println("service_motel_num : " + motel_num);
			return motel_num;
		} else {
			return motel_num;
		}
	}

	// 파일 업로드까지 등록
	public int write_Motel1(Map<String, Object> param, List<MultipartFile> motel_photo) {
		int motel_num = 0;
		//System.out.println("write_motel1 session : " + motel_photo);
		String checkin = (String) param.get("motel_fromDate");
		String checkout = (String) param.get("motel_checkoutDate");
		System.out.println("checkin : " + checkin);
		System.out.println("checkout : " + checkout);
		
		
		System.out.println(param);
		
		if (dao.motel_insert(param) > 0) {
			// MOTEL_TB 에 정상등록시 사진테이블도 insert 해준다

			motel_num = (int) param.get("MOTEL_NUM");
			//System.out.println("motel_num" + motel_num);
			System.out.println("========pl/sql========================");
			
			//숙박 가능 테이블에 데이터를 넣기위해 pl/sql 에 필요한 변수설정
			Map<String, Object> motel_procedure = new HashMap<String, Object>();
			int start_number = 0;
			int end_number = startEnd(checkin, checkout);
			int insert_motel_number = (int) param.get("MOTEL_NUM");
			//Date start_date = (Date) param.get("motel_fromDate");
			
			String date = param.get("motel_fromDate").toString();
			System.out.println(date);
			SimpleDateFormat start_date = new SimpleDateFormat("yyyy-mm-dd");
			
//			java.text.SimpleDateFormat start_date = new java.text.SimpleDateFormat(date);
//			int start_date = (int) param.get("motel_fromDate");
//			System.out.println("start_date : " + start_date);
		
			System.out.println("end_number : " + end_number);
			System.out.println("insert_motel_number : " + insert_motel_number);
			System.out.println("start_date : " + start_date);
			motel_procedure.put("start_number", start_number);
			motel_procedure.put("end_number", end_number);
			motel_procedure.put("insert_motel_number", insert_motel_number);
			motel_procedure.put("start_date", date);
			//숙박 가능날짜 테이블 pl/sql end
			
			
			
			dao.motel_Date_procedure(motel_procedure);
			
			Map<String, Object> filesParam = new HashMap<String, Object>();
			filesParam.put("MOTEL_NUM", motel_num);
			System.out.println("service motel_photo : " + motel_photo);
			for (int i = 0; i < motel_photo.size(); i++) {
				filesParam.put("motel_photo_" + (i+1), wirte_motel_Photo(motel_photo.get(i)));
			}
			
			System.out.println("filesParam : " + filesParam);
			dao.insertMotel_Photo(filesParam);
			return motel_num;
		} else {
			return motel_num;
		}
		
	}
	
	public String wirte_motel_Photo(MultipartFile file) {
		String fullName = null;
		// 1. UUID만들어내서 원래 파일이름에 붙여서 fullName을 만들어냄
		// 2. 만들어낸 fullName으로 파일 저장(지정한 경로에 복사)
		// 3. fullName 반환

		// 1. UUID만들어내서 원래 파일이름에 붙여서 fullName을 만들어냄
		UUID uuid = UUID.randomUUID();
		fullName = uuid.toString() + "_" + file.getOriginalFilename();

		// 2. 만들어낸 fullName으로 파일 저장(지정한 경로에 복사)
		File target = new File(UPLOAD_PATH, fullName);

		try {
			FileCopyUtils.copy(file.getBytes(), target);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fullName;
	}
	
	// 날짜 입력받아서 pl/sql 함수에 넣을 값 만들기 
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

}
