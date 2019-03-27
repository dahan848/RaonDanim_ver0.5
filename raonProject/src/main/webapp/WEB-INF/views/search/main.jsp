<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>회원검색</title>

<!-- fastselect CSS -->
<link rel="stylesheet" href="${contextPath}/css/fastselect.css"/>
<!-- fastselect CSS END -->

<!-- select2 CSS -->
<link rel="stylesheet" href="${contextPath}/css/select2.css"/>
<!-- select2 CSS END -->

</head>

<body>
	<!-- NAV BAR -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<!-- NAV BAR END -->
	
	<!-- FASTSELECT JS  -->
	<script src="${contextPath}/js/fastselect.standalone.js"></script>
	<!-- FASTSELECT JS END -->
	
	<!-- SWEETALERT JS -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!-- SWEETALERT JS END -->
	
	<!-- select2 JS -->
	<script src="${contextPath}/js/select2.min.js"></script>
	<script src="${contextPath}/js/i18n/ko.js"></script>
	<!-- select2 JS END -->
	
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
													<select class="form-control select-city" name="city">
														<!-- placeholder 사용을 위한 option blank -->
														<option></option>
													</select>
													<script>
													$(document).ready(function(){
														$(".select-city").select2({
															placeholder: "선택",
															allowClear: true,
															language: "ko",
															ajax: {
																url: function(params){
																	var url = "http://localhost:8000/api/cities/";
																	if(params.term == null || params.term == ""){
																		if(params.page > 1){
																			url = url + "?page=" + params.page;
																			return url
																		}else{
																			return url
																		}
																	}else{
																		if(params.page > 1){
																			url = url + "?page=" + params.page + "&?search=" + params.term;
																			return url
																		}else{
																			url = url + "?search=" + params.term;
																			return url
																		}
																	}
																},
																delay: 500,
																dataType: 'json',
																data: function(params){
																	
																},
																processResults: function(data,params){
																	params.page = params.page || 1;
																	return{
																		results: data.results,
																		pagination: {																		
																			more: (params.page * 30) < data.count
																		}
																	};
																}
															}
														});
													});
													</script>
												</div>
											</div>
											<!-- 상세 검색 - 도시 END -->
											
											<!-- 상세 검색 - 언어 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_language">사용 언어</label>
												<div class="col-sm-9">
													<select class="form-control select-language" name="language">
														<!-- placeholder 사용을 위한 option blank -->
														<option></option>
													</select>
													<script>
														$(document).ready(function(){
															$(".select-language").select2({
																placeholder: "선택",
																allowClear: true,
																language: "ko",
																ajax: {
																	url: function(params){
																		var url = "http://localhost:8000/api/languages/";
																		if(params.term == null || params.term == ""){
																			if(params.page > 1){
																				url = url + "?page=" + params.page;
																				return url
																			}else{
																				return url
																			}
																		}else{
																			if(params.page > 1){
																				url = url + "?page=" + params.page + "&?search=" + params.term;
																				return url
																			}else{
																				url = url + "?search=" + params.term;
																				return url
																			}
																		}
																	},
																	delay: 500,
																	dataType: 'json',
																	data: function(params){
																		
																	},
																	processResults: function(data,params){
																		params.page = params.page || 1;
																		return{
																			results: data.results,
																			pagination: {																		
																				more: (params.page * 30) < data.count
																			}
																		};
																	}
																}
															});
														});
													</script>
												</div>
											</div>
											<!-- 상세 검색 - 언어 END -->
											
											<!-- 상세 검색 - 여행스타일 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_travlestyle">여행 스타일</label>
												<div class="col-sm-9">
													<select class="form-control select-travlestyle" name="travlestyle">
														<!-- placeholder 사용을 위한 option blank -->
														<option></option>
													</select>
													<script>
														$(document).ready(function(){
															$(".select-travlestyle").select2({
																placeholder: "선택",
																allowClear: true,
																language: "ko",
																ajax: {
																	url: function(params){
																		var url = "http://localhost:8000/api/travlestyles/";
																		if(params.term == null || params.term == ""){
																			if(params.page > 1){
																				url = url + "?page=" + params.page;
																				return url
																			}else{
																				return url
																			}
																		}else{
																			if(params.page > 1){
																				url = url + "?page=" + params.page + "&?search=" + params.term;
																				return url
																			}else{
																				url = url + "?search=" + params.term;
																				return url
																			}
																		}
																	},
																	delay: 500,
																	dataType: 'json',
																	data: function(params){
																		
																	},
																	processResults: function(data,params){
																		params.page = params.page || 1;
																		return{
																			results: data.results,
																			pagination: {																		
																				more: (params.page * 30) < data.count
																			}
																		};
																	}
																}
															});
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
												<label class="col-sm-3 control-label" for="id_name">이름 </label>
												<div class="col-sm-9">
													<input class="form-control" name="name" placeholder="이름" type="text"/>
												</div>
											</div>
											<!-- 상세 검색 - 이름 END -->
											
											<!-- 상세 검색 - 국적 START -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_nationality">국적</label>
												<div class="col-sm-9">
													<select class="form-control select-nationality" name="nationality">
														<!-- placeholder 사용을 위한 option blank -->
														<option></option>
													</select>
													<script>
														$(document).ready(function(){
															$(".select-nationality").select2({
																placeholder: "선택",
																allowClear: true,
																language: "ko",
																ajax: {
																	url: function(params){
																		var url = "http://localhost:8000/api/nationalities/";
																		if(params.term == null || params.term == ""){
																			if(params.page > 1){
																				url = url + "?page=" + params.page;
																				return url
																			}else{
																				return url
																			}
																		}else{
																			if(params.page > 1){
																				url = url + "?page=" + params.page + "&?search=" + params.term;
																				return url
																			}else{
																				url = url + "?search=" + params.term;
																				return url
																			}
																		}
																	},
																	delay: 500,
																	dataType: 'json',
																	data: function(params){
																		
																	},
																	processResults: function(data,params){
																		params.page = params.page || 1;
																		return{
																			results: data.results,
																			pagination: {																		
																				more: (params.page * 30) < data.count
																			}
																		};
																	}
																}
															});
														});
													</script>
												</div>
											</div>
											<!-- 상세 검색 - 국적 END -->
											
											<!-- 상세 검색 - 성별 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_gender">성별</label>
												<div class="col-sm-9">
													 <select class="form-control select-gender" name="gender">
													 	<!-- placeholder 사용을 위한 option blank -->
													 	<option></option>
													 	<option value="1">남</option>
													 	<option value="2">여</option>
													 </select>
													 <script>
														$(document).ready(function(){
													 		$('.select-gender').select2({
													 			placeholder: "선택",
																allowClear: true,
													 			minimumResultsForSearch: Infinity
													 		});													
														});
													 </script>
												</div>
											</div>
											<!-- 상세 검색 - 성별 END -->
											
											<!-- 상세 검색 - 관심사 -->
											<div class="form-group">
												<label class="col-sm-3 control-label" for="id_interest">관심</label>
												<div class="col-sm-9">
													<select class="form-control select-interest" name="interest">
														<!-- placeholder 사용을 위한 option blank -->
														<option></option>
													</select>
													<script>
														$(document).ready(function(){
															$(".select-interest").select2({
																placeholder: "선택",
																allowClear: true,
																language: "ko",
																ajax: {
																	url: function(params){
																		var url = "http://localhost:8000/api/interests/";
																		if(params.term == null || params.term == ""){
																			if(params.page > 1){
																				url = url + "?page=" + params.page;
																				return url
																			}else{
																				return url
																			}
																		}else{
																			if(params.page > 1){
																				url = url + "?page=" + params.page + "&?search=" + params.term;
																				return url
																			}else{
																				url = url + "?search=" + params.term;
																				return url
																			}
																		}
																	},
																	delay: 500,
																	dataType: 'json',
																	data: function(params){
																		
																	},
																	processResults: function(data,params){
																		params.page = params.page || 1;
																		return{
																			results: data.results,
																			pagination: {																		
																				more: (params.page * 30) < data.count
																			}
																		};
																	}
																}
															});
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
				<!-- 상단 검색 섹션 END -->
				
				
				<!-- 회원 정보 -->
				<div class="row">
				<c:forEach items="${userList}" var="user">
					<div class="col-md-4 col-sm-6">
						<div class="item-cover item-cover-sm">
								
							<!-- 프로필 백그라운드 이미지 -->
							<div class="cover-background" style="background-image: url(${contextPath}/img/default/profile_cover_1.jpg)"></div>
							
							<!-- 프로필 이미지 -->
							<div class="cover-profile-image">
								<a href="${contextPath}/accounts/profile?user=${user.USER_NUM}" class="img-circle img-avatar">
								<c:choose>
									<c:when test="${user.USER_PROFILE_PIC eq 'n'}">
										<img src="${contextPath}/img/home_profile_2.jpg" class="img-profile">
									</c:when>
									<c:otherwise>
										<img src="${contextPath}/image?fileName=${user.USER_PROFILE_PIC}" class="img-profile">
									</c:otherwise>
								</c:choose>
								</a>
							</div>
							
							<!-- 닉네임 -->
							
								<h4 class="profile-name">${user.USER_LNM} ${user.USER_FNM}</h4>							
							
							<!-- 거주도시 -->
							<p class="profile-city">거주도시: ${user.city}</p>
							
							<hr>
							
							<!-- 관심사 -->
							<div class="cover-tags cover-tags-properties">
								<c:forEach items="${user.interests}" var="interests">
									<span class="label label-default">${interests.INTEREST_KO_NAME}</span>
								</c:forEach>
							</div>
							
							<!-- 희망 여행도시 -->
							<!--  
							<div class="cover-tags cover-tags-certification">
								<span class="label">hopecity</span>
							</div>
							-->
						</div>
					</div>
					</c:forEach>
				</div>
				<!-- 회원 정보 END -->
				
				<!-- 페이징 처리 -->
				<div class="text-center">
					<ul class="pagination">
						<c:choose>
							<c:when test="${page == 1}">
								<li class="prev disabled">
									<a>&laquo;</a>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a href="home?page=1">&laquo;</a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach var="pageNum" begin="${startPage}" end="${endPage < totalPage ? endPage : totalPage}">
							<c:choose>
								<c:when test="${pageNum == page}">
									<li class="active">
										<a>${pageNum}</a>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="home?page=${pageNum}">${pageNum}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${page == totalPage}">
								<li class="prev disabled">
									<a>&raquo;</a>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a href="home?page=${totalPage}">&raquo;</a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</section>
	</div>
	
	<!-- 조건검색시 텍스트 변환 자바스크립트 -->
	<script src="${contextPath}/js/search-detail.js"></script>
	
	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 푸터 종료 -->
	
</body>
</html>