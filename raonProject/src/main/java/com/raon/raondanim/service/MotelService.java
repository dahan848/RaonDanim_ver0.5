package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

public interface MotelService {
	public List<Map<String, Object>>  getAllNational();
	public List<Map<String, Object>> getAllCity();
	public boolean write_Motel(Map<String, Object> param);
	
	
}
