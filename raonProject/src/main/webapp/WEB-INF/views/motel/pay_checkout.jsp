<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 확인</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	/*방법1 (실패)*/
	/* $(function(){
		$("#submit").on("click",function(){
			window.open("pay_paypal","popup_window","width=500, height=300, scrollbars=no");
			this.method="POST";
			$("pay_form").submit();
		})
	}); */
	/*방법2 성공*/
	function popup(frm){
		var url ="pay_paypal";
		var title="pay_popup";
		var status="toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=240, height=200, top=0,left=20";
		window.open("",title,status);
		
		frm.target=title;
		frm.action=url;
		frm.method="post";
		frm.submit();
	}

	
</script>
</head>
<body>
<!-- 방법1 (실패) -->
<%-- 	<h1>주문 확인</h1>
	<form id="pay_form" method="post" target="popup_window">
		<input style="border: none" value="${item }" name="item" id="item"
			readonly="readonly"><br> <input style="border: none"
			value="${price }" id="price" name="price" readonly="readonly"><br> 
	</form>
	<button id="submit">확인</button> --%>

<!-- 방법2 성공-->
	<form name="pay_form">
		<input style="border: none" value="${item }" name="item" id="item" readonly="readonly"><br> 
		<input style="border: none" value="${price }" id="price" name="price" readonly="readonly"><br>
		<input type="hidden" name="num" value="${num }">
		<input type="button" name="btn_pay" value="확인" onclick="javascript:popup(this.form)">
	</form>
</body>
</html>