//대화하기 버튼 눌렀을 때 모달 창 출력 및 필요한 데이터를 인자로 받아옴 
function chatClick(user, targetid) {
	//소켓 통신을 위한 객체 선언 
	var sock;
	var stompClient = null;

	//인자로 받아온 데이터를 변수에 참조
	var usernum = user //본인
	var target = targetid //상대방
	//alert("로그인유저 : " + usernum + " 대상 : " + targetid + " 경로 : " + path);

	//웹소켓 연결 : 본인의 아이디와 타겟 아이디를 넘겨줌 > 화면 그릴 때 간선 방지
	connect(usernum, targetid);

	//메시지 전송 
	send(usernum, target);

	//head에 이름 표기하기
	$("#msg_name").text(target + "번 유저");

	//클릭 될 떄 마다 창 닫고 열기 
	$("#raonChat").show();
	$(".msg_box").show();
}
//ContextPath 구하기
function getContextPath() {
	var offset = location.href.indexOf(location.host) + location.host.length;
	var ctxPath = location.href.substring(offset, location.href.indexOf('/',
			offset + 1));
	return ctxPath;
}
//웹소켓 연결 ()
function connect(user, target) {
	//alert("connect!");
	var path = getContextPath()

	sock = new SockJS(path + "/chat");
	//sockjs로만 연결하는 게 아니라 sockjs 기반으로 stomp를 동작시킴
	stompClient = Stomp.over(sock);

	stompClient.connect({}, function() {

		//		alert(test1 +"가 보낸 : " + test2);
		//연결이 되면 WebSocket으로 부터 들어오는 메시지를 어떻게 처리할지
		//결정하는 동작을 작성한다. 
		//stompClient.subscribe(destination, callback);
		//destination 작성된 url 형태로 메시지가 들어오면 , callback 실행
		//내가 사용하고 있는 id로 메시지가 들어오면 수신하면 된다. 
		stompClient.subscribe("/category/msg/" + user, function(message) {
			console.log("Message :" + message.body);
			//			var test1 = JSON.stringify(user);
			//			var test2 = JSON.stringify(message);
			addMsg(message.body, target);
		});
	});
}
//받은 메시지 그리기 
function addMsg(m, target) {
	obj = JSON.parse(m); //전달 받은 json 객체를 파싱하기 위해서 변수에 참조 
	var send_user = obj.userid; //메시지 전송자를 변수에 담는다.
	var message = obj.msg; //전달받은 메시지를 변수에 담는다.

	//자신이 메시지를 보낸 사람 (현재 메시지창)과 상대측 발송자가 동일 할 때만 메시지 창에 수신 메시지를 그린다.
	if (send_user == target) {
		$('<div class="msg_a">' + message + '</div>').insertBefore('.msg_push');
		$('.msg_body').scrollTop($('.msg_body')[0].scrollHeight);
	}

}
//메시지 전송()
function send(user, target) {
	$('textarea').keypress(
			function(e) {
				//엔터키를 눌렀다면 
				if (e.keyCode == 13) {
					e.preventDefault();
					//textarea에 작성 된 문자를 변수에 참조 
					var msg = $(this).val();
					//textarea(화면)을 비워줌
					$(this).val('');
					//msg가 비어있지 않다면, 화면에 div를 통해 메시지를 그려줌 
					if (msg != '')
						$('<div class="msg_b">' + msg + '</div>').insertBefore(
								'.msg_push');
					$('.msg_body').scrollTop($('.msg_body')[0].scrollHeight);
					//ChatController로 메시지 전달 (웹소켓)
					stompClient.send("/client/hello/" + user + "/" + target,
							{}, msg);
				}
			});
}

//메시지 아이콘 클릭 시 채팅목록 그려주는 ()
function getChatRoomList(usernum) {
	//alert("테스트 전달 : " + usernum);
	var path = getContextPath();
	$.ajax({
		url: path + "/chatList/" + usernum,
		type: "get",
		dateType : "json",
//		success : function(data){
//			for(var i in data){
//				var path = "${contextPath}/image?fileName=" + data[i].GALLERY_FILE_NAME;
//				var fileNum = data[i].GALLERY_FILE_NUM;
//				 //기본 뼈대 그리기 
//				 $(".carousel-indicators").append("<li data-target='#myCarousel' data-slide-to=\""+i+"\"></li>");
//				 $(".carousel-inner").append("<div class='item'><img src='"+path+"' alt='"+i+"' style='width: 100%'></div>");
//
//				 //클래스 속성 부여하기
//		         $(".carousel-indicators li:first").addClass("active");
//		         $(".carousel-inner .item:first").addClass("active");
//		         $('.carousel').carousel();
//			}//반복문 종료 
//		}
	});
}

$(document).ready(function() {

});//onLoad END

