<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
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
	<jsp:include page="/WEB-INF/views/accounts/accounts-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->


	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon"
						src="/static/potluck/img/icon/Profile.png" alt=""> 3단계: 현지친구
					정보 입력하기
				</h3>
				<div class="progress">
					<div class="progress-bar" role="progressbar"
						aria-valuenow="71.4285714286" aria-valuemin="0"
						aria-valuemax="100" style="width: 100%;"></div>
				</div>
				<form id="form-profile-update" method="post" class="form-horizontal"
					enctype="multipart/form-data" novalidate>
					<input type='hidden' name='csrfmiddlewaretoken'
						value='JxkZuD5jke0rLfciMHrQOIWCxejvVi73I8FrT7UOmYwujiFJo9fypydbb3ikZ3w8' />
					<input type="hidden" name="step" value="1">
					<div class="row">
						<div class="col-sm-4">
							<div class="border-box border-box-tips">
								<h4>
									<i class="fa fa-lightbulb-o"></i> <span>Tips</span>
								</h4>
								<ul>
									<li>해외친구에게 숙박을 제공하면 당신도 다른 현지친구의 집에서 무료 숙박할 수 있어요!</li>
								</ul>
							</div>
						</div>
						<div class="col-sm-8">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">현지친구 정보</h3>
								</div>
								<div class="panel-body pt-30">
									<div class="form-group">
										<label class="col-sm-3 control-label" for="id_city">나의
											거주 도시</label>
										<div class="col-sm-9">
											<select
												class="form-control django-select2 django-select2-heavy"
												data-ajax--cache="true" data-ajax--type="GET"
												data-ajax--url="/select2/fields/auto.json"
												data-allow-clear="true"
												data-field_id="MTM5NzE4OTQxMTA3MjE2:1h6VKJ:RuQev-0UAyyw139gYUG4033-X10"
												data-minimum-input-length="0" data-placeholder=""
												id="id_city" name="city" title="">
												<option></option>
												<option value="12800" selected="selected">Seoul,
													South Korea</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"
											for="id_host_availability_0">숙박제공 가능 여부</label>
										<div class="col-sm-9">
											<div id="id_host_availability">
												<div class="radio">
													<label for="id_host_availability_0"><input class=""
														id="id_host_availability_0" name="host_availability"
														title="" type="radio" value="always" required /> 항상가능</label>
												</div>
												<div class="radio">
													<label for="id_host_availability_1"><input class=""
														id="id_host_availability_1" name="host_availability"
														title="" type="radio" value="maybe" required /> 때에따라 가능</label>
												</div>
												<div class="radio">
													<label for="id_host_availability_2"><input
														checked="checked" class="" id="id_host_availability_2"
														name="host_availability" title="" type="radio"
														value="none" required /> 불가능</label>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
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