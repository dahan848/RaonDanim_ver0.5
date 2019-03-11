package com.raon.raondanim.model;

public class TripRel {

	int rel_Key;
	int trip_Board_Key;
	int trip_City_Key;
	int user_Num;
	int rel_St;
	
	
	public int getRel_St() {
		return rel_St;
	}
	public void setRel_St(int rel_St) {
		this.rel_St = rel_St;
	}
	public int getRel_Key() {
		return rel_Key;
	}
	public void setRel_Key(int rel_Key) {
		this.rel_Key = rel_Key;
	}
	public int getTrip_Board_Key() {
		return trip_Board_Key;
	}
	public void setTrip_Board_Key(int trip_Board_Key) {
		this.trip_Board_Key = trip_Board_Key;
	}
	public int getTrip_City_Key() {
		return trip_City_Key;
	}
	public void setTrip_City_Key(int trip_City_Key) {
		this.trip_City_Key = trip_City_Key;
	}
	public int getUser_Num() {
		return user_Num;
	}
	public void setUser_Num(int user_Num) {
		this.user_Num = user_Num;
	}
	
	@Override
	public String toString() {
		return "TripRel [rel_Key=" + rel_Key + ", trip_Board_Key=" + trip_Board_Key + ", trip_City_Key=" + trip_City_Key
				+ ", user_Num=" + user_Num + ", rel_St=" + rel_St + "]";
	}
	
	
	
	
}
