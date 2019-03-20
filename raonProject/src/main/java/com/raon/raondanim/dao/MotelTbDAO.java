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
	//평점 업데이트
	public int starUpdate(Map<String, Object>params);
	//평점 달았는지 하나 불러옴
	public Map<String, Object> starCheck(Map<String, Object>params);
	//숙소 예약시 motel_date_tb 상태값 N으로 변경 
	public int date_tb_update(Map<String, Object>params);
	//motel_date_tb 업데이트 후 중복 예약 방지 체크
	public int checkDate(Map<String, Object>params);
	//댓글 상태값 삭제로 변경
	public int deleteReply(Map<String, Object>params);
	//댓글 신고 내용 가져오기
	public List<Map<String, Object>> declaration();
	//신고테이블 insert
	public int insertDeclaration (Map<String, Object>params);
	//숙박글 신고 insert
	public int insert_motel_Declaration(Map<String, Object>params);
	//댓글 중복신고 방지 체크
	public Map<String, Object> insertDeclaration_check(Map<String, Object>params);
	//숙박글 중복신고 방지 체크
	public Map<String, Object>insert_motel_Declaration_check(Map<String, Object>params);
	//숙박글 삭제
	public int delete_motel(Map<String, Object>params);
	//이미지 가져오기 테스트
	public Map<String, Object> getImage(int motel_num);
	//숙소 결제시 host user 포인트 적립
	public int add_point(Map<String, Object>params);
	//숙소 결제시 결제 내역 insert
	public int pay_history_insert(Map<String, Object>params);
	
	
	//모텔 병합중
	public List<Map<String, Object>> National_selectAll();
	public List<Map<String, Object>> City_selectAll();
	public int motel_insert(Map<String, Object> param);
	//숙소 사진 등록
	public int insertMotel_Photo(Map<String, Object> param);
	// 숙박가능날짜  pl/sql 함수 실행
	public void motel_Date_procedure(Map<String, Object> motel_procedure);
	
}
