package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

public interface MotelTbDAO {
	public List<Map<String,Object>> selectAll();
	public int insertMotel(Map<String, Object> param);
	public int updateMotel(Map<String, Object> param);
	public int deleteMotel(int num);
	public Map<String, Object> selectOne(int num);
	
	public List<Map<String, Object>> motelList(Map<String, Object>param);
	//게시글의 조회수를 1 증가시키는 메서드
	public int plusReadCount(int num);
	//전체 게시글 수 가져오는 메서드
	public int selectTotalCount(Map<String, Object>params);
	//댓글수
	public List<Map<String, Object>> replyCount();
	
	//첨부파일 이름 저장을 위한 메서드(uploadfile 테이블 사용)
	public int insertAttach(Map<String, Object>params);
	public Map<String, Object> selectAttach(int num);
	
	
	
	//숙박 게시글 상세정보(view화면용)
	public Map<String, Object> viewSelect(Map<String, Object>params);
	//숙박 게시글 댓글(view화면용)
	public List<Map<String, Object>>viewReply(Map<String, Object>params);
	//댓글 작성
	public int write_reply(Map<String, Object> params);
	//평점 등록
	public int starAvg(Map<String, Object>params);
	
	
	//모텔 병합중
	public List<Map<String, Object>> National_selectAll();
	public List<Map<String, Object>> City_selectAll();
	public int motel_insert(Map<String, Object> param);
	//숙소 사진 등록
	public int insertMotel_Photo(Map<String, Object> param);
	
	
}
