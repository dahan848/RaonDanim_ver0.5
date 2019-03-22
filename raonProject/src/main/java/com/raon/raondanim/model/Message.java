package com.raon.raondanim.model;
import java.util.Date;

import com.google.gson.Gson;

public class Message {
	private int chat_room_num; //채팅방 번호 
	private int message_num;   //메시지 번호 
	private int send_user;	   //보낸 사람
	private int receive_user;  //받는 사람
	private String content;    //내용
	private Date send_time;    //전송시간
	private Date read_time;    //읽은 시간
	public int getChat_room_num() {
		return chat_room_num;
	}
	public void setChat_room_num(int chat_room_num) {
		this.chat_room_num = chat_room_num;
	}
	public int getMessage_num() {
		return message_num;
	}
	public void setMessage_num(int message_num) {
		this.message_num = message_num;
	}
	public int getSend_user() {
		return send_user;
	}
	public void setSend_user(int send_user) {
		this.send_user = send_user;
	}
	public int getReceive_user() {
		return receive_user;
	}
	public void setReceive_user(int receive_user) {
		this.receive_user = receive_user;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getSend_time() {
		return send_time;
	}
	public void setSend_time(Date send_time) {
		this.send_time = send_time;
	}
	public Date getRead_time() {
		return read_time;
	}
	public void setRead_time(Date read_time) {
		this.read_time = read_time;
	}
	@Override
	public String toString() {
		return "Message [chat_room_num=" + chat_room_num + ", message_num=" + message_num + ", send_user=" + send_user
				+ ", receive_user=" + receive_user + ", content=" + content + ", send_time=" + send_time
				+ ", read_time=" + read_time + "]";
	}
	
	


}
