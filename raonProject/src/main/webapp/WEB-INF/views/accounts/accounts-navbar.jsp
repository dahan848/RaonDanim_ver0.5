<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 스프링 시큐리티 사용을 위한 태그 정의 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.user_num" var="user_num"/>
</sec:authorize>     
<!-- contextPath 설정 -->
<%	request.setAttribute("contextPath", request.getContextPath()); %>	  
<script type="text/javascript">
function update1Form(){
	alert("update1Form");
	var url = "${contextPath}/accounts/update1Form";
	var user_num = "${user_num}";
	
	$("#update1Form").attr("href", "${contextPath}/accounts/update1Form")
	
}

</script>


	<!-- 서브 네브바 -->
	<!-- 서브 네브바 -->
	<div
		class="navbar navbar-inverse navbar-sub navbar-sub-light hidden-xs">
		<div class="container">
			<ul class="nav navbar-nav navbar-core">
				<li><a href="${contextPath}/accounts/update1Form">프로필 수정</a></li>
<!-- 				<li><a id="update1Form" href="javascript:update1Form();">프로필 수정</a></li> -->
				<li><a href="${contextPath}/accounts/personalForm">계정설정</a></li>
				<li><a href="${contextPath}/accounts/dashboard">대시보드</a></li>
				<li><a href="${contextPath}/accounts/gallerySettings">갤러리 관리</a></li>
			</ul>
		</div>
	</div>
	<!-- 서브 네브바 END -->