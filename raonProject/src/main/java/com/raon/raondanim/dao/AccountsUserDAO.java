package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.User;

public interface AccountsUserDAO {

	public int setDnmmyData (User user);
	public int joinUser (User user); //회원가입
	public User selectByUserId (String UserId); //아이디로 유저 선택
	public User selectByUserNum (String userNum); //유저넘으로 유저 선택
	public int email_verify (User user); //이메일 인증 여부 설정
	public int updatePersonal(Map<String, Object> param); //개인설정에 필요한 데이터 업데이트
	public int passwordChange(Map<String, Object> param); //비밀번호 변경 
	public List<Map<String, Object>> getUserInterest(String usernum); //번호로 유저 관심사 선택
	public List<Map<String, Object>> getUserLanguage(String usernum); //번호로 유저 사용가능언어 선택
	public List<Map<String, Object>> getUserGallery(String usernum); //번호로 유저의 갤러리 정보 (사진넘, 사진이름, 등록일) 얻기
	public Map<String, Object> getUserCityCountry(String usernum); //번호로 유저 거주 도시 선택
	public String getUserNationality(String usernum); //번호로 유저 국적 선택 
	public List<Map<String, Object>> getHomeUserList (); //메인(홈) 화면 하단에 출력 될 유저리스트 (유저넘, 프로필픽, 유저 이름(lnm, fnm))
	public int setProfilePic(Map<String, Object> param); //프로필 사진 등록하는 ()
	public int setGalleryPic(Map<String, Object> param); //갤러리 사진 등록하는 ()
	public int deleteGalleryPic(String picnum);

	
	
	//======추가 프로필 관련 =======
	//userNum 기준으로 사용가능 언어 취미 여행스타일 출력
	public List<Map<String,Object>> selectUserLanguageNum(int userNum);
	public List<Map<String,Object>> selectUserInterestNum(int userNum);
	public List<Map<String,Object>> selectUserTripStyleNum(int userNum);
	
	public List<Map<String, Object>> userUseLanguage(int languageNum);
	
	//interest DBT 전부 가져오기
	public List<Map<String, Object>> getAll_Interest();
	//언어 DTB 불러오기 
	public List<Map<String, Object>> selectAllLanuage();
	//여행스타일 DTB 불러오기
	public List<Map<String, Object>> getAll_TripStyle();
	
	
	//사용가능 언어 Language_tb 테이블에 insert/delete 하기 
	public int insert_Language_tb(String languageNum, int userNum);
	public int delete_Language_tb(int userNum);
	//좋아하는 것 INTEREST_TB 테이블에 insert/delete 하기 
	public int insert_Interest_tb(String InterestNum, int userNum);
	public int delete_Interest_tb(int userNum);
	//여행스타일 TRAVLE_STYLE_TB 테이블에 insert/delete 하기 
	public int insert_trip_style_tb(String tripStyleNum, int userNum);
	public int delete_trip_style_tb(int userNum);
	
	//user_tb 에 USER_INTRO update 하기 
	public int user_intro_update(Map<String, Object> param);
	
	//user_tb 에 국적/나의 거주도시/ 전화번호 업데이트 하기
	public int user_city_nation_phoneNumber(Map<String, Object>param);
	
	//dashboard 작성 - 조현길
	public List<Map<String, Object>> trip_list(Map<String, Object>params);//dashboard 여행활동 탭 - 여행 작성글 리스트
	public int selectTotalCount(int num);//여행 게시글 토탈카운트
	public List<Map<String, Object>> trip_reply_list(Map<String, Object>params);//여행탭 여행 댓글 리스트 호출 
	public int selectReplyTotalCount(int num);//여행 댓글 토탈카운트


	public void passwordReset(Map<String, Object> param); //해당 아이디의 비밀번호를 초기화 하는 () 이메일과 초기화 된 비밀번호를 인자로 받는다. 
	public void setAdmin(User user);
	public double getMotelAvg(String usernum);
	public List<Map<String, Object>> motelNullCheck(String usernum);
	
	
	
	
	
	
	
	
	
	
	
	
	
	///////////////////////////////
	//여행파트 dao추가
	public List<Map<String, Object>> getTrStyle(String usernum); //번호로 유저 여행스타일 선택
	//public List<Map<String, Object>> getTravleHope(String usernum); //번호로 유저 희망국가 도시 선택
	public List<Map<String, Object>> getUserRegDate(); // 월별 가입일로 유저 총 갯수 뽑아오기 
	////////////////////////////////


}
