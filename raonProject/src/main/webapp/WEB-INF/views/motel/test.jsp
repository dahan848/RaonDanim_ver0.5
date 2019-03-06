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

	  //������.
    $('#fromDate').datepicker({
        dateFormat: "yy-mm-dd",             // ��¥�� ����
        minDate: 0,                       // �����Ҽ��ִ� �ּҳ�¥, ( 0 : ���� ���� ��¥ ���� �Ұ�)
        onClose: function( selectedDate ) {    
            // ������(fromDate) datepicker�� ������
            // ������(toDate)�� �����Ҽ��ִ� �ּ� ��¥(minDate)�� ������ �����Ϸ� ����
            $("#checkoutDate").datepicker( "option", "minDate", selectedDate );
        }                
    });

    //������
    $('#checkoutDate').datepicker({
        dateFormat: "yy-mm-dd",
        minDate: 0, // ���� ���� ��¥ ���� �Ұ�
        onClose: function( selectedDate ) {
            // ������(toDate) datepicker�� ������
            // ������(fromDate)�� �����Ҽ��ִ� �ִ� ��¥(maxDate)�� ������ �����Ϸ� ���� 
            $("#fromDate").datepicker( "option", "maxDate", selectedDate );
        }                
    });
   
});
</script>
</head>
<body>
	<p>��ȸ�Ⱓ: 
		<input type="text" id="fromDate"> ~ 
		<input type="text" id="checkoutDate">
	</p>
</body>
</html>