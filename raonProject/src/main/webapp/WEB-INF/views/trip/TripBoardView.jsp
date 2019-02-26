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
		leftDiv1.animate({width:"100%"},"swing")
	}else if(leftDiv2.css("display")=="block"){
		leftDiv1.animate({width:"50%"},"swing")
	}
}


function drawCityTable() {
	var cityNames = "${cityTable}";
	var leftDiv12 = $("#leftDiv-1-2");
	var j = 1;
	alert(cityNames);
	for(var i in cityNames){
		var col = $("<div class='col-sm-12'>");
		var table = $("<table class='table'>");
		var tr = $("<tr>");
		var moveBtn = $("<input type='button' class='btn btn-primary btn-sm' value='>>' id='moveBtn' onclick=''>")
		$("<th>").text(j+"번").appendTo(tr);
		$("<th>").text(cityNames[i].TRIP_CITY_TOWN).appendTo(tr);
		$("<th>").html(moveBtn).appendTo(tr);
		$("<th>").html("<input type='hidden' value='"+cityNames[i].TRIP_CITY_LAT+"' class='btn btn-primary btn-sm' id='moveLat"+i+"'>").appendTo(tr);
		$("<th>").html("<input type='hidden' value='"+cityNames[i].TRIP_CITY_LNG+"' class='btn btn-primary btn-sm' id='moveLng"+i+"'>").appendTo(tr);
		tr.appendTo(table);
		table.appendTo(col);
		col.appendTo(leftDiv12);
		j++;
	}
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
				 					<img src="${contextPath}/img/Profile.png" width="30px;" onclick="#" >
				 					&nbsp;&nbsp;
				 					<span>${boardInfo.USER_NICK}</span>
				 					<button style="background-image:${contextPath}/img/Profile.png "></button>
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
				 	
<%-- 				 		<c:forEach items="${cityTable}" var="list" varStatus="status"> --%>
<!-- 				 			<div class="col-sm-12"> -->
<!-- 								<table class="table"> -->
<!-- 									<tr> -->
<%-- 										<th>${status.count}번</th> --%>
<%-- 										<th>${list.TRIP_CITY_TOWN}</th> --%>
<!-- 										<th> -->
<!-- 											<form action="#" id="moveMaker" method="post"> -->
<%-- 												<input type="hidden" name="lat" value="${list.TRIP_CITY_LAT}"> --%>
<%-- 												<input type="hidden" name="lng" value="${list.TRIP_CITY_LNG}"> --%>
<!-- 												<input type="button" class="btn btn-primary btn-sm" value=">>" id="moveBtn" onclick=""> -->
<!-- 											</form> -->
<!-- 										</th> -->
<!-- 									</tr> -->
<!-- 								</table> -->
<!-- 							</div> -->
<%-- 				 		</c:forEach>	 --%>
				 			
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