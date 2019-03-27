<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	request.setAttribute("contextPath", request.getContextPath()); %>	  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.user_num" var="user_num"/>
</sec:authorize>  
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>111333</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
function login_Check(){
	var tmpUser_num = "${user_num}";
	//alert("tmpUser_num : " + tmpUser_num);
	if(tmpUser_num == ""){

		location.href = "${contextPath}/accounts/loginForm";	
	}else{
		
		location.href = "${contextPath}/motel/write_registor_type_style";
		
	}
	
}

</script>
<style type="text/css">
.registor_main{
	background-repeat : no-reapt; 
	height: 700px;
	width: 100%;
	background-image: url("${contextPath}/img/motel/motel_background.jpg");
	background-position: center;
	background-size: cover;
	
}

.regisor_main_contents{
	position : center;
	margin-top: 0px;
	margin-left:25%;
	margin-right: 25%;
	color: white; 
	text-align: center;
	padding-top: 15%
}
.a_tag{
	text-decoration: none;
	color: white;
}
</style>
<script type="text/javascript"></script>
</head>
<body>
<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->



	<!-- 본문 -->
	<div class="main-container" style="padding:0 0 0 0">
		<section id="section-profile-update" class="bg-gray">
			<div class="container" style="width: 100%; padding-left: 10%; padding-right: 10%;">
			<!-- 이 부분에 자신의 페이지 넣기 -->
				<div class="registor_main">
					<h3 class="regisor_main_contents" >
					숙소를 등록하고 새로운 다양한 친구를 만들며<br>부가적인 수입을 획득하세요.<br>
<%-- 					href = "${contextPath}/motel/write_registor_type_style"  --%>
					<a class="a_tag" onclick="login_Check()">숙소 등록하러 가기</a></h3>
				</div>
			</div>
		</section>
	</div>
		
	<!-- 본문 END-->

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>