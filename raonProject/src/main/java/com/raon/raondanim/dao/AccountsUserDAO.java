package com.raon.raondanim.dao;

import java.util.Map;

import com.raon.raondanim.model.User;

public interface AccountsUserDAO {
	public int joinUser (User user); //회원가입
	public User selectByUserId (String UserId); //아이디로 유저 선택
	public User selectByUserNum (String userNum); //유저넘으로 유저 선택
	public int email_verify (User user); //이메일 인증 여부 설정
	public int updatePersonal(Map<String, Object> param); //개인설정에 필요한 데이터 업데이트
	public int passwordChange(Map<String, Object> param); //비밀번호 변경 
	public Map<String, Object> getUserInterest(String usernum); //번호로 유저 관심사 선택
	public Map<String, Object> getUserLanguage(String usernum); //번호로 유저 사용가능언어 선택 
}
