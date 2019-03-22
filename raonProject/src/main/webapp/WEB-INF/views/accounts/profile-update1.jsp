<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- contextPath 설정 -->
<%	request.setAttribute("contextPath", request.getContextPath()); %>	 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 테스트 추가 코드 -->
<style type="text/css">
.capitalize {
	text-transform: capitalize;
}

.select2-container-multi .select2-choices .select2-search-choice {
	padding: 5px 5px 5px 18px;
}
</style>
<title>라온다님</title>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/accounts/accounts-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->
	
	<!-- 테스트를 위한 추가  -->
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.4/select2.min.css" />
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2-bootstrap-css/1.4.6/select2-bootstrap.min.css" />
</head>
<body>
	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon" src="${contextPath}/img/accounts_Profile.png" alt="">
					1단계: 기본 정보 입력하기
				</h3>
				<div class="progress">
					<div class="progress-bar" role="progressbar"
						aria-valuenow="14.2857142857" aria-valuemin="0"
						aria-valuemax="100" style="width: 33.333%;"></div>
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
									<li>닉네임은 영어로 입력하세요.</li>
									<li>* 닉네임이 아닌 실제 이름은 친구로 맺어진 회원에게만 노출 됩니다.</li>
								</ul>
							</div>
						</div>
						<div class="col-sm-8">
							<div class="panel panel-default">
								<div class="panel-body pt-30">
									<div class="form-group">
										<label class="col-sm-3 control-label" for="id_nationality">국적</label>
										<div class="col-sm-9">
											<!-- 테스트 추가 코드 -->
											<input id="nationality" style="width: 100%;" placeholder="숫자를 입력하고 스크롤하여 자세한 결과를 확인하십시오." />
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="id_languages">사용가능
											언어</label>
										<div class="col-sm-9">
											<select
												class="form-control"
												id="id_languages" name="languages" title="">
												<option value="1" selected="selected">한국어</option>
												<option value="2" selected="selected">일본어</option>
												<option value="3" selected="selected">중국어</option>
												<option value="4" selected="selected">영어</option>
												<option value="5" selected="selected">스페인어</option>
												<option value="6" selected="selected">아랍어</option>
												<option value="7" selected="selected">포르투갈어</option>
												<option value="8" selected="selected">러시아어</option>
												<option value="9" selected="selected">독일어</option>
												<option value="10" selected="selected">말레이어</option>
												<option value="11" selected="selected">몽골어</option>
												<option value="12" selected="selected">베트남어</option>
												<option value="13" selected="selected">인도네시아어</option>
												<option value="14" selected="selected">이탈리아어</option>
												<option value="15" selected="selected">프랑스어</option>
												<option value="16" selected="selected">힌디어</option>
												<option value="17" selected="selected">벵골어</option>
												<option value="18" selected="selected">그리스어</option>
												<option value="19" selected="selected">네덜란드어</option>
												<option value="20" selected="selected">노르웨이어</option>
												<option value="21" selected="selected">네팔어</option>
												<option value="22" selected="selected">태국어</option>
												<option value="23" selected="selected">터키어</option>
												<option value="24" selected="selected">폴란드어</option>
												<option value="25" selected="selected">자바어</option>
												<option value="26" selected="selected">덴마크어</option>
												<option value="27" selected="selected">보스니아어</option>
												<option value="28" selected="selected">에스토니아어</option>
												<option value="29" selected="selected">아일랜드어</option>
												<option value="30" selected="selected">크로아티아어</option>
												<option value="31" selected="selected">아이슬란드어</option>
												<option value="32" selected="selected">라트비아어</option>
												<option value="33" selected="selected">리투아니아어</option>
												<option value="34" selected="selected">라틴어</option>
												<option value="35" selected="selected">몰타어</option>
												<option value="36" selected="selected">알바니아어</option>
												<option value="37" selected="selected">핀란드어</option>
												<option value="38" selected="selected">스웨덴어</option>
												<option value="39" selected="selected">마케도니아어</option>
												<option value="40" selected="selected">세르비아어</option>
												<option value="41" selected="selected">아제르바이잔어</option>
												<option value="42" selected="selected">체코어</option>
												<option value="43" selected="selected">헝가리어</option>
												<option value="44" selected="selected">루마니아어</option>
												<option value="45" selected="selected">슬로바키아어</option>
												<option value="46" selected="selected">슬로베니아어</option>
												<option value="47" selected="selected">불가리아어</option>
												<option value="48" selected="selected">카자흐어</option>
												<option value="49" selected="selected">우크라이나어</option>
												<option value="50" selected="selected">조지아어</option>
												<option value="51" selected="selected">아르메니아어</option>
												<option value="52" selected="selected">아제르바이잔어</option>
												<option value="53" selected="selected">필리핀어</option>
												<option value="54" selected="selected">우즈베크어</option>
												<option value="55" selected="selected">카자흐어</option>
												<option value="56" selected="selected">조지아어</option>
												<option value="57" selected="selected">라오스어</option>
												<option value="58" selected="selected">버마어</option>
												<option value="59" selected="selected">소말리아어</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label">전화번호</label>
										<div class="col-sm-4">
											<div class="input-group">
												<input class="form-control" value="">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="id_interests">좋아하는 것</label>
										<div class="col-sm-9">
											<select
												class="form-control"
												id="id_interests" name="interests" title="">
												<option value="1" selected="selected">더미</option>
												<option value="999" selected="selected">좋아 DB테스트</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="id_cities_desired">여행 희망도시</label>
										<div class="col-sm-9">
											<select
												class="form-control"
												id="id_cities_desired" name="cities_desired" title="">
												<option value="1" selected="selected">더미</option>
												<option value="999" selected="selected">희망도시 DB테스트</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="id_tour_styles">여행 스타일</label>
										<div class="col-sm-9">
											<select
												class="form-control"
												id="id_tour_styles" name="tour_styles" title="">
												<option value="1" selected="selected">더미</option>
												<option value="999" selected="selected">스타일 DB테스트</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="btn-group-form-submit">
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
	
	<!-- 테스트 추가 코드 -->
	<script type="text/javascript" src='//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
	<script	src="//cdnjs.cloudflare.com/ajax/libs/lodash.js/4.15.0/lodash.min.js"></script>
	<script	src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.4/select2.min.js"></script>
