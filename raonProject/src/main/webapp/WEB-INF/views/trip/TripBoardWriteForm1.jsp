<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
<meta charset="UTF-8">
<title>여행일정</title>
<style type="text/css">
#con {
	height: 900px;
}

#con1 {
	height: 10%;
	width: 100%;
	margin-bottom: 30px;
	padding: 0;
}

th {
	width: 300px;
}

/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
.ui-datepicker-trigger{cursor: pointer;}
/*datepicer input 롤오버 시 손가락 모양 표시*/
.hasDatepicker{cursor: pointer;}

</style>
<script type="text/javascript">

function goToProfile() {

/* 	$(".profile").mousedown(function() {
		(".profile").css("background-color", "#ef2d4d");
	})
	
	$(".profile").mouseup(function() {
		location.href = "${contextPath}/accounts/profile?user=${user_Num}";
	}) */
	location.href = "${contextPath}/accounts/profile?user=${user_Num}";
}


</script>


</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/trip/trip-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->

	<!-- 바디 시작 -->


	<div class="container" id="con1">
		<img src="${contextPath}/img/TripImg1.jpg"
			style="width: 100%; height: 100%;">
	</div>

	<div class="container" id="con">
		<h3>
			<b>여행만들기</b>
		</h3>
		<br>
		<p style="color: red;">
			<input type="button" disabled="disabled" value="중요"
				class="btn btn-danger" height="20px;" width="20px;"> 여행사의
			여행상품, 패키지 상품 등 기타 상업적인 목적의 이용은 금지사항 입니다
		</p>
		<br>
		<form action="write2" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<input type="hidden" value="${user_Num}" name="user_Num">
			<table class="table" id="ta">

				<tr>
					<th style="padding: 20px;" class="info">제목</th>
					<td style="padding: 20px;">
						<input type="text" id="trip_Board_Title" name="trip_Board_Title" class="form-control" style=" width: 300px;" required="required">
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="info">나의 관심사</th>
<!-- 					미작성 처리된 부분 추후  c:if 로 걸러서 프로필 없는사람한테 띄우고 onclick 달아서 누르면 프로필 설정으로 이동가능하게 하고 마우스 호버시 툴팀 표시 (클릭시 프로필설정 가능이라고) -->
					<td style="padding: 20px;">
						<c:choose>
							<c:when test="${userInfo.UserInterest != null}">			
								<c:forEach items="${userInfo.UserInterest}" var="i">
									<span class="label label-mint label-lg"><b>${i.INTEREST_NAME}</b></span>
								</c:forEach>	
							</c:when>
							<c:otherwise>			
								<span class="label label-pink label-lg profile" onclick="goToProfile()" data-toggle="tooltip" data-placement="right" title="클릭시 프로필 설정으로 이동합니다.">미등록</span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="info">나의 여행희망도시</th>
					<td style="padding: 20px;">
						
						<c:choose>
							<c:when test="${userInfo.UserTravleHope != null}">
								<c:forEach items="${userInfo.UserTravleHope}" var="th">
									<span class="label label-mint label-lg"><b>${th.HOPE_CITY}</b></span>
								</c:forEach>	
							</c:when>
							<c:otherwise>
									<span class="label label-pink label-lg profile" onclick="goToProfile()" data-toggle="tooltip" data-placement="right" title="클릭시 프로필 설정으로 이동합니다.">미등록</span>
							</c:otherwise>
						</c:choose>

					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="info">나의 여행 스타일</th>
					<td style="padding: 20px;">
						<c:choose>
							<c:when test="${userInfo.UserTrStyle != null}">
								<c:forEach items="${userInfo.UserTrStyle}" var="tr">
									<span class="label label-mint label-lg"><b>${tr.TR_STYLE}</b></span>
								</c:forEach>	
							</c:when>
							<c:otherwise>
								<span class="label label-pink label-lg profile" onclick="goToProfile()" data-toggle="tooltip" data-placement="right" title="클릭시 프로필 설정으로 이동합니다.">미등록</span>
							</c:otherwise>
						</c:choose>
						
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="info">여행출발일</th>
					<td style="padding: 20px;">
						<input type="date" id="datepicker"  name="trip_Board_Start">
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="info">여행 종료일</th>
					<td style="padding: 20px;">
						<input type="date" id="datepicker2" name="trip_Board_End">
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="info">여행 동행모집</th>
					<td style="padding: 20px;">
						<select id="Trip_Board_Together" name="Trip_Board_Together" class="form-control" style="width: 200px;">
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="info">여행 소개</th>
					<td style="padding: 20px;">
						<textarea rows="5" cols="10" name="trip_Board_Content"  required="required" style="width: 500px; font-size: 14pt;" ></textarea>
					</td>
				</tr>
				<tr>
					<th>
						<input type="button" value="취소하기" class="btn btn-success" onclick="location.href='list'">
						<input type="submit" value="다음 단계로" class="btn btn-success">
						
					</th>
				</tr>

			</table>

			
		</form>

	</div>
<script>
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();   
});
</script>
<%--달력 스크립트 부분 헤드로 올리면 달력 뻑남 --%>	
<script type="text/javascript">
$(function() {
	
    //여행 시작 날짜
    $("#datepicker").datepicker({
        dateFormat: 'yy-mm-dd' //Input Display Format 변경
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
        ,changeYear: true //콤보박스에서 년 선택 가능
        ,changeMonth: true //콤보박스에서 월 선택 가능                
        ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
        ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
        ,buttonText: "출발일을 선택해주세요" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
        ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
        ,minDate: "D" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            
    });                    
    
    //초기값을 오늘 날짜로 설정
    $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
    
    
    
    //여행 끝 날짜
    $("#datepicker2").datepicker({
        dateFormat: 'yy-mm-dd' //Input Display Format 변경
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true //콤보박스에서 년 선택 가능
            ,changeMonth: true //콤보박스에서 월 선택 가능                
            ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
            ,buttonText: "종료일을 선택해주세요" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
            ,minDate: "1D" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
    });                    
    
    //초기값을 오늘 날짜로 설정
    $('#datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
    
    
});

</script>
<%--달력 스크립트 부분끝 헤드로 올리면 달력 뻑남 --%>	

	<!-- 바디 끝 -->

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->



</body>
</html>