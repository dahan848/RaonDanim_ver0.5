package com.raon.raondanim.service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.raondanim.dao.AccountsUserDAO;
import com.raon.raondanim.dao.ChatDAO;
import com.raon.raondanim.model.ChatRoom;
import com.raon.raondanim.model.Message;
import com.raon.raondanim.model.User;



@Service
public class ChatService {
	
	@Autowired
	private ChatDAO dao;
	@Autowired
	private AccountsUserDAO userDao;
	
	private ChatRoom rVo;
	private Message mVo;
	
	//채팅방 존재 유무 확인하는 ()
	public ChatRoom checkRoom(String userid, String targetid) {
		if(dao.getRoom(getChatRoom(userid, targetid)) != null) {
			return dao.getRoom(getChatRoom(userid, targetid));
		}else {
			return null;
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
	public List<Map<String, Object>> getRoomList(int usernum) {
//		System.out.println("서비스 getChatRoomList 요청 받음!");
		//반환 할Map선언 
		Map<String, Object> result = new HashMap<String, Object>();
		//DAO를 통해 전달받은 값을 참조 할 List<Map>와 합친 결과 List<Map>을 선언
		List<Map<String, Object>> room = dao.getRoomList(usernum);
		List<Map<String, Object>> partner = dao.getRoomPartner(usernum);
		//두개의 List<Map>을 하나의 List<Map>으로 만들기
		for (int i = 0; i < room.size(); i++) {
			for (int n = 0; n < partner.size(); n++) {
				//파트너 정보를 Map에 넣어준다.
				Map<String, Object> map = partner.get(n); 
				//조건문 비교를 통해서 같은 채팅 방 넘버라면 방정보 맵에 파트너 정보 맵의 데이터를 putAll 
				if (room.get(i).get("CHAT_ROOM_NUM").equals(map.get("CHAT_ROOM_NUM"))) {
					room.get(i).putAll(map);
				}
			}
		}
		
//		for(Map<String, Object> test : room) {
//			System.out.println("합치기 테스트 : "+test.toString());
//		}
		
//		System.out.println("======================================================");
//		//선언 한 Map에 두 개의 List을 넣어줌 
//		result.put("roomList", dao.getRoomList(usernum));
//		result.put("partnerInfo", dao.getRoomPartner(usernum));
//		//sysout
//		for(Map<String, Object> test: dao.getRoomList(usernum)) {
//			System.out.println("방 목록 : " + test.toString());
//		}
//		for(Map<String, Object> test: dao.getRoomPartner(usernum)) {
//			System.out.println("채팅방 참여자  : " + test.toString());
//		}
		//반환
		return room;
	}
	
	//방 번호를 전달 받아서 해당 방의 메시지 목록을 반환하는 ()
	public Map<String, Object> getMessageList(int roomnum, int usernum){
		//반환 할Map선언 
		Map<String, Object> data = new HashMap<String, Object>();
		//getRoomPartner()에 넘겨 줄 Map 선언 
		Map<String, Object> param = new HashMap<String, Object>();
		//param Map에 필요한 데이터를 넣어준다. : usernum, roomnum
		param.put("chat_room_num", roomnum);
		param.put("usernum", usernum);
		//채팅방 참여자와 채팅방 번호를 반환하는 DAO의 MAP을 참조 할 변수를 선언 및 초기화 
		Map<String, Object> targetInfo = dao.getRoomPartnerByMap(param);
		//참여자 이름을 얻기 위한 로직 수행
		String targetId = (String) targetInfo.get("USER_NUM");
		User target = userDao.selectByUserNum(targetId);
		String targetName = target.getUser_lnm() + " " + target.getUser_fnm();
		
		//메시지 리스트 null 예외 처리 
		List<Map<String, Object>> message = dao.getMessageList(roomnum);
		if(message.isEmpty()) {
//			System.out.println("메시지 리스트 없음.");
			data.put("mList", null); 
		}else {
//			System.out.println("메시지 리스트 있음.");
//			System.out.println(dao.getMessageList(roomnum).toString());
			data.put("mList", dao.getMessageList(roomnum)); 
		}
		
		//반환 할 Map에 필요한 데이터를 넣어줌  
		data.put("usernum", usernum); // 로그인 한 유저의 넘 
		data.put("partner", dao.getRoomPartnerByMap(param)); //채팅방 참여자
		data.put("partnerName", targetName); //채팅방 참여자 이름 
		
		//sysout 테스트
//		System.out.println(data.toString());
		return data;
	}
	
	//채팅방이 열렸을 떄 읽은 시간을 DB에 넣는 ()
	public void updateReadMessage(Map<String, Object> data) {
		dao.setReadTime(data);
	}
}
	
