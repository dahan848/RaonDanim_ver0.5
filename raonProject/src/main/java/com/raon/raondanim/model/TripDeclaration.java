package com.raon.raondanim.model;

public class TripDeclaration {

	int trip_Board_Key;
	int d_User_Num;
	int user_Num;
	int declaration_Key;
	String trip_D_DetailContent;
	public int getTrip_Board_Key() {
		return trip_Board_Key;
	}
	public void setTrip_Board_Key(int trip_Board_Key) {
		this.trip_Board_Key = trip_Board_Key;
	}
	public int getD_User_Num() {
		return d_User_Num;
	}
	public void setD_User_Num(int d_User_Num) {
		this.d_User_Num = d_User_Num;
	}
	public int getUser_Num() {
		return user_Num;
	}
	public void setUser_Num(int user_Num) {
		this.user_Num = user_Num;
	}
	public int getDeclaration_Key() {
		return declaration_Key;
	}
	public void setDeclaration_Key(int declaration_Key) {
		this.declaration_Key = declaration_Key;
	}
	public String getTrip_D_DetailContent() {
		return trip_D_DetailContent;
	}
	public void setTrip_D_DetailContent(String trip_D_DetailContent) {
		this.trip_D_DetailContent = trip_D_DetailContent;
	}
	@Override
	public String toString() {
		return "TripDeclaration [trip_Board_Key=" + trip_Board_Key + ", d_User_Num=" + d_User_Num + ", user_Num="
				+ user_Num + ", declaration_Key=" + declaration_Key + ", trip_D_DetailContent=" + trip_D_DetailContent
				+ "]";
	}
	
	
	
}
