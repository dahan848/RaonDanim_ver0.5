package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.TripBoard;
import com.raon.raondanim.model.TripCity;
import com.raon.raondanim.model.TripRel;


public interface TripBoardDao {
	//입력메소드
	public int insertBoard(TripBoard tripBoard);
	//검색 메소드
	public TripBoard selectOneByBoardKey(int TripKey);
	public TripBoard selectOneByUserNum(int userNum);
	public List<TripBoard> selectAll();	
	//페이징관련 메소드
	public List<Map<String, Object>> getTenBoardPage(Map<String, Object> params);
	public int getTotalCount(Map<String, Object> params);
	/////////////////////////////////////////////
	//도시테이블 메소드
	public int insertCity(TripCity tripCity);
	//이거 안씀
	public TripCity selectOneByCity(Map<String, Object> params);
	public List<TripCity> selectAllByCity();
	//게시판 리스트 띄울때 맵에 마커찍을  위도경도가지는 메소드
	public List<Map<String, Object>> getListlatlng();

	////////////////////////////////////////////
	//관계테이블 메소드
	public int insertRel(TripRel tripRel);
	//관계 테이블 낀 조회 메소드는 테스트 데이터 집어놓고 나서 
	
	//게시판상세 화면용 메소드
	public Map<String, Object> getTripBoardOneInfo(int boardKey);
	public List<Map<String, Object>> getTripBoardCityOneInfo(int boardKey);
}
