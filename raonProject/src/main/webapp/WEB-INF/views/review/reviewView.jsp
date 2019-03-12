<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행후기 상세보기</title>

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
<script type="text/javascript">
	$(function() {
		
		createReplyList();
		
		$("#replyForm").on("submit", function () {
			var d = $(this).serialize();
			$.ajax({
				url : "${contextPath}/reply/reply",
				data : d,
				type : "post",
				datatype : "json",
				success : function(data) {
					if(data) {
						createReplyList();
						$("#inputReply").val("");
					}
				}
			});
			return false;
		});
	});
	
	function createReplyList() {
		var replyTable = $("#replies");
		$("#replies tr:gt(0)").remove();
		$.ajax({
			url : "${contextPath}/reply/all/${review.REVIEW_NUM}",
			type : "get",
			dataType : "json",
			success : function(data) {
				for(var i in data) {
					var tr = $("<tr>");
					var href = $("<a href='#' style='text-decoration: none;'>신고</a>");
					var btnUpdate = $("<button type='button' class='btn btn-primary' id='btnUpdate' onclick='#'>수정</button>");
					var btnDelete = $("<button type='button' class='btn btn-primary' id='btnDelete' onclick='#'>삭제</button>");
					$("<td style='text-align: center; border: 1px solid #cccccc;'>").text(data[i].USER_LNM+data[i].USER_FNM).appendTo(tr);
					$("<td style='border: 1px solid #cccccc;'>").text(data[i].REV_REP_CONTENT).appendTo(tr);
					$("<td style='text-align: center; border: 1px solid #cccccc;'>").append(btnUpdate).appendTo(tr);
					$("<td style='text-align: center; border: 1px solid #cccccc;'>").append(btnDelete).appendTo(tr);
					$("<td style='text-align: center; border: 1px solid #cccccc;'>").append(href).appendTo(tr);
					tr.appendTo(replyTable);
				}
			}
		});
	}
</script>


<style type="text/css">
	#btnUpdate{
		background-color: #eeeeee;
		color: green;
		border: 1px solid #cccccc;
	}
	#btnDelete{
		background-color: #eeeeee;
		color: green;
		border: 1px solid #cccccc;
	}
	#box {
  		float: left;  
		margin: 30px;
		border: 1px solid #cccccc;
		width: 250px;
		height: 350px;
		text-align: center;
		font-size: 20px;
		background: #eeeeee;
	}
	#form-group {
		width: 800px;
		float: right;
	}
	#btnList {
		float: right;
	}
	#btnSave {
		display: inline;
		float: right;
	}
	#inputReply {
		width: 1000px; 
		display: inline;
	}
	#contentView {
		 border: 1px solid #cccccc;
/* 		 width: 800px; */
		 width: auto;
		 height: auto;
		 background: #eeeeee;
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
</style>

  
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/review/review-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->



<form action="reviewView" method="get">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
		<div class="tab-content">
			
			<!----------------------------------------- 프로필 시작 -------------------------------------->
			<div class="box" id="box">
				<div id="userimg"></div>
				<br>
				<span>${review.USER_LNM}${review.USER_FNM}</span>
				<br><br>
				<span>여행지 : <b>${review.REV_DESTINATION}</b></span>
				<br><br>
				<i class="fas fa-home">
					<br>
					<span>숙소 평점</span>
					<br>
					<span><i style="color: blue;">4.2</i> / 5</span>
				</i>
				<i class="fas fa-camera" style="margin-left: 20px;">
					<br>
					<span>후기 평점</span>
					<br>
					<span><i style="color: blue;">4.8</i> / 5</span>
				</i>
			</div>
			<!----------------------------------------- 프로필 끝 -------------------------------------->
			
			<h3>
				<i class="fas fa-cloud" style="font-size:38px;color:aqua;"></i>
				${review.USER_LNM}${review.USER_FNM}님의 여행후기입니다
			</h3>
			
			<button type="button" class="btn btn-primary" id="btnList" onclick="location.href='reviewMain'">후기 목록</button>
			
			<!------------ 등록한 정보 출력 시작 ------------>
				<div class="form-group" id="form-group">
					<label for="inputlg">제목</label> 
					<input class="form-control input-lg" id="inputlg" type="text" readonly="readonly" value="${review.REV_TITLE}">
				</div>
			
				<div class="form-group" id="form-group">
					<label for="inputlg">여행지</label> 
					<input class="form-control input-lg" id="inputlg" type="text" readonly="readonly" value="${review.REV_DESTINATION}">
				</div>
			
				<div class="form-group" id="form-group">
					<label for="inputlg">후기</label> 
					<div class="form-control input-lg" id="contentView">
						${review.RE_CONTENT}
					</div>
				</div>
			<!------------ 등록한 정보 출력 끝 ------------>
				
			</div>
		</div>
		
	</section>
	</div>	
</form>

<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
		<div class="tab-content">
		
		<!------------ 댓글 리스트 시작 ------------>
			<table class="table table-striped" id="replies">
      				<tr style="border: 1px solid #cccccc;">
        				<th style="width: 130px; border: 1px solid #cccccc; text-align: center;">닉네임</th>
        				<th style="width: 700px; border: 1px solid #cccccc; text-align: center;">댓글</th>
        				<th style="border: 1px solid #cccccc; text-align: center;">수정</th>
        				<th style="border: 1px solid #cccccc; text-align: center;">삭제</th>
        				<th style="float: right;"></th>
      				</tr>
  			</table>
  		<!------------ 댓글 리스트 끝 ------------>	
  			
  		<!------------ 댓글 리스트 페이징 시작 ------------>
  			<div align="center">
  				<ul class="pagination justify-content-center">
  					<li class="page-item">
    					<a class="page-link" href="javascript:void(0);">
    						Previous
    					</a>
    				</li>
    				<li class="page-item">
    					<a class="page-link" href="javascript:void(0);">
    						1
    					</a>
    				</li>
    				<li class="page-item">
    					<a class="page-link" href="javascript:void(0);">
    						2
    					</a>
    				</li>
    				<li class="page-item">
    					<a class="page-link" href="javascript:void(0);">
    						3
    					</a>
    				</li>
    				<li class="page-item">
    					<a class="page-link" href="javascript:void(0);">
    						4
    					</a>
    				</li>
    				<li class="page-item">
    					<a class="page-link" href="javascript:void(0);">
    						5
    					</a>
    				</li>
    				<li class="page-item">
    					<a class="page-link" href="javascript:void(0);">
    						Next
    					</a>
    				</li>
  				</ul>
  			</div>
			<!------------ 댓글 리스트 페이징 끝 ------------>
	
  			<!------------ 댓글 달기 시작 ------------>
  			<form name="replyForm" id="replyForm" method="post" action="#">
  				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
  				<input type="hidden" name="REVIEW_NUM" value="${review.REVIEW_NUM}">
  				<input type="hidden" name="USER_NUM" value="${review.USER_NUM}">
  				<input type="text" class="form-control form-control-sm" placeholder="댓글을 입력하세요" id="inputReply" name="REV_REP_CONTENT">
				<input type="submit" class="btn btn-primary" id="btnSave" value="등록">
			</form>
			<!------------ 댓글 달기 끝 ------------>
			
		</div>	
	</div>
	</section>
	</div>
	<br><br><br>
	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>