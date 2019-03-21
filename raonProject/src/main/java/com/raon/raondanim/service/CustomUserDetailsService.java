package com.raon.raondanim.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.raon.raondanim.dao.UserAuthDAO;
import com.raon.raondanim.model.customUserDetails;

import org.springframework.security.core.userdetails.UserDetailsService;

public class CustomUserDetailsService implements UserDetailsService  {
	
    @Autowired
    private UserAuthDAO userAuthDao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//System.out.println("UserDetails 요청받음");
		customUserDetails user = userAuthDao.getUserById(username);
        if(user==null) {
            throw new UsernameNotFoundException(username);
        }
        return user;
    }
}