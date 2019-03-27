package com.raon.raondanim.service;

import java.math.BigDecimal;
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
	
	public List<Map<String, Object>> getUserList(Map<String, Object> params){
		
		List<Map<String, Object>> user = dao.getUserList(params);
		System.out.println("user : " + user);
		for(Map<String, Object> a : user) {
			
			String userNum = ((BigDecimal)a.get("USER_NUM")).toString();		
			
			// 유저 도시 정보 추가
			String userCity = null;
			if(dao.getUserCity(userNum) != null) {
				Map<String, Object> CityCountry = dao.getUserCity(userNum);
				String getCity = (String) CityCountry.get("CITY");
				userCity = getCity;
			}
			
			// 유저 언어 정보 추가
			List<Map<String, Object>> uesrLanguages = null;
			if(!dao.getUserLanguages(userNum).isEmpty()) {
				uesrLanguages = dao.getUserLanguages(userNum);
			}
			
			// 유저 여행스타일 정보 추가
			List<Map<String, Object>> userTravlestyles = null;
			if(!dao.getUserTravlestyles(userNum).isEmpty()) {
				userTravlestyles = dao.getUserTravlestyles(userNum);
			}	
			
			// 유저 관심사 정보 추가
			List<Map<String, Object>> userInterests = null;
			if(!dao.getUserInterests(userNum).isEmpty()) {
				userInterests = dao.getUserInterests(userNum);
			}
			
			a.put("city", userCity);
			a.put("languages", uesrLanguages);
			a.put("travlestyles", userTravlestyles);
			a.put("nationality", dao.getUserNationality(userNum));
			a.put("interests", userInterests);
			
		}
		return user;
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
		String city = (String) params.get("city");
		String language = (String) params.get("language");
		String travlestyle = (String) params.get("travlestyle");
		String name = (String) params.get("name");
		String nationality = (String) params.get("nationality");
		String gender = (String) params.get("gender");
		String interest = (String) params.get("interest");
		
		Map<String, Object> daoParam = new HashMap<String, Object>();
		
		if(city != null) {
			daoParam.put("city", city);
		}
		
		if(language != null) {
			daoParam.put("language", language);
		}
		
		if(travlestyle != null) {
			daoParam.put("travlestyle", travlestyle);
		}
		
		if(name != null) {
			daoParam.put("name", name);
		}
		
		if(nationality != null) {
			daoParam.put("nationality", nationality);
		}
		
		if(gender != null) {
			daoParam.put("gender", gender);
		}
		
		if(gender != null) {
			daoParam.put("interest", interest);
		}
		
		daoParam.put("firstRow", getFirstRow(page));
		daoParam.put("endRow", getEndRow(page));
		
		Map<String, Object> viewData = new HashMap<String, Object>();
		
		List<Map<String, Object>> userList = getUserList(daoParam);
		
		viewData.put("userList", userList);
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getTotalPage(daoParam));
		viewData.put("page", page);
		
		return viewData;
	}
	
}