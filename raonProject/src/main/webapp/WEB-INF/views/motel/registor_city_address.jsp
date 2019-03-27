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
//submit 실행시 form안에 
//나라 도시 주소 입력 확인 함수

	$(function(){
		
		
		//국가입력 스크립트
		$(".national").click(function() {
			$(this).next().show();
			$(this).next().hide();
		});
		//도시입력 스크립트
		$(".city").click(function() {
			$(this).next().show();
			$(this).next().hide();
		});
		
		//서밋 이벤트실행 시 유효성 검사
		$("#register_form").on("submit",function (){
			
			var nation = $('#nation').val();
			var city = $('#city').val();
			var address = $('#address').val();
			
			var city_split = city.split(', ');
			var city_en = city_split[0];
			var city_ko = city_split[1];
// 			alert(city);
// 			alert(city_en);
// 			alert(city_ko);
			
			var nation_split = nation.split(', ');
			var nation_en = nation_split[0];
			var nation_ko = nation_split[1];
			//var isFind = false;
			var checkNum = 0;
			
			if(address == "" || address.length < 5){
				swal({
		               text:"숙소의 상세주소를 작성해 주세요.",
		               icon:"warning",
		               buttons:[false,"확인"]
		            })
				return false;
			}
			
			
			$.ajax({
				url : "${contextPath}/motel/DB_nation",
				type : "get",
				async : false,
				dataType : "json",
				success : function(data) {
						//alert("나라  : " + nation_ko);
//		 				console.log("나라  : " + nation_ko);
//		 				console.log("nation : " + nation_en);
						
						//console.log(data[i].NATIONALITY_KOR_NAME);
						//console.log(data[i].NATIONALITY_NAME);

					for(var i in data){
						
						if(data[i].NATIONALITY_KOR_NAME == nation_ko && data[i].NATIONALITY_NAME == nation_en){
							//서밋
							//console.log("같다!!!12312312")
							checkNum++;
							break;
						}
						
					}		
				}
			});
			
			$.ajax({
				url : "${contextPath}/motel/DB_city",
				type : "get",
				async : false,
				dataType : "json",
				success : function(data) {
					for(var i in data){
						
						if(data[i].KO_CITY == city_ko && data[i].CITY == city_en){
							checkNum++

						}
						
					}		
				}
			});

			if(checkNum == 2){
				//console.log("같다!!!");
				
			}else{
				//console.log("다르다");
				swal({
		               text:"숙소의 국가/도시를 정확히 선택해 주세요.",
		               icon:"warning",
		               buttons:[false,"확인"]
		            })
				return false;
			}
				
		});
		
	});


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
        	
           
          if (status === 'OK') {
            resultsMap.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
              map: resultsMap,
              position: results[0].geometry.location
            });
            //debugger;
          } else {
            alert('Geocode was not successful for the following reason: ' + status);
          }
        });
      }
	
      //국가 도시 검색 후 엔터키 쳤을 때 페이지 넘어가는것 막는 코드
	 function captureReturnKey(e) {
         if(e.keyCode==13 && e.srcElement.type != 'textarea')
         return false;
     }


</script>	
<style type="text/css">
#register_form{
	padding-left: 10px;
}
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
	margin-right: 2%;
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
	height: 85%;
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
        width: 700px;
        margin-top: 65px;
        
      }
      #searchMap{
         display:none;
         height: 250px;
         width: 700px;
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
					
					<form method="post" action="registor_photo" id = "register_form" onkeydown="return captureReturnKey(event)">
						<input type="hidden" value="${_csrf.token}"
							name="${_csrf.parameterName}">
						<!-- 						기존에 받았던 데이터 -->
						<input type="hidden" value="${motel_type }" name="motel_type">
						<input type="hidden" value="${motel_category }"name="motel_category"> 
						<input type="hidden" value="${motel_bathroom }" name="motel_bathroom"> 
						<input type="hidden" value="${motel_room }" name="motel_room"> 
						<input type="hidden" value="${motel_people }" name="motel_people">

						<h4>숙소의 국가를 선택하여 주세요.</h4> 
						<c:if test="${!empty national}">
							<input list="brow" id="nation" class="national" name="motel_nation" style="width: 300px;">
							<datalist id="brow">

								<c:forEach var="national" items="${national}" varStatus="i">

									<option id = "nationDB"
										value="${national.NATIONALITY_NAME}, ${national.NATIONALITY_KOR_NAME}" onkeypress='chkCode(this,event.keyCode)'></option>

								</c:forEach>

							</datalist>
						</c:if>
						<br>
						
						<h4>숙소의 도시를 선택하여 주세요.</h4>
						<c:if test="${!empty city}">
							<input list="brow1" id="city" class="city" name="motel_city" style="width: 300px;">
							<datalist id="brow1">

								<c:forEach var="city" items="${city}" varStatus="i">

									<option
										value="${city.CITY}, ${city.KO_CITY}" ></option>

								</c:forEach>

							</datalist>
						</c:if>
						<br>

							
						<h4>상세주소를 입려하여주세요.(지도에서 위치를 확인하여주세요.)</h4>
							<div id="floating-panel">
								<input id="address" type="text" placeholder="주소를 입력하세요" name="motel_address">
								<input id="submit" type="button" value="검색">
							</div>
							<div id="map"></div>
							<div id="searchMap"></div>

							<input type="submit" value="" class="btn_next" id="btn_next">
						 <input	type="button" value="" class="btn_back"
									onclick="history.back(-1);" >
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