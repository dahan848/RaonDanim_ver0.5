<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>2222</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	function form_Check(){
		var type = $('#motel_type').val();
		var category = $('#motel_category').val(); 
		if(type == 0){
			swal({
	               text:"���� ������ ������ �ּ���.",
	               icon:"warning",
	               buttons:[false,"Ȯ��"]
	            })
			return false;
		}else if(category == 0){
			swal({
	               text:"���� ������ ������ �ּ���.",
	               icon:"warning",
	               buttons:[false,"Ȯ��"]
	            })
			return false;
		}
	}
		
		
//���� �ο� �� ���� ��� ���� ���� ��ũ��Ʈ
	function people_change(num) {
		var x = $('#motel_people').val();
		var y = Number(x) + num;
		
		if (y < 1){
			y = 1;
			swal({
	               text:"���� �ο��� 1�� �̻� ������ �ּ���",
	               icon:"warning",
	               buttons:[false,"Ȯ��"]
	            })
			
			return false;
		}
		if(y > 15){
			y=15;
			swal({
	               text:"���� �ο��� 15�� �̻����� ������ �� �����ϴ�.",
	               icon:"warning",
	               buttons:[false,"Ȯ��"]
	            })
			return false;
		}
		$('#motel_people').val(y);
		return false;
	}
	function room_change(num) {
		var x = $('#motel_room').val();
		var y = Number(x) + num;
		if (y < 1){
			y = 1;
			swal({
	               text:"��밡���� �氳���� 1�� �̻� ������ �ּ���",
	               icon:"warning",
	               buttons:[false,"Ȯ��"]
	            })
			
			return false;
		}
		if(y > 5){
			y=15;
			swal({
	               text:"��밡���� �氳����  5�� �̻����� ���� �� �� �����ϴ�.",
	               icon:"warning",
	               buttons:[false,"Ȯ��"]
	            })
			return false;
		}
		$('#motel_room').val(y);
		return false;
	}
	function bathroom_change(num) {
		var x = $('#motel_bathroom').val();
		var y = Number(x) + num;
		if (y < 1){
			y = 1;
			swal({
	               text:"��밡���� ��ǰ����� 1�� �̻� ������ �ּ���",
	               icon:"warning",
	               buttons:[false,"Ȯ��"]
	            })
			
			return false;
		}
		if(y > 5){
			y=15;
			swal({
	               text:"��밡���� ��ǰ�����  5�� �̻����� ���� �� �� �����ϴ�.",
	               icon:"warning",
	               buttons:[false,"Ȯ��"]
	            })
			return false;
		}
		$('#motel_bathroom').val(y);
		return false;
	}	
</script>
<style type="text/css">
.registor_main {
	padding-top : 9%;
	background-repeat: no-reapt;
	height: 700px;
	width: 100%;
	background-image: url("${contextPath}/img/motel/motel_registor.jpg");
	background-position: center;
	background-size: cover;
}

.registor_contain {
	margin : auto;
/*  	margin-top : 15%;  */
	background-position: center;
	width: 60%;
	height: 80%;
	background-color: white;
	width: 60%;
	border: 1px solid #444444;
	background-position: center;
	padding: 5%;
	float: center;
	
}

#plus_minus{
	font-size: 30px;
}
.btn_next{
 background-image: url('${contextPath}/img/motel/next.jpg');
    background-position:  0px 0px;
    background-repeat: no-repeat;
    width: 50px;
    height: 45px;
    border: 0px;
 	cursor:pointer;
 	outline: 0;
 	margin-top : 10px;
 	float: right;
}
</style>

</head>
<body>
	<!-- ��Ŭ��� ���� ��� -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
	<!-- ��Ŭ��� ���� ��� END -->



	<!-- ���� -->
		<section id="section-profile-update" class="bg-gray">
			<div class="container"
				style="width: 100%; padding-left: 18%; padding-right: 18%;">
				<!-- �� �κп� �ڽ��� ������ �ֱ� -->	
				<div class="registor_main">
					<div class="registor_contain">
						<form action="registor_city_address" method="post" class="registor_form" onsubmit="return form_Check();">
							<input type="hidden" value="${_csrf.token}" name="${_csrf.parameterName}">
							<h5>������ ������ ������ �ּ���.</h5>
							<select name="motel_type" id="motel_type">
								<option value="0">���� ����</option>
								<option value="1">����Ʈ</option>
								<option value="2">����</option>
								<option value="3">����</option>
							</select><br>
							<h5>�Խ�Ʈ���� ���� �� ������ ������ ������ �ּ���.</h5>
							<select name="motel_category" id="motel_category">
								<option value="0">���� ����</option>
								<option value="1">�� ��ü</option>
								<option value="2">���ν�</option>
							</select><br>
							<h5>������ �ִ� ���� �ο��� ������ �ּ���.(�ִ� 15��)</h5>
							<a id="plus_minus" href='#' onclick='javascript_:people_change(1);'><i class="fa fa-plus-circle" id="tt"></i></a> <input
								type='text' name='motel_people' id="motel_people" value='1' size='3' readonly> <a id="plus_minus"
								href='#' onclick='javascript_:personnel_change(-1);'><i class="fa fa-minus-circle" id="tt"></i></a>
							<h5>�Խ�Ʈ�� ����� �� �ִ� ���� ������ ������ �ּ���.(�ִ� 5��)</h5>
							<a id="plus_minus" href='#' onclick='javascript_:room_change(1);'><i class="fa fa-plus-circle"></i></a> <input
								type='text' name='motel_room' id="motel_room" value='1' size='3' readonly> <a id="plus_minus"
								href='#' onclick='javascript_:room_change(-1);'><i class="fa fa-minus-circle" id="tt"></i></a>
							<h5>�Խ�Ʈ�� ����� �� �ִ� ����� ������ ������ �ּ���.(�ִ� 5��)</h5>
							<a id="plus_minus" href='#' onclick='javascript_:bathroom_change(1);'><i class="fa fa-plus-circle"></i></a> <input
								type='text' name='motel_bathroom' id="motel_bathroom" value='1' size='3' readonly> <a id="plus_minus"
								href='#' onclick='javascript_:bath_change(-1);'><i class="fa fa-minus-circle" id="tt"></i></a><br>
							<input type="submit" value="" class="btn_next">
						</form>
					</div>
				</div>
			</div>
		</section>

	<!-- ���� END-->

	<!-- ��Ŭ���-Ǫ�� -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- ��Ŭ���-Ǫ�� END -->
</body>
</html>