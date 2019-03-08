<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
	<form action="${contextPath}/board/checkout">
		<!-- <input type="text" name="item" value="연필" readonly="readonly"><br> -->
		<p name="item">연필</p>
		<input type="text" name="price" value="1" readonly="readonly"><br>
		<input type="hidden" name="num" value="${num }"> 
		<input type="submit" value="주문하기">
	</form>
	
</body>
</html>