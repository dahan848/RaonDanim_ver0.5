//웹소켓을 사용할 수 있도록 페이지 로딩 완료 시 웹소켓 초기화//
document.addEventListener("DOMContentLoaded", function(){
	WebSocket.init();
});
//웹소켓 설정//
var WebSocket = (function(){
	var stompClient;
	
	var textArea = document.getElementById("chatOutput");
	var inputElm = document.getElementById("chatInput");
	var sendbtn = document.getElementById("sendbtn");
	var outroombtn = document.getElementById("outroom");
	var usersessionid = document.getElementById("sessionuserid");
	var chatoutaddress = document.getElementById("chatoutaddress");
	
	//연결//
	function connect(){
		//SockJS, STOMP관련 객체 생성//
		var socket = new SockJS("/websockethandler");
		stompClient = Stomp.over(socket);
		
		stompClient.connect({}, function(){
			//메세지를 받는다. 각각의 구독//
			stompClient.subscribe('/topic/roomId', function(msg){
				printMessage(JSON.parse(msg.body).sendMessage + '/' + JSON.parse(msg.body).senderName);
			});
			
			stompClient.subscribe('/topic/out', function(msg){
				printMessage(msg.body);
			});
			
			stompClient.subscribe('/topic/in', function(msg){
				printMessage(msg.body);
			});
			
			//입장글//
			stompClient.send("/app/in", {}, usersessionid.value + ' is in chatroom');
		});
	}
	
	//연결해제//
	function disconnect() {
	    	if (stompClient !== null) {
	    		stompClient.send("/app/out", {}, usersessionid.value + ' is out chatroom');
	    		stompClient.disconnect();
	    		
	    		window.location.href=chatoutaddress.value;
	    	}
	}
	
	//메세지 전송 버튼 이벤트//
	sendbtn.onclick = function(){
		sendMessage(inputElm.value);
		clear(inputElm);
	}
	
	//채팅방 나가기 버튼 이벤트//
	outroombtn.onclick = function(){
		disconnect();
	}
	
	function printMessage(message){
		textArea.value += message + "\n";
	}
	
	//입력창 초기화//
	function clear(input){
		input.value = "";	
	}
	
	//메세지 전송//
	function sendMessage(text){
		//send()부분에 매개변수로 MessageMapping을 입력//
		//세번째 인자로 보내고자 하는 정보를 JSON으로 설정하여 보낸다.(관련 VO존재 필요)//
		stompClient.send("/app/hello", {}, JSON.stringify({'sendMessage':text, 'senderName':''+usersessionid.value}));
	}
	
	//초기화//
	function init(){
		connect();
	}
	
	return {
		init : init
	}
})();