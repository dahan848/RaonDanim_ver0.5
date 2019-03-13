package com.raon.raondanim.service;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.ChatDAO;
import com.raon.raondanim.model.ChatRoom;
import com.raon.raondanim.model.Message;



@Service
public class ChatService {
	
	@Autowired
	private ChatDAO dao;
	
	private ChatRoom rVo;
	private Message mVo;
	
	//채팅방 존재 유무 확인하는 ()
	public boolean checkRoom(String userid, String targetid) {
		if(dao.getRoom(getChatRoom(userid, targetid)) != null) {
			return true;
		}else {
			return false;
		}
	}
	
	//인자로 받은 유저와 타켓을 통해 채팅방을 반환하는 ()
	public ChatRoom getChatRoom(String userid, String targetid) {
		//인자로 받은 데이터 형 변환 
		int user = Integer.parseInt(userid);
		int target = Integer.parseInt(targetid);
		//ChatRoomVo 생성 
		rVo = new ChatRoom();
		//인자로 받은 데이터를 모델에 주입  1 
		rVo.setUser1_num(user);
		rVo.setUser2_num(target);
		//인자로 받은 데이터로 생성 된 채팅 방 반환
		return rVo;
	}
	
	//채팅방을 생성하는 ()
	public boolean createRoom(String userid, String targetid) {
		rVo = getChatRoom(userid, targetid);
		if(dao.createRoom(rVo) > 0) {
			return true;
		}else {
			return false;
		}
	}

	//메세지를 추가하는 ()
	public boolean insertMessage(String userid, String targetid, String content) {
		//인자로 받은 유저 정보를 통해 rVo 생성 및 해당 채팅방 선택
		rVo = getChatRoom(userid, targetid);
		ChatRoom rVo2 = dao.getRoom(rVo);
		//해당 채팅방의 번호를 변수에 참조 
		int roomNum = rVo2.getChat_room_num();
		//앞서 얻은 방 번호를 가지는 메시지 인서트
		mVo = new Message();
		mVo.setSend_user(Integer.parseInt(userid)); //전송자
		mVo.setReceive_user(Integer.parseInt(targetid)); //수신자
		mVo.setChat_room_num(roomNum); //채팅방 번호 
		mVo.setContent(content);
		//조건문을 통한 성공 유/무 반환
		if(dao.insertMessage(mVo) > 0) {
			return true;
		}else {
			return false;
		}
	}
	
	//채팅리스트 그리는데 필요한 데이터 반환하는 ()
	public List<Map<String, Object>> getChatList(int usernum) {
		/*
			채팅 리스트 그리는데 필요한 데이터 
			아래의 정보가 하나의 맵에 들어가고
			이러한 정보는 해당 유저의 채팅방 갯수 만큼 만들어짐   
			1. 상대방 프로필 사진  			: 유저 테이블
			2. 상대방 이름 	  			: 유저 테이블
			3. 상대방 번호				: 채팅방 테이블
			4. 채팅방 번호 				: 채팅방 테이블
			5. 해당 채팅방의 마지막 메시지 		: 메시지 테이블
			6. 마지막 메시지의 SEND_USER 	: 메시지 테이블
			7. 마지막 메시지 전송 시간  		: 메시지 테이블 
		*/
		
		
		return null;
	}
}
	
