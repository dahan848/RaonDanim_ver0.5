package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AdminDAO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO dao;
	
	//잠금 상태의 계정 목록을 반환하는 ()
	public List<Map<String, Object>>getLockoutUserList() {
		//System.out.println(dao.getLockoutUserList());
		return dao.getLockoutUserList(); 
	}
	
	//잠금 상태의 유저의 잠금을 해제하는 ()
	public boolean userUnlock(int usernum) {
		if(dao.userUnlock(usernum) > 0) {
			return true;
		}else {
			return false;			
		}
	}

}
