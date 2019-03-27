package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

public interface WithReviewBoardDao {
	public List<Map<String, Object>> selectAll();
	
	public int insertWith(Map<String, Object> param);
	public int updateWith(Map<String, Object> param);
	public int deleteWith(int num);
	
	//타임라인 주인 TL_USER_NUM 으로 select
	public Map<String, Object> selectOne(int num);
	//타임라인에 글쓴 사람 WR_USER_NUM 으로 select
	public Map<String, Object> selectOneByWrUserNum(int num);
	//WITH_NUM으로 select
	public Map<String, Object> selectWithOne(int num);						
	
	
	public List<Map<String, Object>> selectByUserNum(int USER_NUM);
	
	//조회수 +1
	public int plusReadCount(int num);
	
	//검색
	public List<Map<String, Object>> searchUser(Map<String, Object> param);
	
	//페이징
	public List<Map<String, Object>> boardList(Map<String, Object> param);
	public int selectTotalCount();
	public Map<String, Object> selectOneByWithNum(int num);
	
	//별점 계산 계산 식
	public int avgStar(int TL_USER_NUM);
	//별점 계산 시 NULL 잡아줌
	public List<Map<String, Object>> avgStarNullCheck(int TL_USER_NUM);
}
