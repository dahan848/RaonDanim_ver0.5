<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라온다님</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	function form_Check(){
		var up;
		up = confirm("등록하시겠습니까 ??");
		
		if(up){
			return true;
		}else{
			return false;
		}
// 		swal({
//             text:"등록하시겠습니까 ????",
//             icon:"warning",
//             buttons:[false,"확인"]
//          })
	}
</script>	
<style type="text/css">
textarea{
	margin: auto;
}
.btn_next{
 background-image: url('${contextPath}/img/motel/next.jpg');
    background-position:  0px 0px;
    background-repeat: no-repeat;
    width: 50px;
    height: 45px;
    border: 0px;
	cursor:pointer;
 	outline: 0;
 	margin-top : 10px;
 	float: right;
 	margin-right: 15%;
}
.btn_back{
 background-image: url('${contextPath}/img/motel/back.jpg');
    background-position:  0px 0px;
    background-repeat: no-repeat;
    width: 50px;
    height: 45px;
    border: 0px;
 	cursor:pointer;
 	outline: 0;
 	margin-top : 10px;
 	float: left;
 	
}
</style>
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->



	<!-- 본문 -->
	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
			<!-- 이 부분에 자신의 페이지 넣기 -->
				<div class="registor_main">
					<form action="registor" method="post" onsubmit="return form_Check();">
					<input type="hidden" value="${_csrf.token}" name="${_csrf.parameterName}">
						<h3>
							숙소에 대한 소개를 남겨 주세요.<br>
						</h3>
						<textarea name="motel_intro" rows="10" cols="100"></textarea>
						<h3>
							숙소 등록을 위한 제목을 남겨 주세요.<br>
						</h3>
						<input type="text">
						<h3>
							숙소의 요금을 설정해 주세요.(설정하지 않을 경우 게스트가 무료로 이용 가능합니다.)<br>			
						</h3>
						<input type="text">
						<input type="submit" value="" class="btn_next">
						<input type="button" value= "" class="btn_back" onclick="history.back(-1);">
					</form>
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