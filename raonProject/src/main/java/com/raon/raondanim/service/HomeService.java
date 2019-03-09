package com.raon.raondanim.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.model.User;

@Service
public class HomeService {

	@Autowired
	private AccountsUserDAO dao;
	private User user;
	
	//홈 화면에 출력 할 유저 리스트를 반환하는 () : 전체 회원 중 12명의 랜덤한 회원 리스트
	public List<Map<String, Object>> getHomeUserList(){
		//반환 할 List 변수 선언 및 DAO를 활용한 데이터 담기
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = dao.getHomeUserList();
		//System.out.println("홈 서비스 : " + list);
		
		//List 순서 랜덤하게 섞기 
		Collections.shuffle(list);
		//System.out.println("랜덤 섞기 : " + list);
		
		//반환 할  List 선언  
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		
		//반복문을 통한 12개의 회원 데이터 이전 list > result
		if(list.size()!=0) {
			for(int i=0; i < 12; i++) {
				result.add(i, list.get(i)); 
			}
		}
		
		
		//System.out.println(result + "리스트 길이 : " + result.size());
		
		return result;
	}
}
