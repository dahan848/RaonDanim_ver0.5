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
	
	
	<script type="text/javascript">
		$(function() {
			
			//국가입력 스크립트
			$("#national").click(function() {
				$(this).next().show();
				$(this).next().hide();
			});
			
			$("#write").on("submit", function () {
				var nation = $("#national").val();
				
				var nation_split = nation.split(', ');
				var nation_en = nation_split[0];
				var nation_ko = nation_split[1];
				
				var checkNum = 0;
				
				$.ajax({
					url : "${contextPath}/review/DB_nation",
					type : "get",
					async : false,
					dataType : "json",
					success : function (data) {
						for(var i in data) {
							if(data[i].NATIONALITY_KOR_NAME == nation_ko && data[i].NATIONALITY_NAME == nation_en) {
								checkNum++;
								break;
							}
						}
					}
				});
				
				//debugger
				if(checkNum == 2) {
					
				}else {
					swal({
			               text:"국가를 정확히 선택해 주세요.",
			               icon:"warning",
			               buttons:[false,"확인"]
			            })
					return false;
				}
				
			});
			
		});
		
		//국가 도시 검색 후 엔터키 쳤을 때 페이지 넘어가는것 막는 코드
		 function captureReturnKey(e) {
	         if(e.keyCode==13 && e.srcElement.type != 'textarea')
	         return false;
	     }
	</script>
	
	
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
<%-- 	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include> --%>
<%-- 	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include> --%>
<%-- 	<jsp:include page="/WEB-INF/views/review/review-navbar.jsp"></jsp:include> --%>
	<!-- 인클루드 심플 헤더 END -->
	
	<form action="write" method="post" id="write">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<input type="hidden" name="userNum" value="${userNum}">
		<div class="main-container">
			<section id="section-profile-update" class="bg-gray">
			<div class="container">
			
			<h1>
				<i class="fas fa-cloud" style="font-size:38px;color:aqua;"></i>
				후기 작성
			</h1>
			
			<br>
			
			<div class="form-group">
				<input class="form-control input-lg" name="REV_TITLE" id="inputlg" type="text" placeholder="TITLE">
			</div>
			
			<br>
			
			<div class="form-group">
<!-- 				<input class="form-control input-lg" name="REV_DESTINATION" id="inputlg" type="text"> -->
					<c:if test="${!empty national}">
						<input list="brow" id="national" class="form-control input-lg" name="REV_DESTINATION" placeholder="DESTINATION">
						<datalist id="brow">

							<c:forEach var="national" items="${national}" varStatus="i">

								<option id = "nationDB"
									value="${national.NATIONALITY_NAME}, ${national.NATIONALITY_KOR_NAME}" 
										onkeypress='chkCode(this,event.keyCode)'>
								</option>

							</c:forEach>

						</datalist>
					</c:if>
			</div>
		
			<br>
		
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
			
			<br>
			
			<button type="submit" class="btn btn-primary" id="save" value="저장" 
						style="margin-left: 48%; background-color: #eeeeee; color: green; border: 0.5px solid #cccccc;">
				<i class="far fa-edit"></i> 저장
			</button>
			
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