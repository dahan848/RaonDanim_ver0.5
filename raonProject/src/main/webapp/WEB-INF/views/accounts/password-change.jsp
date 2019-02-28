<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- contextPath 설정 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%	request.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라온다님</title>
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->
	<section id="section-authentication">
		<div class="container">
			<div class="form-block">
				<img src="${contextPath}/img/home_logo-raon.png" alt="">
				<form method="post">
					<div class="form-group">
						<label class="sr-only control-label" for="id_oldpassword">현재
							비밀번호</label><input class="form-control" id="id_oldpassword"
							name="oldpassword" placeholder="현재 비밀번호" title="" type="password"
							required />
					</div>
					<div class="form-group">
						<label class="sr-only control-label" for="id_password1">새
							비밀번호</label><input class="form-control" id="id_password1"
							name="password1" placeholder="새 비밀번호" title="" type="password"
							required />
					</div>
					<div class="form-group">
						<label class="sr-only control-label" for="id_password2">새
							비밀번호 (확인)</label><input class="form-control" id="id_password2"
							name="password2" placeholder="새 비밀번호 (확인)" title=""
							type="password" required />
					</div>
					<button class="btn btn-potluck btn-block">비밀번호 변경</button>
				</form>
			</div>
			<p>라온다님에 오신것을 환영합니다</p>
		</div>
	</section>
	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>