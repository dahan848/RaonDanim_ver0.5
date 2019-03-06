<!-- Header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- contextPath 설정 -->
<%	request.setAttribute("contextPath", request.getContextPath()); %>	

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="${contextPath}/css/commonness.css" rel="stylesheet"> 
<link href="${contextPath}/css/bootstrap-social.css" rel="stylesheet"> 
<link href="${contextPath}/css/font-awesome.css" rel="stylesheet"> 
<link href="${contextPath}/css/chatList.css" rel="stylesheet">
<link href="${contextPath}/css/lightgallery.min.css" rel="stylesheet">  
<script type='text/javascript' src="${contextPath}/js/lightgallery-all.min.js" ></script>
<script type='text/javascript' src="${contextPath}/js/chat.js" ></script>


<meta charset="UTF-8">
<title>화면 테스트 페이지</title>
</head>
<body>
	<div class="lg-backdrop in" style="transition-duration: 150ms;"></div>
	<div
		class="lg-outer  lg-start-zoom lg-use-css3 lg-css3 lg-slide lg-show-after-load lg-pull-caption-up lg-has-thumb lg-can-toggle lg-visible lg-thumb-open lg-grab">
		<div class="lg" style="width: 100%; height: 100%">
			<div class="lg-inner"
				style="transition-timing-function: ease; transition-duration: 600ms;">
				<div class="lg-item lg-loaded lg-complete lg-zoomable lg-current">
					<div class="lg-img-wrap" style="left: 0px; top: 0px;" data-x="0"
						data-y="0">
						<img class="lg-object lg-image"
							src="${contextPath}/image?fileName=25_gallery_1551838713606575686.jpg"
							data-scale="1" style="transform: scale3d(1, 1, 1);">
					</div>
				</div>
				<div class="lg-item lg-loaded lg-complete lg-zoomable lg-next-slide">
					<div class="lg-img-wrap">
						<img class="lg-object lg-image"
							src="${contextPath}/image?fileName=25_gallery_1551838713606575686.jpg">
					</div>
				</div>
				<div class="lg-item lg-loaded lg-complete lg-zoomable lg-prev-slide">
					<div class="lg-img-wrap">
						<img class="lg-object lg-image"
							src="${contextPath}/image?fileName=25_gallery_1551838713606575686.jpg">
					</div>
				</div>
			</div>
			<div class="lg-toolbar group">
				<span class="lg-close lg-icon"></span><a id="lg-download"
					target="_blank" download="" class="lg-download lg-icon"
					href="./팟럭트립_files/96441cac-50e2-467b-bd11-08cf2c722620.jpg"></a><span
					class="lg-autoplay-button lg-icon"></span><span
					class="lg-fullscreen lg-icon"></span><span id="lg-zoom-in"
					class="lg-icon"></span><span id="lg-zoom-out" class="lg-icon"></span><span
					id="lg-actual-size" class="lg-icon"></span>
				<div id="lg-counter">
					<span id="lg-counter-current">1</span> / <span id="lg-counter-all">3</span>
				</div>
			</div>
			<div class="lg-actions">
				<div class="lg-prev lg-icon"></div>
				<div class="lg-next lg-icon"></div>
			</div>
			<div class="lg-sub-html lg-empty-html"></div>
			<div class="lg-progress-bar">
				<div class="lg-progress"></div>
			</div>
			<div class="lg-thumb-outer lg-grab" style="height: 100px;">
				<div class="lg-thumb group"
					style="width: 315px; position: relative; transform: translate3d(0px, 0px, 0px); transition-duration: 600ms;">
					<div data-vimeo-id="" class="lg-thumb-item active"
						style="width: 100px; margin-right: 5px">
						<img src="${contextPath}/image?fileName=25_gallery_1551838713606575686.jpg">
					</div>
					<div data-vimeo-id="" class="lg-thumb-item"
						style="width: 100px; margin-right: 5px">
						<img src="${contextPath}/image?fileName=25_gallery_1551838713606575686.jpg">
					</div>
					<div data-vimeo-id="" class="lg-thumb-item"
						style="width: 100px; margin-right: 5px">
						<img
							src="${contextPath}/image?fileName=25_gallery_1551838713606575686.jpg">
					</div>
				</div>
				<span class="lg-toogle-thumb lg-icon"></span>
			</div>
		</div>
	</div>
</body>
</html>