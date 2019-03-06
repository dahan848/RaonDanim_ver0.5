<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript">

$(function() {

	  //시작일.
    $('#fromDate').datepicker({
        dateFormat: "yy-mm-dd",             // 날짜의 형식
        minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
        onClose: function( selectedDate ) {    
            // 시작일(fromDate) datepicker가 닫힐때
            // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
            $("#checkoutDate").datepicker( "option", "minDate", selectedDate );
        }                
    });

    //종료일
    $('#checkoutDate').datepicker({
        dateFormat: "yy-mm-dd",
        minDate: 0, // 오늘 이전 날짜 선택 불가
        onClose: function( selectedDate ) {
            // 종료일(toDate) datepicker가 닫힐때
            // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
            $("#fromDate").datepicker( "option", "maxDate", selectedDate );
        }                
    });
   
});
</script>
</head>
<body>
	<p>조회기간: 
		<input type="text" id="fromDate"> ~ 
		<input type="text" id="checkoutDate">
	</p>
</body>
</html>