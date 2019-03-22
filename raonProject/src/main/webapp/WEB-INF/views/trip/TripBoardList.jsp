<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html>
<html>
<head>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc
&callback=initMap">
    </script>
<script
	src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
<meta charset="UTF-8">
<title>동행</title>
<style type="text/css">
#con {
	min-height: 1300px;
	max-height: 1300px;
	overflow: hidden;
}

#con1 {
	height: 10%;
	width: 100%;
	margin-bottom: 30px;
	padding: 0;
}

#con2 {
	height: 70%;
	width: 100%;
	margin-bottom: 30px;
	padding: 0;
}

.swal-text {
  background-color: #FEFAE3;
  padding: 17px;
  border: 1px solid #F0E1A1;
  display: block;
  margin: 22px;
  text-align: center;
  color: #f94563;
  font-size: 12pt;
}

</style>

<script type="text/javascript">

	var locations = ${tripLatLng};

	function initMap() {
		// 검색한 지도
		var labels = '1';

		var uluru = {
			lat : 37.566535,
			lng : 126.97796919999996
		};
		// The map, centered at Uluru
		var map = new google.maps.Map(document.getElementById('map'), {
			zoom : 2,
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
		
	}
	window.onload = function() {
	
		
		initMap();
		
		//수정 삭제 성공시 alert로 사용자에게 알림 
 		var msg = "${msg}";
 		if(msg !=null && msg != ""){
 			swal({
 				icon:"success",
 				text:msg,
 			});
 		}
	

 		
	$("#searchType").on("change",function() {
			
			var typeValue = $("#searchType option:selected").val();
			
			var keywordDiv = $("#keywordDiv");
			var keyword = $("<input type='text' class='form-control' id='keyword' placeholder='검색어를 입력하세요' name='keyword' style='width: 700px;'>");
			var keyword2 = $(" <label for='email'>성:</label>" + 
			"      <input type='text' class='form-control' placeholder='성 을 입력하세요' id='lName' name='lName'>" + 
			"      <label for='pwd'>이름:</label>" + 
			"      <input type='text' class='form-control' placeholder='이름 를 입력하세요' id='fName' name='fName'>");
		
			keywordDiv.html("");
			if(typeValue==4){
				keyword2.appendTo(keywordDiv);
			}else{
				keyword.appendTo(keywordDiv);
			}
			
		});

	$("#searchForm").on("submit", function() {
		//검색창 공백 체크
		
		var typeValue = $("#searchType option:selected").val();
		var keyword = $("#keyword");
		var lName = $("#lName");
		var fName = $("#fName");
		
		if(typeValue==0){
			//디폴트
			return true;
		}else if(typeValue==4){
			//이름검색
			if(lName.val()=="" && fName.val()!=""){
				//성입력칸이 비었을때
				return true;
				
			}else if(lName.val()!="" && fName.val()==""){
				//이름 입력칸이 비었을때
				return true;
			}else if(lName.val()=="" && fName.val()==""){
				//둘다 비었을때
				swal({
					icon:"warning",
					text:"검색어를 입력해주세요.",
				});
				return false;
			}else{
				//둘다 입력했을때
				return true;
			}
			
			
			
		}else{
			if(keyword.val()=="" || keyword.val()==null){
				//옵션밸류 1~3으로 입력값 안집어넣었을 때
				swal({
					icon:"warning",
					text:"검색어를 입력해주세요.",
				});
				return false;
			}
			
		}
		

		
	});
	
	
	$("#dongHangBtn").on("click", function() {
		var dongHangTable = $("#dongHangTable");
		$("#dongHangTable tr:gt(0)").remove();
		$.ajax({
			url:"getMyDongHangList",
			type:"post",
			data:{"${_csrf.parameterName}":"${_csrf.token}"},
			dataType:"json",
			success:function(result){
				
				for(var i in result){
					var tr = $("<tr>");
					$("<td>").html("<a href='view?boardKey="+result[i].TRIP_BOARD_KEY+"'>"+result[i].TRIP_BOARD_TITLE+"</a>").appendTo(tr);
					$("<td>").text(result[i].TRIP_BOARD_START).appendTo(tr);
					$("<td>").text(result[i].TRIP_BOARD_END).appendTo(tr);
					$("<td>").text(result[i].TRIP_BOARD_TOGETHER+"인").appendTo(tr);
					tr.appendTo(dongHangTable);
					
					
				}
				
				
				
				
			}
			
		})
		
			
		
		
	});
	
	
	
	
	

	}
</script>

</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/trip/trip-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->



	<!--바디 시작  -->
	<div class="container" id="con1">
		<img src="${contextPath}/img/TripImg2.jpg"
			style="width: 100%; height: 100%;">
	</div>


	<div class="container" id="con">


		<div class="container" id="con2">

			<h1>
				<small><b>여행자들이 선택한 여행지들</b></small>
			</h1>

			<!--맵자리 시작  -->
			<div style="height: 500px; border: 1px solid black;" id="map"></div>
			<!--맵자리 끝  -->

			<!-- 검색 collaspe 활성화 버튼  -->
			<input type="button" value="검색" style="width: 100%;" class="btn btn-success" data-toggle="collapse" data-target="#search">
			<!-- 검색 collaspe 활성화 버튼  -->
			<div id="search" class="collapse" style="border: 1px solid;">
				<div class="container" style="height: 100px;">
					<form class="form-inline" action="list" method="post" id="searchForm">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
						<br> <br> 
						<select class="form-control" name="type" id="searchType" style="width: 100px;">
							<option value="0">검색</option>
							<option value="1">제목</option>
							<option value="2">출발일</option>
							<option value="3">종료일</option>
							<option value="4">여행자</option>
						</select>



						<div class="form-group" id="keywordDiv">
							<input type="text" class="form-control" id="keyword"
								placeholder="검색어를 입력하세요" name="keyword" style="width: 700px;">
							
			   			    <input type="hidden" class='form-control' id='lName' name='lName' value="">			     			
			     			<input type="hidden" class='form-control' id='fName' name='fName' value="">	

						</div>

						<input type="submit" class="btn btn-default" value="검색">
					</form>
				</div>
			</div>

			<table class="table">
				<thead>
					<tr class="warning">
						<th><h5>
								<b></b>
							</h5></th>
						<th><h5>
								<b>여행자</b>
							</h5></th>
						<th><h5>
								<b>제목</b>
							</h5></th>
						<th><h5>
								<b>여행기간</b>
							</h5></th>

<!-- 						<th><h5>
								<b>여행스타일(아마도 삭제 예정)</b>
							</h5></th> -->
						<th><h5>
								<b>동행가능</b>
							</h5></th>
						<th><h5>
								<b>조회수</b>
							</h5></th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${empty tripData.tripBoardList}">
					
					<script>
						swal({
							icon:"warning",
							text:"검색된 결과가 없습니다.",
						});
						
					</script>
					
				</c:if>

					<c:forEach items="${tripData.tripBoardList}" var="list" varStatus="status">
						<tr>
							<td><c:choose>
									<c:when test="${list.USER_PROFILE_PIC eq 'n'}">
										<a href="" rel="popover" data-placement="bottom"
											data-popover-content="#userInfo${status.index}"> <img
											src="${contextPath}/img/trip_Profile.png">
										</a>

									</c:when>
									<c:otherwise>
										<a href="" rel="popover" data-placement="bottom"
											data-popover-content="#userInfo${status.index}"> <img
											src="${contextPath}/image?fileName=${list.USER_PROFILE_PIC}"
											style="width: 40px; height: 40px;">
										</a>
									</c:otherwise>
								</c:choose></td>
							<td>${list.USER_LNM}${list.USER_FNM}</td>
							<td><a
								href="view?boardKey=${list.TRIP_BOARD_KEY}&userNum=${list.USER_NUM}">${list.TRIP_BOARD_TITLE}</a>
							</td>



							<td>
								<f:formatDate value="${list.TRIP_BOARD_START}"
										pattern="yyyy-MM-dd" /> &nbsp;<strong>~</strong>&nbsp; <f:formatDate
										value="${list.TRIP_BOARD_END}" pattern="yyyy-MM-dd" />
							</td>

					
						<!-- 	<td>
								<span class="label label-pink label-lg">미작성</span>
							</td> -->
							<td>${list.TRIP_BOARD_TOGETHER}<small><b>인</b></small></td>
							<td>${list.TRIP_BOARD_READCOUNT}</td>
						</tr>
						        <div id="userInfo${status.index}" class="hide" style="margin-left: auto; margin-right: auto; text-align: center;">
									${list.USER_LNM} ${list.USER_FNM} <br>
									<a href="${contextPath}/accounts/profile?user=${list.USER_NUM}">프로필보기</a><br>
									<sec:authorize access="isAuthenticated()"> <!-- 로그인 상태 일때만 표시 -->
									<a href="#">대화하기</a>
									</sec:authorize>
										   
								</div>   
						
					</c:forEach>
				</tbody>
			</table>
			
			
			<div class="container">
				<input type="button" class="btn btn-info" data-toggle="modal" id="dongHangBtn" data-target="#dongHang" value="내 동행신청" style="margin-right: 30%;">
				<ul class="pager" style="display: inline-block;">
					<c:if test="${tripData.page!=1}">
						<li><a
							href="list?pageNum=${param.pageNum-1}&type=${param.type}&keyword=${param.keyword}">Previous</a></li>
					</c:if>
					<c:forEach var="pageNum" begin="${tripData.start}"
						end="${tripData.end < tripData.total ? tripData.end: tripData.total}">
						<a
							href="list?pageNum=${pageNum}&type=${param.type}&keyword=${param.keyword}&lName=${param.lName}&fName=${param.fName}">${pageNum}&nbsp;&nbsp;&nbsp;</a>
					</c:forEach>
					<c:if test="${tripData.page!=tripData.total}">
						<li><a
							href="list?pageNum=${param.pageNum+1}&type=${param.type}&keyword=${param.keyword}">Next</a></li>
					</c:if>
				</ul>
			</div>
		</div>


	</div>


	<!--팝오버 끝  -->
	<!--바디끝  -->

<!-- 내 동행신청 모달 -->
<div class="container">

  <!-- Modal -->
  <div class="modal fade" id="dongHang" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h2><small><b>동행신청리스트</b></small></h2>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body" id="dongHangBody" style="overflow: auto;">
        	
         	<table id="dongHangTable" class="table">
         		<tr class="warning">
         			<th>
         				동행 신청 글
         			</th>
         			<th>
         				여행 출발 일
         			</th>
         			<th>
         				여행 종료 일
         			</th>
         			<th>
         				동행 가능 수
         			</th>
         		</tr>
         	
         	</table>
          
          
          
          
          
          
          
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</div>


<!-- 내 동행신청 모달  끝-->

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->


</body>
</html>