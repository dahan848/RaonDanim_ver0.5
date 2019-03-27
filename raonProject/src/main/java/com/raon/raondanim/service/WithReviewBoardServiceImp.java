package com.raon.raondanim.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
		System.out.println("서비스 -> 동행후기 작성");
		System.out.println(param);
		if(dao.insertWith(param)>0) {
			System.out.println("서비스 -> 동행후기 작성 성공");
			return true;
		} else {
			System.out.println("서비스 -> 동행후기 작성 실패");
			return false;
		}
	}

	@Override
	public boolean updateWith(Map<String, Object> params) {
		System.out.println("서비스 -> 동행후기 수정");
		if(dao.updateWith(params)>0) {
			System.out.println("서비스 -> 동행후기 수정 성공");
			return true;
		} else {		
			System.out.println("서비스 -> 동행후기 수정 실패");
			return false;
		}
	}

	@Override
	public boolean deleteWith(Map<String, Object> param) {
		
//		System.out.println("서비스 -> 여행후기 삭제");
//		System.out.println("서비스 삭제 param : " + param);
		
		//입력한 비밀번호
		String input_pass = String.valueOf(param.get("input_pass"));
		//게시글 번호
		String numStr = String.valueOf(param.get("num"));
		int num = Integer.parseInt(numStr);			// num = WITH_NUM 
		//로그인한 USER_NUM
		String userNum = String.valueOf(param.get("userNum"));
		
		Map<String, Object> with = dao.selectWithOne(num);
//		System.out.println("서비스 삭제 Map : " + review);
		
//		System.out.println("userNum : " + userNum);
//		System.out.println("USER_NUM : " + with.get("USER_NUM"));
//		System.out.println("USER_PW : " + with.get("USER_PW"));
//		System.out.println("input_pass : " + input_pass);
		
		String user_Num =  String.valueOf(with.get("USER_NUM"));
		String user_Pw =  String.valueOf(with.get("USER_PW"));
		
		
		if(user_Num.equals(userNum)) {
//			System.out.println("num 같음");
			if(user_Pw.equals(input_pass)){
//				System.out.println("서비스 -> 비밀번호 같음");
				if(dao.deleteWith(num)>0) {
//					System.out.println("서비스 -> 여행후기 삭제 성공");
					return true;
				} else {
//					System.out.println("서비스 -> 여행후기 삭제 실패");
					return false;
				}
			} else {
//				System.out.println("서비스 -> 비밀번호 다름");
				return false;
			}
		} else {
//			System.out.println("num 다름");
			return false;
		}
	}

	@Override
	public Map<String, Object> selectOne(int num) {
		return dao.selectOne(num);
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
	
	//유저 검색
	@Override
	public List<Map<String, Object>> getSearchUser(Map<String, Object> params) {
		return dao.searchUser(params);
	}

	@Override
	public Map<String, Object> getViewData(Map<String, Object> params) {
		
		String keyword = (String)params.get("keyword");
		
		int type = (int)params.get("type");
		
		Map<String, Object> daoParam = new HashMap<String, Object>();
		
		daoParam.put("type", type);
		
		if(type == 1) {
			daoParam.put("USER_LNM", keyword);
			daoParam.put("USER_FNM", keyword);
		} else if(type == 2) {
			daoParam.put("USER_ID", keyword);
		}
		
		Map<String, Object> viewData = new HashMap<String, Object>();
		
		List<Map<String, Object>> searchList = getSearchUser(daoParam);
		viewData.put("searchList", searchList);
		
		return viewData;
	}
	
	

}
