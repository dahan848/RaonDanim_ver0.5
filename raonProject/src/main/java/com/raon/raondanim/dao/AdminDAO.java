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
	public int updateInquiryAnswer(String INQUIRY_NUM); //문의글 답변 상태 업데이트 
	public Map<String, Object> selectInquiry(String INQUIRY_NUM); //문의글 번호로 해당 글 정보 얻기 (메일 발송을 위한)

	//여행 게시글 목록 출력
	public List<Map<String, Object>> getDeclarationBoard(Map<String, Object> params);
	public int getTripboardTotalCount();
	
	//숙박 신고 게시글 출력
	public List<Map<String, Object>> getMotelDeclarationList(Map<String, Object> params);
	public int getMotelTotalCount();

	//숙박 신고 댓글 출력
	public List<Map<String, Object>> getMotelReplyDeclarationList(Map<String, Object> params);
	public int getMotelReplyTotalCount();
	
}
