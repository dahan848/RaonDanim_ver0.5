package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

public interface ReviewBoardService {	
	public boolean insertReview(Map<String, Object> param);
	public boolean updateReview(Map<String, Object> params);
	public boolean deleteReview(int num);
	//user key를 가지고 user의 정보까지 포함한 정보 select
	public Map<String, Object> selectOne(int num);
	public List<Map<String, Object>> selectAll();
	//조회수 증가
	public Map<String, Object> plusReadCount(int num);
	public List<Map<String, Object>> getReviewBoard(int USER_NUM);
	//수정, 삭제 시 비밀번호 체크
//	public boolean checkPass(int num,String pass);
}
