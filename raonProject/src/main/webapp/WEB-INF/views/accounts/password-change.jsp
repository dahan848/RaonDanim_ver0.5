<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- contextPath 설정 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라온다님</title>
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->
	<script type="text/javascript">
	
	 $(document).ready(function(){

		 
		//비교 할 비밀번호 값 변수에 참조 
		var oldPw = $("#oldpassword").val(); //DB에 저장 된 비밀번호  
		var path = "http://localhost:8081";
		//현재 비밀번호의 입력 유효성 검사
		/*
			비밀번호는 암호화 되어 저장되어 있기 때문에 
			Ajax를 활용해서 비동기적으로 처리한다.
		*/
		$("#id_oldpassword").change(function(){
			var inPutOldPw = $("#id_oldpassword").val(); //사용자가 입력 한 현재 비밀번호			 
			 //사용자가 '현재 비밀번호' 입력 창에 길이 '0'이상의 문자열을 입력 한 경우 
			 if(inPutOldPw.length != 0){
				 	//Ajax로 현재 사용자가 입력 한 비밀번호를 전송한다.
					$.ajax({
				        type : 'get',
				        url : path + '/accounts/passwordCheck',
				        data : {"check":inPutOldPw},
				        datType:"json",
				        success : function(result) {
				        	if(result){
				        		//동일한 비밀번호 입력 시, 출력 되었던 메시지를 지워준다.
				        		$("#alarm").text('');
				        	}else{
				        		//DB에 저장 된 비밀번호가 다른 비밀번호가 입력 될 경우 메시지를 화면단에 보여준다,
								 $("#alarm").text("기존 비밀번호와 다른 비밀번호가 입력되었습니다.");
								 $("#alarm").css("color","red");
								 $("#id_oldpassword").val('').focus();
				        	}
				        },
				        error : function(error) {
				            console.log(error);
				            console.log(error.status);
				        }
				    });
		 	 }
		});
		
		//새 비밀번호 입력 창 1 유효성 검사 
		$("#id_password1").change(function(){
			var inPutOldPw = $("#id_oldpassword").val(); //사용자가 입력 한 현재 비밀번호
			var newPw = $("#id_password1").val();
			if(inPutOldPw.length != 0 && inPutOldPw == newPw){
				$("#alarm").text("기존 비밀번호와 같은 비밀번호는 사용할 수 없습니다.");
				$("#alarm").css("color","red");
				$(this).val('').focus();
			}
		});
		
		//새 비밀번호 입력 창 2 유효성 검사 
		$("#id_password2").change(function(){
			var newPw1 = $("#id_password1").val(); 
			var newPw2 = $("#id_password2").val();
			if(newPw1.length != 0 && newPw1 != newPw2){
				$("#alarm").text("새로운 비밀번호가 동일하지 않습니다.");
				$("#alarm").css("color","red");
				$(this).val('').focus();
			}
		});
				
		 $("#password-change-form").on("submit", function() {
	    		//fomr 요소에 있는 데이터 직렬화 
	    		var pwdata = $(this).serialize();
	    		$.ajax({
	    			url:"${contextPath}/accounts/passwordChange",
	    			dataType : "json",
	    			type:"post",
	    			data:pwdata,
	                beforeSend : function(xhr)
	                {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                },
	    			success:function(data){
	    				if(data == 0){
	    					//변경 할 비밀번호가 서로 맞지 않는 경우
	    					$("#alarm").text("새로운 비밀번호가 동일하지 않습니다.");
							$("#alarm").css("color","red");
							$("#id_password2").val('');
	    				}else if(data == 1){
	    					//변경에 성공하면 로그아웃 처리
	    					logout();
	        				swal({
	        					  title:"비밀번호 변경에 성공하였습니다.",
		      					  text: "새로운 비밀번호로 로그인 해주세요.",
		      					  button: "확인",
		      					  confirmButtonColor: "#484848",
		      					}).then(function() {
		      						//알람 창 출력 후 메인 화면으로 이동 
		      						window.location = "http://localhost:8081/home";
		      					});	
	    				}else if(data == 2){
	        				swal({
	        					  text: "비밀번호 변경에 실패하였습니다.",
	        					  button: "확인",
	        					  confirmButtonColor: "#484848",
	        					}).then(function() {
	        						location.reload();
	        					});	
	    				}
	    			},
	    		});
	    		return false;
	    	});//submit END
	 });//onLoad END
	 //로그아웃 함수
	function logout() {
		$.ajax({
			url:"/accounts/logout"
		});
	}
	</script>
	<section id="section-authentication" style="height: 800px;">
		<div class="container" style="margin-top: 100px;">
			<div class="form-block">
				<img src="${contextPath}/img/home_logo-raon.png" alt="">
				<form name="pwChange" id="password-change-form" method="post">
					<input type="hidden" id = "oldpassword" name="user_pw" value="${pass}">
					<div class="form-group">
						<label class="sr-only control-label" for="id_oldpassword">현재
							비밀번호</label> <input class="form-control" id="id_oldpassword"
							name="old_user_pw" placeholder="현재 비밀번호" title=""
							type="password" required />
					</div>
					<div class="form-group">
						<label class="sr-only control-label" for="id_password1">새
							비밀번호</label><input class="form-control" id="id_password1"
							name="new_user_pw1" placeholder="새 비밀번호" title="" type="password"
							required />
					</div>
					<div class="form-group">
						<label class="sr-only control-label" for="id_password2">새
							비밀번호 (확인)</label><input class="form-control" id="id_password2"
							name="new_user_pw2" placeholder="새 비밀번호 (확인)" title=""
							type="password" required />
					</div>
					<button type="submit" class="btn btn-potluck btn-block">비밀번호
						변경</button>
					<hr>
					<span id="alarm"></span>
				</form>
			</div>
			<p>라온다님에 오신것을 환영합니다</p>
		</div>
	</section>
	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>