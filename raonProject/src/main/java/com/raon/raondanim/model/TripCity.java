package com.raon.raondanim.model;

public class TripCity {

	int trip_City_Key;
	String trip_City_Town;
	String trip_City_Lat;
	String trip_City_Lng;
	String trip_City_Pid;
	int trip_City_St;
	
	public int getTrip_City_St() {
		return trip_City_St;
	}
	public void setTrip_City_St(int trip_City_St) {
		this.trip_City_St = trip_City_St;
	}
	public int getTrip_City_Key() {
		return trip_City_Key;
	}
	public void setTrip_City_Key(int trip_City_Key) {
		this.trip_City_Key = trip_City_Key;
	}
	public String getTrip_City_Town() {
		return trip_City_Town;
	}
	public void setTrip_City_Town(String trip_City_Town) {
		this.trip_City_Town = trip_City_Town;
	}
	public String getTrip_City_Lat() {
		return trip_City_Lat;
	}
	public void setTrip_City_Lat(String trip_City_Lat) {
		this.trip_City_Lat = trip_City_Lat;
	}
	public String getTrip_City_Lng() {
		return trip_City_Lng;
	}
	public void setTrip_City_Lng(String trip_City_Lng) {
		this.trip_City_Lng = trip_City_Lng;
	}
	public String getTrip_City_Pid() {
		return trip_City_Pid;
	}
	public void setTrip_City_Pid(String trip_City_Pid) {
		this.trip_City_Pid = trip_City_Pid;
	}
	
	@Override
	public String toString() {
		return "TripCity [trip_City_Key=" + trip_City_Key + ", trip_City_Town=" + trip_City_Town + ", trip_City_Lat="
				+ trip_City_Lat + ", trip_City_Lng=" + trip_City_Lng + ", trip_City_Pid=" + trip_City_Pid
				+ ", trip_City_St=" + trip_City_St + "]";
	}
	
	
	
	
	
	
}
