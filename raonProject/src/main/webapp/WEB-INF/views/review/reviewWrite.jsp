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
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
<%-- 	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include> --%>
<%-- 	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include> --%>
<%-- 	<jsp:include page="/WEB-INF/views/review/review-navbar.jsp"></jsp:include> --%>
	<!-- 인클루드 심플 헤더 END -->
	
	<form action="write" method="post" id="write">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<div class="main-container">
			<section id="section-profile-update" class="bg-gray">
			<div class="container">
			
			<h1>
				<i class="fas fa-cloud" style="font-size:38px;color:aqua;"></i>
				후기 작성
			</h1>
			
			<div class="form-group">
				<label for="inputlg">제목</label> 
				<input class="form-control input-lg" name="REV_TITLE" id="inputlg" type="text">
			</div>
			
			<div class="form-group">
				<label for="inputlg">여행지</label> 
				<input class="form-control input-lg" name="REV_DESTINATION" id="inputlg" type="text">
			</div>
		
			<!-- Summernote -->
			<textarea rows="10" id="summernote" name="RE_CONTENT"></textarea>
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