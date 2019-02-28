<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- contextPath 설정 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%	request.setAttribute("contextPath", request.getContextPath()); %>
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
		 //기존 비밀번호, 새로운 비밀번호 유효성 검사 : 동일한 값인지
		 $("#id_password1").on("blur", function() {
			//비교 할 비밀번호 값 변수에 참조 
			var oldPw = $("#id_oldpassword").val();
			var newPw = $(this).val();
			//조건문을 통해 검사 1. 기존 비밀번호 칸에 값이 입력 된 상태이면 
			if(oldPw.length != 0){
				if(oldPw == newPw){
					//경고창 문구 출력 
					$("#alarm").text("기존 비밀번호와 같은 비밀번호는 사용할 수 없습니다.");
					$("#alarm").css("color","red");
					//swal({text: "기존 비밀번호와 같은 비밀번호로 변경 할 수 없습니다.",button: "확인"});
					//값 비우기 
					$(this).val('');
				}else{
					$("#alarm").text('');
				}//비교 if END
			}//oldPw If END
		});
		 
		 $("#section-authentication").on("submit", function() {
	    		
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
	    				if(data){
	        				swal({
	      					  text: "비밀번호 변경에 성공하였습니다.",
	      					  button: "확인",
	      					  confirmButtonColor: "#484848",
	      					}).then(function() {
	      						location.reload();
	      					});	
	    				}else{
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
	 });
	</script>
	<section id="section-authentication" style="height: 800px;">
		<div class="container" style="margin-top: 100px;">
			<div class="form-block">
				<img src="${contextPath}/img/home_logo-raon.png" alt="">
				<form name="pwChange" id="password-change-form" method="post">
					<div class="form-group">
						<label class="sr-only control-label" for="id_oldpassword">현재 비밀번호</label>
						<input class="form-control" id="id_oldpassword"
							name="old_user_pw " placeholder="현재 비밀번호" title="" type="password"
							required />
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
					<button type="submit" class="btn btn-potluck btn-block">비밀번호 변경</button>
					<hr>
                    <span id ="alarm"></span>
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