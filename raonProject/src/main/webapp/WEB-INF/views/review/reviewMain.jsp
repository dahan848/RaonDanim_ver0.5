<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라온다님 여행후기 메인</title>

<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>

<script type="text/javascript">
	$(window).on("scroll",function() {
		var scrollHeight = $(document).height();
		var scrollPosition = $(window).height() + $(window).scrollTop();
		
		if(scrollPosition > scrollHeight - 300) {
			$("#scroll").append('<div class="box" id="box"></div>');
		}
	});
</script>

<style type="text/css">
	#upload {
		float: right;
		margin-right: 40px;
		background-color: #eeeeee;
		color: green;
		border: 1px solid #cccccc;
	}
	#box {
 		float: left; 
		margin: 10px;
		border: 1px solid black;
		width: 350px;
		height: 350px;
	}
	#backimg { 
   		background-image: url("${contextPath}/img/search-back.jpg");   
 		background-repeat: no-repeat; 
 		background-position: left; 
 		background-size: cover; 
	  	border: 1px solid red;  
 		z-index: 1; 
 		width: 348px; 
 		height: 190px; 
 		margin: auto; 
 	} 
 	#userimg { 
     	background-image: url("${contextPath}/img/user.jpg");      
  		background-repeat: no-repeat;  
  		background-position: bottom;  
 		background-size: cover; 
 		border-radius: 50%; 
 		z-index: 2; 
 		border: 1px solid black; 
 		margin: 0 auto; 
   		margin-top: -50px;   
 		width: 100px; 
 		height: 100px; 
 	} 
 	#profile { 
 		font-size: 20px; 
 		text-align: center; 
 		z-index: 1;
	} 
</style>


</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/review/review-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->

	<!-- 본문 -->
	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<h3 id="h3" style="font-family: 'Nanum Pen Script', cursive; font-size: 50px;"><b>여행후기</b></h3>
				<h5 style="font-family: 'Nanum Pen Script', cursive;  font-size: 30px;">다른 회원들에게 여행지 정보를 공유해주세요</h5>
				<input type="button" onclick="location.href='writeForm'" class="btn btn-primary" id="upload" value="후기 올리기">
				<br><br>			
				
				<div id="scroll">
				<!------------ 회원 프로필 화면 시작 ------------>
				<c:forEach items="${review}" var="review" varStatus="status">
					<div class="box" id="box">
						<div id="backimg"></div>
	  					<div id="userimg"></div>  
						<div id="profile">
							<span style="text-align: center; display: inline-block;">${review.USER_LNM}${review.USER_FNM}</span>
							<br>
							<span style="text-align: center; display: inline-block; text-decoration: none;">여행지 : <b>${review.REV_DESTINATION}</b></span>
							<br>
							<a href="reviewView?num=${review.REVIEW_NUM}" style="text-align: center;">${review.REV_TITLE}</a>
						</div>
					</div>		
				</c:forEach>
				<!------------ 회원 프로필 화면 끝 ------------>
				</div>
			
				<!------------ 화면 맨 위로 시작 ------------>
				<div style="position: fixed; bottom: 20px; right: 150px;">
					<a href="#h3" style="font-size: 50px;">
						<i class="fas fa-arrow-alt-circle-up" style="color: #cccccc;"></i>
					</a>
				</div>
				<!------------ 화면 맨 위로 끝 ------------>
			</div>
		</section>
	</div>
	<!-- 본문 END-->

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>