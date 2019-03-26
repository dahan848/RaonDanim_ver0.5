package com.raon.raondanim.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.dao.WithReviewBoardDao;
import com.raon.raondanim.model.User;

@Service
public class WithReviewBoardServiceImp implements WithReviewBoardService{
	
	@Autowired
	private WithReviewBoardDao dao;
	
	@Autowired
	private AccountsUserDAO userDao;
	
	@Override
	public boolean insertWith(Map<String, Object> param) {

		if(dao.insertWith(param)>0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean updateWith(Map<String, Object> params) {
		
		//parmas ==>> userNum(로그인한 USER_NUM), WITH_GPA, WITH_CONTENT, num(WITH_NUM)
		System.out.println("서비스 -> 동행 후기 수정 params : " + params);
		
		//WITH_NUM
		String numStr = String.valueOf(params.get("num"));
		int with_Num = Integer.parseInt(numStr);
		
		//로그인 한 USER_NUM
		String userNum = String.valueOf(params.get("userNum"));
		
		//WITH_NUM 으로 게시글 정보 뽑기
		Map<String, Object> with = dao.selectWithOne(with_Num);
		
		//Map<String, Object> with에 들어있는 WR_USER_NUM
		String user_Num = String.valueOf(with.get("WR_USER_NUM"));
		
		if(user_Num.equals(userNum)) {
			if(dao.updateWith(params)>0) {
				return true;
			} else {		
				return false;
			}
		} else {
			return false;
		}
		
		
	}

	@Override
	public boolean deleteWith(Map<String, Object> param) {
		
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		
		//입력한 비밀번호
		String input_pass = String.valueOf(param.get("input_pass"));
		
		//게시글 번호
		String numStr = String.valueOf(param.get("num"));
		
		// num = WITH_NUM
		int num = Integer.parseInt(numStr);
		
		//로그인한 USER_NUM
		String userNum = String.valueOf(param.get("userNum"));
		
		Map<String, Object> with = dao.selectWithOne(num);
		
		String user_Num =  String.valueOf(with.get("USER_NUM"));
		String user_Pw =  String.valueOf(with.get("USER_PW"));
		
		
		if(user_Num.equals(userNum)) {
			if(encoder.matches(input_pass, user_Pw)){
				if(dao.deleteWith(num)>0) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

	@Override
	public Map<String, Object> selectOne(int num) {
		return dao.selectOne(num);
	}
	
	@Override
	public Map<String, Object> selectOneByWrUserNum(int num) {
		return dao.selectOneByWrUserNum(num);
	}
	
	@Override
	public Map<String, Object> selectWithOne(int num) {
		return dao.selectWithOne(num);
	}

	@Override
	public List<Map<String, Object>> selectAll() {
		return dao.selectAll();
	}

	@Override
	public Map<String, Object> plusReadCount(int num) {
		dao.plusReadCount(num);
		return dao.selectOne(num);
	}

	@Override
	public List<Map<String, Object>> getWithBoard(int TL_USER_NUM) {
		return dao.selectByUserNum(TL_USER_NUM);
	}

	@Override
	public User selectByUserNum(String num) {
		return userDao.selectByUserNum(num);
	}
	
	//-------------------------------유저 검색-----------------------------------------//
	@Override
	public List<Map<String, Object>> getSearchUser(Map<String, Object> params) {
		return dao.searchUser(params);
	}

	@Override
	public Map<String, Object> getViewData(Map<String, Object> params) {
		
		//keyword를 입력받으면 daoparam에 집어넣음
		//daoparam에 있는 키워드로 getSearchUser(daoParam) 해서 관련된 회원 뽑아 냄   --> searchList
		//searchList를 map에 집어넣음
		
		String keyword = (String)params.get("keyword");
		
		Map<String, Object> daoParam = new HashMap<String, Object>();
		daoParam.put("USER_ID", keyword);
	
		List<Map<String, Object>> searchList = getSearchUser(daoParam);
		Map<String, Object> viewData = new HashMap<String, Object>();
		viewData.put("searchList", searchList);
		
		return viewData;
		
	}

	//---------------- 페이징 부분 ----------------//
	
		//한 페이지에 표시될 게시글의 갯수 
		private static final int NUM_OF_BOARD_PER_PAGE=10;
		//한 번에 표시될 네비게이션 갯수
		private static final int NUM_OF_NAVI_PAGE=10;
		
		
		@Override
		public List<Map<String, Object>> getBoardList(Map<String, Object> params) {
			return dao.boardList(params);
		}
		
		private int getFirstRow(int page) {
			int result = (page-1)*NUM_OF_BOARD_PER_PAGE+1;
			return result;
		}
		
		private int getEndRow(int page) {
			int result = ((page-1)+1)*NUM_OF_BOARD_PER_PAGE;
			return result;
		}
		
		private int getStartPage(int page) {
			int result = ((page-1)/NUM_OF_BOARD_PER_PAGE)*NUM_OF_BOARD_PER_PAGE+1;
			return result;
		}
		
		private int getEndPage(int page) {
			int result = getStartPage(page) + 9;
			return result;
		}
		
		private int getTotalPage() {
			int totalCount = dao.selectTotalCount();
			int totalPage = (totalCount-1)/NUM_OF_BOARD_PER_PAGE+1;
			return totalPage;
		}
		
		@Override
		public Map<String, Object> getViewPagingData(Map<String, Object> params) {
			
			System.out.println("=-===================");
			System.out.println("param : " + params);
			System.out.println("=-===================");
			
			//page=1   --> startPage
			int page = Integer.parseInt(String.valueOf(params.get("page")));
			
			int num = Integer.parseInt(String.valueOf(params.get("num")));
			
			//daoParam --> firstRow=1, endRow=10
			Map<String, Object> daoParam = new HashMap<String, Object>();
			daoParam.put("firstRow", getFirstRow(page));
			daoParam.put("endRow", getEndRow(page));
			daoParam.put("num", num);
			
			System.out.println("getFirstRow(page) : " + getFirstRow(page));
			System.out.println("getEndRow(page) : " + getEndRow(page));
			
			//viewData ==>> startPage, totalPage, endPage, page, boardList
			Map<String, Object> viewData = new HashMap<String, Object>();
			List<Map<String, Object>> boardList = getBoardList(daoParam);
			
			viewData.put("boardList", boardList);
			viewData.put("startPage", getStartPage(page));
			viewData.put("endPage", getEndPage(page));
			viewData.put("totalPage", getTotalPage());
			viewData.put("page", page);
			
			
			System.out.println("리스트 길이 : "+boardList.size());
			System.out.println("서비스 -> viewData : " + viewData);
			
			return viewData;
		}

		@Override
		public Map<String, Object> getBoardByNum(int num) {
			return dao.selectOneByWithNum(num);
		}
	
	

}
