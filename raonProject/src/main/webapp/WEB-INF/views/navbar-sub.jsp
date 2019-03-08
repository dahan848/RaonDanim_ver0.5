<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 스프링 시큐리티 사용을 위한 태그 정의 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>      
<!-- contextPath 설정 -->
<%	request.setAttribute("contextPath", request.getContextPath()); %>	  
<!-- navbar-sub -->
<div class="navbar navbar-inverse navbar-sub hidden-xs">
    <div class="container">
        <ul class="nav navbar-nav">
        <sec:authorize access="isAnonymous()"> <!-- 로그인 상태 X -->
        	<li><a href="${contextPath}/introduction">라온 다님</a></li>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
	         <li><a href="${contextPath}/accounts/update1">나의 정보</a></li>
        </sec:authorize>
	         <li><a href="${contextPath}/search/test">회원 검색</a></li>
	         <li><a href="${contextPath}/trip/test">여행</a></li>
	         <li><a href="${contextPath}/motel/search">숙박</a></li>
	         <li><a href="${contextPath}/review/test">후기</a></li>
        </ul>
    </div>
</div>
<!-- navbar-sub END-->
