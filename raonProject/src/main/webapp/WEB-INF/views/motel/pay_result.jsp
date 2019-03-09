<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function(){
		selectValue();
	});
	alert("${msg}");
	
	function selectValue(){
		var item = '${item}';
		var price = '${price}';
		   if(${result}){
			   var theURL = "http://localhost:8081/${contextPath}/motel/view";
			   opener.window.location = theURL;
			   window.close();
		   }else{
			   var theURL = "http://localhost:8081/${contextPath}/motel/view";
			   opener.window.location = theURL;
			   window.close();
		   }
	    /* var requestValue = document.getElementById("Name").value; */                   // 전송 파라미터 값
	     // 전송 URL
	    // 호출 한 부모 페이지에서 URL 호출
	    
	    // 호출 한 뒤 현재 팝업 창 닫기 이벤트
	    
	} 
</script>