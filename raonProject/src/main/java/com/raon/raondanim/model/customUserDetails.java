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
    private String user_pw;
    private String AUTHORITY;
    private boolean ENABLED;
    private String NAME;
    //회원 DB에 있는 칼럼 
    private int user_num; 		//KEY값
    private String user_id; 	//이메일주소
    private String user_fnm;	//이름
    private String user_lnm;	//성
    private Date user_reg_date; //가입일
    private Date user_last_login_time;	 	//마지막 로그인 
    private Date user_last_try_login_time;	//마지막 로그인 시도
    private int user_failure_cnt; //로그인 실패 회수
    private String user_verify_code; //이메일 인증코드
    private int user_email_verify; 	 // 이메일 인증유무
    private int user_profile_st;	 //추가 프로필 작성 유무 
    
    
    private String user_nick;	//닉네임 
    private String user_nation; //거주 국가
    private String user_city; 	//거주 도시
    private String user_phone_num; 	//전화번호 
    private int user_accom_st;		//숙박 제공 여부 상태값  
    private Date user_birth_date;	//생년월일 
    private int user_gender; 		//성별
    private String user_profile_pic;//프로필 사진  디폴트 'n'
    
    private int user_with_avg;		//동행후기 평점 
    private int user_motel_avg; 	//숙박 평점
    private int user_point;			//숙박 포인트 
    
    
    
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
        ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
        auth.add(new SimpleGrantedAuthority(AUTHORITY));
        return auth;
	}

	@Override
	public String getPassword() {
		return user_pw;
	}

	@Override
	public String getUsername() {
		this.NAME = getUser_lnm() + " " + getUser_fnm();
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
	
	

	public int getUser_num() {
		return user_num;
	}

	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
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

	public int getUser_failure_cnt() {
		return user_failure_cnt;
	}

	public void setUser_failure_cnt(int user_failure_cnt) {
		this.user_failure_cnt = user_failure_cnt;
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

	public String getUser_nick() {
		return user_nick;
	}

	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
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

	
	//toString
	@Override
	public String toString() {
		return "customUserDetails [user_pw=" + user_pw + ", AUTHORITY=" + AUTHORITY + ", ENABLED=" + ENABLED + ", NAME="
				+ NAME + ", user_num=" + user_num + ", user_id=" + user_id + ", user_fnm=" + user_fnm + ", user_lnm="
				+ user_lnm + ", user_reg_date=" + user_reg_date + ", user_last_login_time=" + user_last_login_time
				+ ", user_last_try_login_time=" + user_last_try_login_time + ", user_failure_cnt=" + user_failure_cnt
				+ ", user_verify_code=" + user_verify_code + ", user_email_verify=" + user_email_verify
				+ ", user_profile_st=" + user_profile_st + ", user_nick=" + user_nick + ", user_nation=" + user_nation
				+ ", user_city=" + user_city + ", user_phone_num=" + user_phone_num + ", user_accom_st=" + user_accom_st
				+ ", user_birth_date=" + user_birth_date + ", user_gender=" + user_gender + ", user_profile_pic="
				+ user_profile_pic + ", user_with_avg=" + user_with_avg + ", user_motel_avg=" + user_motel_avg
				+ ", user_point=" + user_point + "]";
	}
}
