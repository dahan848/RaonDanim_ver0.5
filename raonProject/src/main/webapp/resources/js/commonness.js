function chatClickbyUser(user, targetid) {
	//대화하기 버튼 눌렀을 때 모달 창 출력 및 필요한 데이터를 인자로 받아옴 
	//인자로 받아온 데이터를 변수에 참조 : Ajax로 전송 할 데이터 
	var usernum = user //본인
	var target = targetid //상대방
	
	var data = {
		"user" : user,
		"ta" : targetid
	}

	var path = "http://localhost:8081"; //경로

	//ajax를 이용해서 채팅방 번호 얻어내기 : 채팅방이 없는 경우 컨트롤러에서 새롭게 생성 된 채팅방 번호를 반환
	var chatRomm;
	$.ajax({
		type : "get",
		url : path + "/chat",
		data : data,
		async : false, //ajax 동기 선언
		success : function(data) {
			//반환 받은 채팅방 번호로 채팅방 클릭 시 함수 실행
			chatRomm = data;
		},
		error : function(error) {
			console.log(error);
			console.log(error.status);
		}
	});//ajax END

	//채팅방 번호로 채팅 진행하는 함수 실행
	chatClickbyRoom(chatRomm,user);
}

//채팅창이 오픈되는 함수
function chatClickbyRoom(roomnum,usernum) {	
	var path = "http://localhost:8081";
	var conveyRoomNum = roomnum; //인자로 전달 받은 ROOMNUM
	
	//Ajax로 전송 할 데이터 생성 
	var data = {
			"user" : usernum,
			"roomnum" : roomnum
				}
	
	//Ajax를 통해서 해당 채팅방의 메시지를 읽음 처리 해줌
	$.ajax({
		type : "get",
		url : path + "/read",
		data : data,
		async : false, //ajax 동기 선언
		error : function(error) {
			console.log(error);
			console.log(error.status);
		}
	});//ajax END

	//기존에 작성 된 메시지를 지우기 위한 코드
	$(".msg_b").remove();
	$(".msg_a").remove();

	$.ajax({
		url : path + "/messageListByRoom/" + roomnum,
		type : "get",
		dateType : "json",
		async : false, //ajax 동기 선언
		success : function(result) {
			var targetName = result.partnerName;
			var loginuser = result.usernum; // 로그인 유저
			
			// mList 널 체크  및 그에 따른 채팅방 번호 지정
			var checknull = nullCheck(result.mList);
			if(!checknull){
				var room_num = result.mList[0].CHAT_ROOM_NUM; //반환 받은 채팅방 번호 				
			}else{
				var room_num = roomnum;
			}
			var target = result.partner.USER_NUM; //채팅방 참여자 
			//alert(loginuser+"의 파트너 : " + target);

			if (room_num == conveyRoomNum) {
				//ajax로 전달 받은 방 번호와 인자로 받은 방 번호가 같을 때만 화면에 데이터를 그린다.
				//alert("조건문 작동!");

				//hidden 타입으로 그려놓은 input에 값을 넣어준다.
				$('#user').val(loginuser); //로그인 유저
				$('#target').val(target); //타겟 (상대방)
				$('#roomnum').val(room_num); //채팅방 번호

				//head에 이름 표기하기
				$("#msg_name").text(targetName);

				//반복문을 통해 DB에 저장 된 해당 방의 메시지 목록을 그려준다.
				//mList가 null이 아닐 때만 화면에 리스트 목록을 그림 : 예외방지

				if (!checknull) {
					//alert("mList가 있음");
					for ( var i in result.mList) {
						var suser = result.mList[i].SEND_USER; //송신자
						var ruser = result.mList[i].RECEIVE_USER; //수신자
						var sendtime = result.mList[i].SEND_TIME; //송신시간
						var mnum = result.mList[i].MESSAGE_NUM; //메시지 넘
						var msg = result.mList[i].CONTENT; //내용

						//화면 그리기 
						if (loginuser == suser) {
							//송신자 
							$(
									'<div class="msg_b" id='
											+ result.mList[i].MESSAGE_NUM + '>'
											+ msg + '</div>').insertBefore(
									'.msg_push');
							$('.msg_body').scrollTop(
									$('.msg_body')[0].scrollHeight);
						} else if (loginuser == ruser) {
							//수신자
							$(
									'<div class="msg_a" id=' + mnum + '>' + msg
											+ '</div>').insertBefore(
									'.msg_push');
							$('.msg_body').scrollTop(
									$('.msg_body')[0].scrollHeight);
						}
					}//반복문 종료					
				}else {
					//alert("mList 비어있음");
				}//mList null if문 종료 
			}//조건문 종료
			$("#raonChat").show();
			$(".msg_box").show();
		}
	});//Ajax END

	//Ajax로 DB에 저장 된 메시지를 그려준 이후로는 일반적인 채팅 메서드 구현
	var t = $('#target').val(); //타겟 유저 
	var u = $('#user').val(); //로그인 유저
	//alert("전송자 : " + u + " 대상자 : " + t);
	connect(u, t); //웹소켓 연결 : 본인의 아이디와 타겟 아이디를 넘겨줌 > 화면 그릴 때 간선 방지
	send(u, t); //메시지 전송 
	//alert("전달 완료");
}//chatClickbyRoom() END

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
	//alert("connect ! "+"전송자 : " + user + " 대상자 : " + target);
	var path = "http://localhost:8081";

	sock = new SockJS(path + "/chat");
	stompClient = Stomp.over(sock);

	stompClient.connect({}, function() {
		stompClient.subscribe("/category/msg/" + user, function(message) {
			console.log("Message :" + message.body);
			//			var test1 = JSON.stringify(user);
			//			var test2 = JSON.stringify(message);
			addMsg(message.body, target);
		});
	});
}

//메시지 전송()
function send(user, target) {
	//alert("send!");
	//alert("send ! "+"전송자 : " + user + " 대상자 : " + target);
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
						$('<div class="msg_b">' + msg + '</div>').insertBefore('.msg_push');
					$('.msg_body').scrollTop($('.msg_body')[0].scrollHeight);
					//ChatController로 메시지 전달 (웹소켓)
					stompClient.send("/client/hello/" + user + "/" + target, {}, msg);
				}
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

//ajax로 반환 받은 데이터의 값이 있는지 체크하는 함수
function nullCheck(value) {
	if (value == ""
			|| value == null
			|| value == undefined
			|| (value != null && typeof value == "object" && !Object
					.keys(value).length)) {
		return true
	} else {
		return false
	}
}

//연결해제
function disconnect() {
		stompClient.send("/client/out", {}, ' is out chatroom');
		stompClient.disconnect();
//		window.location.href=chatoutaddress.value; //정체불명
}

$(document).ready(function() {
	//alert("테스트");
	//소켓 통신을 위한 객체 선언 
	var sock;
	var stompClient = null;
	
	//웹소켓 연결 해제 관련
	$('.close').click(function(){
		disconnect();
	});
	
	/* 웹소켓 초기화
	function init(){
		connect();
	}
	 */
});//onLoad END

