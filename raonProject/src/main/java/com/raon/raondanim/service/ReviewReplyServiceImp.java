package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.ReviewReplyDao;

@Service
public class ReviewReplyServiceImp implements ReviewReplyService{

	@Autowired
	private ReviewReplyDao dao;
	
	@Override
	public List<Map<String, Object>> selectAll() {
		return dao.selectAll();
	}

	@Override
	public boolean insertReply(Map<String, Object> param) {
		System.out.println("서비스 -> 댓글입력");
		if(dao.insertReply(param) > 0) {
			System.out.println("서비스 -> 댓글 입력 성공");
			return true;
		} else {
			System.out.println("서비스 -> 댓글 입력 실패");
			return false;
		}
	}

	@Override
	public boolean updateReply(Map<String, Object> param) {
		System.out.println("서비스 -> 여행후기 댓글 수정");
		if(dao.updateReply(param)>0) {
			System.out.println("서비스 -> 여행후기 댓글 수정 성공");
			return true;
		} else {		
			System.out.println("서비스 -> 여행후기 댓글 수정 실패");
			return false;
		}
	}

	@Override
	public boolean deleteReply(int num) {
		System.out.println("서비스 -> 여행후기 댓글 삭제");
		if(dao.deleteReply(num)>0) {
			System.out.println("서비스 -> 여행후기 댓글 삭제 성공");
			return true;
		} else {
			System.out.println("서비스 -> 여행후기 댓글 삭제 실패");
			return false;			
		}
	}

	@Override
	public Map<String, Object> selectOne(int num) {
		return dao.selectOne(num);
	}

	@Override
	public Map<String, Object> selectByUserNum(int num) {
		return dao.selectByUserNum(num);
	}

	@Override
	public List<Map<String, Object>> getReviewReply(int num) {
		return dao.selectByReviewNum(num);
	}

	@Override
	public List<Map<String, Object>> getReviewReplyList(Map<String, Object> params) {
		return dao.replyList(params);
	}
	
}
