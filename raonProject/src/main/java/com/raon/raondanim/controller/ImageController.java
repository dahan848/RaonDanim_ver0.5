package com.raon.raondanim.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class ImageController {
	@Resource(name = "uploadPath")
	private String FILE_PATH;
	//private static final String FILE_PATH = "c:\\temp";
	
	@ResponseBody
	@RequestMapping("/image")
	public byte[] getImage(String fileName) {
		//System.out.println("==================/image 요청==================");
		//System.out.println(fileName);
		//해당 이미지를 byte[]형태로 반환
		File file = new File(FILE_PATH+fileName);
		InputStream in = null;
		
		try {
			in = new FileInputStream(file);
		
			return IOUtils.toByteArray(in);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return null;
	}
}