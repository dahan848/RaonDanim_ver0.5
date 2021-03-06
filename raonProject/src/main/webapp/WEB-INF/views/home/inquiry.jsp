<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- contextPath 설정 -->
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
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->
	<div class="main-container">
		<section id="section-inquiry">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon"
						src="${contextPath}/img/home_Message.png" alt=""> 문의하기 
				</h3>
				<form method="post">
					<!-- 시큐리티 사용하기 위한 파라미터 (토큰) -->
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">문의내용</h3>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-8 col-sm-offset-2">
									<div class="form-group">
										<label class="control-label" for="id_category">카테고리</label><select
											class="form-control" id="id_category" name="category"
											title="" required>
											<option value="일반문의">일반문의</option>
											<option value="탈퇴문의">탈퇴문의</option>
										</select>
									</div>
									<div class="form-group">
										<label class="control-label" for="id_email">이메일</label><input
											class="form-control" id="id_email" maxlength="200"
											name="email" placeholder="이메일" title="" type="email" />
									</div>
									<div class="form-group">
										<label class="control-label" for="id_subject">제목</label><input
											class="form-control" id="id_subject" maxlength="200"
											name="subject" placeholder="제목" title="" type="text" required />
									</div>
									<div class="form-group">
										<label class="control-label" for="id_content">문의내용</label>
										<textarea class="form-control" cols="40" id="id_content"
											name="content" placeholder="문의내용" rows="10" title=""></textarea>
									</div>
									<button class="btn btn-potluck btn-block">보내기</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</section>
	</div>
	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>