</body>

	<!-- 테스트 추가 코드 -->
	<script type="text/javascript">
	//화면에 표시 될 데이터를 넣어주는 부분 Ajax를 활용하여 데이터를 서버로 부터 받아오는 식으로 넣어주면 될 것 같다.
	//_.map() 함수 설명 : https://medium.com/@cheonmyung0217/underscore-js-map-%ED%95%A8%EC%88%98-cd3d47774d96
	//_.range() 함수 설명 : https://mylife365.tistory.com/192
	//그려질 배열의 총 길이를 설정하는 부분이라 생각하면 될 것 같음.
	function mockData() {
		//시작 숫자와 끝 숫자는 DB 데이터의 KEY 넘의 시작과 끝 번호로 넣어주면 됨
		return _.map(_.range(1, 20000), function(i) {
			return {
				id : i, //이 부분에 DB에 저장 된 KEY 값으로 넣어주고 
				text : '테스트' + ' ' + i, //이 부분에는 DB상에 저장 된 문자 (EX: 서울, 대한민국)
			};
		});
	}
	
	//무한 스크롤을 발생 시키는 코드 
	(function() {
		$('#nationality').select2(
				{
					data : mockData(), //위에서 만든 데이터 
					placeholder : 'search',
					multiple : true, //다중 선택 여부 
					// query with pagination
					query : function(q) {
						var pageSize, results, that = this;
						pageSize = 20; //한 번에 불러올 로우의 개수 
						results = [];
						if (q.term && q.term !== '') {
							// HEADS UP; for the _.filter function i use underscore (actually lo-dash) here
							results = _.filter(that.data, function(e) {
								return e.text.toUpperCase().indexOf(
										q.term.toUpperCase()) >= 0;
							});
						} else if (q.term === '') {
							results = that.data;
						}
						q.callback({
							results : results.slice((q.page - 1) * pageSize,
									q.page * pageSize),
							more : results.length >= q.page * pageSize,
						});
					},
				});
	})();
	</script>
</html>