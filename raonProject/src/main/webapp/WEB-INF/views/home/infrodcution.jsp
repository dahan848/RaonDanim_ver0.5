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
	<section id="section-introduction-detail">
		<div class="introduction-detail-bg"
			style="background-image: url(${contextPath}/img/home_banner.jpg)"></div>
		<div class="container">
			<h1>
				<strong>라온다님</strong>을 추천합니다.
			</h1>
			<p>
				라온다님은 여행지의 현지 친구와 여행자를 연결해주는 커뮤니티 입니다.<br>
				여행 계획 중에 혹은 여행지에서 즉석으로 현지의 친구를 만나보세요.
			</p>
			<div class="row mb-60">
				<div class="col-sm-4 col-xs-4">
					<div class="item-intro">
						<img class="mb-35"
							src="${contextPath}/img/home_trending_up.png">
						<h3>효율적인 여행</h3>
					</div>
				</div>
				<div class="col-sm-4 col-xs-4">
					<div class="item-intro">
						<img class="mb-25"
							src="${contextPath}/img/home_people.png">
						<h3>외국인 친구와의 우정</h3>
					</div>
				</div>
				<div class="col-sm-4 col-xs-4">
					<div class="item-intro">
						<img class="mb-25"
							src="${contextPath}/img/home_safety.png">
						<h3>안전한 여행</h3>
					</div>
				</div>
			</div>
			<h2>현지인과 친구과 되어 깊게 체험하고 우정을 나누세요.</h2>
			<div class="row mt-30 mb-40">
				<div class="col-sm-6">
					<p>누구나 찾을 만한 유명 관광지를 방문하는 것만이 여행의 전부는 아니에요. 그 지역을 제대로 경험하려면 현지의
						사람들과 어울리고 소통하는 것이 가장 좋은 방법입니다.</p>
					<p>
						여행지의 현지인과 친구가 되어보세요!<br> 그들만이 알고있는 멋진 장소, 그 지역 여행지를 돌아다닐 때의
						유용한 정보 등 많은 것을 얻을 수 있습니다.<br> 가장 중요한 것은 낯선 곳에서 우정을 나눌 수 있는
						친구가 생긴다는 것이죠!
					</p>
				</div>
				<div class="col-sm-6">
					<img src="${contextPath}/img/home_1.jpg">
				</div>
			</div>
			<h2>Trips를 모아서 여행에 사용하세요.</h2>
			<div class="row mt-30 mb-40">
				<div class="col-sm-6">
					<img src="${contextPath}/img/home_2.jpg">
				</div>
				<div class="col-sm-6">
					<p>
						현지친구는 여행자와의 교류를 통해 포인트(Trips)를 적립하고, 본인의 여행에서 현지친구를 만날때 사용할 수	있습니다.<br>
						Trips는 교류(밋업 등)가 정상적으로 완료되어야 이전됩니다. 이를 통해 교류의 안정성과 만족이 높아지게 됩니다.
					</p>
				</div>
			</div>
			<div class="row mt-30 mb-30">
				<a class="btn btn-mint center-block" href="home">라온다님
					시작하기</a>
			</div>
		</div>
	</section>
<!-- 인클루드-푸터 -->
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<!-- 인클루드-푸터 END -->
</html>