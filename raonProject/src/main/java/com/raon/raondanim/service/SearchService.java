package com.raon.raondanim.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.SearchUserDAO;
import com.raon.raondanim.model.User;

@Service
public class SearchService {
	
	@Autowired
	private SearchUserDAO dao;
	
	private static final int NUM_OF_USER_PER_PAGE = 15;
	private static final int NUM_OF_NAVI_PAGE = 10;
	
	public List<Map<String, Object>> getUserList(Map<String, Object> params){
			
		List<Map<String, Object>> user = dao.getUserList(params);
		for(Map<String, Object> a : user) {
			
			String userNum = ((BigDecimal)a.get("USER_NUM")).toString();		
			
			// 유저 도시 정보 추가
			String city = null;
			if(dao.getUserCity(userNum) != null) {
				Map<String, Object> CityCountry = dao.getUserCity(userNum);
				String UserCity = (String) CityCountry.get("CITY");
				city = UserCity;
			}
			
			// 유저 언어 정보 추가
			List<Map<String, Object>> languages = null;
			if(!dao.getUserLanguages(userNum).isEmpty()) {
				languages = dao.getUserLanguages(userNum);
			}
			
			// 유저 여행스타일 정보 추가
			List<Map<String, Object>> travlestyles = null;
			if(!dao.getUserTravlestyles(userNum).isEmpty()) {
				travlestyles = dao.getUserTravlestyles(userNum);
			}	
			
			// 유저 관심사 정보 추가
			List<Map<String, Object>> interests = null;
			if(!dao.getUserInterests(userNum).isEmpty()) {
				interests = dao.getUserInterests(userNum);
			}
			
			a.put("city", city);
			a.put("languages", languages);
			a.put("travlestyles", travlestyles);
			a.put("nationality", dao.getUserNationality(userNum));
			a.put("interests", interests);
			
		}
		return user;
	}
	
	public List<Map<String, Object>> SearchByLanguageList(String language){
		
		List<Map<String, Object>> user = dao.searchByLanguage(language);
		
		System.out.println("user : " + user);
		
		for(Map<String, Object> a : user) {
			
			String userNum = ((BigDecimal)a.get("USER_NUM")).toString();
			
			String fnm = null;
			String lnm = null;
			int gender = 0;
			
			if(dao.selectByUserNum(userNum) != null) {
				User selectUser = dao.selectByUserNum(userNum);
				fnm = selectUser.getUser_fnm();
				lnm = selectUser.getUser_lnm();
				gender = selectUser.getUser_gender();
			}
			
			String city = null;
			if(dao.getUserCity(userNum) != null) {
				Map<String, Object> CityCountry = dao.getUserCity(userNum);
				String UserCity = (String) CityCountry.get("CITY");
				city = UserCity;
			}
			
			List<Map<String, Object>> travlestyles = null;
			if(!dao.getUserTravlestyles(userNum).isEmpty()) {
				travlestyles = dao.getUserTravlestyles(userNum);
			}
			
			List<Map<String, Object>> interests = null;
			if(!dao.getUserInterests(userNum).isEmpty()) {
				interests = dao.getUserInterests(userNum);
			}
			
			a.put("USER_FNM", fnm);
			a.put("USER_LNM", lnm);
			a.put("USER_GENDER", gender);
			a.put("city", city);
			a.put("travlestyles", travlestyles);
			a.put("nationality", dao.getUserNationality(userNum));
			a.put("interests", interests);

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
		String language = (String) params.get("language");
		System.out.println("language : " + language);
		
		Map<String, Object> daoParam = new HashMap<String, Object>();
		
		daoParam.put("firstRow", getFirstRow(page));
		daoParam.put("endRow", getEndRow(page));
		
		Map<String, Object> viewData = new HashMap<String, Object>();
		
		List<Map<String, Object>> userList = getUserList(daoParam);
		List<Map<String, Object>> searchByLanguageList = SearchByLanguageList(language);
		
		System.out.println("searchByLanguageList : " + searchByLanguageList);
		
		viewData.put("userList", userList);
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getTotalPage(daoParam));
		viewData.put("page", page);
		
		return viewData;
	}
	
}