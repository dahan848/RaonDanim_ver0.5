package com.raon.raondanim.dao;

import java.util.List;
import java.util.Map;



public interface MotelDAO {
	public List<Map<String, Object>> National_selectAll();
	public List<Map<String, Object>> City_selectAll();
	public int motel_insert(Map<String, Object> param);
}
