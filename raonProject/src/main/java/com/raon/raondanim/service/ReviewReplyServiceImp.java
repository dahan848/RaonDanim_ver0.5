package com.raon.raondanim.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.dao.ReviewReplyDao;
import com.raon.raondanim.model.User;

@Service
public class ReviewReplyServiceImp implements ReviewReplyService{

	@Autowired
	private ReviewReplyDao dao;
	
	@Autowired
	private AccountsUserDAO accDao;
	
	@Override
	public List<Map<String, Object>> selectAll() {
		return dao.selectAll();
	}

	@Override
	public boolean insertReply(Map<String, Object> param) {
		if(dao.insertReply(param) > 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean updateReply(Map<String, Object> param) {
		if(dao.updateReply(param)>0) {
			return true;
		} else {		
			return false;
		}
	}

	@Override
	public boolean deleteReply(Map<String, Object> params) {
		//입력한 비밀번호
		String input_reply_pass = String.valueOf(params.get("input_reply_pass"));
		//게시글 번호(REVIEW_NUM)
		String numStr = String.valueOf(params.get("num"));
		int num = Integer.parseInt(numStr);
		//로그인 한 USER_NUM
		String userNum = String.valueOf(params.get("userNum"));
		//댓글 번호(RE_REPLY_NUM)
		int re_Reply_Num = (Integer)params.get("re_Reply_Num");
		// 댓글 키에서 select one해서 해당 댓글의 유저 넘 뽑기
		Map<String, Object> replyWriteUserNum = dao.selectOne(re_Reply_Num);
		// 뽑은 유저 넘으로 유저 셀렉트 하면 유저 정보 뽑아옴
		User user = accDao.selectByUserNum(String.valueOf(replyWriteUserNum.get("USER_NUM")));
		//유저한테 뽑아온 인트 유저넘
		String uNum = String.valueOf(user.getUser_num());
		// 뽑은 유저 넘하고 로그인한 유저넘 비교
		// 뽑은 유저 비밀번호 == 가져온 비번 비교
		if(userNum.equals(uNum)) {
			if(user.getUser_pw().equals(input_reply_pass)) {
				if(dao.deleteReply(re_Reply_Num)>0) {
					return true;
				} else {
					return false;
				} 
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

	@Override
	public Map<String, Object> selectOne(int num) {
		return dao.selectOne(num);
	}

	@Override
	public Map<String, Object> selectByUserNum(int num) {
		return dao.selectByUserNum(num);
	}

	@Override
	public List<Map<String, Object>> getReviewReply(int num) {
		return dao.selectByReviewNum(num);
	}

	
	
	//---------------- 페이징 부분 ----------------//
	
	//한 페이지에 표시될 게시글의 갯수 
	private static final int NUM_OF_BOARD_PER_PAGE=10;
	//한 번에 표시될 네비게이션 갯수
	private static final int NUM_OF_NAVI_PAGE=10;
	
	
	@Override
	public List<Map<String, Object>> getBoardList(Map<String, Object> params) {
		return dao.replyList(params);
	}
	
	private int getFirstRow(int page) {
		int result = (page-1)*NUM_OF_BOARD_PER_PAGE+1;
		return result;
	}
	
	private int getEndRow(int page) {
		int result = ((page-1)+1)*NUM_OF_BOARD_PER_PAGE;
		return result;
	}
	
	private int getStartPage(int page) {
		int result = ((page-1)/NUM_OF_BOARD_PER_PAGE)*NUM_OF_BOARD_PER_PAGE+1;
		return result;
	}
	
	private int getEndPage(int page) {
		int result = getStartPage(page) + 9;
		return result;
	}
	
	private int getTotalPage() {
		int totalCount = dao.selectTotalCount();
		int totalPage = (totalCount-1)/NUM_OF_BOARD_PER_PAGE+1;
		return totalPage;
	}
	
	@Override
	public Map<String, Object> getViewData(Map<String, Object> params) {
		int page = Integer.parseInt(String.valueOf( params.get("page")));
		
		Map<String, Object> daoParam = new HashMap<String, Object>();
		daoParam.put("firstRow", getFirstRow(page));
		daoParam.put("endRow", getEndRow(page));
		
//		System.out.println("firstRow : " + getFirstRow(page));
//		System.out.println("endRow : " + getEndRow(page));
		
		Map<String, Object> viewData = new HashMap<String, Object>();
		List<Map<String, Object>> boardList = getBoardList(daoParam);
		
		viewData.put("boardList", boardList);
		viewData.put("startPage", getStartPage(page));
		viewData.put("endPage", getEndPage(page));
		viewData.put("totalPage", getTotalPage());
		viewData.put("page", page);
		
		//System.out.println("서비스/댓글 페이징 데이터"+viewData);
//		System.out.println("서비스/댓글 페이징 startPage"+getStartPage(page));
//		System.out.println("서비스/댓글 페이징 endPage"+getEndPage(page));
//		System.out.println("서비스/댓글 페이징 totalPage"+getTotalPage());
//		System.out.println("서비스/댓글 페이징 firstRow"+getFirstRow(page));
//		System.out.println("서비스/댓글 페이징 endRow"+getEndRow(page));

		
		
		return viewData;
	}
	
	@Override
	public Map<String, Object> getBoardByNum(int num) {
		return dao.selectOne(num);
	}

	
	
}
