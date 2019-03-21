$(document).ready(function() {
	alert("테스트4");
	//이메일 유효성 및 중복여부 체크 
	$("#id_email").change(function(){
		emailCheck($('#id_email').val());
	});
	
	//비밀번호 조건식 검사 
	$("#id_password1").change(function(){
	    checkPassword($('#id_password1').val());
	});

	//비밀번호 동일 검사  
	$("#id_password2").change(function(){
	    checkPassword2($('#id_password1').val(),$('#id_password2').val());
	});
	
	//서밋 이벤트가 발생하면 알람창 출력 
	/*
	 	sweetalert은 일반 alert와 달리 창이 떠 있는 동안 발생 한 이벤트가 멈추지 않는다.
	 	preventDefault();와 setTimeout 그리고 sweetalert에 .then()을 추가하여 해당 문제를 해결 
	 */
	$("#signupform").submit(function(event){
		var form = this;
		swal({
			  title: "환영합니다!",
			  text: "사이트 이용은 이메일 인증 이후 가능합니다.",
			  icon: "success",
			  button: "확인",
			}).then(function() {
				//확인 버튼을 누르면 바로 submit 이벤트를 발생
				form.submit();
			});		
		//submit 이벤트를 멈춘다.
		event.preventDefault();
		//5초 후에 다시 해당 폼의 submit 이벤트를 발생시킨다.
	    setTimeout( function () { 
	        form.submit();
	    }, 5000);
	});

	
	if($("input:checkbox[id='id_is_agreed_2']").is(":checked") == true){
		alert("테");
	}
});//onLoad END

//이메일 사용가능 여부 체크 
function emailCheck(email) {
	var path = "http://localhost:8081";
	/*
	 1.유효성 검사를 통해 이메일 주소 인지 판단
	 2.사용자가 입력 한 이메일 주소가 이미 가입되어 있는 이메일 주소인지 Ajax로 비동기적 체크 
	*/
	
	//1.유효성 검사
	var idForm = $("#idCheck"); 
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; //정규식 
	if(exptext.test(email)==false){
		idForm.text("유효한 이메일 주소를 입력하십시오."); 
		idForm.show(); 
		$('#id_email').val('').focus();
	}else{
		idForm.hide();
		//2.Ajax 활용 중복여부 체크 
		$.ajax({
	        type : 'get',
	        url : path + '/accounts/emailCheck',
	        data : {"check":email},
	        datType:"json",
	        success : function(result) {
	        	if(result){
	        		idForm.hide();
	        	}else{
	        		idForm.text("해당 이메일은 이미 사용되고 있습니다."); 
	        		idForm.show(); 
	        		$('#id_email').focus();
	        	}
	        },
	        error : function(error) {
	            console.log(error);
	            console.log(error.status);
	        }
	    });
	}
}

//비밀번호 1,2가 같은지 체크하는 함수 
function checkPassword2(pw1, pw2) {
	
	//alert("1번 칸 : " + pw1 + " 2번 칸  : " + pw2);
	/*
	 비밀번호 입력 칸 1,2의 비밀번호가 동일하지 않을경우 알람문구를 출력한다.
	 */
	
	//비밀번호 조건식 오류를 띄울 DIV 요소 선택 및 변수에 참조
	var pwForm = $("#pwCheck2");
	
	if(pw1 != pw2){
		pwForm.text("동일한 비밀번호를 입력해야 합니다."); 
		pwForm.show(); 
		$('#id_password2').val('').focus();
	}else{
		pwForm.hide();
	}
}

//비밀번호 조건식 검사 함수 
function checkPassword(password){
	
	/*
	 조건식 검사에 걸릴 경우, 관련 알람 문구를 출력
	 포커스를 문제가 발생 한 div에 고정 시키고 
	 이전에 입력 한 내용은 삭제 되게끔 설정 
	 조건식 검사에 체크 되고 이후에 올바르게 입력 된 경우 경고문구 div를 다시 감춘다.  
	 */
	
	//비밀번호 조건식 오류를 띄울 DIV 요소 선택 및 변수에 참조
	var pwForm = $("#pwCheck");
	if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(password)){            
		pwForm.text("숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다."); 
		pwForm.show(); 
		$('#id_password1').val('').focus();
		return false;
	}else{
		pwForm.hide();
	}
	
	var checkNumber = password.search(/[0-9]/g);
	var checkEnglish = password.search(/[a-z]/ig);
	if(checkNumber <0 || checkEnglish <0){
		pwForm.text("숫자와 영문자를 혼용하여야 합니다.");  
		pwForm.show(); 
		$('#id_password1').val('').focus();  
		return false;
	}else{
		pwForm.hide();
	}
	
	if(/(\w)\1\1\1/.test(password)){
		pwForm.text("같은 문자를 4번 이상 사용하실 수 없습니다."); 
		pwForm.show(); 
		$('#id_password1').val('').focus();  
		return false;
	}else{
		pwForm.hide();
	}
	
	return true;
}