<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>회원검색</title>

<!-- fastselect CSS -->
<link rel="stylesheet" href="${contextPath}/css/fastselect.css"/>
<!-- fastselect CSS END -->

</head>
<body>
	<!-- NAV BAR -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<!-- NAV BAR END -->
	
	<!-- fastselect JS  -->
	<script src="${contextPath}/js/fastselect.standalone.js"></script>
	<!-- fastselect JS END -->
	
	<!-- 상단 검색 섹션 -->
	<div class="main-container">
		<section id="section-profile-list">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon" src="${contextPath}/img/Alarm.png" alt=""> 검색
				</h3>
				<form id="form-search" class="form-horizontal form-filter">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">현지친구 및 여행자 검색</h3>
						</div>
						<div class="panel-body">
							<div class="tab-content">
								
								<!-- 기본 검색 -->
								<div id="form-simple" class="tab-pane active">
									<div class="form-group">
										<label class="sr-only control-label" for="id_search">검색</label>
										<input class="form-control" id="id_search" name="search" placeholder="지역, 관심사, 직업, 이름, 닉네임 검색" title="" type="text" />
									</div>
									
									<!-- 상세 검색 기능 활성화 버튼 -->
									<div class="text-center">
										<a class="btn-collapse" data-toggle="tab" href="#form-detail">
											<i class="fa fa-chevron-down mr-5" aria-hidden="true"></i>조건 추가
										</a>
									</div>
									<!-- 상세 검색 기능 활성화 버튼 END -->
									
								</div>
								<!-- 기본 검색 END -->
								
								<!-- 상세 검색 -->
								<div id="form-detail" class="tab-pane">
									<div class="row">
									
										<!-- 상세검색 좌측 섹션 -->
										<div class="col-sm-6">
										
											<!-- 상세 검색 - 검색 대상 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_traveler_type_0">검색 대상</label>
												<div class="col-sm-9">
													<div id="id_traveler_type">
														<div class="radio">
															<label for="id_traveler_type_0">
															<input class="" id="id_traveler_type_0" name="traveler_type" title="" type="radio" value="local" />현지친구
															</label>
														</div>
														<div class="radio">
															<label for="id_traveler_type_1">
															<input class="" id="id_traveler_type_1" name="traveler_type" title="" type="radio" value="traveler" />여행자
															</label>
														</div>
													</div>
												</div>
											</div>
											<!-- 상세 검색 - 검색대상 END -->
											
											<!-- 상세 검색 - 도시(검색대상 현지친구일 때: 거주도시, 검색대상 여행자일 때: 여행도시 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_city">거주 도시</label>
												<div class="col-sm-9">
													<input class="form-control" id="select-city" type="text" data-url="${contextPath}/json/city.json" data-load-once="true" name="city"/>
													<script>
														$('#select-city').fastselect();
													</script>
												</div>
											</div>
											<!-- 상세 검색 - 도시 END -->
											
											<!-- 상세 검색 - 언어 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_languages">사용 언어</label>
												<div class="col-sm-9">
													<input class="form-control" id="select-language" type="text" multiple="multiple" data-url="${contextPath}/json/language.json" name="language"/>
													<script>
														$('#select-language').fastselect({
															maxItems: 3,
															onMaxItemsReached: function(){
																alert('3개까지만 입력할 수 있습니다.');
															},
														});
													</script>
												</div>
											</div>
											<!-- 상세 검색 - 언어 END -->
											
											<!-- 상세 검색 - 여행스타일 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_tour_styles">여행 스타일</label>
												<div class="col-sm-9">
													<input class="form-control" id="select-tourstyles" type="text" multiple="multiple" data-url="${contextPath}/json/tourstyles.json" name="language"/>
													<script>
														$('#select-tourstyles').fastselect({
															maxItems: 5,
															onMaxItemsReached: function(){
																alert('5개까지만 입력할 수 있습니다.');
															},
														});
													</script>
												</div>
											</div>
											<!-- 상세 검색 - 여행스타일 END -->

										</div>
										<!-- 상세 검색 좌측 섹션 END -->
										
										<!-- 상세 검색 우측 섹션 -->
										<div class="col-sm-6">
										
											<!-- 상세 검색 - 이름 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_search_name">이름 </label>
												<div class="col-sm-9">
													<input class="form-control" id="id_search_name" name="search_name" placeholder="이름" title="" type="text"/>
												</div>
											</div>
											<!-- 상세 검색 - 이름 END -->
											
											<!-- 상세 검색 - 성별 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_gender">성별</label>
												<div class="col-sm-9">
													 <input class="form-control" id ="select-gender" type="text" multiple="multiple" data-url="${contextPath}/json/gender.json"name="gender"/>
													 <script>
														 $('#select-gender').fastselect();
													 </script>
												</div>
											</div>
											<!-- 상세 검색 - 성별 END -->
											
											<!-- 상세 검색 - 관심사 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_interests">관심</label>
												<div class="col-sm-9">
													 <input class="form-control" id="select-interest" type="text" multiple="multiple" data-url="${contextPath}/json/interest.json" name="interest"/>
													 <script>
														$('#select-interest').fastselect({
															maxItems: 5,
															onMaxItemsReached: function(){
																alert('5개까지만 입력할 수 있습니다.');
															}
														});
													 </script>
												</div>
											</div>
											<!-- 상세 검색 - 관심사 END -->
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
					
						<!-- 검색 기능 실행 버튼 -->
						<div class="col-sm-6 col-sm-offset-3 col-md-offset-4 col-md-4">
							<button class="btn btn-potluck btn-block">검색</button>
						</div>
						<!-- 검색 기능 실행 버튼 END -->
						
					</div>
				</form>
			</div>
		</section>
	</div>
	<!-- 상단 검색 섹션 END -->
	
	<!-- 조건검색시 텍스트 변환 자바스크립트 -->
	<script src="${contextPath}/js/search-detail.js"></script>
	
	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 푸터 종료 -->
	
</body>
</html>