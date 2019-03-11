package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.ReviewBoardDao;

@Service
public class ReviewBoardServiceImp implements ReviewBoardService{

	@Autowired
	private ReviewBoardDao dao;
	
	@Override
	public boolean insertReview(Map<String, Object> param) {
		System.out.println("서비스 -> 여행후기 작성");
		System.out.println(param);
		if(dao.insertReview(param)>0) {
			System.out.println("서비스 -> 여행후기 작성 성공");
			return true;
		} else {
			System.out.println("서비스 -> 여행후기 작성 실패");
			return false;
		}
	}

	@Override
	public boolean updateReview(Map<String, Object> params) {
		System.out.println("서비스 -> 여행후기 수정");
		if(dao.updateReview(params)>0) {
			System.out.println("서비스 -> 여행후기 수정 성공");
			return true;
		} else {		
			System.out.println("서비스 -> 여행후기 수정 실패");
			return false;
		}
	}

	@Override
	public boolean deleteReview(int num) {
		System.out.println("서비스 -> 여행후기 삭제");
		if(dao.deleteReview(num)>0) {
			System.out.println("서비스 -> 여행후기 삭제 성공");
			return true;
		} else {
			System.out.println("서비스 -> 여행후기 삭제 실패");
			return false;			
		}
	}

	@Override
	public Map<String, Object> selectOne(int num) {
		System.out.println("안녕!");
		System.out.println("asd : " + dao.selectOne(num));
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

//	@Override
//	public boolean checkPass(int num, String pass) {
//		Map<String, Object> board = dao.selectOne(num);
//		if(board.get())
//		return false;
//	}

}
