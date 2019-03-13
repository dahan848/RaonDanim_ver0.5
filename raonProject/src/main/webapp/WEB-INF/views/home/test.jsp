<!-- Header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!-- contextPath 설정 -->
<%
	request.setAttribute("contextPath", request.getContextPath());
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="${contextPath}/css/commonness.css" rel="stylesheet">
<link href="${contextPath}/css/bootstrap-social.css" rel="stylesheet">
<link href="${contextPath}/css/font-awesome.css" rel="stylesheet">
<link href="${contextPath}/css/chatList.css" rel="stylesheet">
<link href="${contextPath}/css/lightgallery.min.css" rel="stylesheet">

<script type='text/javascript'
	src="${contextPath}/js/lightgallery-all.min.js"></script>
<script type='text/javascript' src="${contextPath}/js/chat.js"></script>
<link href="${contextPath}/css/image-picker.css" rel="stylesheet">
<script src="${contextPath}/js/image-picker.min.js" ></script>

<!-- 테스트 CSS -->

<meta charset="UTF-8">
<title>화면 테스트 페이지22222222</title>
</head>
<body>
<select class="image-picker show-html">
  <option value=""></option>
  <option data-img-src="http://placekitten.com/300/200" value="1">Cute Kitten 1</option>
  <option data-img-src="http://placekitten.com/150/200" value="2">Cute Kitten 2</option>
  <option data-img-src="http://placekitten.com/400/200" value="3">Cute Kitten 3</option>
</select>
</body>

<script type="text/javascript">
	var $image_picker = $(".image-picker");
	$image_picker.imagepicker();
</script>

</html>