package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.TripBoard;
import com.raon.raondanim.model.TripCity;
import com.raon.raondanim.model.TripRel;


public interface TripBoardDao {
	//입력메소드
	public int insertBoard(TripBoard tripBoard);
	//게시글 수정
	public int updateBoard(TripBoard tripBoard);
	//게시글 삭제
	public int deleteBoard(int boardKey);
	
	
	//보드키로 게시판 정보 검색
	public TripBoard selectOneByBoardKey(int TripKey);
	//유저넘으로 게시판 정보 검색
	public TripBoard selectOneByUserNum(int userNum);
	//게시판 정보 전부검색
	public List<TripBoard> selectAll();	
	
	//페이징관련 메소드
	public List<Map<String, Object>> getTenBoardPage(Map<String, Object> params);
	public int getTotalCount(Map<String, Object> params);
	/////////////////////////////////////////////
	
	//도시테이블 입력
	public int insertCity(TripCity tripCity);
/*	//도시 수정 -보류 - 안씀
	public int updateCity(TripCity tripCity);*/
	//도시 삭제
	public int deleteCity(int CityKey);
	
	//도시정보 뽑는 select메소드
	public List<Map<String, Object>> selectRelKeyAndCityKey(int boardKey);
	public List<TripCity> selectAllByCity();
	
	//게시판 리스트 띄울때 맵에 마커찍을  위도경도가지는 메소드
	public List<Map<String, Object>> getListlatlng();

	////////////////////////////////////////////
	//관계테이블 메소드
	public int insertRel(TripRel tripRel);
	public int deleteRel(int relKey);

	
	//게시판상세 화면용 메소드
	public Map<String, Object> getTripBoardOneInfo(int boardKey);
	public List<Map<String, Object>> getTripBoardCityOneInfo(int boardKey);
	
	//조회수 1증가
	public int incrementViews(int boardKey);
	
	
	//내가 동행신청 남긴 게시글 가져오기
	public List<Map<String, Object>> getMyDongHangList(String userNum);
	
	
	
	//신고 목록 불러오기
	public List<Map<String, Object>> getDeclaration();
	//신고내용 테이블 저장
	public int insertDeclaration(Map<String, Object> params);
	//이미신고한건지 알기위해 조회
	public Map<String, Object> selectOneByDeclaration(Map<String, Object> params);
	
	//더미데이터 추가 
	public int insertDummyData(Map<String, Object> tripBoard);
	
	
	//월별 게시글 작성수
	public List<Integer> getMonthWriteData();
	//여행 게시판 게시글 총게시글수와 신고수 선택
	public Map<String, Integer> getBoardAndDeclatation();
	
}
