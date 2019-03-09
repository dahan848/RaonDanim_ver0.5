<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
	
	 $(function(){
		var IMP = window.IMP;  // 생략가능
		IMP.init('imp07370950'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		/* var num = ${num}; */
		var price = ${price};
		var item = '${item}';
		IMP.request_pay({
		    pg : 'paypal', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명:결제테스트',
		    amount : price,
		    buyer_email : '',
		    buyer_name : '',
		    buyer_tel : '',
		    buyer_addr : '',
		    buyer_postcode : '',
		   	m_redirect_url : 'http://localhost:8081/${contextPath}/motel/pay_result?item='+item+'&price='+price
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
	<input type="hidden" id="price" value="${price }">
	<input type="hidden" id="item" value="${item }">
</body>
</html>