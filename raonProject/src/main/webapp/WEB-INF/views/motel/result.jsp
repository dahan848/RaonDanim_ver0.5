<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	$(function(){
		if(${result}){
			swal({
			      text: "${msg}",
			      icon: "success",
			      buttons:[false,"확인"]
			    	  
			    }).then(function(isConfirm){
			    	if(isConfirm){
			    		location.href="${contextPath}"+"${url}";
			    	}
			    });
		}else{
			swal({
			      text: "${msg}",
			      icon: "warning",
			      buttons:[false,"확인"]
			    	  
			    }).then(function(isConfirm){
			    	if(isConfirm){
			    		location.href="${contextPath}"+"${url}";
			    	}
			    });
		};
	});
</script>