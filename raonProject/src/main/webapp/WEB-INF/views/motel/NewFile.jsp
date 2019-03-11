<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->

	

	<!-- 본문 -->
	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
			<!-- 팟럭트립 박스 테스트 -->
			<div class="row">
                  <div class="col-md-4 col-sm-6">
                     <div class="item-cover item-cover-sm">
                        <div class="cover-background" style="background-image: url(${contextPath}/img/default/profile_cover_1.jpg)"></div>
                        <div class="cover-profile-image">
                           <a href="#" class="img-circle img-avatar">
                              <img src="${contextPath}/img/profile/profile_1.jpg" class="img-profile">
                           </a>
                        </div>
                        <h4 class="profile-name">Serebee</h4>
                        <p class="profile-city">거주도시:Seoul,Korea</p>
                        <hr>
                        <div class="cover-tags cover-tags-properties">
                           <span class="label label-default">축구</span>
                           <span class="label label-default">농구</span>
                           <span class="label label-default">자전거</span>
                        </div>
                        <div class="cover-tags cover-tags-certification">
                           <span class="label label-pink label-mint label-orange label-gray label-skyblue label-violet">Seoul</span>
                        </div>
                     </div>
                  </div>
               </div>
               <!-- 팟럭트립 박스 테스트 END -->
			</div>
		</section>
	</div>
	<!-- 본문 END-->

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>