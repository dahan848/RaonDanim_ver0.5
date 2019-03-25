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
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>여행일정수정</title>
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
$(function() {
	
// 	$("#writeForm").on("submit", function() {
// 		$('#boardContent').val().replace(/\n/g, "<br>");

		
// 	})
	
	
})

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
			<b>여행만들기 수정</b>
		</h3>
		<br>
		<p style="color: red;">
			<input type="button" disabled="disabled" value="중요"
				class="btn btn-danger" height="20px;" width="20px;"> 여행사의
			여행상품, 패키지 상품 등 기타 상업적인 목적의 이용은 금지사항 입니다
		</p>
		<br>
		<form action="modify2" method="post" id="writeForm">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<%-- 			<input type="text" value="${user_Num}" name="user_Num"> --%>
			<input type="hidden" value="${boardInfo.TRIP_BOARD_KEY}" name="trip_Board_Key">
			<input type="hidden" value="${boardInfo.USER_NUM}" name="user_Num">
			<input type="hidden" value="스타일 스펠링 확인용" style='margin-top: 10px;'>
			
			<table class="table" id="ta">
				
				<tr>
					<th style="padding: 20px;" class="success">제목</th>
					<td style="padding: 20px;">
						<input type="text" id="trip_Board_Title" name="trip_Board_Title" class="form-control" style=" width: 300px;" value="${boardInfo.TRIP_BOARD_TITLE}">
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="warning">나의 관심사</th>
					<td style="padding: 20px;">
						<c:choose>
							<c:when test="${userInfo.UserInterest != null}">			
								<c:forEach items="${userInfo.UserInterest}" var="i">
									<span class="label label-mint label-lg"><b>${i.INTEREST_NAME}</b></span>
								</c:forEach>	
							</c:when>
							<c:otherwise>			
								<span class="label label-pink label-lg profile" onclick="goToProfile()" data-toggle="tooltip" data-placement="right" title="프로필 설정은 나의 정보에서 가능합니다.">미등록</span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
<!-- 				<tr> -->
<!-- 					<th style="padding: 20px;" class="info">나의 여행희망도시</th> -->
<!-- 					<td style="padding: 20px;"> -->
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${userInfo.UserTravleHope != null}"> --%>
<%-- 								<c:forEach items="${userInfo.UserTravleHope}" var="th"> --%>
<%-- 									<span class="label label-mint label-lg"><b>${th.HOPE_CITY}</b></span> --%>
<%-- 								</c:forEach>	 --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<!-- 									<span class="label label-pink label-lg profile" onclick="goToProfile()" data-toggle="tooltip" data-placement="right" title="프로필 설정은 나의 정보에서 가능합니다.">미등록</span> -->
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<!-- 					</td> -->
<!-- 				</tr> -->
				<tr>
					<th style="padding: 20px;" class="warning">나의 여행 스타일</th>
					<td style="padding: 20px;">
						<c:choose>
							<c:when test="${userInfo.UserTrStyle != null}">
								<c:forEach items="${userInfo.UserTrStyle}" var="tr">
									<span class="label label-mint label-lg"><b>${tr.TR_STYLE}</b></span>
								</c:forEach>	
							</c:when>
							<c:otherwise>
								<span class="label label-pink label-lg profile" onclick="goToProfile()" data-toggle="tooltip" data-placement="right" title="프로필 설정은 나의 정보에서 가능합니다.">미등록</span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="danger">여행출발일</th>
					<td style="padding: 20px;">
						<input type="date" id="datepicker"  name="trip_Board_Start" value="${boardInfo.TRIP_BOARD_START}" required="required">
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="success">여행 종료일</th>
					<td style="padding: 20px;">
						<input type="date" id="datepicker2" name="trip_Board_End" value="${boardInfo.TRIP_BOARD_END}" required="required">
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="danger">여행 동행모집</th>
					<td style="padding: 20px;">
						<select id="Trip_Board_Together" name="trip_Board_Together" class="form-control" style="width: 200px;">
							<option value="0" <c:if test="${boardInfo.TRIP_BOARD_TOGETHER==0}">selected="selected"</c:if>>0</option>
							<option value="1" <c:if test="${boardInfo.TRIP_BOARD_TOGETHER==1}">selected="selected"</c:if>>1</option>
							<option value="2" <c:if test="${boardInfo.TRIP_BOARD_TOGETHER==2}">selected="selected"</c:if>>2</option>
							<option value="3" <c:if test="${boardInfo.TRIP_BOARD_TOGETHER==3}">selected="selected"</c:if>>3</option>
							<option value="4" <c:if test="${boardInfo.TRIP_BOARD_TOGETHER==4}">selected="selected"</c:if>>4</option>
							<option value="5" <c:if test="${boardInfo.TRIP_BOARD_TOGETHER==5}">selected="selected"</c:if>>5</option>
						</select>
					</td>
				</tr>
				<tr>
					<th style="padding: 20px;" class="info">여행 소개</th>
					<td style="padding: 20px;">
						<textarea rows="5" cols="10" style="width: 500px; font-size: 14pt;" id="boardContent" name="trip_Board_Content">${boardInfo.TRIP_BOARD_COUNTENT}</textarea>
					</td>
				</tr>
				<tr>
					<th>
						<input type="button" value="취소하기" class="btn btn-success" onclick="location.href='view?boardKey=${boardInfo.TRIP_BOARD_KEY}'">
						<input type="submit" value="다음 단계로" class="btn btn-success">
					</th>
				</tr>

			</table>

			
		</form>

	</div>
	
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