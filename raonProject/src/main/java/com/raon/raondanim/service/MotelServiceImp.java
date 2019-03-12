package com.raon.raondanim.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.raon.raondanim.dao.MotelDAO;

@Service
public class MotelServiceImp implements MotelService{

	//������ ������ ��ġ
	private static final String UPLOAD_PATH = "D:\\project_img";
	
	@Autowired
	private MotelDAO dao;
	
	@Override
	public List<Map<String, Object>> getAllNational() {
		//System.out.println("service : " + dao.National_selectAll());
		return dao.National_selectAll();
	}

	@Override
	public List<Map<String, Object>> getAllCity() {
		// TODO Auto-generated method stub
		return dao.City_selectAll();
	}

	@Override
	public boolean write_Motel(Map<String, Object> param) {
		if(dao.motel_insert(param) > 0) {
			return true;
		}else {
			return false;			
		}
	}

	//���� ���ε� ���� ���
	@Override
	public boolean write_Motel1(Map<String, Object> param, List<MultipartFile> files) {
		
		if(dao.motel_insert(param) > 0) {
			//MOTEL_TB �� �����Ͻ� �������̺� insert ���ش�
			
			int motel_num = (int)param.get("MOTEL_NUM");
			System.out.println("motel_num" + motel_num);
			
			Map<String, Object> filesParam = new HashMap<String, Object>();
			
			filesParam.put("MOTEL_NUM", motel_num);
			for(int i=0;i<files.size();i++) {
				filesParam.put("funllName" + i, wirte_motel_Photo(files.get(i)));
			}
			System.out.println("filesParam : " + filesParam);
			return true;
		}else {
			return false;			
		}
	}
	
	@Override
	public String wirte_motel_Photo(MultipartFile file) {
		String fullName = null;
		//1. UUID������ ���� �����̸��� �ٿ��� fullName�� ����
		//2. ���� fullName���� ���� ����(������ ��ο� ����)
		//3. fullName ��ȯ
		
		//1. UUID������ ���� �����̸��� �ٿ��� fullName�� ����
		UUID uuid = UUID.randomUUID();
		fullName = uuid.toString()+"_" + file.getOriginalFilename();
		
		//2. ���� fullName���� ���� ����(������ ��ο� ����)
		File target = new File(UPLOAD_PATH, fullName);
		
		try {
			FileCopyUtils.copy(file.getBytes(), target);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fullName;
	}


}
