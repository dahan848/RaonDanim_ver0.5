<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라온다님</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
    
        <script defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc&callback=initMap&libraries=places">
    </script>

<script type="text/javascript">
	//주소입력 후 지도에 표시 
       function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 1,
          center: {lat: -34.397, lng: 150.644}
        });
        var searchMap = new google.maps.Map(document.getElementById('searchMap'), {
            zoom: 14,
            center: {lat: -34.397, lng: 150.644}
          });
        
        var geocoder = new google.maps.Geocoder();

        document.getElementById('submit').addEventListener('click', function() {
          geocodeAddress(geocoder, searchMap);
          $("#map").hide();
          $("#searchMap").show();
        });
      }

      function geocodeAddress(geocoder, resultsMap) {
         
        var address = document.getElementById('address').value;
        geocoder.geocode({'address': address}, function(results, status) {
           debugger;
          if (status === 'OK') {
            resultsMap.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
              map: resultsMap,
              position: results[0].geometry.location
            });
          } else {
            alert('Geocode was not successful for the following reason: ' + status);
          }
        });
      }
      
		//국가입력 스크립트
	$(document).ready(function() {
		
		$(".national").click(function() {
			$(this).next().show();
			$(this).next().hide();
		});

	});
		
	$(document).ready(function() {
		
		$(".city").click(function() {
			$(this).next().show();
			$(this).next().hide();
		});

	});
	
      //국가 도시 검색 후 엔터키 쳤을 때 페이지 넘어가는것 막는 코드
	 function captureReturnKey(e) {
         if(e.keyCode==13 && e.srcElement.type != 'textarea')
         return false;
     }

// 주소로 지도에 찍는 함수
</script>	
<style type="text/css">
.btn_next {
	background-image: url('${contextPath}/img/motel/next.jpg');
	background-position: 0px 0px;
	background-repeat: no-repeat;
	width: 50px;
	height: 45px;
	border: 0px;
	cursor: pointer;
	outline: 0;
	margin-top: 10px;
	float: right;
	margin-right: 15%;
}

.btn_back {
	background-image: url('${contextPath}/img/motel/back.jpg');
	background-position: 0px 0px;
	background-repeat: no-repeat;
	width: 50px;
	height: 45px;
	border: 0px;
	cursor: pointer;
	outline: 0;
	margin-top: 10px;
	float: left;
}
.registor_main {
	padding-top : 9%;
	background-repeat: no-reapt;
	height: 800px;
	width: 100%;
	background-image: url("${contextPath}/img/motel/motel_registor.jpg");
	background-position: center;
	background-size: cover;
}
.registor_contain {
	margin : auto;
/*  	margin-top : 15%;  */
	background-position: center;
	width: 60%;
	height: 80%;
	background-color: white;
	width: 60%;
	border: 1px solid #444444;
	background-position: center;
	padding: 3%;
	float: center;
	
}

/* 지도관련 css */
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 250px;
        width: 500px;
        margin-top: 65px;
        
      }
      #searchMap{
         display:none;
         height: 250px;
         width: 500px;
        margin-top: 65px;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #floating-panel {
        position: absolute;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }



</style>
</head>
<body>
<%-- 	확이 : ${city}.length<br> --%>
	motel_bath : ${motel_bath }
	<br> motel_type : ${motel_type }
	<br> motel_category : ${motel_category }
	<br> motel_people : ${motel_people }
	<br> motel_room : ${motel_room }
	<br>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->



	<!-- 본문 -->
	<div class="main-container" style="padding-top: 0; padding-bottom: 0;">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<div class="registor_main">
					<div class="registor_contain" style="width: 70%;">
					<form action="registor_photo" method="post" id = "register_form" onkeydown="return captureReturnKey(event)">
						<input type="hidden" value="${_csrf.token}"
							name="${_csrf.parameterName}">
						<!-- 						기존에 받았던 데이터 -->
						<input type="hidden" value="${motel_type }" name="motel_type">
						<input type="hidden" value="${motel_category }"name="motel_category"> 
						<input type="hidden" value="${motel_bath }" name="motel_bath"> 
						<input type="hidden" value="${motel_room }" name="motel_room"> 
						<input type="hidden" value="${motel_people }" name="motel_people">

<%-- 						<c:if test="${!empty national}"> --%>

<!-- 							<select name="selectBox" id="selectBox" style="width: 80px;" -->
<!-- 								class="select_02"> -->

<%-- 								<c:forEach var="national" items="${national}" varStatus="i"> --%>

<%-- 									<option value="${national.NATIONALITY_KOR_NAME}">${national.NATIONALITY_NAME}${national.NATIONALITY_KOR_NAME}</option> --%>

<%-- 								</c:forEach> --%>

<!-- 							</select> -->

<%-- 						</c:if> --%>

<!-- 						<br> -->

<!-- 						<input list="brow"> -->
<!-- 						<datalist id="brow"> -->
<!-- 							<option value="Internet Explorer"> -->
							
<!-- 							<option value="Firefox"> -->
  
<!-- 							<option value="Chrome"> -->
  
<!-- 							<option value="Opera"> -->
  
<!-- 							<option value="Safari"> -->
							
<!-- 							<option value="한국"> -->
							
<!-- 							<option value="일본"> -->
							
<!-- 							<option value="중국"> -->
							
<!-- 							<option value="미국"> -->

<!-- 						</datalist> -->
<!-- 						<br> -->

						<h4>숙소의 국가를 선택하여 주세요.</h4> 
						<c:if test="${!empty national}">
							<input list="brow" class="national" style="width: 300px;">
							<datalist id="brow">

								<c:forEach var="national" items="${national}" varStatus="i">

									<option
										value="${national.NATIONALITY_KOR_NAME}${national.NATIONALITY_NAME}" ></option>

								</c:forEach>

							</datalist>
						</c:if>
						<br>
						
						<h4>숙소의 도시를 선택하여 주세요.</h4>
						<c:if test="${!empty city}">
							<input list="brow1" class="city" style="width: 300px;">
							<datalist id="brow1">

								<c:forEach var="city" items="${city}" varStatus="i">

									<option
										value="${city.CITY}||${city.KO_CITY}" ></option>

								</c:forEach>

							</datalist>
						</c:if>
						<br>

							
						<h4>상세주소를 입려하여주세요.(지도에서 위치를 확인하여주세요.)</h4>
							<div id="floating-panel">
								<input id="address" type="textbox" placeholder="주소를 입력하세요">
								<input id="submit" type="button" value="검색">
							</div>
							<div id="map"></div>
							<div id="searchMap"></div>

							<input type="submit" value="" class="btn_next">
						 <input	type="button" value="" class="btn_back"
									onclick="history.back(-1);">
					</form>
					</div>
				</div>
			</div>
		</section>
	</div>
	<!-- 본문 END-->

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>