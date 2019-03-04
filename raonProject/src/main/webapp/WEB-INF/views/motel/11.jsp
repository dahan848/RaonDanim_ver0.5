<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 스프링 시큐리티 사용을 위한 태그 정의 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>      
<!-- contextPath 설정 -->
<%	request.setAttribute("contextPath", request.getContextPath()); %>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc&libraries=places&language=en"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	//도시 불러오는 스크립트
	function initialize() {
          var input = document.getElementById('searchTextField');
          //애가 요소 찝어서 자동완성하게 해주는거
          var autocomplete = new google.maps.places.Autocomplete(input);
            google.maps.event.addListener(autocomplete, 'place_changed', function () {
                var place = autocomplete.getPlace();
                document.getElementById('city3').value = place.name;


            });
        }
        //윈도우 onload시 실행
        google.maps.event.addDomListener(window, 'load', initialize);

        
</script>		  
	<!-- 서브 네브바 -->
	<input type="text" id="city3" name="city3" />
	<!-- 서브 네브바 END -->