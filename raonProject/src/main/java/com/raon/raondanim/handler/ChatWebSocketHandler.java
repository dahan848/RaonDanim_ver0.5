package com.raon.raondanim.handler;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.util.JSONPObject;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler{
	//연결 요청 처리 
    //메시지 받기, 메시지 전달
	//WebSocketSession 클라이언트 당 하나씩 생성, 
	//해당 클라이언트와 연결된 웹소켓을 이용할 수 있는 객체  
	private List<WebSocketSession> users;
	private Map<String, Object> userMap;
	public ChatWebSocketHandler() {
		users= new ArrayList<WebSocketSession>();
		userMap = new HashMap<String,Object>();
	}
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("TextWebSocketHandler : 연결 생성!");
		users.add(session);
	}
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("TextWebSocketHandler : 메시지 수신!");
		System.out.println("메시지 : " + message.getPayload());
		JSONObject object = new JSONObject(message.getPayload());
		String type = object.getString("type");
		if(type != null && type.equals("register") ) {
			//등록 요청 메시지
			String user = object.getString("userid");
			//아이디랑 Session이랑 매핑 >>> Map
			userMap.put(user, session);
		}else {
			//채팅 메시지 : 상대방 아이디를 포함해서 메시지를 보낼것이기 때문에
			//Map에서 상대방 아이디에 해당하는 WebSocket 꺼내와서 메시지 전송
			String target = object.getString("target");
			WebSocketSession ws = (WebSocketSession)userMap.get(target);
			String msg = object.getString("message");
			if(ws !=null ) {
				ws.sendMessage(new TextMessage(msg));
			}
		}
		
//		System.out.println("메시지  : " + message.getPayload());
//		//session.sendMessage(new TextMessage("Hello! from server"));
//		for(WebSocketSession wss:users) {
//			if(wss != session) {
//				wss.sendMessage(new TextMessage(message.getPayload()));				
//			}
//		}
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("TextWebSocketHandler : 연결 종료!");
		users.remove(session);
	}
	
}