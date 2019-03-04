<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라온다님</title>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc&libraries=places"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	//도시 불러오는 스크립트
	function initialize() {
          var input = document.getElementById('searchTextField');
          //애가 요소 찝어서 자동완성하게 해주는거
          var autocomplete = new google.maps.places.Autocomplete(input);
            google.maps.event.addListener(autocomplete, 'place_changed', function () {
                var place = autocomplete.getPlace();
                document.getElementById('city2').value = place.name;


            });
        }
        //윈도우 onload시 실행
        google.maps.event.addDomListener(window, 'load', initialize);
        


          
          function captureReturnKey(e) {
              if(e.keyCode==13 && e.srcElement.type != 'textarea')
              return false;
          }
        
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
</style>
</head>
<body>
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
	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<div class="registor_main">
					<form action="registor_photo" method="post" id = "register_form" onkeydown="return captureReturnKey(event)">
						<input type="hidden" value="${_csrf.token}"
							name="${_csrf.parameterName}">
						<!-- 						기존에 받았던 데이터 -->
						<input type="hidden" value="${motel_type }" name="motel_type">
						<input type="hidden" value="${motel_category }"name="motel_category"> 
						<input type="hidden" value="${motel_bath }" name="motel_bath"> 
						<input type="hidden" value="${motel_room }" name="motel_room"> 
						<input type="hidden" value="${motel_people }" name="motel_people">

<%-- 						<c:if test="${!empty testList}"> --%>

<!-- 							<select name="selectBox" id="selectBox" style="width: 80px;" -->
<!-- 								class="select_02"> -->

<%-- 								<c:forEach var="testList" items="${testList}" varStatus="i"> --%>

<%-- 									<option value="${testList.name}">${testList.name}</option> --%>

<%-- 								</c:forEach> --%>

<!-- 							</select> -->

<%-- 						</c:if> --%>

						<h4>숙소의 국가를 선택하여 주세요.</h4>
						<select name="motel_city">
							<option value="1">도시1</option>
							<option value="2">도시2</option>
							<option value="3">도시3</option>
							<option value="4">도시4</option>
						</select>
						
						<h4>숙소의 도시를 선택하여 주세요.</h4>
						<input id="searchTextField" type="text" size="50"
							placeholder="도시를 입력하세요" autocomplete="on" runat="server" /> 
							<input type="text" id="city2" name="city2" />
							<jsp:include page="/WEB-INF/views/motel/11.jsp">
<%--  								<jsp:param name="city3" value="<%=city3%>"/>  --%>
							</jsp:include>
							
						<h4>상세주소를 입려하여주세요.</h4>
						<input type="text" name="motel_address">
						<h4>지도에서 위치를 확인하여주세요.</h4>
						<input type="submit" value="" class="btn_next"> <input
							type="button" value="" class="btn_back"
							onclick="history.back(-1);">
					</form>
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