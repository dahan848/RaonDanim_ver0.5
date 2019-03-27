package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.User;

public interface AccountsUserDAO {

	public int setDnmmyData (User user);
	public int joinUser (User user); //회원가입
	public User selectByUserId (String UserId); //아이디로 유저 선택
	public User selectByUserNum (String userNum); //유저넘으로 유저 선택
	public int email_verify (User user); //이메일 인증 여부 설정
	public int updatePersonal(Map<String, Object> param); //개인설정에 필요한 데이터 업데이트
	public int passwordChange(Map<String, Object> param); //비밀번호 변경 
	public List<Map<String, Object>> getUserInterest(String usernum); //번호로 유저 관심사 선택
	public List<Map<String, Object>> getUserLanguage(String usernum); //번호로 유저 사용가능언어 선택
	public List<Map<String, Object>> getUserGallery(String usernum); //번호로 유저의 갤러리 정보 (사진넘, 사진이름, 등록일) 얻기
	public String getUserNationality(String usernum); //번호로 유저 국적 선택 
	public List<Map<String, Object>> getHomeUserList (); //메인(홈) 화면 하단에 출력 될 유저리스트 (유저넘, 프로필픽, 유저 이름(lnm, fnm))
	public int setProfilePic(Map<String, Object> param); //프로필 사진 등록하는 ()
	public int setGalleryPic(Map<String, Object> param); //갤러리 사진 등록하는 ()
	public int deleteGalleryPic(String picnum);
	//dashboard 작성 - 조현길
	public List<Map<String, Object>> trip_list(Map<String, Object>params);//dashboard 여행활동 탭 - 여행 작성글 리스트
	public int selectTotalCount(int num);//여행 게시글 토탈카운트
	public List<Map<String, Object>> trip_reply_list(Map<String, Object>params);//여행탭 여행 댓글 리스트 호출 
	public int selectReplyTotalCount(int num);//여행 댓글 토탈카운트
	public int deleteReply(Map<String, Object>param);//여행 댓글 삭제로직(반복 시킬 로직임)
	public int deleteTrip(Map<String, Object>param);//여행 게시글 삭제로직(반복 시킬 로직임)
	public int selectTripReviewTotalCount(int num);//여행 후기 게시판 토탈 카운트
	public List<Map<String, Object>> tripReview_review(Map<String, Object>params);//dashboard 여행 후기 게시판 리스트
	public int deleteTripReview_review(Map<String, Object>param);//여행 후기 게시판 삭제 로직(반복 시킬 로직임)
	public int selectTripReview_ReplyTotalCount(int num);//여행 후기 댓글 게시판 토탈 카운트
	public List<Map<String, Object>> tripReview_review_reply(Map<String, Object>params);//여행 후기 게시판 리스트
	public int deleteTripReview_review_reply(Map<String, Object>param);//여행 후기 게시판 삭제 로직(반복 시킬 로직임)

}
