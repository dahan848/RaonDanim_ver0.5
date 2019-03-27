package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.ReviewBoardDao;

@Service
public class ReviewBoardServiceImp implements ReviewBoardService{

	@Autowired
	private ReviewBoardDao dao;
	
	@Override
	public boolean insertReview(Map<String, Object> param) {

		if(dao.insertReview(param)>0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean updateReview(Map<String, Object> params) {

		// num = REVIEW_NUM
		String numStr = String.valueOf(params.get("num"));
		int num = Integer.parseInt(numStr);			
		
		//로그인한 USER_NUM
		String userNum = String.valueOf(params.get("userNum"));  
		
		Map<String, Object> review = dao.selectReviewOne(num);
		
		String user_Num =  String.valueOf(review.get("USER_NUM"));
		
		if(user_Num.equals(userNum)) {
			if(dao.updateReview(params)>0) {
				return true;
			} else {		
				return false;
			}
		} else {
			return false;
		}
	}

	@Override
	public boolean deleteReview(Map<String, Object> param) {
		
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		
		String input_pass = String.valueOf(param.get("input_pass"));
		
		// num = REVIEW_NUM
		String numStr = String.valueOf(param.get("num"));
		int num = Integer.parseInt(numStr);			
		
		String userNum = String.valueOf(param.get("userNum"));
		
		Map<String, Object> review = dao.selectReviewOne(num);
		
		String user_Num =  String.valueOf(review.get("USER_NUM"));
		String user_Pw =  String.valueOf(review.get("USER_PW"));
		
		
		if(user_Num.equals(userNum)) {
			if(encoder.matches(input_pass, user_Pw)){
				if(dao.deleteReview(num)>0) {
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
	public List<Map<String, Object>> selectAll() {
		return dao.selectAll();
	}

	@Override
	public Map<String, Object> plusReadCount(int num) {
		dao.plusReadCount(num);
		return dao.selectOne(num);
	}

	@Override
	public List<Map<String, Object>> getReviewBoard(int USER_NUM) {
		return dao.selectByUserNum(USER_NUM);
	}

	@Override
	public Map<String, Object> selectReviewOne(int num) {
		return dao.selectReviewOne(num);
	}

}
