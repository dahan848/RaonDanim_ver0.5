<!-- Header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- contextPath 설정 -->
<%	request.setAttribute("contextPath", request.getContextPath()); %>	
<!-- CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- 부트스트랩 END -->
<!-- CSS -->
<link href="${contextPath}/css/commonness.css" rel="stylesheet"> <!-- 공통 스타일 CSS -->
<link href="${contextPath}/css/bootstrap-social.css" rel="stylesheet"> <!-- 부트스트랩 소셜 -->
<link href="${contextPath}/css/font-awesome.css" rel="stylesheet"> <!-- 폰트어썸 -->
<link href="${contextPath}/css/chatList.css" rel="stylesheet"> <!-- 채팅목록 창  -->
<link href="${contextPath}/css/chatBox.css" rel="stylesheet"> <!-- 채팅창 CSS -->
<!-- JS -->
<script src="${contextPath}/js/sockjs.js" ></script> <!-- 웹 소켓 통신 -->
<script src="${contextPath}/js/stomp.js" ></script>	<!-- 웹 소켓 통신 -->
<script src="${contextPath}/js/chatBox.js" ></script>
<script src="${contextPath}/js/commonness.js" ></script>
<!-- 스프링 시큐리티 설정 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

<!-- trip파트  cdn  -->

<!-- 제이쿼리 충돌 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- 스윗 얼럿 -->
<script type="text/javascript" src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>




<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.user_email_verify" var="verify"/>
	<sec:authentication property="principal.user_num" var="user_num"/>
</sec:authorize>
<script type="text/javascript">
	var check = ${verify};
	if(check == 0){
		logout();
		swal({
			  title: "이메일 인증이 되지 않은 계정입니다.",
			  text: "이메일 인증 이후 사이트 이용이 가능합니다.",
			  button: "확인",
			  confirmButtonColor: "#484848",
			}).then(function() {
				location.reload();
			});		
	}//CHECK IF END
	function logout() {
		$.ajax({
			url:"/accounts/logout"
		});
	}
	
	//문자 아이콘 클릭 시 나올 채팅 방 목록 그려주는 () 
	function getChatRoomList() {
		var path = "http://localhost:8081";
		var usernum = ${user_num}
		//alert(path);
		//alert(usernum);
		
		//이전에 그려졌던 목록을 지우고 ajax로 받아온 리스트만 그릴 수 있도록 
		$(".user").remove();
		
		$.ajax({
			url: path + "/chatList/" + usernum,
			type: "get",
			dateType : "json",
			success : function(data){
				//화면을 한 번만 그릴 수 있도록 조건문 

				for(var i in data){
					//partnerInfo
					//프로필 사진 설정 
					if(data[i].USER_PROFILE_PIC != 'n'){
						//등록된 프로필 사진이 있으면
						var profile_pic = path + "/image?fileName=" + data[i].USER_PROFILE_PIC;
					}else{
						//등록된 프로필 사진이 없으면 (기본 프로필)
						var profile_pic = path + "/img/home_profile_2.jpg";						
					}
					var name = data[i].USER_LNM +" "+data[i].USER_FNM;
					var user_num = data[i].USER_NUM;
					var room_num = data[i].CHAT_ROOM_NUM;
					//roomList
					var content = data[i].CONTENT;
					 //화면 그리기  
					 $(".chat_body").append("<div class='user' onclick='chatClickbyRoom("+room_num+")'> <img src='"+profile_pic+"'/><div class='namechat'>"+name+"</div><div class='chat_msg'>"+content+"</div><hr></div");
				}//반복문 종료
			}
		});
	}
	
	$(document).ready(function() {
// 		getChatRoomList(); //화면이 그려지면 메시지 리스트를 그려줌
	});//onLoad END
</script>

<!-- navbar-main -->
<header>
<input type="hidden" value="${user_num}" name="user_num" id="user_num">
	<nav class="navbar navbar-default">
    	<div class="container">
        	<div class="navbar-header" style="width: 875px;">
       			<a class="navbar-brand hidden-xs" href="${contextPath}/">
            		<img src="${contextPath}/img/home_logo-raon.png">
        		</a>
		        <!-- 로그인 상태에서 출력 되는 회원 정보  -->
		        <sec:authorize access="isAuthenticated()">
		        <sec:authentication property="principal.user_profile_pic" var="pic"/>
		        <c:if test="${verify eq 1}"> <!-- 이메일 인증 사용자가 아니면 정보 안나오게 -->
		        	<div class="profile-summary">
		            	<a href="${contextPath}/accounts/profile?user=${user_num}">
		              		<c:choose>
		              			<c:when test="${pic eq 'n'}">
		              				<img src="${contextPath}/img/home_profile_2.jpg">
		              			</c:when>
		              			<c:otherwise>
		              				<img src="${contextPath}/image?fileName=${pic}">
		              			</c:otherwise>
		              		</c:choose>   	
		                 		 	<sec:authentication property="principal.username"/>
		                   </a>
		                   <a href="#">
		                       <strong class="text-potluck">
		                       		<sec:authentication property="principal.user_point"/>
		                       </strong>	                   		
		                   </a>
		             </div>
	             </c:if>
	             </sec:authorize>
	        </div>
	        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	            <ul class="nav navbar-nav navbar-right">
	            
	           		<sec:authorize access="isAnonymous()"> <!-- 로그인 상태 X -->
                	<li><a href="${contextPath}/accounts/loginForm">로그인</a></li>
					<li><span class="vertical-separator"></span><a href="${contextPath}/accounts/signupForm">회원가입</a></li>
					<li><span class="vertical-separator"></span><a href="${contextPath}/inquiry"><i class="fa fa-info-circle fa-lg"></i></a></li>
					</sec:authorize>	            	

					<sec:authorize access="isAuthenticated()"> <!-- 로그인 상태 O -->
						<c:if test="${verify eq 1}"> <!-- 이메일 인증 사용자가 아니면 탭 안나오게 -->
							<li><span class="vertical-separator"></span>
								<!-- 메시지List 버튼 -->
								<a onclick="getChatRoomList()" id="btn_msg" href="#" rel="popover" data-trigger="focus" data-placement="bottom" data-popover-content="#chatList">
										<i class="fa fa-envelope fa-lg"></i>
								</a>
							</li>
							<li><span class="vertical-separator"></span><a href="${contextPath}/inquiry"><i class="fa fa-info-circle fa-lg"></i></a></li>
							<li><span class="vertical-separator"></span><a href="${contextPath}/accounts/logout">로그아웃</a></li>
						</c:if>
					</sec:authorize>	         
					   	
	                <li class="dropdown">
	                	<span class="vertical-separator"></span>
	                    	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
	                       aria-expanded="false">한국어 <span class="caret"></span>
	                       </a>
	                    <ul class="dropdown-menu">
	                        <li><a href="#" data-language="ko">한국어</a></li>
	                        <li><a href="#" data-language="en">English</a></li>
	                        <li><a href="#" data-language="ja">日本語</a></li>
	                        <li><a href="#" data-language="zh-hans">简体中文</a></li>
	                        <li><a href="#" data-language="zh-hant">繁體中文</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </div>
	    </div>
<div id="chatList" class="hide">
  <div class="chat_box2">
	<div class="chat_body"> 
	</div>
  </div>
</div>
</nav>
</header>
<!-- navbar-main END -->