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

<!-- 테스트 CSS -->
<style type="text/css">
#photos {
  opacity: .88;
}

#photos img {
  width: 30%;
  float: left;
  display: block;
  margin: 2px;
}

ul {
  list-style: none;
  margin: 0px auto;
  padding: 10px;
  display: block;
  max-width: 780px;
  text-align: center;
}

#overlay {
  background: rgba(0,0,0, .8);
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
  display: none;
  text-align: center;
}

#overlay img {
  margin: 10% auto 0;
  width: 550px;
  border-radius: 5px;
}

#photos {
  width: 100%;
}

#photo-gallery {
  width: 100%;
}
</style>
<meta charset="UTF-8">
<title>화면 테스트 페이지</title>
</head>
<body>
<div id="photos">
  <ul id="photo-gallery">
    <li>
      <a href="https://41.media.tumblr.com/0390d80d6c8cc4a7096033182a4bfe8a/tumblr_ndyvukSjNl1tubinno1_1280.jpg">
        <img src="https://41.media.tumblr.com/0390d80d6c8cc4a7096033182a4bfe8a/tumblr_ndyvukSjNl1tubinno1_1280.jpg">
      </a>
    </li>
    <li>
      <a href="https://40.media.tumblr.com/bbe414414f4fd1f0b4886c6fcf4193de/tumblr_ndyvd3qoiL1tubinno1_1280.jpg">
        <img src="https://40.media.tumblr.com/bbe414414f4fd1f0b4886c6fcf4193de/tumblr_ndyvd3qoiL1tubinno1_1280.jpg">
      </a>
    </li>
    <li>
      <a href="https://41.media.tumblr.com/3dde93f097de5e9db4f11b67729d6a2e/tumblr_na06dk1vWM1tubinno1_1280.jpg">
        <img src="https://41.media.tumblr.com/3dde93f097de5e9db4f11b67729d6a2e/tumblr_na06dk1vWM1tubinno1_1280.jpg">
      </a>
    </li>
    <li>
      <a href="https://40.media.tumblr.com/e67b59d43c79c496b6fa8f1dddabef47/tumblr_nbc7zx6vJl1tubinno1_1280.jpg">
        <img src="https://40.media.tumblr.com/e67b59d43c79c496b6fa8f1dddabef47/tumblr_nbc7zx6vJl1tubinno1_1280.jpg">
      </a>
    </li>
    <li>
      <a href="https://40.media.tumblr.com/d94d2a63ab509f403111c6e8ebfc22a4/tumblr_ndyfu61hzH1tubinno1_1280.jpg">
        <img src="https://40.media.tumblr.com/d94d2a63ab509f403111c6e8ebfc22a4/tumblr_ndyfu61hzH1tubinno1_1280.jpg"></a>
    </li>
    <li>
      <a href="https://40.media.tumblr.com/d7a014af6eaec53ccdc7a4171033f96d/tumblr_na06t4fnlI1tubinno1_1280.jpg">
        <img src="https://40.media.tumblr.com/d7a014af6eaec53ccdc7a4171033f96d/tumblr_na06t4fnlI1tubinno1_1280.jpg">
      </a>
    </li>
    <li>
      <a href="https://40.media.tumblr.com/7302cf024c924726c6ad99bb80b0be41/tumblr_nauccbKUCw1tubinno1_1280.jpg">
        <img src="https://40.media.tumblr.com/7302cf024c924726c6ad99bb80b0be41/tumblr_nauccbKUCw1tubinno1_1280.jpg">
      </a>
    </li>
    <li>
      <a href="https://41.media.tumblr.com/fddb3f2b0bdf390efd7ea87372e75fa5/tumblr_ndyg3pYbKW1tubinno1_1280.jpg">
      <img src="https://41.media.tumblr.com/fddb3f2b0bdf390efd7ea87372e75fa5/tumblr_ndyg3pYbKW1tubinno1_1280.jpg">
      </a>
    </li>
    <li>
      <a href="https://41.media.tumblr.com/758a5cb9046fde53138ad0f55527ca25/tumblr_ndyfdoR6Wp1tubinno1_1280.jpg">
        <img src="https://41.media.tumblr.com/758a5cb9046fde53138ad0f55527ca25/tumblr_ndyfdoR6Wp1tubinno1_1280.jpg">
      </a>
    </li>
  </ul>
</div>
</body>
<script type="text/javascript">

var $overlay = $('<div id="overlay"></div>');
var $image = $("<img>");

//An image to overlay
$overlay.append($image);

//Add overlay
$("body").append($overlay);

  //click the image and a scaled version of the full size image will appear
  $("#photo-gallery a").click( function(event) {
    event.preventDefault();
    var imageLocation = $(this).attr("href");

    //update overlay with the image linked in the link
    $image.attr("src", imageLocation);

    //show the overlay
    $overlay.show();
  } );

  $("#overlay").click(function() {
    $( "#overlay" ).hide();
  });
</script>
</html>