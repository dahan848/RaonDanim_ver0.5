package com.raon.raondanim.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.raon.raondanim.service.AccountsService;

@Controller
public class FileUploadController {
	
//    @RequestMapping(value = "/successUpload")
//    public String ajaxUpload() {
//        return "/accounts/profile";
//    }
	public Map<String, Object> param;
	
	@Autowired
	private AccountsService service;
	
	//메서드 끼리 Map 전달하기 위한 set,get
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	@ResponseBody
	@RequestMapping(value = "/fileUploadInfo")
	public void data(@RequestParam Map<String, Object> param) {
		//System.out.println("파일 업로드 데이터 요청받음");
		//System.out.println(param);
		setParam(param);
	}

	@ResponseBody
    @RequestMapping(value = "/fileUpload")
    public Boolean fileUp(MultipartHttpServletRequest multi) {
    	System.out.println("파일업로드 요청 받음");
    	//System.out.println(multi);
    	
    	//ajax로 반환 할 boolean 변수
    	//boolean result = false;
    	
        // 저장 경로 설정
        String root = multi.getSession().getServletContext().getRealPath("/");
        String path = root+"resources/upload/";
        
        System.out.println("경로  ? : " + path);
         
        String newFileName = ""; // 업로드 되는 파일명
        String usernum = (String) getParam().get("user_num") + "_"; //파일명 앞에 작성 할 usernum
        File dir = new File(path);
        if(!dir.isDirectory()){
            dir.mkdir();
        }
         
        Iterator<String> files = multi.getFileNames();
        while(files.hasNext()){
            String uploadFile = files.next();
            MultipartFile mFile = multi.getFile(uploadFile);
            String fileName = mFile.getOriginalFilename();
            System.out.println("실제 파일 이름 : " +fileName);
            newFileName = System.currentTimeMillis()+"."
                    +fileName.substring(fileName.lastIndexOf(".")+1);
            try {
                mFile.transferTo(new File(path+(usernum+newFileName)));
                //result = true;
            } catch (Exception e) {
            	e.printStackTrace();
            }
        }
        //System.out.println("변경 된 파일 이름 : " + newFileName); //이상하게 여기서는 usernum 붙은거로 안 나옴
        
        ////////////////DB에 넣는 작업
        //1. 서비스로 넘길 Map 선언 
        Map<String, Object> pic = new HashMap<String, Object>();
        //2. 서비스로 넘길 Map에 필요한 데이터 생성
        String filename = usernum+newFileName;
        //3 Map에 데이터 put
        pic.put("user_num", (String) getParam().get("user_num"));
        pic.put("filename", filename);
       //4 서비스에 인자 넘기기 및 서비스를 활용 return 값 설정
        System.out.println("인자 확인 : " + pic);
        return service.setProfilePic(pic);
    }
	
}
