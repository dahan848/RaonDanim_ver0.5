package com.raon.raondanim.model;

public class TripReply {

	int trip_Reply_Key;
	int trip_Board_Key;
	int User_Num;
	int trip_Reply_Gid;
	int trip_Reply_Depth;
	int trip_Reply_Sorts;
	String trip_reply_Content;
	String trip_trply_WriteDate;
	int trip_Reply_St;
	
	public int getTrip_Reply_Key() {
		return trip_Reply_Key;
	}
	public void setTrip_Reply_Key(int trip_Reply_Key) {
		this.trip_Reply_Key = trip_Reply_Key;
	}
	public int getTrip_Board_Key() {
		return trip_Board_Key;
	}
	public void setTrip_Board_Key(int trip_Board_Key) {
		this.trip_Board_Key = trip_Board_Key;
	}
	public int getUser_Num() {
		return User_Num;
	}
	public void setUser_Num(int user_Num) {
		User_Num = user_Num;
	}
	public int getTrip_Reply_Gid() {
		return trip_Reply_Gid;
	}
	public void setTrip_Reply_Gid(int trip_Reply_Gid) {
		this.trip_Reply_Gid = trip_Reply_Gid;
	}
	public int getTrip_Reply_Depth() {
		return trip_Reply_Depth;
	}
	public void setTrip_Reply_Depth(int trip_Reply_Depth) {
		this.trip_Reply_Depth = trip_Reply_Depth;
	}
	public int getTrip_Reply_Sorts() {
		return trip_Reply_Sorts;
	}
	public void setTrip_Reply_Sorts(int trip_Reply_Sorts) {
		this.trip_Reply_Sorts = trip_Reply_Sorts;
	}
	public String getTrip_reply_Content() {
		return trip_reply_Content;
	}
	public void setTrip_reply_Content(String trip_reply_Content) {
		this.trip_reply_Content = trip_reply_Content;
	}
	public String getTrip_trply_WriteDate() {
		return trip_trply_WriteDate;
	}
	public void setTrip_trply_WriteDate(String trip_trply_WriteDate) {
		this.trip_trply_WriteDate = trip_trply_WriteDate;
	}
	public int getTrip_Reply_St() {
		return trip_Reply_St;
	}
	public void setTrip_Reply_St(int trip_Reply_St) {
		this.trip_Reply_St = trip_Reply_St;
	}
	
	@Override
	public String toString() {
		return "TripReply [trip_Reply_Key=" + trip_Reply_Key + ", trip_Board_Key=" + trip_Board_Key + ", User_Num="
				+ User_Num + ", trip_Reply_Gid=" + trip_Reply_Gid + ", trip_Reply_Depth=" + trip_Reply_Depth
				+ ", trip_Reply_Sorts=" + trip_Reply_Sorts + ", trip_reply_Content=" + trip_reply_Content
				+ ", trip_trply_WriteDate=" + trip_trply_WriteDate + ", trip_Reply_St=" + trip_Reply_St + "]";
	}
	
	
}
