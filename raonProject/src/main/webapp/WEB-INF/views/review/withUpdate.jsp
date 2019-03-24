<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행후기 작성</title>
	<!-- include libraries(jQuery, bootstrap) -->
  	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
  	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
  	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
  	
  	<!-- include summernote css/js -->
  	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
  	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
  	
	<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
	
<style type="text/css">
	.starR{
        	background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
          	background-size: auto 100%;
          	width: 30px;
          	height: 30px;
          	display: inline-block;
          	text-indent: -9999px;
          	cursor: pointer;
    	}
    	.starR.on{
        	background-position:0 0;
    	}
    	#star {
        	margin-left: 20px; 
    	}
    	#starCase {
      		border: 1px solid #cccccc;
      		background-color: #eeeeee;
      		width: 800px;
      		float: right;
      		margin-bottom: 10px;
    	}
</style>
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
<%-- 	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include> --%>
<%-- 	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include> --%>
<%-- 	<jsp:include page="/WEB-INF/views/review/review-navbar.jsp"></jsp:include> --%>
	<!-- 인클루드 심플 헤더 END -->
	
	<form action="update" method="post" id="update">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<input type="text" name="userNum" value="${userNum}">
<%-- 	<input type="text" name="num" value="${with.WITH_NUM}"> --%>
		<div class="main-container">
			<section id="section-profile-update" class="bg-gray">
			<div class="container">
			
			<h1>
				<i class="fas fa-cloud" style="font-size:38px;color:aqua;"></i>
				후기를 수정하세요
			</h1>
			
			<!----------------------------------------- 별점 시작 -------------------------------------->
				<div id="starCase">
					<h5 style="text-align: center;">
						<b>별의 갯수로 평점을 남겨주세요</b>
					</h5>
					<div class="starRev" style="text-align: center;" id="reviewScore">
						<span class="starR on" id="star">별1</span> 
						<span class="starR" id="star">별2</span> 
						<span class="starR" id="star">별3</span> 
						<span class="starR" id="star">별4</span> 
						<span class="starR" id="star">별5</span>
						<input type="hidden" name="WITH_GPA" id="WITH_GPA" value="1">
					</div>
				</div>
				<!----------------------------------------- 별점 끝 -------------------------------------->
		
			<!-- Summernote -->
			<textarea rows="10" id="summernote" name="WITH_CONTENT">
				${with.WITH_CONTENT}
			</textarea>
			<script type="text/javascript">
				$(document).ready(function() {
					$('#summernote').summernote();
				});
				$('#summernote').summernote({
					height : 500,
					width : 1150,
					focus : true
				});
				
				
			</script>
			<input type="submit" class="btn btn-primary" id="save" value="저장">
		</div>
		</section>
		</div>
	</form>
	<br><br><br>
	<!-- 인클루드-푸터 -->
<%-- 	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include> --%>
	<!-- 인클루드-푸터 END -->
</body>
</html>