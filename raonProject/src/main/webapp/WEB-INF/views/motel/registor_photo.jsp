<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%-- <meta name="_csrf" content="${_csrf.token}"/> --%>
<%-- <meta name="_csrf_header" content="${_csrf.headerName}"/> --%>
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	function getThumbnailPrivew(html, $target) {
		if (html.files && html.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				//$target.css('display', '');
				//$('.filebox').css('background-image', 'url(\"' + e.target.result + '\")');
				$target.css('background-image', 'url(\"' + e.target.result + '\")'); // ������� ������
						
 				$target.css('background-repeat',"no-repeat");
 				$target.css('background-size',"contain");
				//$(target).css('height','300px');
				//$(target).css('width','500px');
				// 				$(".label").text("");
				/* $target
						.html('<img src="' + e.target.result + '" border="0" alt="" height : "100%" />'); */
			}

			reader.readAsDataURL(html.files[0]);
		}
	}
	function getThumbnailPrivew1(html, $target) {
		if (html.files && html.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				//$target.css('display', '');
				//$('.filebox').css('background-image', 'url(\"' + e.target.result + '\")');
				$target.css('background-image', 'url(\"' + e.target.result + '\")'); // ������� ������
						
 				$target.css('background-repeat',"no-repeat");
 				$target.css('background-size',"contain");
				//$(target).css('height','300px');
				//$(target).css('width','500px');
				// 				$(".label").text("");
				/* $target
						.html('<img src="' + e.target.result + '" border="0" alt="" height : "100%" />'); */
			}

			reader.readAsDataURL(html.files[0]);
		}
	}
</script>

<style type="text/css">
.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #c1bbbb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
 	width: 300px;   
  	height: 300px;   
  	max-width: 100%;  
}

.filebox input[type="file"] { /* ���� �ʵ� ����� */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
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
.btn_back{
 background-image: url('${contextPath}/img/motel/back.jpg');
    background-position:  0px 0px;
    background-repeat: no-repeat;
    width: 50px;
    height: 45px;
    border: 0px;
 	cursor:pointer;
 	outline: 0;
 	margin-top : 10px;
 	float: left;
}
</style>
</head>
<body>${registor}
	<!-- ��Ŭ��� ���� ��� -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
	<!-- ��Ŭ��� ���� ��� END -->



	<!-- ���� -->
	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<!-- �� �κп� �ڽ��� ������ �ֱ� -->
				<h3 style="text-align: center">�Խ�Ʈ���� ������ ������ ������ ����ϼ���.(������� 5��
					�ʼ�!!)</h3>
				<form name="form" id="form" action="registor_intro" method="post"
					enctype="multipart/form-data" autocomplete="off">
					<input type="hidden" value="${_csrf.token}" name="${_csrf.parameterName}">
					<input type="hidden" value="${registor}" name="registor_step1">
					<div class="filebox">
						<label for="cma_file" id="cma_image" >���� ������
							���ε�</label> <input type="file" name="cma_file" id="cma_file"
							accept="image/*" capture="camera"
							onchange="getThumbnailPrivew(this,$('#cma_image'))" /> <br />
					</div>
					<div class="filebox">
						<label for="cma_file1" id="cma_image1" >���� ������
							���ε�</label> <input type="file" name="cma_file1" id="cma_file1"
							accept="image/*" capture="camera"
							onchange="getThumbnailPrivew1(this,$('#cma_image1'))" /> <br />
					</div>
					<input type="submit" value="" class="btn_next">
					<input type="button" value= "" class="btn_back" onclick="history.back(-1);">
				</form>
			</div>
		</section>
	</div>
	<!-- ���� END-->

	<!-- ��Ŭ���-Ǫ�� -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- ��Ŭ���-Ǫ�� END -->
</body>
</html>