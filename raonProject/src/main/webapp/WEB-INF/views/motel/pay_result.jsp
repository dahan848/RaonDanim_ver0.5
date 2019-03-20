<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>

<!DOCTYPE html>

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  <script type="text/javascript" src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		selectValue();
	});
	
	
	function selectValue(){
		var num = "${num}";
		var host = "${host}";
		var checkIn = "${checkIn}";
		var checkOut = "${checkOut}";
		var tripDate = "${tripDate}";
		var people = "${people}";
		var url = "${url}";
		var check = "${doubleResult}";
		var check2 = "${result}";
		var check3 = "${result_free}"
		if(check==""){
			if(check2=="true"){
				   swal({
					   text:"${msg}",					
						icon:"success",		
						buttons:[false,"확인"]
				   }).then(function(isConfirm){
					   var theURL = "http://localhost:8081/${contextPath}"+url;
					   opener.window.location = theURL;
					   window.close();
				   })
				   
			   }else{
				   if(check3 == "true"){
					   swal({
						   text:"${msg}",					
							icon:"success",		
							buttons:[false,"확인"]
					   }).then(function(isConfirm){
						   var theURL = "http://localhost:8081/${contextPath}"+url;
						   location.href=theURL;
						   
					   })
				   }else{
					   swal({
						   text:"${msg}",					
							icon:"warning",		
							buttons:[false,"확인"]
					   }).then(function(isConfirm){
						   var theURL = "http://localhost:8081/${contextPath}"+url;
						   opener.window.location = theURL;
						   window.close();
					   }) 
				   }
				   
			   }
		}else{

			   swal({
				   text:"${msg}",					
					icon:"warning",		
					buttons:[false,"확인"]
			   }).then(function(isConfirm){
				   var theURL = "http://localhost:8081/${contextPath}"+url;
				   location.href=theURL;
			   })
			   
			   
			   

		}

		   
		
			
	   
	    
	} 
</script>