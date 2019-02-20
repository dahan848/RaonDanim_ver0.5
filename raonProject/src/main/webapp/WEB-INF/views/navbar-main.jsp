<!-- Header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- contextPath 설정 -->
<%	request.setAttribute("contextPath", request.getContextPath()); %>	
<!-- 부트스트랩 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!-- 부트스트랩 END -->
<!-- CSS -->
<link href="${contextPath}/css/commonness.css" rel="stylesheet"> <!-- 공통 스타일 CSS -->
<link href="${contextPath}/css/bootstrap-social.css" rel="stylesheet"> <!-- 부트스트랩 소셜 -->
<link href="${contextPath}/css/font-awesome.css" rel="stylesheet"> <!-- 폰트어썸 -->
<!-- CSS END -->  
<!-- 스프링 시큐리티 설정 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%
//     Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//     Object principal = auth.getPrincipal();
 
//     String name = "";
//     if(principal != null) {
//         name = auth.getName();
//     }
%>
<!-- navbar-main -->
<header>
	<nav class="navbar navbar-default">
    	<div class="container">
        	<div class="navbar-header" style="width: 875px;">
       			<a class="navbar-brand hidden-xs" href="${contextPath}/">
            		<img src="${contextPath}/img/home_logo-raon.png">
        		</a>
		        <!-- 로그인 상태에서 출력 되는 회원 정보  -->
		        <sec:authorize access="isAuthenticated()">
	        	<div class="profile-summary">
	                   <a href="#">
	                       <img src="${contextPath}/img/profile_2.jpg">
	                   </a>
	                   <a href="#">
	                 		 	더미
	                       <strong class="text-potluck">(숙박포인트)</strong>
	                   </a>
	             </div>
	             </sec:authorize>
	        </div>
	        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	            <ul class="nav navbar-nav navbar-right">
	           		<sec:authorize access="isAnonymous()"> <!-- 로그인 상태 X -->
                	<li><a href="${contextPath}/accounts/loginForm">로그인</a></li>
					<li><span class="vertical-separator"></span><a href="${contextPath}/accounts/signupForm">회원가입</a></li>
					<li><span class="vertical-separator"></span><a href="${contextPath}/inquiry"><i class="fa fa-info-circle fa-lg"></i></a></li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()"> <!-- 로그인 상태 O -->
						<li><span class="vertical-separator"></span><a href="#"><i class="fa fa-envelope fa-lg"></i></a></li>
						<li><span class="vertical-separator"></span><a href="${contextPath}/inquiry"><i class="fa fa-info-circle fa-lg"></i></a></li>
						<li><span class="vertical-separator"></span><a href="${contextPath}/accounts/logout">로그아웃</a></li>
					</sec:authorize>
	                <li class="dropdown">
	                	<span class="vertical-separator"></span>
	                    	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
	                       aria-expanded="false">한국어 <span class="caret"></span>
	                       </a>
	                    <ul class="dropdown-menu">
	                        <li><a href="#" data-language="ko">한국어</a></li>
	                        <li><a href="#" data-language="en">English</a></li>
	                        <li><a href="#" data-language="ja">日本語</a></li>
	                        <li><a href="#" data-language="zh-hans">简体中文</a></li>
	                        <li><a href="#" data-language="zh-hant">繁體中文</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </div>
	    </div>
	</nav>
</header>
<!-- navbar-main END -->