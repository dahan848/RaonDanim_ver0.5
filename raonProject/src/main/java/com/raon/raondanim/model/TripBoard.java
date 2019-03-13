package com.raon.raondanim.model;

public class TripBoard {
//	TRIP_BOARD_KEY          NUMBER(10)        NOT NULL, 
//    USER_NUM                NUMBER(10)        NOT NULL, 
//    TRIP_BOARD_TITLE        VARCHAR2(100)     NOT NULL, 
//    TRIP_BOARD_COUNTENT     VARCHAR2(2000)    NOT NULL, 
//    TRIP_BOARD_START        DATE              NOT NULL, 
//    TRIP_BOARD_END          DATE              NOT NULL, 
//    TRIP_BOARD_TOGETHER     NUMBER(10)        NOT NULL, 
//    TRIP_BOARD_READCOUNT    NUMBER(10)        DEFAULT 0 NOT NULL, 
//    TRIP_BOARD_ST           NUMBER(10)        DEFAULT 0 NULL, 

	int trip_Board_Key;
	int user_Num;
	String trip_Board_Title;
	String trip_Board_Content;
	String trip_Board_Start;
	String trip_Board_End;
	int trip_Board_Together;
	int trip_Board_Readcount;
	int trip_Board_St;

	public int getTrip_Board_Key() {
		return trip_Board_Key;
	}

	public void setTrip_Board_Key(int trip_Board_Key) {
		this.trip_Board_Key = trip_Board_Key;
	}

	public int getUser_Num() {
		return user_Num;
	}

	public void setUser_Num(int user_Num) {
		this.user_Num = user_Num;
	}

	public String getTrip_Board_Title() {
		return trip_Board_Title;
	}

	public void setTrip_Board_Title(String trip_Board_Title) {
		this.trip_Board_Title = trip_Board_Title;
	}

	public String getTrip_Board_Content() {
		return trip_Board_Content;
	}

	public void setTrip_Board_Content(String trip_Board_Content) {
		this.trip_Board_Content = trip_Board_Content;
	}

	public String getTrip_Board_Start() {
		return trip_Board_Start;
	}

	public void setTrip_Board_Start(String trip_Board_Start) {
		this.trip_Board_Start = trip_Board_Start;
	}

	public String getTrip_Board_End() {
		return trip_Board_End;
	}

	public void setTrip_Board_End(String trip_Board_End) {
		this.trip_Board_End = trip_Board_End;
	}

	public int getTrip_Board_Together() {
		return trip_Board_Together;
	}

	public void setTrip_Board_Together(int trip_Board_Together) {
		this.trip_Board_Together = trip_Board_Together;
	}

	public int getTrip_Board_Readcount() {
		return trip_Board_Readcount;
	}

	public void setTrip_Board_Readcount(int trip_Board_Readcount) {
		this.trip_Board_Readcount = trip_Board_Readcount;
	}

	public int getTrip_Board_St() {
		return trip_Board_St;
	}

	public void setTrip_Board_St(int trip_Board_St) {
		this.trip_Board_St = trip_Board_St;
	}

	@Override
	public String toString() {
		return "TripBoard [trip_Board_Key=" + trip_Board_Key + ", user_Num=" + user_Num + ", trip_Board_Title="
				+ trip_Board_Title + ", trip_Board_Content=" + trip_Board_Content + ", trip_Board_Start="
				+ trip_Board_Start + ", trip_Board_End=" + trip_Board_End + ", trip_Board_Together="
				+ trip_Board_Together + ", trip_Board_Readcount=" + trip_Board_Readcount + ", trip_Board_St="
				+ trip_Board_St + "]";
	}
}
