package com.raon.raondanim.handler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.raon.raondanim.dao.ChatDAO;

public class ReadMessageTime extends TextWebSocketHandler {

	@Autowired
	ChatDAO dao;

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//화면단으로 부터 전달받은 usernum (로그인 한 유저)을 int 변수에 형변환 하여 참조 
		System.out.println("리드타임요청받음");
		System.out.println(message.getPayload());
//		int usernum = Integer.parseInt(message.getPayload());
//		//앞서 변환 한 usernum를 dao에 넣어서 해당 유저의 총 메시지 개수를 반환 받는다. (이것을 형 변환하여 String으로 넣어줌)
//		String count = Integer.toString(dao.messageAlarmCount(usernum));
//		//해당 count를 화면 단으로 반환 해준다.
		session.sendMessage(new TextMessage("테스트"));
	}
}
