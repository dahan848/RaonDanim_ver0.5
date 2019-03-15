package com.raon.raondanim.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.ChatService;

@Controller
public class ChatController {
	
	@Autowired
	private ChatService service;
	
	@MessageMapping("/hello/{userid}/{targetid}")
	@SendTo("/category/msg/{targetid}")
	public String stompChat(
			String message,
			@DestinationVariable(value="userid") String userid,
			@DestinationVariable(value="targetid") String targetid
			) {
		System.out.println("=======================stompChat 요청 받음=======================");
		System.out.println("전송자 : " + userid);
		System.out.println("대상자 : " + targetid);
		System.out.println("메시지 : " + message);
		System.out.println("==============================================================");
		
		//userid와 targetid를 통해 채팅방이 존재하는지 검사하고,
		//존재하지 않으면 채팅방을 생성, 존재하지 않으면 전달 받은 메시지를 바로 해당 채팅방에 추가
		if(service.checkRoom(userid, targetid)) {
			//채팅방이 존재하면, 바로 메시지를 추가 
			if(service.insertMessage(userid, targetid, message)) {
				System.out.println("=======================stompChat 메시지 추가 완료=======================");
			}else {
				System.out.println("=======================stompChat 메시지 추가 실패=======================");
			}
		}else {
			//채팅방이 존재하지 않음 > 채팅방 생성
			if(service.createRoom(userid, targetid)) {
				System.out.println("=======================stompChat 채팅방 생성 완료=======================");	
				//채팅 방 생성 후 전달 받은 메시지를 해당 채팅방에 인서트
				if(service.insertMessage(userid, targetid, message)) {
					System.out.println("=======================stompChat 메시지 추가 완료=======================");
				}else {
					System.out.println("=======================stompChat 메시지 추가 실패=======================");
				}
			}else {
				System.out.println("=======================stompChat 채팅방 생성 실패=======================");
			}
		}
		//테스트
		JSONObject jsonMessage = new JSONObject();
		jsonMessage.put("userid", userid);
		jsonMessage.put("msg", message);

		System.out.println(jsonMessage.toString());
			
		return jsonMessage.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/chatList/{usernum}",method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getChatList(@PathVariable("usernum") int usernum){
		System.out.println("chat 리스트 요청 받음!" + usernum);
		ResponseEntity<Map<String, Object>> entity = null;
		try{
			Map<String, Object> chatList = service.getRoomList(usernum);
			entity = new ResponseEntity<Map<String, Object>>(chatList, HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/messageList/{roomnum}",method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getMessageList(@PathVariable("roomnum") int roomnum, Authentication authentication){
		System.out.println("chat 리스트 요청 받음!" + roomnum);
		//아오 그냥 뒷단에서 하자 
		customUserDetails user = (customUserDetails) authentication.getPrincipal();
		int usernum = user.getUser_num();
		//반환 할 데이터 만들기 
		ResponseEntity<Map<String, Object>> entity = null;
		try{
			Map<String, Object> chatList = service.getMessageList(roomnum, usernum);
			entity = new ResponseEntity<Map<String, Object>>(chatList, HttpStatus.OK);
		}catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	
	
}
