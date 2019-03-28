<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.user_num" var="user_num"/>
</sec:authorize>
<% request.setAttribute("contextPath", request.getContextPath()); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
// 생략가능
	  $(function(){
		var num = "${motel_num}";
		var host = "${host}";
		var checkIn = "${checkIn}";
		var checkOut = "${checkOut}";
		var tripDate = "${tripDate}";
		var people = "${people}";
		
		var IMP = window.IMP;  
		IMP.init('imp07370950');

		var price = '${price}';
		
		/* var item = '${item}'; */
		IMP.request_pay({
		    pg : 'paypal', 
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명:결제테스트',
		    amount : price,
		    buyer_email : '',
		    buyer_name : '',
		    buyer_tel : '',
		    buyer_addr : '',
		    buyer_postcode : '',
		   	m_redirect_url : 'http://localhost:8081/${contextPath}/motel/pay_result?num='+num+'&host='+host+'&checkIn='+checkIn+'&checkOut='+checkOut+'&tripDate='+tripDate+'&people='+people+'&price='+price+'&user_num='+${user_num}
		} , function(rsp) {
		    if ( rsp.success ) {

		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		});
		
		
	});
</script>
</head>
<body>

	<input type="hidden" name="price" value="${price}">
	<input type="hidden" name="motel_num" value="${motel_num}">
	<input type="hidden" name="host" value="${host}">
	<input type="hidden" name="user_num" value="${user_num}">
	
	<input type="hidden" name="checkIn" value="${checkIn}">
	<input type="hidden" name="checkOut" value="${checkOut }">
	<input type="hidden" name="tripDate" value="${tripDate }">
	<input type="hidden" name="people" value="${people}">
</body>
</html>