$(document).ready(function() {
	alert("테스트4");
	var path = "http://localhost:8081";
	//'비밀번호 초기화' 버튼을 변수에 담는다.
	var btn = $("#btn_reset");
	//버튼을 클릭하면 함수 실행 
	btn.click(function() {
		//form 요소에 있는 요소를 직렬화하여 변수에 저장 (이메일, 토큰)
		var data = $("#form_reset").serialize();
		var input = $("#id_email"); 
		var email = input.val();
		$.ajax({
	        type : 'get',
	        url : path + '/accounts/passwordreset',
	        data : data,
	        datType:"json",
	        success : function(result) {
	        	if(result){
			        swal({
				          text: email+'로 임시 비밀번호를 발송하였습니다.',
				          buttons : '확인'
				        }).then(function() {
				        	window.location = "http://localhost:8081/home";
				        });
	        	}else{
	        		input.val("존재 하지 않는 메일 입니다.");
	        		input.css("text-align","center");
	        		input.css("color","red");
	        		$('#id_email').focus();
	        	}
	        },
	        error : function(error) {
	            console.log(error);
	            console.log(error.status);
	        }
	    });
		return false;
	})	
});//onLoad END
