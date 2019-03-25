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
//		System.out.println("서비스 -> 여행후기 작성");
//		System.out.println(param);
		if(dao.insertReview(param)>0) {
//			System.out.println("서비스 -> 여행후기 작성 성공");
			return true;
		} else {
//			System.out.println("서비스 -> 여행후기 작성 실패");
			return false;
		}
	}

	@Override
	public boolean updateReview(Map<String, Object> params) {
//		System.out.println("서비스 -> 여행후기 수정");
		
//		System.out.println("서비스 동행 수정 params : " + params);

		String numStr = String.valueOf(params.get("num"));
		int num = Integer.parseInt(numStr);			// num = REVIEW_NUM
		
		//System.out.println("서비스 여행 수정 REVIEW_NUM : " + num);
		
		String userNum = String.valueOf(params.get("userNum"));  //로그인한 USER_NUM
		
		//System.out.println("서비스 동행 수정 로그인한 USER_NUM : " + userNum);
		
		Map<String, Object> review = dao.selectReviewOne(num);
		
		String user_Num =  String.valueOf(review.get("USER_NUM"));
		
		if(user_Num.equals(userNum)) {
			System.out.println("USER_NUM 같음");
			if(dao.updateReview(params)>0) {
				System.out.println("서비스 -> 여행후기 수정 성공");
				return true;
			} else {		
				System.out.println("서비스 -> 여행후기 수정 실패");
				return false;
			}
		} else {
			System.out.println("USER_NUM 다름");
			return false;
		}
	}

	@Override
	public boolean deleteReview(Map<String, Object> param) {
		
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		
		System.out.println("서비스 -> 여행후기 삭제");
		System.out.println("서비스 삭제 param : " + param);
		
		String input_pass = String.valueOf(param.get("input_pass"));
		
		String numStr = String.valueOf(param.get("num"));
		int num = Integer.parseInt(numStr);			// num = REVIEW_NUM
		
		String userNum = String.valueOf(param.get("userNum"));
		
		Map<String, Object> review = dao.selectReviewOne(num);
//		System.out.println("서비스 삭제 Map : " + review);
		
//		System.out.println("userNum : " + userNum);
//		System.out.println("USER_NUM : " + review.get("USER_NUM"));
//		System.out.println("USER_PW : " + review.get("USER_PW"));
//		System.out.println("input_pass : " + input_pass);
		
		String user_Num =  String.valueOf(review.get("USER_NUM"));
		String user_Pw =  String.valueOf(review.get("USER_PW"));
		
		
		if(user_Num.equals(userNum)) {
//			System.out.println("num 같음");
			if(encoder.matches(input_pass, user_Pw)){
//				System.out.println("서비스 -> 비밀번호 같음");
				if(dao.deleteReview(num)>0) {
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
