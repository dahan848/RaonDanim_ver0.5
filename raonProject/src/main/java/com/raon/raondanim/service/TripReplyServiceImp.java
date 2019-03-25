package com.raon.raondanim.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.dao.TripReplyDao;
import com.raon.raondanim.model.TripReply;

@Service
public class TripReplyServiceImp implements TripReplyService {

	@Autowired
	TripReplyDao replyDao;
	
	@Autowired
	AccountsUserDAO userDao;
	
	public static final int PER_PAGE = 10;
	public static final int NAVI_PAGE = 10;
	
	@Override
	public boolean insertBasicReply(TripReply reply) {
		
		if(replyDao.insertBasicReply(reply)>0) {
			return true;
		}else {
			return false;
		}
		
		
	}

	@Override
	public List<Map<String, Object>> getReplyList(int boardKey) {
		
		return replyDao.getReplyList(boardKey);
	}

	@Override
	public boolean insertReReply(TripReply reply) {
		//대댓글 입력할 서비스 메소드 부분 
		//댓글이 분기를 타는건지 그냥 내려갈지 파라메터를 집어넣는 맵
		
		
/*		*공식
		1. SELECT NVL(MIN(SORTS),0) FROM BOARD
		   WHERE  BGROUP = (원글의 BGROUP)
		   AND SORTS > (원글의 SORTS)
		   AND DEPTH <= (원글의 DEPTH)

		2-1. 1번이 0 일 경우 

		3. SELECT NVL(MAX(SORTS),0) + 1 FROM BOARD 
		    WHERE BGROUP = (원글의 BGROUP);

		4. INSERT INTO BOARD VALUES 
		   (번호, (원글의 BGROUP), (3번값), (원글의 DEPTH +1) ,' 제목')

		2-2. 1번이 0이 아닐 경우 

		3. UPDATE BOARD SET SORTS = SORTS + 1 
		  WHERE BGROUP =  (원글의 BGROUP)  AND SORTS >= (1번값)

		4. INSERT INTO BOARD VALUES 
		   (번호, (원글의 BGROUP), (1번값), (원글의 DEPTH +1) ,' 제목')
*/

		
		Map<String, Object> params = new HashMap<>();
		
		int gId = reply.getTrip_Reply_Gid();
		int sorts = reply.getTrip_Reply_Sorts();
		int depth = reply.getTrip_Reply_Depth();
		
		params.put("gId", gId);
		params.put("sorts", sorts);
		params.put("depth", depth);

		
		int replyCondition = replyDao.replyCondition(params);
		System.out.println("댓글 조건 값 확인 : "+replyCondition);
		try {
			
			if(replyCondition==0) {
				/*
				replyCondition에 따라 2단계로 나눠진다. 말하자면 replyCondition에서 SORTS를 구하는 것이다. 
				만약 0일 경우 맨 마지막 오는 경우이다.
				아닐 경우 중간에 넣는 것인데 중간이후에 있는 다른 것들을 SORTS를 1씩 더해주고 넣는 것이다.
				*/
				int replySorts = replyDao.insertReply(gId);
				reply.setTrip_Reply_Sorts(replySorts);
				replyDao.insertReply2(reply);
				System.out.println("내려가는 댓글 sort확인:"+replySorts);	
				System.out.println("내려가는 댓글확인:"+reply);	

			
			}else {
				// 분기타는 대댓글 
				params.put("sorts", replyCondition);
				//댓글의 들어갈자리에 있는 담것들 하나씩 뒤로 밀기
				replyDao.insertReReply(params);
				//빈자리에 댓글 넣기
				reply.setTrip_Reply_Sorts(replyCondition);
				replyDao.insertReReply2(reply);
				System.out.println("분기 대댓글 여기까지 옴");
				
			}
			
			
			return true;
			
			
		} catch (Exception e) {
			System.out.println("대댓글 입력중 오류");
			e.printStackTrace();
			return false;
		}
	
	}

	
	@Override
	public Map<String, Object> getReplyListByTen(Map<String, Object> params) {
		//페이징된 댓글 리스트 뽑는 메소드
		
		int pageNum = (int) params.get("pageNum");
		int boardKey = (int) params.get("boardKey");
		
		int startRow = PER_PAGE * (pageNum - 1) + 1;
		int endRow = PER_PAGE * pageNum;
		
		params.put("start", startRow);
		params.put("end", endRow);
		
		Map<String, Object> replyData = new HashMap<>();
		
		replyData.put("replyList", replyDao.getReplyListByTen(params));
		replyData.put("start", getStartPage(pageNum));
		replyData.put("end", getEndPage(pageNum));
		replyData.put("total", getTotalPage(boardKey));
		replyData.put("page", pageNum);
		
		
//		System.out.println("서비스/ start댓글데이터 확인 : "+getStartPage(pageNum));
//		System.out.println("서비스/ end댓글데이터 확인 : "+ getEndPage(pageNum));
//		System.out.println("서비스/ total댓글데이터 확인 : "+getTotalPage(boardKey));
//		System.out.println("서비스/ page댓글데이터 확인 : "+pageNum);
		
		return replyData;
	}

	@Override
	public int getStartPage(int pageNum) {
		
		return ((pageNum - 1) / NAVI_PAGE) * NAVI_PAGE + 1;
	}

	@Override
	public int getEndPage(int pageNum) {
		
		return getStartPage(pageNum) + (NAVI_PAGE - 1);
	}

	@Override
	public int getTotalPage(int boardKey) {
		int totalPage = 0;
		int replyCount = replyDao.getReplyTotalCount(boardKey);
		
		totalPage = (replyCount - 1) / PER_PAGE + 1;
		
		return totalPage;
	}

	@Override
	public boolean deleteReply(int replyKey) {
		//댓글 삭제
		Map<String, Object> reply = replyDao.selectOneByreplyKey(replyKey);
		String gId = String.valueOf(reply.get("TRIP_REPLY_GID")) ;
		
		//맵에서 값 꺼낼때 클래스 캐스트 예외 발생시 이렇게 하면됨 문자열로 바꿀때는 String.valueOf /숫자로 바꿀때는
		//Integer.parseInt(String.valueOf(오브젝트))
		int depth = Integer.parseInt(String.valueOf(reply.get("TRIP_REPLY_DEPTH")));
		
		
		Map<String, Object> delete = new HashMap<>();
		delete.put("replyKey", replyKey);
		delete.put("gId", gId);
		System.out.println("서비스/삭제/그룹아이디 확인 :"+gId);
		
		if(depth ==0) {
			//원글 삭제
			if(replyDao.deleteReply(delete)>0) {
				//삭제(상태값 1로 업데이트)성공
				return true;
				
			}else {
				//실패
				return false;
			}
			
			
		}else {
			//대글 대댓글 단독 삭제
			
			if(replyDao.deleteReply2(delete)>0) {
				//삭제(상태값 1로 업데이트)성공
				return true;
				
			}else {
				//실패
				return false;
			}
			
		}
		
		
		
		
	}

	@Override
	public Map<String, Object> selectOneByreplyKey(int replyKey) {
		
		return replyDao.selectOneByreplyKey(replyKey);
	}

	@Override
	public boolean checkPw(String userNum, String checkPw) {
		
		String userPw = userDao.selectByUserNum(userNum).getUser_pw();
		
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		
		
		
		if(encoder.matches(checkPw, userPw)) {
			//비번같음
			return true;
		}else {
			//비번틀림
			return false;
		}
		
		
		
	}

}
