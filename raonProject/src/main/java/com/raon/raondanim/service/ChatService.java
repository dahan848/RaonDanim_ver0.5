package com.raon.raondanim.service;
import java.util.ArrayList;
import java.util.HashMap;
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
	public Map<String, Object> getRoomList(int usernum) {
		System.out.println("서비스 getChatRoomList 요청 받음!");
		//반환 할Map선언 
		Map<String, Object> data = new HashMap<String, Object>();
		//선언 한 Map에 두 개의 List을 넣어줌 
		data.put("roomList", dao.getRoomList(usernum));
		data.put("partnerInfo", dao.getRoomPartner(usernum));
		
		//sysout
//		for(Map<String, Object> test: dao.getRoomList(usernum)) {
//			System.out.println(test.toString());
//		}
//		
//		for(Map<String, Object> test: dao.getRoomPartner(usernum)) {
//			System.out.println(test.toString());
//		}
		//반환
		return data;
	}
	
	//방 번호를 전달 받아서 해당 방의 메시지 목록을 반환하는 ()
	public Map<String, Object> getMessageList(int roomnum, int usernum){
		//반환 할Map선언 
		Map<String, Object> data = new HashMap<String, Object>();
		//선언 한 Map에 메시지 목록을 넣어줌 
		data.put("mList", dao.getMessageList(roomnum));
		data.put("usernum", usernum);
		for(Map<String, Object> test: dao.getMessageList(roomnum)) {
			System.out.println(test.toString());
		}
		return data;
	}
}
	
