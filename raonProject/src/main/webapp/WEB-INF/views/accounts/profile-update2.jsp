<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	<!-- 서브 네브바 -->
	<div
		class="navbar navbar-inverse navbar-sub navbar-sub-light hidden-xs">
		<div class="container">
			<ul class="nav navbar-nav navbar-core">
				<li><a href="${contextPath}/statics/profile/update1">프로필 수정</a></li>
				<li><a href="${contextPath}/statics/profile/personal">계정설정</a></li>
				<li><a href="#">대시보드</a></li>
			</ul>
		</div>
	</div>
	<!-- 서브 네브바 END -->

	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon"
						src="${contextPath}/img/Profile.png" alt=""> 3단계: 자기 소개 문구 입력하기
				</h3>
				<div class="progress">
					<div class="progress-bar" role="progressbar"
						aria-valuenow="42.8571428571" aria-valuemin="0"
						aria-valuemax="100" style="width: 66.666%;"></div>
				</div>
				<form id="form-profile-update" method="post" class="form-horizontal"
					enctype="multipart/form-data" novalidate>
					<input type="hidden" name="step" value="1">
					<div class="row">
						<div class="col-sm-4">
							<div class="border-box border-box-tips">
								<h4>
									<i class="fa fa-lightbulb-o"></i> <span>Tips</span>
								</h4>
								<ul>
									<li>자기소개를 성의있게 입력하면, 친구 연결 확률이 높아집니다!</li>
									<li>본인의 전공 또는 전문분야, 여행 경험담 등등. 나를 표현하는 어떤 주제라도 좋습니다.</li>
								</ul>
							</div>
						</div>
						<div class="col-sm-8">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">자기소개</h3>
								</div>
								<div class="panel-body pt-30">
									<div class="form-group">
										<label class="col-sm-3 sr-only control-label"
											for="id_description">자기소개</label>
										<div class="col-xs-12">
											<textarea class="form-control" cols="40"
												data-points-given="0" id="id_description" name="description"
												placeholder="자기소개를 입력해주세요." rows="8" title=""></textarea>
										</div>
									</div>
								</div>
							</div>
							<p id="points-earned" data-step="3" class="text-mint text-right "></p>
							<div class="btn-group-form-submit">
								<button class="btn btn-default btn-submit" data-step="-1">이전</button>
								<button class="btn btn-potluck btn-submit" data-step="1">다음</button>
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