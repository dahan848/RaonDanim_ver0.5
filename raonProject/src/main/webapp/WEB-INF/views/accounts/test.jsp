<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$("#profile-personal-form").on("submit", function() {
		//fomr 요소에 있는 데이터 직렬화 
		var personal = $(this).serialize();
		
		$.ajax({
			url:"/accounts/personal",
			type:"get",
			success:function(data){
				alert(data);
			},
		});
	});

</script>

</head>
<body>

</body>
</html>