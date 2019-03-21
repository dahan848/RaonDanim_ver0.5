package com.raon.raondanim.controller;

import java.io.File;
import java.security.Principal;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.raon.raondanim.model.customUserDetails;
import com.raon.raondanim.service.AccountsService;

@Controller
public class FileUploadController {
	
	@Resource(name = "uploadPath")
	private String FILE_PATH;
	
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
	@RequestMapping(value = "/picInfo")
	public void data(@RequestParam Map<String, Object> param) {
		//System.out.println("파일 업로드 정보 전달 받음");
		//System.out.println(param);
		setParam(param);
	}
	
	
	//프로필 사진 업로드 메서드
	@ResponseBody
    @RequestMapping(value = "/profilePicUpload")
    public Boolean fileUp(MultipartHttpServletRequest multi) {
    	//System.out.println("profilePicUpload 요청 받음");
    	//System.out.println(multi);
    	
    	//ajax로 반환 할 boolean 변수
    	//boolean result = false;
    	         
        String newFileName = ""; // 업로드 되는 파일명
        String usernum = (String) getParam().get("user_num") + "_profile_"; //파일명 앞에 작성 할 usernum
        File dir = new File(FILE_PATH);
        if(!dir.isDirectory()){
            dir.mkdir();
        }
         
        Iterator<String> files = multi.getFileNames();
        while(files.hasNext()){
            String uploadFile = files.next();
            MultipartFile mFile = multi.getFile(uploadFile);
            String fileName = mFile.getOriginalFilename();
            //System.out.println("실제 파일 이름 : " +fileName);
            Random random = null;
            String randomName = "";
            for (int i = 0; i < 6; i++) {
            	random = new SecureRandom();
            	int temp = random.nextInt(9);
            	randomName += Integer.toString(temp);
            }
            newFileName = System.currentTimeMillis()+randomName+"."
                    +fileName.substring(fileName.lastIndexOf(".")+1);
            try {
            		mFile.transferTo(new File(FILE_PATH+(usernum+newFileName)));
                //result = true;
            } catch (Exception e) {
            	e.printStackTrace();
            }
        }
        //System.out.println("변경 된 파일 이름 : " + newFileName); //이상하게 여기서는 usernum 붙은거로 안 나옴
        
        
        // 중요! 서비스 그리고 UserPrincipal에 넘길 데이터 (파일이름) 문자열 변수 선언 및 초기화
        String filename = usernum+newFileName;
        
        ////////////////시큐리티 세션에 저장되어 있는 정보를 바꾸는 작업
        //시큐리티 세션에 저장되어 있는 UserPrincipa의 프로필 관련 정보를 바꾸어 주기 위해서 필요한 변수를 선언해준다.
      	Principal auth = multi.getUserPrincipal();
      	customUserDetails userDetails = (customUserDetails) ((Authentication) auth).getPrincipal ();

      	//여기서 인자로 넘겨주는 String 문자열은 앞선 작업으로 생성된 파일의 이름이다. 
      	userDetails.setUser_profile_pic(filename);
        
        ////////////////DB에 넣는 작업
        //1. 서비스로 넘길 Map 선언 
        Map<String, Object> pic = new HashMap<String, Object>();
        //2 Map에 데이터 put
        pic.put("user_num", (String) getParam().get("user_num"));
        pic.put("filename", filename);
        //3 서비스에 인자 넘기기 및 서비스를 활용 return 값 설정
        //System.out.println("인자 확인 : " + pic);
        return service.setProfilePic(pic);
    }
	
	//갤러리 업로드 메서드 
	@ResponseBody
    @RequestMapping(value = "/galleryPicUpload")
    public Boolean galleryfileUp(MultipartHttpServletRequest multi) {
		//System.out.println("galleryPicUpload 요청 받음");
		//System.out.println(multi);
         
        String newFileName = ""; // 업로드 되는 파일명
        String delimiter = "_gallery_"; //구분자
        String usernum = (String) getParam().get("user_num") + delimiter; //파일명 앞에 작성 할 usernum
         
        File dir = new File(FILE_PATH);
        if(!dir.isDirectory()){
            dir.mkdir();
        }
         
        Iterator<String> files = multi.getFileNames();
        
        //파일을 여러개 입력 하여야 하기 때문에, while 밖에서 여러 사진 정보를 담을 수 있는 List<Map> 변수 선언 
        List<Map<String, Object>> pic = new ArrayList<Map<String, Object>>();
        //user_num은 변동이 없기에 미리 밖에서 선언 해둔다. * getter로 가져오는 것이기에 굳이 쓸 떄 없는 반복을 피하기 위해..
        String user_num = (String) getParam().get("user_num");
        
        int count = 1;
        while(files.hasNext()){
            String uploadFile = files.next();
                         
            MultipartFile mFile = multi.getFile(uploadFile);
            String fileName = mFile.getOriginalFilename();
            //System.out.println("실제 파일 이름 : " +fileName);
            
            //System.currentTimeMillis() 해당 함수를 통해 숫자 번호를 생성하는데
            //요청 시간의 차이가 매우 짧은 경우 중복값이 발생한다. 이를 보안하기 위해 랜덤난수 생성 
            Random random = null;
            String randomName = "";
            for (int i = 0; i < 6; i++) {
            	random = new SecureRandom();
            	int temp = random.nextInt(9);
            	randomName += Integer.toString(temp);
            }
            
            //위에서 생성한 난수를 확장자명과 System.currentTimeMillis() 사이에 추가한다.
            newFileName = System.currentTimeMillis()+randomName+"."
                    +fileName.substring(fileName.lastIndexOf(".")+1);
            
            //반복문을 돌면서 새로운 Map을 만들어 준다.
            Map<String, Object> picData = new HashMap<String, Object>();
            try {
            	//존재하지 않는 (input에 추가 안된) 파일을 거르기 위한 작업 
            	//파일 이름에서 .을 기준으로 뒤에 오는 문자열 개수를 체크 
            	int idx = newFileName.indexOf(".");
            	//문자열 변수에 '.'을 기준으로 뒤에 오는 문자열을 참조한다.
            	String check = newFileName.substring(idx+1);
            	if(!check.isEmpty()) {
            		//만약 check 문자열의 값이 Null 이라면 = 확장자명이 없는 파일이라면 = 파일이 선택 안된 input의 더미
            		//즉, check의 값이 Null이 아닐 때만 파일 업로드 로직을 실행한다.
            		mFile.transferTo(new File(FILE_PATH+(usernum+newFileName)));
            		String filename = usernum+newFileName; //실제 저장되는 파일 이름
            		picData.put("filename", filename); //파일네임 put
            		picData.put("user_num", user_num); //유저넘 put
            		
                    //while문이 끝나기 전에 List에 Map을 담는다.
            		//조건문 내에서 파일이 있을 때만 파일명을 생성하기 때문에 add 역시 조건문 안에서 해준다.
                    pic.add(picData);
            	}
            } catch (Exception e) {
                e.printStackTrace();
            }

            //System.out.println(count+"번 째 생성 된 파일 : " + picData);
            count ++;
        }
		//System.out.println("넘겨줄 데이터 확인 : " + pic);
		return service.setGalleryPic(pic);
	}
	
}
