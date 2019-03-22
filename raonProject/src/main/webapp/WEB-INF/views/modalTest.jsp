<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- taglib -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 시큐리티 taglib -->
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="org.springframework.security.core.Authentication"%>

<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>

<!-- 채팅에 필요한 로그인 유저 정보 : 프로필사진, 이름, USER_NUM -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.user_profile_pic" var="pic" />
	<!-- 프로필 사진 : pic -->
	<sec:authentication property="principal.username" var="name" />
	<!-- 회원이름 : name -->
	<sec:authentication property="principal.user_num" var="usernum" />
	<!-- USER_NUM : usernum -->
</sec:authorize>

<div class="col-12">
	<div class="col-2" style="float: left">
		<span> 목록 </span>
	</div>
	<div class="col-8" style="float: left; text-align: center;">
		[여기에 상대방 이름] 님과 대화</div>
	<div class="col-2" style="float: right">
		<span> 닫기 </span>
	</div>
</div>
<!-- 채팅 내용 -->
<div class="col-12">
	<div class="col-11"
		style="margin: 0 auto; border: 1px solid #01D1FE; height: 400px; border-radius: 10px; overflow: scroll"
		id="chatArea">
		<div id="chatMessageArea" style="margin-top: 10px; margin-left: 10px;"></div>
	</div>
</div>
<!-- 채팅 입력창 -->
<div class="col-12" style="margin-top: 20px; margin-bottom: 15px;">
	<div class="col-12" style="float: left">
		<textarea class="form-control"
			style="border: 1px solid #01D1FE; height: 65px; float: left; width: 80%"
			placeholder="Enter ..." id="message">
			</textarea>
		<span
			style="float: right; width: 18%; height: 65px; text-align: center; background-color: #01D1FE; border-radius: 5px;">
			<a
			style="margin-top: 30px; text-align: center; color: white; font-weight: bold;"
			id="sendBtn"><br>전송</a>
		</span>
	</div>
</div>

<img id="profileImg" class="img-fluid"
	src="${contextPath}/img/home_profile_2.jpg"
	style="display: none">
<input type="text" id="nickname" value="${name}"
	style="display: none">
<input type="button" id="enterBtn" value="입장" style="display: none">
<input type="button" id="exitBtn" value="나가기" style="display: none">

<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>

<script type="text/javascript">
 connect();

 function connect() {
		//요청 보내기
	    sock = new SockJS('/chat');
		
		//연결생성
	    sock.onopen = function() {
	        console.log('open');
	    };
	    
	    //메시지 수신
	    sock.onmessage = function(evt) {
    	 var data = evt.data;
    	   console.log(data)
  		   var obj = JSON.parse(data)  	   
    	   console.log(obj)
    	   appendMessage(obj.message_content);
	    };
	    
	    //연결종료
	    sock.onclose = function() {
	    	 appendMessage("연결을 끊었습니다.");
	        console.log('close');
	    };
	}
 
 //메시지를 전송하는 ()
 function send() {
  //textArea에 작성 된 내용을 가져와서 msg변수에 참조 
  var msg = $("#message").val();
  
  //msg 변수에 값이 있다면 (내용이 작성되면)
  if(msg != ""){
	  //message 객체(VO) 생성 및 필요한 값을 넣어줌
	  message = {};
	  message.content = $("#message").val() //채팅 내용
  	  message.frinend_num = 27 //받는 사람
  	  message.user_num = '${usernum}' //보내는 사람
  	  message.send_user = '${usernum}' //보내는 사람
  }
  //json 객체를 String 객체로 변환하여 웹소켓으로 전송
  sock.send(JSON.stringify(message));
  
  //textArea를 비워준다.
  $("#message").val("");
 }

 //보낸 날짜 작성하는 ()
 function getTimeStamp() {
   //d 라는 변수에 Date 객체 참조 	
   var d = new Date();
   var s =
     leadingZeros(d.getFullYear(), 4) + '-' +
     leadingZeros(d.getMonth() + 1, 2) + '-' +
     leadingZeros(d.getDate(), 2) + ' ' +

     leadingZeros(d.getHours(), 2) + ':' +
     leadingZeros(d.getMinutes(), 2) + ':' +
     leadingZeros(d.getSeconds(), 2);
   return s;
 }

 //모르겠다..
 function leadingZeros(n, digits) {
   var zero = '';
   n = n.toString();

   if (n.length < digits) {
     for (i = 0; i < digits - n.length; i++)
       zero += '0';
   }
   return zero + n;
 }

 //메시지를 추가
 function appendMessage(msg) {
	 //msg 변수가 비어있다면 false를 반환
	 if(msg == ''){
		 return false;
	 }else{
	 //var는 앞서 만든 변수를 통해 보낸 날짜를 작성하는데 사용
	 var t = getTimeStamp();
	 //전송 된 메시지를 화면에 그려준다.
	 $("#chatMessageArea").append("<div class='col-12 row' style = 'height : auto; margin-top : 5px;'><div class='col-2' style = 'float:left; padding-right:0px; padding-left : 0px;'><img id='profileImg' class='img-fluid' src='/displayFile?fileName=${userImage}&directory=profile' style = 'width:50px; height:50px; '><div style='font-size:9px; clear:both;'>${user_name}</div></div><div class = 'col-10' style = 'overflow : y ; margin-top : 7px; float:right;'><div class = 'col-12' style = ' background-color:#ACF3FF; padding : 10px 5px; float:left; border-radius:10px;'><span style = 'font-size : 12px;'>"+msg+"</span></div><div col-12 style = 'font-size:9px; text-align:right; float:right;'><span style ='float:right; font-size:9px; text-align:right;' >"+t+"</span></div></div></div>")		 
	  //채팅창 영역의 높이를 가져옴
	  var chatAreaHeight = $("#chatArea").height();
	  //가져온 높이를 활용해서, 스크롤을 내려준다.
	  var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
	  $("#chatArea").scrollTop(maxScroll);
	 }
 }
 
 //OnLoad
 $(document).ready(function() {
  //textArea에 키보드 눌림 이벤트가 발생하면 
  $('#message').keypress(function(event){
   var keycode = (event.keyCode ? event.keyCode : event.which);
   if(keycode == '13'){ //엔터키가 눌르면 메시지를 전송함 
    send();
   }
   event.stopPropagation(); //이벤트를 중단하는 메서드 인데 왜 쓰이는 거지...?
  });
  
  //보내기 버튼에 클릭 이벤트가 발생하면 메시지를 보냄
  $('#sendBtn').click(function() {
	  send(); 
  });/* $('#enterBtn').click(function() { connect(); }); $('#exitBtn').click(function() { disconnect(); }); */
 
 });//OnLoad END
</script>
