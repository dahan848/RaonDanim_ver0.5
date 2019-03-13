<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라온다님</title>
</head>
<body>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.user_num" var="user_num"/>
</sec:authorize>
<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>

	<section id="section-intro"> <!-- 최상단 -->
	    <div class="description-intro">
	        <h1>외국인 여행자와 친구가 되어 <br>즐거운 교류를 경험하세요!</h1>
	    </div>
	    <div id="carousel-backgrounds" class="owl-carousel owl-theme">
	        <div style="background-image: url(${contextPath}/img/home_banner_landing.jpg" class="carousel-background"></div>
	    </div>
	</section> <!-- 최상단 END -->
	
	<section id="section-introduce"> <!-- 상단 : 소개영역 -->
        <div class="container">
            <h3 class="h3-title text-center">
             		   라온다님 이란?
            </h3>
            <h1 class="text-center">라온다님은 여행지의 현지 친구와 여행자를 연결합니다.</h1>
            <div class="text-center mb-40">
                <a href="introduction" class="btn btn-potluck btn-lg bg-pink">더 알아보기</a>
            </div>
        </div>
    </section> <!-- 상단 : 소개영역 END -->
    
    <section id="section-cities"> <!-- 중단 : 각 도시 별 친구 -->
        <div class="container">
            <h3 class="text-pink">아시아 대도시의 현지친구와 친분을 맺어보세요!</h3>
            <div class="col-sm-4">
                <div class="trip-cover" style="background-image: url(${contextPath}/img/home_seoul_trip_cover.jpg)">
                    <a href="/accounts/profiles/?search=&city=12800">
                        <h1>서울</h1>
                        <h2>153명의 현지친구</h2>
                    </a>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="trip-cover" style="background-image: url(${contextPath}/img/home_manila_trip_cover.jpg)">
                    <a href="/accounts/profiles/?search=&city=15288">
                        <h1>마닐라</h1>
                        <h2>127명의 현지친구</h2>
                    </a>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="trip-cover" style="background-image: url(${contextPath}/img/home_sgp_trip_cover.jpg)">
                    <a href="/accounts/profiles/?search=&city=17721">
                        <h1>싱가포르</h1>
                        <h2>38명의 현지친구</h2>
                    </a>
                </div>
            </div>
        </div>
    </section> <!-- 중단 : 각 도시 별 친구 END -->
    
    <!-- 하단 : 현재 가입된 회원 목록 -->
    <section id="section-members">
        <div class="container">
            <h3 class="h3-title text-center">
                <img class="section-header-icon" src="${contextPath}/img/accounts_Chart.png" alt=""> 라온다님 회원을 만나보세요!
            </h3>
            <div class="row mt-50 mb-30">
                <div class="col-sm-6">
                    <h3 class="h3-sub-title text-center">
                        <img class="section-header-icon" src="${contextPath}/img/accounts_Profile.png" alt=""> 라온친구
                    </h3>
                    <a href="/accounts/profiles/" class="badge badge-gray">+더보기</a>
                    <div class="row row-p5 mb-20">
	                   	<!-- 12개의 유저 목록을 반복문으로 그려줌 (랜덤하게) -->
	                   	<c:forEach items="${userList}" var="user" varStatus="status">
	                   		<div class="col-xs-2 col-sm-3 col-md-2">
		                     	<c:choose>
			             			<c:when test="${user.USER_PROFILE_PIC eq 'n'}">
			             				<a href="#" rel="popover" data-placement="bottom" data-trigger="focus" data-popover-content="#userInfo${status.index}">
			             					<img class="img-circle" src="${contextPath}/img/home_profile_2.jpg">
			             				</a>
			             			</c:when>
			             			<c:otherwise>
				              			<a href="#" rel="popover" data-placement="bottom" data-popover-content="#userInfo${status.index}">
				              				<img class="img-circle"  src="
				                                	   		 ${contextPath}/image?fileName=${user.USER_PROFILE_PIC}">
				                        </a>
			             			</c:otherwise>
		             			</c:choose>
	             				<!-- POPOVER DIV -->
		           		        <div id="userInfo${status.index}" class="hide" style="margin-left: auto; margin-right: auto; text-align: center;">
									${user.USER_LNM} ${user.USER_FNM} <br>
									<a href="${contextPath}/accounts/profile?user=${user.USER_NUM}">프로필보기</a><br>
									<sec:authorize access="isAuthenticated()"> <!-- 로그인 상태 일때만 표시 -->
									<a onclick="chatClick(${user_num},${user.USER_NUM})">대화하기</a>
									</sec:authorize>
										   
								</div>   	
	                       	</div>
	                   	</c:forEach>
                    </div>
                </div>
                <div class="col-sm-6">
                    <h3 class="h3-sub-title text-center">
                        <img class="section-header-icon" src="${contextPath}/img/accounts_Profile.png" alt=""> 여행자
                    </h3>
                    <a href="/accounts/profiles/" class="badge badge-gray">+더보기</a>
                    <div class="row row-p5 mb-20">
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                            <div class="col-xs-2 col-sm-3 col-md-2">
                                <img class="img-circle" src="#">
                            </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="/WEB-INF/views/test.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
    
<script type="text/javascript">
	
$(function(){
    $('[rel="popover"]').popover({
        container: 'body',
        html: true,
        content: function () {
            var clone = $($(this).data('popover-content')).clone(true).removeClass('hide');
            return clone;
        }
    }).click(function(e) {
        e.preventDefault();
    });
});


</script>
</body>
</html>