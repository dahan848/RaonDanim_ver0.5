package com.raon.raondanim.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface MotelService {
	public List<Map<String, Object>>  getAllNational();
	public List<Map<String, Object>> getAllCity();
	public boolean write_Motel(Map<String, Object> param);
	public boolean write_Motel1(Map<String, Object> param, List<MultipartFile> files);
	public String wirte_motel_Photo(MultipartFile file);
	
}
