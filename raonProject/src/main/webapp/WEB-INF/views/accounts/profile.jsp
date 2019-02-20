<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>라온다님</title>
<!-- CSS -->

</head>
<body>
<!-- 인클루드 심플 헤더 -->
<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
<!-- 인클루드 심플 헤더 END -->

	<div class="main-container">
		<div class="container">
			<!-- 상단 프로필 타이틀 -->
			<h3 class="section-title">
				<img class="section-header-icon" src="../img/Profile.png" alt="">
            		 나의 프로필
                <a href="#" class="btn btn-potluck pull-right">프로필 수정</a>
			</h3>
			<section id="section-user-detail"> <!-- 프로필 section -->
				<div class="user-info"> <!-- 상단 사진, 기본정보 출력 되는 부분 -->
					<div class="user-images"><!-- 유저 이미지 영역 -->
						<div id="carousel-user-images" class="carousel slide" data-ride="carousel">
						  <ol class="carousel-indicators">
						    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						    <li data-target="#myCarousel" data-slide-to="1"></li>
						    <li data-target="#myCarousel" data-slide-to="2"></li>
						  </ol>
						<!-- 갤러리 이미지 불러와야 할 부분 -->
						  <div class="carousel-inner">
						    <div class="item active">
						      <img src="../img/la.jpg" alt="Los Angeles">
						    </div>
						    <div class="item">
						      <img src="../img/chicago.jpg" alt="Chicago">
						    </div>
						    <div class="item">
						      <img src="../img/ny.jpg" alt="New York">
						    </div>
						  </div>
						  <!-- Left and right controls -->
						  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
						    <span class="glyphicon glyphicon-chevron-left"></span>
						    <span class="sr-only">Previous</span>
						  </a>
						  <a class="right carousel-control" href="#myCarousel" data-slide="next">
						    <span class="glyphicon glyphicon-chevron-right"></span>
						    <span class="sr-only">Next</span>
						  </a>
						</div>
					</div><!-- 유저 이미지 영역 END -->

					<div class="user-profile"> <!-- 유저 기본 정보 영역 -->
						<a href="/accounts/users/1705" class="img-profile-container">
							<!-- 유저 프로필 사진 -->
					        <img src="../img/profile_2.jpg" class="img-circle img-avatar">
					        <!-- 유저 국가 사진 -->
					        <img class="img-flag" src="../img/KR.png" alt="">
				   		</a>
				        <h4>dahan han (manzza)</h4>	<!-- 이름, 닉네임 -->
					    <p class="mb-0">Seoul, South Korea</p> <!-- 도시, 국가 -->
				   		<p>
				     	  기타
				  		</p>
				  		<p><small>Last login few minutes ago</small></p> <!-- 마지막 로그인 정보 -->
                   		<hr>
                   		<div class="row">
                        	<div class="col-xs-6">
                            	<div class="friends-count"><i class="ion ion-ios-heart"></i> 0</div>
                            	<small>교류 수</small> <!-- 교류 회원 수 -->
                       		</div>
                        	<div class="col-xs-6">
                            	<div class="friends-count"><i class="ion ion-android-person"></i> 0</div>
                            		<small>라온다님 친구</small>	<!-- 친구 수 -->
                        	</div>
                    	</div>
					</div> <!-- 유저기본 정보 영역 END -->
				</div> <!-- 상단 사진, 기본정보 출력 되는 부분 END -->
				
				<div class="user-descriptions"> <!-- 유저 상세 정보 출력 부  -->
	          		<div class="row">
	              		<label class="col-sm-3 control-label text-right">나의소개</label>
	              			<div class="col-sm-9">
	                  			<p>프로필 화면 테스트 더미 데이터</p>	<!-- 데이터 받아와야 됨 -->
	              			</div>
	          		</div>
               		<div class="row">
                    	<label class="col-sm-3 control-label text-right">나이</label>
                    <div class="col-sm-9">
                    	<p>프로필 화면 테스트 더미 데이터</p> <!-- 데이터 받아와야 됨 -->
                    </div>
                	</div>
               		<div class="row">
                    	<label class="col-sm-3 control-label text-right">직업</label>
                    		<div class="col-sm-9">
                            	<span class="label label-default label-lg">프로필 화면 테스트 더미 데이터</span>
	                    </div>
	                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">좋아하는 것</label>
                    	<div class="col-sm-9">
                            <span class="label label-default label-lg">프로필 화면 테스트 더미 데이터</span>
                    </div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">사용가능언어</label>
                    	<div class="col-sm-9">
                            <span class="label label-default label-lg">프로필 화면 테스트 더미 데이터</span>
                   		</div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">Facebook계정</label>
                   		<div class="col-sm-9">
                            <span class="label label-standby label-lg">프로필 화면 테스트 더미 데이터</span>
                    	</div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">인증상태</label>
                    	<div class="col-sm-9">
                    </div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">국적</label>
                    <div class="col-sm-9">
                        <p>프로필 화면 테스트 더미 데이터</p>
                    </div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">거주 도시</label>
                    <div class="col-sm-9">
                        <p>프로필 화면 테스트 더미 데이터</p>
                    </div>
                </div>
                <div class="row">	<!-- 나와의 거리 영역 지도 필요 -->
                	<label class="col-sm-3 control-label text-right">나와의 거리</label>
                    	<div class="col-sm-9">
                        	<p id="map-address-info"
                            	data-mylat="37.56600"
                            	data-mylng="126.97840"
                            	data-friendlat="37.56600"
                            	data-friendlng="126.97840">
                             	Seoul, South Korea - Seoul, South Korea
                             <strong id="distance"></strong>KM</p>
                         	<div id="map-canvas" style="height: 300px;"></div>
                     	</div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">숙박 제공 가능 여부</label>
                    	<div class="col-sm-9">
                    		<span class="label label-pink label-lg">불가능</span>
					</div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">지역소개</label>
                    <div class="col-sm-9">
                        <p>프로필 화면 테스트 더미 데이터</p>
                    </div>
                </div>
				</div> <!-- 유저 상세 정보 출력 부  END-->
			</section> <!-- 프로필 section END-->
		</div>
	</div>
	
<!-- 인클루드-푸터 -->
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<!-- 인클루드-푸터 END -->
</body>
</html>