<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<% request.setAttribute("contextPath", request.getContextPath()); %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc&libraries=places"></script>
<script
	src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">	
</script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script type="text/javascript">
var locations = ${cityInfo};

function initMap() {
	// 검색한 지도
	var labels = '123456789';

	var uluru = {
		lat : 37.566535,
		lng : 126.97796919999996
	};
	// The map, centered at Uluru
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom : 3,
		center : uluru
	});
	// The marker, positioned at Uluru
	var markers = locations.map(function(location, i) {
		return new google.maps.Marker({
			position : location,
			label : labels[i % labels.length],
			animation : google.maps.Animation.DROP
		});
	});
	var markerCluster = new MarkerClusterer(
			map,
			markers,
			{
				imagePath : 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
			});
	
	
	var flightPath = new google.maps.Polyline({
		path : locations,
		geodesic : true,
		strokeColor : '#4286f4',
		strokeOpacity : 1.0,
		strokeWeight : 2
	});

	flightPath.setMap(map);
	
	
}


	
	

//div 토글용 펑션
function toggleDisplay() {
	var leftDiv1 = $("#leftDiv-1");
	var leftDiv2 = $("#leftDiv-2");
	//var leftDiv2Attr = $("leftDiv-2").attr("display");
	leftDiv2.toggle();
	//css속성이라 css로 했어야했는데 attr prop 쓰냐고 헷갈림
	if(leftDiv2.css("display")=="none"){
		leftDiv1.animate({width:"100%"},400,"swing");
	}else if(leftDiv2.css("display")=="block"){
		leftDiv1.animate({width:"50%"}, 400 ,"swing");
	}
}


function drawCityTable() {
	//일단 이 펑션 보류
	var cityNames = ${cityInfo};
	var leftDiv12 = $("#leftDiv-1-2");
	var j = 1;
		
		 for(var i =0;i<cityNames.length;i++){
			var col = $("<div class='col-sm-12' style='padding: 0px;'>");	
			var table = $("<table class='table'>");
			var tr = $("<tr>");
			var hiddenLat = $("<input type='hidden' name='lat' value='"+cityNames[i].lat+"' id='lat"+i+"'>");
			var hiddenLng = $("<input type='hidden' name='lng' value='"+cityNames[i].lng+"' id='lng"+i+"'>");
			var moveBtn = $("<input type='button' class='btn btn-primary btn-sm' value='>>' id='moveBtn' onclick='moveToMakerLocation("+i+")'> ")
			$("<th style='width: 20px;'>").text(j+"번").appendTo(tr);
			$("<th style='max-width: 90px; text-align: left; width: 90px;'>").text(cityNames[i].cityName).appendTo(tr);
			$("<th style='max-width: 15px; text-align: right; width: 15px;'> ").append(hiddenLat).append(hiddenLng).append(moveBtn).appendTo(tr);
			tr.appendTo(table);
			table.appendTo(col);
			col.appendTo(leftDiv12);
			j++;
			
			
		} 
		
		
	  
}

function moveToMakerLocation(i) {
	//버튼 클릭시 해당 마커로 이동하는 펑션 
	//단점이 맵 을 다시 줌을 작게했을때 마커 사이에 선그린게 없어짐 
	//마커를 지우니 어디 찍고있는지 안보임
	swal({
		  icon:"success"
	  });
	  //alert($("#lat"+i).val());
	  var mlat = $("#lat"+i).val();
	  var mlng = $("#lng"+i).val();
	
	  var move = {lat: parseFloat(mlat), lng: parseFloat(mlng)};
	 
	  var map = new google.maps.Map(
	      document.getElementById('map'), {zoom: 15, center: move});
	 
	  var marker = new google.maps.Marker({position: move, map: map});
}


window.onload = function() {
	
	
	initMap();
	drawCityTable();
	
	
	
}



</script>
<style type="text/css">
#con1 {
	height: 1000px;
}

#leftDiv {
	min-height: 1000px;
	max-height: 1000px;
	overflow: auto;
	border-right: 1px dotted;
	padding: 0px;
	background-color: #eeeeee;
}
#leftDiv-1{
	min-height: 1000px;
	max-height: 1000px;
	height:100%;
	width: 100%;
	padding:0px;
	margin:0px;
	overflow: hidden;
}
#leftDiv-1-1{
	min-height: 200px;
	max-height: 200px;
	height:20%;
	width: 100%;
	border: 1px solid blue;
	margin:0px;
	overflow: hidden;
}
#leftDiv-1-2{
	min-height: 800px;
	max-height: 800px;
	height:800%;
	width: 100%;
	border: 1px solid purple;
	margin:0px;
	overflow: auto;
}
#leftTable{
	min-height: 200px;
	max-height: 200px;
	height: 100%;
	overflow: hidden;
}
#leftDiv-2{
	min-height: 1000px;
	max-height: 1000px;
	height:100%;
	width: 50%;
	border: 1px solid green;
	padding: 0px;
	overflow: auto;
	display: none;
}
th{
	padding: 0px;
}
/* #leftDiv-2-1{ */


