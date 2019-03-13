<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	request.setAttribute("contextPath", request.getContextPath()); %>	    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>111333</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
<!-- ��Ŭ��� ���� ��� -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
	<!-- ��Ŭ��� ���� ��� END -->



	<!-- ���� -->
	<div class="main-container" style="padding:0 0 0 0">
		<section id="section-profile-update" class="bg-gray">
			<div class="container" style="width: 100%; padding-left: 10%; padding-right: 10%;">
			<!-- �� �κп� �ڽ��� ������ �ֱ� -->
				<div class="registor_main">
					<h3 class="regisor_main_contents" >
					���Ҹ� ����ϰ� ���ο� �پ��� ģ���� �����<br>�ΰ����� ������ ȹ���ϼ���2222.<br>
					<a class="a_tag" href = "${contextPath}/motel/write_registor_type_style" >���� ����Ϸ� ����</a></h3>
				</div>
			</div>
		</section>
	</div>
		
	<!-- ���� END-->

	<!-- ��Ŭ���-Ǫ�� -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- ��Ŭ���-Ǫ�� END -->
</body>
</html>