<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 후기 작성</title>

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
	<script type="text/javascript">
	// ------------------- 별점 시작 ------------------- //
    $(function(){
        $(".starRev span").click(function(){
             var index = $(".starRev span").index(this);
             console.log(index+1);
             for(i=0; i<5; i++){
                
                $(this).parent().children('span').removeClass('on');
                $(this).addClass('on').prevAll('span').addClass('on');
             }
             $("#WITH_GPA").val(index+1);
 
            return false;
          });    
    });
    // ------------------- 별점 끝 ------------------- //
	</script>
	
	<style type="text/css">
    	#box {
          float: left;
        	margin: 30px;
        	border: 1px solid #cccccc;
        	width: 250px;
        	height: 350px;
        	text-align: center;
        	font-size: 20px;
        	background: #eeeeee;
        	width: 250px;
        	height: 350px;
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
         	margin-top: 20px;
        	width: 100px;
        	height: 100px;
    	}
    	#btnSave {
        	width: 100px;
        	margin-left: 9%;
    	}
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
	
	<form id="withWrite" action="withWrite" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	TL : <input type="text" name="TL_USER_NUM" value="${param.num }">
	WR : <input type="text" name="WR_USER_NUM" value="${userNum}">
		<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
			<div class="tab-content">
				<h3>
					<i class="fas fa-cloud" style="font-size: 38px; color: aqua;"></i>
					${with.USER_LNM}${with.USER_FNM}님에게 후기를 남겨주세요
				</h3>
				<!----------------------------------------- 프로필 시작 -------------------------------------->
				<div class="box" id="box">
					<div id="userimg"></div>
					<br> 
					<a>${with.USER_LNM}${with.USER_FNM}</a> 
					<br><br> 
					<a>아이디 : <b>${with.USER_ID}</b></a> 
					<br><br> 
					<i class="fas fa-home"> 
						<br> 
						<a>숙소 평점</a> 
						<br>
						<a>
							<i style="color: blue;">4.2</i> / 5
						</a>
					</i> 
					<i class="fas fa-camera" style="margin-left: 20px;"> 
					<br>
						<a>후기 평점</a> 
						<br> 
						<a>
							<i style="color: blue;">4.8</i> / 5
						</a>
					</i>
				</div>
				<!----------------------------------------- 프로필 끝 -------------------------------------->
				<br>
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
				
				<!---------------------- 섬머노트 시작 ---------------------->
				<div style="float: right;">
					<textarea rows="10" id="summernote" name="WITH_CONTENT"></textarea>
				</div>
				
				<script type="text/javascript">
					$('.summernote').summernote({
						height : 500,
						minHeight : null,
						maxHeight : null,
						lang : 'ko-KR',
						onImageUpload : function(files, editor, welEditable) {
							sendFile(files[0], editor, welEditable);
						}
					});
					$('#summernote').summernote({
						height : 500,
						width : 800,
						focus : true
					});
					$(document).ready(function() {
						$('#summernote').summernote();
					});
				</script>
				<!---------------------- 섬머노트 끝 ---------------------->
				<input type="submit" class="btn btn-primary" id="btnSave" value="등록">
			</div>
		</div>
		</section>
	</div>
</form>

	<!-- 인클루드-푸터 -->
<%-- 	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include> --%>
	<!-- 인클루드-푸터 END -->
</body>
</html>