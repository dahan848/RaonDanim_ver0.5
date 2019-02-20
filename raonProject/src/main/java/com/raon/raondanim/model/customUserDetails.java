package com.raon.raondanim.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@SuppressWarnings("serial")
public class customUserDetails implements UserDetails {
	
	//스프링 시큐리티 기본 요구 변수 
    private String USER_PW;
    private String AUTHORITY;
    private boolean ENABLED;
    private String NAME;
    //회원 DB에 있는 칼럼 
    private int USER_NUM; 		//KEY값
    private String USER_ID; 	//이메일주소
    private String USER_FNM;	//이름
    private String USER_LNM;	//성
    private Date USER_REG_DATE; //가입일
    private Date USER_LAST_LOGIN_TIME;	 	//마지막 로그인 
    private Date USER_LAST_TRY_LOGIN_TIME;	//마지막 로그인 시도
    private String USER_NICK;	//닉네임 
    private String USER_NATION; //거주 국가
    private String USER_CITY; 	//거주 도시
    private String USER_PHONE_NUM; 	//전화번호 
    private int USER_ACCOM_ST;		//숙박 제공 여부 상태값  
    private Date USER_BIRTH_DATE;	//생년월일 
    private int USER_GENDER; 		//성별
    private String USER_PROFILE_PIC;//프로필 사진 
    private int USER_WITH_AVG;		//동행후기 평점 
    private int USER_MOTEL_AVG; 	//숙박 평점
    private int USER_POINT;			//숙박 포인트 
    
    
    
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
        ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
        auth.add(new SimpleGrantedAuthority(AUTHORITY));
        return auth;
	}

	@Override
	public String getPassword() {
		return USER_PW;
	}

	@Override
	public String getUsername() {
		this.NAME = getUSER_LNM() +" "+getUSER_FNM();
		return this.NAME;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}


	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return ENABLED;
	}

	
	//추가 유저 정보 겟터/셋터 
	public int getUSER_NUM() {
		return USER_NUM;
	}

	public void setUSER_NUM(int uSER_NUM) {
		USER_NUM = uSER_NUM;
	}

	public String getUSER_ID() {
		return USER_ID;
	}

	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
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
		return "customUserDetails [USER_PW=" + USER_PW + ", AUTHORITY=" + AUTHORITY + ", ENABLED=" + ENABLED + ", NAME="
				+ NAME + ", USER_NUM=" + USER_NUM + ", USER_ID=" + USER_ID + ", USER_FNM=" + USER_FNM + ", USER_LNM="
				+ USER_LNM + ", USER_REG_DATE=" + USER_REG_DATE + ", USER_LAST_LOGIN_TIME=" + USER_LAST_LOGIN_TIME
				+ ", USER_LAST_TRY_LOGIN_TIME=" + USER_LAST_TRY_LOGIN_TIME + ", USER_NICK=" + USER_NICK
				+ ", USER_NATION=" + USER_NATION + ", USER_CITY=" + USER_CITY + ", USER_PHONE_NUM=" + USER_PHONE_NUM
				+ ", USER_ACCOM_ST=" + USER_ACCOM_ST + ", USER_BIRTH_DATE=" + USER_BIRTH_DATE + ", USER_GENDER="
				+ USER_GENDER + ", USER_PROFILE_PIC=" + USER_PROFILE_PIC + ", USER_WITH_AVG=" + USER_WITH_AVG
				+ ", USER_MOTEL_AVG=" + USER_MOTEL_AVG + ", USER_POINT=" + USER_POINT + "]";
	}
}
