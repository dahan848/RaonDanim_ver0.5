package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

public interface WithReviewBoardService {
	public boolean insertWith(Map<String, Object> param);
	public boolean updateWith(Map<String, Object> params);
	public boolean deleteWith(int num);
	//USER_NUM 으로 select
	public Map<String, Object> selectOne(int num);
	//WITH_NUM 으로 select
	public Map<String, Object> selectWithOne(int num);
	public List<Map<String, Object>> selectAll();
	//조회수 증가
	public Map<String, Object> plusReadCount(int num);
	public List<Map<String, Object>> getWithBoard(int USER_NUM);
	//수정, 삭제 시 비밀번호 체크
//	public boolean checkPass(int num,String pass);
}
