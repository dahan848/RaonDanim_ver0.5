package com.raon.raondanim.model;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@SuppressWarnings("serial")
public class customUserDetails implements UserDetails {

    private String EMAIL;
    private String PASS;
    private String AUTHORITY;
    private boolean ENABLED;
    private String NAME;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
        ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
        auth.add(new SimpleGrantedAuthority(AUTHORITY));
        return auth;
	}

	@Override
	public String getPassword() {
		return PASS;
	}

	@Override
	public String getUsername() {
		return NAME;
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

	
	//해당 클래스에서 오버라이드 되지 않는, DB상의 데이터 겟터 셋터
	public String getEMAIL() {
		return EMAIL;
	}

	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}

	@Override
	public String toString() {
		return "customUserDetails [EMAIL=" + EMAIL + ", PASS=" + PASS + ", AUTHORITY=" + AUTHORITY + ", ENABLED="
				+ ENABLED + ", NAME=" + NAME + "]";
	}
	
	
	
}
