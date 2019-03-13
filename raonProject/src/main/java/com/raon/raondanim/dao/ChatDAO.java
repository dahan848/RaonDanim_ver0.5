package com.raon.raondanim.dao;

import com.raon.raondanim.model.ChatRoom;
import com.raon.raondanim.model.Message;

public interface ChatDAO {

	public int createRoom(ChatRoom rVo); //채팅방 생성
	public ChatRoom getRoom(ChatRoom rVo);//채팅방을 반환
	public int insertMessage(Message mVo); //메시지 추가
	public Message getListMessage(String roomnum); //해당 채팅방 테이블의 마지막 로우를 메시지모델로 반환
}
