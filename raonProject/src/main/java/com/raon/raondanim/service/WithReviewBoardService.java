package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import org.omg.CORBA.MARSHAL;

import com.raon.raondanim.model.User;

public interface WithReviewBoardService {
	public boolean insertWith(Map<String, Object> param);
	public boolean updateWith(Map<String, Object> params);
	public boolean deleteWith(Map<String, Object> param);
	//TL_USER_NUM 으로 select
	public Map<String, Object> selectOne(int num);
	//WR_USER_NUM 으로 select
	public Map<String, Object> selectOneByWrUserNum(int num);
	//WITH_NUM 으로 select
	public Map<String, Object> selectWithOne(int num);
	public List<Map<String, Object>> selectAll();
	//조회수 증가
	public Map<String, Object> plusReadCount(int num);
	public List<Map<String, Object>> getWithBoard(int TL_USER_NUM);

	
	public User selectByUserNum(String num);
	
	//검색된 조건을 가지고 프로필 정보 출력
	public List<Map<String, Object>> getSearchUser(Map<String, Object> params);
	public Map<String, Object> getViewData(Map<String, Object> params);
	
	//----------------페이징----------------
	//네비게이션 표시 위한 정보 받기
	public Map<String, Object> getViewPagingData(Map<String, Object> params);
	//게시글 하나 정보 가져오기
	public Map<String, Object> getBoardByNum(int num);
	//페이지 번호 받아서 해당 목록 가져오기
	public List<Map<String, Object>> getBoardList(Map<String, Object> params);

	
}
