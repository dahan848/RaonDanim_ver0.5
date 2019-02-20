package com.raon.raondanim.model;

import java.util.Date;

public class User {
    //회원가입 때 입력 받거나 생성 되는 부분 : NOT NULL
	private int USER_NUM; 
    private String AUTHORITY; 
    private int ENABLED; 
    private String USER_ID;
    private String USER_PW; 
    private String USER_FNM; 
    private String USER_LNM; 
    private Date USER_REG_DATE;
    private String USER_VERIFY_CODE; //이메일 인증키 
    
    //로그인 관련 속성 
    private Date USER_LAST_LOGIN_TIME; 
    private Date USER_LAST_TRY_LOGIN_TIME; 
     
    //추가 프로필 입력부
    private String USER_NICK; 
    private String USER_NATION; 
    private String USER_CITY; 
    private String USER_PHONE_NUM; 
    private String USER_INTRO; //자기소개 
    private int USER_ACCOM_ST; //숙박 제공 여부 상태값  
    private Date USER_BIRTH_DATE; 
    private int USER_GENDER; 
    private String USER_PROFILE_PIC;
    
    //평점 및 포인트 속성 
    private int USER_WITH_AVG; 
    private int USER_MOTEL_AVG; 
    private int USER_POINT;
    
    //get/set
	public int getUSER_NUM() {
		return USER_NUM;
	}
	public void setUSER_NUM(int uSER_NUM) {
		USER_NUM = uSER_NUM;
	}
	public String getAUTHORITY() {
		return AUTHORITY;
	}
	public void setAUTHORITY(String aUTHORITY) {
		AUTHORITY = aUTHORITY;
	}
	public int getENABLED() {
		return ENABLED;
	}
	public void setENABLED(int eNABLED) {
		ENABLED = eNABLED;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getUSER_PW() {
		return USER_PW;
	}
	public void setUSER_PW(String uSER_PW) {
		USER_PW = uSER_PW;
	}
	public String getUSER_FNM() {
		return USER_FNM;
	}
	public void setUSER_FNM(String uSER_FNM) {
		USER_FNM = uSER_FNM;
	}
	public String getUSER_LNM() {
		return USER_LNM;
	}
	public void setUSER_LNM(String uSER_LNM) {
		USER_LNM = uSER_LNM;
	}
	public Date getUSER_REG_DATE() {
		return USER_REG_DATE;
	}
	public void setUSER_REG_DATE(Date uSER_REG_DATE) {
		USER_REG_DATE = uSER_REG_DATE;
	}
	public String getUSER_VERIFY_CODE() {
		return USER_VERIFY_CODE;
	}
	public void setUSER_VERIFY_CODE(String uSER_VERIFY_CODE) {
		USER_VERIFY_CODE = uSER_VERIFY_CODE;
	}
	public Date getUSER_LAST_LOGIN_TIME() {
		return USER_LAST_LOGIN_TIME;
	}
	public void setUSER_LAST_LOGIN_TIME(Date uSER_LAST_LOGIN_TIME) {
		USER_LAST_LOGIN_TIME = uSER_LAST_LOGIN_TIME;
	}
	public Date getUSER_LAST_TRY_LOGIN_TIME() {
		return USER_LAST_TRY_LOGIN_TIME;
	}
	public void setUSER_LAST_TRY_LOGIN_TIME(Date uSER_LAST_TRY_LOGIN_TIME) {
		USER_LAST_TRY_LOGIN_TIME = uSER_LAST_TRY_LOGIN_TIME;
	}
	public String getUSER_NICK() {
		return USER_NICK;
	}
	public void setUSER_NICK(String uSER_NICK) {
		USER_NICK = uSER_NICK;
	}
	public String getUSER_NATION() {
		return USER_NATION;
	}
	public void setUSER_NATION(String uSER_NATION) {
		USER_NATION = uSER_NATION;
	}
	public String getUSER_CITY() {
		return USER_CITY;
	}
	public void setUSER_CITY(String uSER_CITY) {
		USER_CITY = uSER_CITY;
	}
	public String getUSER_PHONE_NUM() {
		return USER_PHONE_NUM;
	}
	public void setUSER_PHONE_NUM(String uSER_PHONE_NUM) {
		USER_PHONE_NUM = uSER_PHONE_NUM;
	}
	public String getUSER_INTRO() {
		return USER_INTRO;
	}
	public void setUSER_INTRO(String uSER_INTRO) {
		USER_INTRO = uSER_INTRO;
	}
	public int getUSER_ACCOM_ST() {
		return USER_ACCOM_ST;
	}
	public void setUSER_ACCOM_ST(int uSER_ACCOM_ST) {
		USER_ACCOM_ST = uSER_ACCOM_ST;
	}
	public Date getUSER_BIRTH_DATE() {
		return USER_BIRTH_DATE;
	}
	public void setUSER_BIRTH_DATE(Date uSER_BIRTH_DATE) {
		USER_BIRTH_DATE = uSER_BIRTH_DATE;
	}
	public int getUSER_GENDER() {
		return USER_GENDER;
	}
	public void setUSER_GENDER(int uSER_GENDER) {
		USER_GENDER = uSER_GENDER;
	}
	public String getUSER_PROFILE_PIC() {
		return USER_PROFILE_PIC;
	}
	public void setUSER_PROFILE_PIC(String uSER_PROFILE_PIC) {
		USER_PROFILE_PIC = uSER_PROFILE_PIC;
	}
	public int getUSER_WITH_AVG() {
		return USER_WITH_AVG;
	}
	public void setUSER_WITH_AVG(int uSER_WITH_AVG) {
		USER_WITH_AVG = uSER_WITH_AVG;
	}
	public int getUSER_MOTEL_AVG() {
		return USER_MOTEL_AVG;
	}
	public void setUSER_MOTEL_AVG(int uSER_MOTEL_AVG) {
		USER_MOTEL_AVG = uSER_MOTEL_AVG;
	}
	public int getUSER_POINT() {
		return USER_POINT;
	}
	public void setUSER_POINT(int uSER_POINT) {
		USER_POINT = uSER_POINT;
	}
	
	//toString
	@Override
	public String toString() {
		return "User [USER_NUM=" + USER_NUM + ", AUTHORITY=" + AUTHORITY + ", ENABLED=" + ENABLED + ", USER_ID="
				+ USER_ID + ", USER_PW=" + USER_PW + ", USER_FNM=" + USER_FNM + ", USER_LNM=" + USER_LNM
				+ ", USER_REG_DATE=" + USER_REG_DATE + ", USER_VERIFY_CODE=" + USER_VERIFY_CODE
				+ ", USER_LAST_LOGIN_TIME=" + USER_LAST_LOGIN_TIME + ", USER_LAST_TRY_LOGIN_TIME="
				+ USER_LAST_TRY_LOGIN_TIME + ", USER_NICK=" + USER_NICK + ", USER_NATION=" + USER_NATION
				+ ", USER_CITY=" + USER_CITY + ", USER_PHONE_NUM=" + USER_PHONE_NUM + ", USER_INTRO=" + USER_INTRO
				+ ", USER_ACCOM_ST=" + USER_ACCOM_ST + ", USER_BIRTH_DATE=" + USER_BIRTH_DATE + ", USER_GENDER="
				+ USER_GENDER + ", USER_PROFILE_PIC=" + USER_PROFILE_PIC + ", USER_WITH_AVG=" + USER_WITH_AVG
				+ ", USER_MOTEL_AVG=" + USER_MOTEL_AVG + ", USER_POINT=" + USER_POINT + "]";
	}
}
