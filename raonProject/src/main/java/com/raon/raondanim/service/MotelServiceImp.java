package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.MotelDAO;

@Service
public class MotelServiceImp implements MotelService{

	@Autowired
	private MotelDAO dao;
	
	@Override
	public List<Map<String, Object>> getAllNational() {
		//System.out.println("service : " + dao.National_selectAll());
		return dao.National_selectAll();
	}

	@Override
	public List<Map<String, Object>> getAllCity() {
		// TODO Auto-generated method stub
		return dao.City_selectAll();
	}

}
