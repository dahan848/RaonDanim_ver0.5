<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
	$(document).ready(function() {
		swal({
			  title: "이메일 인증 완료!",
			  text: "잠시 후 메인페이지로 이동됩니다.",
			  icon: "success",
			  button: "확인",
			});
	});
	
	function home() {
		location.href="/home";	
	}
	
</script>
