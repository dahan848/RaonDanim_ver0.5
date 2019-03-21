<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 시큐리티 태그라이브러리 -->
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="org.springframework.security.core.Authentication"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한 테스트</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<!-- 프로필 추가 작성 유/무를'profile_st'라는 변수에 참조 -->
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.user_profile_st"
			var="profile_st" />
	</sec:authorize>
	<!-- 로그인 상태에서 특정 요소가 보이도록  -->
	<sec:authorize access="isAuthenticated()">
		<button id="btn_test">글쓰기</button>
	</sec:authorize>
	<!-- 비로그인 상태에서 특정 요소가 보이도록 -->
	<sec:authorize access="isAnonymous()">
		<a>로그인 해주세요.</a>
	</sec:authorize>
</body>
<script type="text/javascript">
$(document).ready(function() {
	alert("테스트 화면 온로드4");
	//버튼을 변수에  참조 
	var btn = $("#btn_test");
	//버튼 클릭 이벤트에 따른 익명함수 정의
	btn.click(function() {
		//사용자가 추가 프로필을 작성하였는가 ?
		if(${profile_st}){
			//작성 한 상태 
			alert("추가 프로필 작성 한 상태이면 글 쓰기 화면으로 요청을 넘긴다.");
		}else{
			//작성 하지 않은 상태
			swal({
		      title: "글 등록을 할 수 없습니다.",
		      text: "글 등록은 프로필 작성 이후 가능합니다.",
		      icon: "warning",
		      buttons: [
		        '취소',
		        '확인'
		      ],
     		 dangerMode: true,
		    }).then(function(isConfirm) {
		      if (isConfirm) {
		        swal({
		          text: '프로필 추가 작성 페이지로 이동합니다.',
		          buttons : '이동'
		        }).then(function() {
		        	window.location = "http://localhost:8081/home";
		        });
		      }
		    })
		}//프로필 조건문 END
	});//클릭 이벤트 END
});//온로드 END
</script>
</html>