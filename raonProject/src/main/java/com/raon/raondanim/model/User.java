package com.raon.raondanim.model;

import java.util.Date;

public class User {
    //회원가입 때 입력 받거나 생성 되는 부분 : : NOT NUUL
	private int user_num; 
    private String authority; 
    private int enabled; 
    private String user_id; //이메일 주소
    private String user_pw; 
    private String user_fnm; 
    private String user_lnm; 
    private Date user_reg_date; //가입일
    
    //로그인 및 인증과 관련된 변수 
    private Date user_last_login_time; 
    private Date user_last_try_login_time; 
    private int user_failure_count; //로그인 실패 회수
    private String user_verify_code; //이메일 인증키
    
    //회원의 상태 관련 변수 
    private int user_email_verify; //이메일 인증 유/무 default 0 (거짓)
    private int user_profile_st; //추가 프로필 작성 유/무 default 0 (거짓)
    
    //추가 프로필 입력부
    private String user_nationality; //국적
    private String user_nation; 
    private String user_city; 
    private String user_phone_num; 
    private String user_intro; //자기소개 
    private int user_accom_st; //숙박 제공 여부 default0(불가) 가능1 무료2 유료3
    private Date user_birth_date; 
    private int user_gender; 
    private String user_profile_pic; // 프로필 사진 default 'n' (없음을 표시)
    
    //평점 및 포인트 속성 
    private int user_with_avg; 
    private int user_motel_avg; 
    private int user_point;
    
    
    //get,set
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_fnm() {
		return user_fnm;
	}
	public void setUser_fnm(String user_fnm) {
		this.user_fnm = user_fnm;
	}
	public String getUser_lnm() {
		return user_lnm;
	}
	public void setUser_lnm(String user_lnm) {
		this.user_lnm = user_lnm;
	}
	public Date getUser_reg_date() {
		return user_reg_date;
	}
	public void setUser_reg_date(Date user_reg_date) {
		this.user_reg_date = user_reg_date;
	}
	public Date getUser_last_login_time() {
		return user_last_login_time;
	}
	public void setUser_last_login_time(Date user_last_login_time) {
		this.user_last_login_time = user_last_login_time;
	}
	public Date getUser_last_try_login_time() {
		return user_last_try_login_time;
	}
	public void setUser_last_try_login_time(Date user_last_try_login_time) {
		this.user_last_try_login_time = user_last_try_login_time;
	}
	public int getUser_failure_count() {
		return user_failure_count;
	}
	public void setUser_failure_count(int user_failure_count) {
		this.user_failure_count = user_failure_count;
	}
	public String getUser_verify_code() {
		return user_verify_code;
	}
	public void setUser_verify_code(String user_verify_code) {
		this.user_verify_code = user_verify_code;
	}
	public int getUser_email_verify() {
		return user_email_verify;
	}
	public void setUser_email_verify(int user_email_verify) {
		this.user_email_verify = user_email_verify;
	}
	public int getUser_profile_st() {
		return user_profile_st;
	}
	public void setUser_profile_st(int user_profile_st) {
		this.user_profile_st = user_profile_st;
	}
	public String getUser_nation() {
		return user_nation;
	}
	public void setUser_nation(String user_nation) {
		this.user_nation = user_nation;
	}
	public String getUser_city() {
		return user_city;
	}
	public void setUser_city(String user_city) {
		this.user_city = user_city;
	}
	public String getUser_phone_num() {
		return user_phone_num;
	}
	public void setUser_phone_num(String user_phone_num) {
		this.user_phone_num = user_phone_num;
	}
	public String getUser_intro() {
		return user_intro;
	}
	public void setUser_intro(String user_intro) {
		this.user_intro = user_intro;
	}
	public int getUser_accom_st() {
		return user_accom_st;
	}
	public void setUser_accom_st(int user_accom_st) {
		this.user_accom_st = user_accom_st;
	}
	public Date getUser_birth_date() {
		return user_birth_date;
	}
	public void setUser_birth_date(Date user_birth_date) {
		this.user_birth_date = user_birth_date;
	}
	public int getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(int user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_profile_pic() {
		return user_profile_pic;
	}
	public void setUser_profile_pic(String user_profile_pic) {
		this.user_profile_pic = user_profile_pic;
	}
	public int getUser_with_avg() {
		return user_with_avg;
	}
	public void setUser_with_avg(int user_with_avg) {
		this.user_with_avg = user_with_avg;
	}
	public int getUser_motel_avg() {
		return user_motel_avg;
	}
	public void setUser_motel_avg(int user_motel_avg) {
		this.user_motel_avg = user_motel_avg;
	}
	public int getUser_point() {
		return user_point;
	}
	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}
	public String getUser_nationality() {
		return user_nationality;
	}
	public void setUser_nationality(String user_nationality) {
		this.user_nationality = user_nationality;
	}
	//toString
	@Override
	public String toString() {
		return "User [user_num=" + user_num + ", authority=" + authority + ", enabled=" + enabled + ", user_id="
				+ user_id + ", user_pw=" + user_pw + ", user_fnm=" + user_fnm + ", user_lnm=" + user_lnm
				+ ", user_reg_date=" + user_reg_date + ", user_last_login_time=" + user_last_login_time
				+ ", user_last_try_login_time=" + user_last_try_login_time + ", user_failure_count="
				+ user_failure_count + ", user_verify_code=" + user_verify_code + ", user_email_verify="
				+ user_email_verify + ", user_profile_st=" + user_profile_st + ", user_nationality=" + user_nationality
				+ ", user_nation=" + user_nation + ", user_city=" + user_city + ", user_phone_num=" + user_phone_num
				+ ", user_intro=" + user_intro + ", user_accom_st=" + user_accom_st + ", user_birth_date="
				+ user_birth_date + ", user_gender=" + user_gender + ", user_profile_pic=" + user_profile_pic
				+ ", user_with_avg=" + user_with_avg + ", user_motel_avg=" + user_motel_avg + ", user_point="
				+ user_point + "]";
	}
}
