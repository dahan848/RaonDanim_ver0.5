package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.TripBoard;
import com.raon.raondanim.model.TripCity;
import com.raon.raondanim.model.TripRel;


public interface TripBoardService {

	//입력메소드
	public boolean insertBoard(TripBoard tripBoard);
	//검색 메소드
	public TripBoard selectOneByBoardKey(int TripKey);
	public TripBoard selectOneByUserNum(int userNum);
	public List<TripBoard> selectAll();	
	//페이징관련 메소드
	public Map<String, Object> getTenBoardPage(Map<String, Object> params);
	public int getStartPage(int pageNum);
	public int getEndPage(int pageNum);
	public int getTotalPage(Map<String, Object> params);
	
	//도시관련 메소드
	public boolean insertCity(String tripCity);
	public List<TripCity> selectAllByCity();
	public List<Map<String, Object>> getListlatlng();
	
	//관계테이블 관련 메소드
	public boolean insertRel(TripRel tripRel);
	
	//기존 글쓰기 폐기 트랜잭션 이용 통합 글쓰기 
	public boolean totalWrite(TripBoard tripBoard, String tripCity);
	
	//게시판 상세화면용 메소드
	//게시판 상세화면용 유저 정보 , 게시판 정보 가지고있음 파라메터로 컨트롤러에서 보드키인지 유저키인지 정해서 넣어주는걸로
	public Map<String, Object> getTripBoardOneInfo(int boardKey);
	//링크드해시맵으로 순서 맞춰서 json으로 변경후 보내야함-맵에 마커찍는용
	public String getTripBoardCityOneInfo(int boardKey);
	public List<Map<String, Object>> getTripBoardCityTableList(int boardKey);
	
	//게시글 삭제를 위해 update 3개한번에할 메소드 boolean 값을 리턴  
	public boolean totalDelete(int boardKey);
	
	
	//게시판 수정 삭제용 비번체크
	public boolean pwCheck(String user_pwCheck, int boardKey);
	
	//게시판 테이블 update rel city 상태값 0으로 바꾼후 인설트
	public boolean totalUpdate(TripBoard tripBoard, String tripCity);
	
	
}
