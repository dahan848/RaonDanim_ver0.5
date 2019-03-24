package com.raon.raondanim.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.dao.AdminDAO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO dao;
	
	@Autowired
	private AccountsUserDAO userDao;
	
	/*
	 	문의글 페이징 처리를 위한 변수 및 () 선언
	*/  
    private static final int NUM_OF_INQUIRY_PER_PAGE=10; //한 페이지에 표시 될 문의글 개수
    private static final int NUM_OF_NAVI_PAGE=10;		 //한 번에 표시 될 네비게이션 개수 
    
    public List<Map<String, Object>> getInquiryList(Map<String, Object> params) {         
        return dao.InquiryList(params);
    }
    
    private int getInquiryFirstRow(int page) {
	    int result  = (page-1)*NUM_OF_INQUIRY_PER_PAGE+1;
	    return result;
    }
    
    private int getInquiryEndRow(int page) {
        int result =  ((page-1) + 1)*NUM_OF_INQUIRY_PER_PAGE ;
        return result;
    }
    
    private int getInquiryStartPage(int page) {
        int result  = ((page-1)/NUM_OF_INQUIRY_PER_PAGE)*NUM_OF_INQUIRY_PER_PAGE+1;
        return result;
    }
    
    private int getInquiryEndPage(int page) {
        int result = getInquiryStartPage(page)+9;
        return result;
    }
    
    private int getInquiryTotalPage(Map<String, Object> params) {
        int totalCount = dao.selectInquiryTotalCount(params);
        int totalPage = (totalCount-1)/NUM_OF_INQUIRY_PER_PAGE+1;
        return totalPage;
    }
    
    public Map<String, Object> getInquiryViewData(Map<String, Object> params) {
        int page = (int)params.get("page");
        int type = (int)params.get("type");
        
        String keyword = (String)params.get("keyword");
        Map<String, Object> daoParam = new HashMap<String,Object>();
        
        daoParam.put("type", type);
        if(type == 1) {
            daoParam.put("title", keyword); //제목검사
        }else if(type == 2) {
            daoParam.put("name", keyword); //작성자
        }else if(type == 3) {
            daoParam.put("title", keyword); //제목 작성자
            daoParam.put("name", keyword);
        }else if(type == 4) {
            daoParam.put("content", keyword); // 내용
        }
        
        daoParam.put("firstRow", getInquiryFirstRow(page));
        daoParam.put("endRow", getInquiryEndRow(page));
         
        Map<String, Object> viewData = new HashMap<String,Object>();
 
        List<Map<String, Object>> InquiryList = getInquiryList(daoParam);
        viewData.put("InquiryList", InquiryList);
        viewData.put("startPage", getInquiryStartPage(page));
        viewData.put("endPage", getInquiryEndPage(page));
        viewData.put("totalPage", getInquiryTotalPage(daoParam));
        viewData.put("page", page);
        return viewData;
    }
    
	
	
	
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
	
	//문의글 DB에 데이터를 넣는 ()
	public boolean insertInquiry(Map<String, Object> param) {
		// 회원/비회원 타입 구별을 위한 조건문 
		if(userDao.selectByUserId ((String)param.get("inquiry_reg_id")) != null) {
			//inquiry_rge_type : 비회원0, 회원1
			param.put("inquiry_rge_type", 1);
		}else {
			param.put("inquiry_rge_type", 0);
		}
		
		//DAO에 param을 넣는 작업
		if(dao.insertInquiry(param) > 0) {
			return true;
		}else {
			return false;			
		}
	}

}
