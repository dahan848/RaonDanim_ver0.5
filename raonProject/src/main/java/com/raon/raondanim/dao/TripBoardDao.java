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
/*	//도시 수정 -보류
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
	

}