/* } */

#rightDiv {
	min-height: 1000px;
	max-height: 1000px;
	padding: 1px;
}
/*#rightRow1{
	min-height: 1000px;
	max-height: 1000px;
	width:100%;
	margin: 0px;
}
 #rightRow2{
	min-height: 200px;
	max-height: 200px;
	width:100%;
	border-top:1px dotted;
	margin: 0px;
} */
#boardContent{
	min-height: 200px;
	max-height: 200px;
	width: 100%;
	height: 100%;
	overflow: auto;
	
}
#boardContent-1{
	font-size: 12pt;
}

#map{
	height:	1000px;
	width: 100%;

}

</style>
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/trip/trip-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->
	
	
	
	<div class="container-fluid" id="con1">
		<div class="row" id="mainRow">
			<!--왼쪽 사이드 div  -->
			<div class="col-lg-4" id="leftDiv">
				
				<div class="col-lg-6" id="leftDiv-1">
				 	
				 	<div class="row" id="leftDiv-1-1">

				 		<table class="table" id="leftTable">
				 			<tr>
				 				<th colspan="4">
				 					<h4>${boardInfo.TRIP_BOARD_TITLE}</h4>
				 				</th>
				 			</tr>
				 			<tr>
				 				<th>
				 					<img src="${contextPath}/img/trip_Profile.png" width="30px;">
				 					&nbsp;&nbsp;
				 					<span>${boardInfo.USER_NICK}</span>
				 					
				 				</th>
				 			</tr>
				 			<tr>
				 				<td><input type="button" onclick="toggleDisplay()" class="btn btn-primary btn-xs" value="동행신청">
				 				<input type="button" onclick="toggleDisplay()" class="btn btn-primary btn-xs" value="신고">
				 				<input type="button" onclick="toggleDisplay()" class="btn btn-primary btn-xs" value="수정">
				 				<input type="button" onclick="toggleDisplay()" class="btn btn-primary btn-xs" value="삭제">
				 				<input type="button" onclick="toggleDisplay()" class="btn btn-primary btn-xs" value="토글">
				 				</td>
				 			</tr>
				 		</table>
	
				 	
				 	</div>
				 	<div class="row" id="leftDiv-1-2">
				 	
	<%-- 			 		<c:forEach items="${cityTable}" var="list" varStatus="status">
 				 			<div class="col-sm-12" style="padding: 0px;"> 
								<table class="table"> 
 									<tr> 
										<th style="width: 20px;">${status.count}번</th>
										<th style="max-width: 90px; text-align: left; width: 90px;">${list.TRIP_CITY_TOWN}</th>
 										<th style="max-width: 15px; text-align: right; width: 15px;"> 
 											<form action="#" id="moveMaker" method="post"> 
												<input type="hidden" name="lat" value="${list.TRIP_CITY_LAT}" id="lat${status.count}">
												<input type="hidden" name="lng" value="${list.TRIP_CITY_LNG}" id="lng${status.count}">
												<input type="button" class="btn btn-primary btn-sm" value=">>" id="moveBtn" onclick=""> 
 											</form> 
										</th>
 									</tr>
 								</table> 
 							</div> 
				 		</c:forEach>	 --%>
				 			
				 	</div>
				 	
				</div>
				
				<!--중앙 div 콜렙스 될부분  -->
				<div class="col-lg-6" id="leftDiv-2">
				 	<div class="container" id="leftDiv-2-1">
				 		<table class="table">
				 			<tr>
				 				<th>
				 					<h2><b><small><mark>여행소개</mark></small></b></h2>
				 				</th>
				 			</tr>
				 			<tr>
				 				<td style="font-size: 13pt;">
				 					${boardInfo.TRIP_BOARD_COUNTENT}
				 				</td>
				 			</tr>
				 		</table>
	 		
				 	</div>
				</div>
				
			</div>
			
			<!--지도 들어갈 div  -->
			<div class="col-lg-8" id="rightDiv">
				<div id="map">지도</div> 
			<%--	
				우측 div를 상하단으로 8/2비뷸로 나눌때 
			<div class="row" id="rightRow1">
					
				</div>
			 	<div class="row" id="rightRow2">
					 <div id="boardContent">
					 	<span id="boardContent-1">${boardInfo.TRIP_BOARD_COUNTENT}</span>		
					 </div> 
				</div> --%>
			</div>
		
		
		
		
		</div>
	</div>
	
	
	
	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->

</body>
</html>