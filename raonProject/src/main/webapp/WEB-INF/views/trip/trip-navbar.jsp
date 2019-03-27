<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 스프링 시큐리티 사용을 위한 태그 정의 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!-- contextPath 설정 -->
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<!-- 서브 네브바 -->



	<div
		class="navbar navbar-inverse navbar-sub navbar-sub-light hidden-xs">
		<div class="container" style="margin-left: 26%">
			<ul class="nav navbar-nav navbar-core">
			<sec:authorize access="isAuthenticated()">
				<li><a href="write1">여행일정</a></li>
				</sec:authorize>
				<li><a href="list">여행리스트</a></li>
			</ul>
		</div>
	</div>

<!-- 서브 네브바 END -->