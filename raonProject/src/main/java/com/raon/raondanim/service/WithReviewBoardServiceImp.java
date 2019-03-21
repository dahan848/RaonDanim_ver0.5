package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.dao.WithReviewBoardDao;
import com.raon.raondanim.model.User;

@Service
public class WithReviewBoardServiceImp implements WithReviewBoardService{
	
	@Autowired
	private WithReviewBoardDao dao;
	
	@Autowired
	private AccountsUserDAO userDao;
	
	@Override
	public boolean insertWith(Map<String, Object> param) {
		System.out.println("서비스 -> 동행후기 작성");
		System.out.println(param);
		if(dao.insertWith(param)>0) {
			System.out.println("서비스 -> 동행후기 작성 성공");
			return true;
		} else {
			System.out.println("서비스 -> 동행후기 작성 실패");
			return false;
		}
	}

	@Override
	public boolean updateWith(Map<String, Object> params) {
		System.out.println("서비스 -> 동행후기 수정");
		if(dao.updateWith(params)>0) {
			System.out.println("서비스 -> 동행후기 수정 성공");
			return true;
		} else {		
			System.out.println("서비스 -> 동행후기 수정 실패");
			return false;
		}
	}

	@Override
	public boolean deleteWith(int num) {
		System.out.println("서비스 -> 동행후기 삭제");
		if(dao.deleteWith(num)>0) {
			System.out.println("서비스 -> 동행후기 삭제 성공");
			return true;
		} else {
			System.out.println("서비스 -> 동행후기 삭제 실패");
			return false;			
		}
	}

	@Override
	public Map<String, Object> selectOne(int num) {
		return dao.selectOne(num);
	}

	@Override
	public Map<String, Object> selectWithOne(int num) {
		return dao.selectWithOne(num);
	}

	@Override
	public List<Map<String, Object>> selectAll() {
		return dao.selectAll();
	}

	@Override
	public Map<String, Object> plusReadCount(int num) {
		dao.plusReadCount(num);
		return dao.selectOne(num);
	}

	@Override
	public List<Map<String, Object>> getWithBoard(int TL_USER_NUM) {
		return dao.selectByUserNum(TL_USER_NUM);
	}

	@Override
	public User selectByUserNum(String num) {
		return userDao.selectByUserNum(num);
	}
	
	

}
