package com.raon.raondanim.model;

public class ChatRoom {
	private int chat_room_num;
	private int user1_num;
	private int user2_num;
	public int getChat_room_num() {
		return chat_room_num;
	}
	public void setChat_room_num(int chat_room_num) {
		this.chat_room_num = chat_room_num;
	}
	public int getUser1_num() {
		return user1_num;
	}
	public void setUser1_num(int user1_num) {
		this.user1_num = user1_num;
	}
	public int getUser2_num() {
		return user2_num;
	}
	public void setUser2_num(int user2_num) {
		this.user2_num = user2_num;
	}
	@Override
	public String toString() {
		return "ChatRoom [chat_room_num=" + chat_room_num + ", user1_num=" + user1_num + ", user2_num=" + user2_num
				+ "]";
	}
}
