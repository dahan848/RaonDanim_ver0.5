package com.raon.raondanim.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.SearchUserDAO;

@Service
public class SearchService {
	
	@Autowired
	private SearchUserDAO dao;
	
	private static final int NUM_OF_USER_PER_PAGE = 15;
	private static final int NUM_OF_NAVI_PAGE = 10;
	
	public List<Map<String, Object>> getCityList(){
		return dao.cityList();
	}
	
	public List<Map<String, Object>> getUserList(Map<String, Object> params){
		return dao.userList(params);
	}
	
	private int getFirstRow(int page) {
		int result = (page - 1) * NUM_OF_USER_PER_PAGE + 1;
		return result;
	}
	
	private int getEndRow(int page) {
		int result = ((page - 1) + 1) * NUM_OF_USER_PER_PAGE;
		return result;
	}
	
	private int getStartPage(int page) {
		int result = ((page - 1) / NUM_OF_NAVI_PAGE) * NUM_OF_NAVI_PAGE + 1;
		return result;
	}
	
	private int getEndPage(int page) {
		int result = getStartPage(page) + 9;
		return result;
	}
	
	private int getTotalPage(Map<String, Object> params) {
		int totalCount = dao.selectTotalCount(params);
		int totalPage = (totalCount - 1) / NUM_OF_USER_PER_PAGE + 1;
		return totalPage;
	}
	
	public Map<String, Object> getViewData(Map<String, Object> params){
		int page = (int) params.get("page");

		Map<String, Object> daoParam = new HashMap<String, Object>();
		daoParam.put("firstRow", getFirstRow(page));
		daoParam.put("endRow", getEndRow(page));
		
		Map<String, Object> viewData = new HashMap<String, Object>();
		
		List<Map<String, Object>> userList = getUserList(daoParam);
		List<Map<String, Object>> cityList = dao.cityList();
		
		viewData.put("cityList", cityList);
		viewData.put("userList", userList);
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getTotalPage(daoParam));
		viewData.put("page", page);
		
		return viewData;
	}
	
}