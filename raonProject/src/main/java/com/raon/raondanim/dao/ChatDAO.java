package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;

import com.raon.raondanim.model.ChatRoom;
import com.raon.raondanim.model.Message;

public interface ChatDAO {

	public int createRoom(ChatRoom rVo); //채팅방 생성
	public ChatRoom getRoom(ChatRoom rVo);//채팅방을 반환
	public int insertMessage(Message mVo); //메시지 추가
	public List<Map<String, Object>> getRoomList(int usernum); //로그인 한 user의 num으로 해당 유저가 참여 중인 채팅방 리스트 반환 
	public List<Map<String, Object>> getRoomPartner(int usernum); //로그인 한 user의 num으로 해당 유저가 참여 중인 채팅방 참여자 정보 반환
	public List<Map<String, Object>> getMessageList(int roomnum); //인자로 받은 채팅방에 해당하는 메시지 목록을 반환 
	public Map<String, Object> getRoomPartnerByMap(Map<String, Object> param); //로그인 한 user의 num과 채팅방 번호를 받아 타겟의 번호를 얻는 ()
	public int messageAlarmCount(int usernum); //인자로 받은 사용자가 받은 총 메시지의 개수를 반환
	public void setReadTime(Map<String, Object> param); //메시지 읽은 시간 업데이트 
	public List<Map<String, Object>> getUnreadList(int usernum); //읽지 않은 메시지를 표기기 위한 () 
}
