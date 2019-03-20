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
	public int deleteGalleryPic(String picnum); //갤러리 사진 삭제 ()
	

}
