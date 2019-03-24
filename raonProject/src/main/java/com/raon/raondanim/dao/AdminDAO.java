package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

public interface AdminDAO {
	public List<Map<String, Object>> getLockoutUserList(); //계정 비활성화  (enabled 칼럼 값이 0) 인 유저 목록
	public int userUnlock(int usernum); //비활성화 된 계정을 활성화 시키는 dao
	public int insertInquiry (Map<String, Object>param); //문의글을 DB에 넣는 ()
	public int selectInquiryTotalCount (Map<String, Object>param); //페이징을 위한 () 조건에 따른 총 게시물 개수
	public List<Map<String, Object>> InquiryList(Map<String, Object> param); //페이징 처리와 검색 처리가 완료된 List()
	public int insertDummyInquiry(Map<String, Object> param); //문의글 더미데이터 생성
	public int insertAnswer (Map<String, Object>param); //특정 문의 글에 답변 넣기
	public int updateInquiryAnswer(String INQUIRY_NUM);
}
