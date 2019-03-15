//대화하기 버튼 눌렀을 때 모달 창 출력 및 필요한 데이터를 인자로 받아옴 
function chatClickbyUser(user, targetid) {
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

//채팅방 목록에서 채팅방을 클릭하면 실행되는 함수
function chatClickbyRoom(roomnum) {
	var path = "http://localhost:8081";
	$.ajax({
		url: path + "/messageList/" + roomnum,
		type: "get",
		dateType : "json",
		success : function(result){
			var loginuser = result.usernum;
			//alert(loginuser);
			//화면을 한 번만 그릴 수 있도록 반복문 
			for(var i in result.mList){
				var suser = result.mList[i].SEND_USER; //송신자
				var ruser = result.mList[i].RECEIVE_USER; //수신자
				var sendtime = result.mList[i].SEND_TIME; //송신시간
				var mnum = result.mList[i].MESSAGE_NUM; //메시지 넘
				var msg = result.mList[i].CONTENT; //내용
				//테스트
				//alert(ruser +" "+sendtime +" "+ mnum+" "+ msg);
				
				//화면 그리기 
				//중복 출력을 방지하기 위한 변수 선언 및 조건문 
				var checknum = mnum;
				var test = $("#"+result.mList[i].MESSAGE_NUM+"");
				alert("체크넘"+checknum);
				alert("ㅌ세ㅡ트 : " + test)
				if(checknum == $("#"+result.mList[i].MESSAGE_NUM+"")){
					alert("메시지 중복됨 그리지 않음.")
				}else{
					if(loginuser == suser){
						alert("로그인 유저가 송신자4")
						$('<div class="msg_b" id='+result.mList[i].MESSAGE_NUM+'>' + msg + '</div>').insertBefore('.msg_push');
						$('.msg_body').scrollTop($('.msg_body')[0].scrollHeight);					
					}else if(loginuser == ruser){
						alert("로그인 유저가 수신자4")
						$('<div class="msg_a" id='+mnum+'>' + msg + '</div>').insertBefore('.msg_push');
						$('.msg_body').scrollTop($('.msg_body')[0].scrollHeight);	
					}					
				}
			}//반복문 종료
			$("#raonChat").show();
			$(".msg_box").show();
		}
	});
	
	
	
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

$(document).ready(function() {
	
});//onLoad END

