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

<!-- 03-13 여행 구글폰트 추가 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script|Open+Sans" rel="stylesheet">


<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.user_email_verify" var="verify"/>
	<sec:authentication property="principal.user_num" var="user_num"/>
	
	<!-- 시큐리티 함수 안에 스크립트를 설정하여, 로그인이 되어 있는 상태 일 때만 스크립트가 실행 될 수 있도록 설정 -->
	<script type="text/javascript">
	//접속 한 사용자가 가지고 있는 메시지의 개수를 얻는 ()
		var wsUri = "ws://localhost:8081/count";
		//웹소켓 객체를 생성하고 연결하는 ()
		 function send_message() {
			//새로운 웹소켓 객체를 생성 
	        websocket = new WebSocket(wsUri);
			//웹소켓 연결
	        websocket.onopen = function(evt) {
	            onOpen(evt);
	        };
	        //웹소켓에 메시지 전송 
	        websocket.onmessage = function(evt) {
	            onMessage(evt);
	        };
	        //에러 발생 시 에러를 받아옴 
	        websocket.onerror = function(evt) {
	            onError(evt);
	        };
	    }
		
		//MessageAlarm 핸들러로 로그인 한 user의 num을 보낸다
	    function onOpen(evt) {
	       websocket.send("${user_num}");
	    }
	    
		//MessageAlarm로 부터 해당 유저의 count를 받는다
	    function onMessage(evt) {
			//읽지 않은 메시지의 개수를 화면에 출력해준다.
			var count = evt.data;
			if(count > 0){
	    		$('#mCount').append(evt.data);				
			}
	    }
		
	    function onError(evt) {
	    }
	    
		
	    //사용자가 로그인을 하고 화면이 온로드 되면 소켓 연결을 실행한다.
	    $(document).ready(function(){
	    		send_message();
	    });
	</script>
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
		var colon = ",";
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
					var unread = "미확인 메시지 : "+data[i].UNREAD; //채팅 방의 읽지 않은 메시지의 개수 
					var check = data[i].UNREAD;
					//roomList
					var content = data[i].CONTENT;
					 //화면 그리기
					 if(typeof check != "undefined"){
						 //미확인 메시지가 있는 경우
						 $(".chat_body").append("<div class='user' style='padding-bottom: 0px; padding-top: 0px;' onclick='chatClickbyRoom("+room_num+colon+usernum+colon+check+")'> <img src='"+profile_pic+"'/><div class='namechat' style='padding-bottom: 0px;'>"+name+"</div><div class='chat_msg'>"+content+"</div><strong class='text-potluck' style='margin-left: 10px;'>"+unread+"</strong><hr style='margin-top: 5px; margin-bottom: 10px;'></div>");
					 }else{
						 //미확인 메시지가 없는 경우
						 $(".chat_body").append("<div class='user' style='padding-bottom: 0px; padding-top: 0px;' onclick='chatClickbyRoom("+room_num+colon+usernum+")'> <img src='"+profile_pic+"'/><div class='namechat' style='padding-bottom: 0px;'>"+name+"</div><div class='chat_msg'>"+content+"</div><hr style='margin-top: 5px; margin-bottom: 10px;'></div>");
					 }
				}//반복문 종료
			}
		});
	}	
	$(document).ready(function() {
		//alert("악!15");
	});//onLoad END
	
	//메시지를 읽은 경우 읽은 수 만큼 개수 수정
   function updateUnread(check) {
		//현재 그려져 있는 카운트 개수를 변수에 담는다 
		var count = $("#mCount").text();
		if(typeof check != "undefined"){
			//인자로 받은 해당 채팅방의 미확인 메시지 개수가 값이 있는 경우 실행
			//총 미확인 메시지 - 현재 채팅방 미확인 메시지 = 현재 미확인 메시지 개수 
			var update = count - check;
			if(update != 0){
				//적혀있는 값 지워주기
				$('#mCount').text("");
				//현재 메시지 개수를 화면에 그려주기
				$('#mCount').append(update);						
			}else{
				//결과 값이 0인 경우 그냥 적혀있는 값만 지워준다.
				$('#mCount').text("");
			}
		}
	}
</script>
<!-- navbar-main -->
<header>
<input type="hidden" value="${user_num}" name="user_num" id="user_num" style="padding-bottom: 0px;">
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
		        	<div class="profile-summary" style="margin-right: 10px;">
		        	<sec:authorize access="hasRole('ROLE_ADMIN')">
		        		<a href="${contextPath}/admin/main">관리자</a>
		        	</sec:authorize>
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
							<li>
								<span class="vertical-separator" style="margin-bottom: 5px;"></span>
								<!-- 메시지List 버튼 -->
								<a onclick="getChatRoomList()" id="btn_msg" href="#" rel="popover" data-trigger="focus" data-placement="bottom" data-popover-content="#chatList">
										<i class="fa fa-envelope fa-lg"></i>
										<strong id="mCount" class="text-potluck"></strong>
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
<script type="text/javascript">
$(function(){
    $('[rel="popover"]').popover({
        container: 'body',
        html: true,
        content: function () {
            var clone = $($(this).data('popover-content')).clone(true).removeClass('hide');
            return clone;
        }
    }).click(function(e) {
        e.preventDefault();
    });
});
</script>
<!-- navbar-main END -->