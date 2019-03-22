<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.user_num" var="user_num"/>
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<%-- <sec:csrfMetaTags/> --%>
<meta charset="UTF-8">

<%-- <meta name="_csrf" content="${_csrf.token}"/> --%>
<%-- <meta name="_csrf_header" content="${_csrf.headerName}"/> --%>
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	//submit 실행시 사진 등록 확인 
	function form_Check(){
		var cma_file4 = $('#cma_file4').val();
		var cma_file = $('#cma_file').val();
		var cma_file1 = $('#cma_file1').val();
		var cma_file2 = $('#cma_file2').val();
		var cma_file3 = $('#cma_file3').val();
		
// 		alert("cma_file : " + cma_file);
// 		alert("cma_file1 : " + cma_file1);
// 		alert("cma_file2 : " + cma_file2);
// 		alert("cma_file3 : " + cma_file3);
//		alert("cma_file4 : " + cma_file4);
		if(cma_file4 == '' || cma_file == '' || cma_file1 == '' || cma_file2 == '' || cma_file3 == ''){
			swal({
	               text:"숙소 사진을 선택해 주세요.",
	               icon:"warning",
	               buttons:[false,"확인"]
	            })
			return false;
		}
	};


	//사진 등록 함수 
	function getThumbnailPrivew(html, $target) {
		if (html.files && html.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$target.html('<img src="' + e.target.result + '" border="0" alt="" />');
			}

			reader.readAsDataURL(html.files[0]);
		}
	}
	function getThumbnailPrivew1(html, $target) {
		if (html.files && html.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$target.html('<img src="' + e.target.result + '" border="0" alt="" />');						
			}

			reader.readAsDataURL(html.files[0]);
		}
	}
	function getThumbnailPrivew2(html, $target) {
		if (html.files && html.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$target.html('<img src="' + e.target.result + '" border="0" alt="" />');						
			}

			reader.readAsDataURL(html.files[0]);
		}
	}
	function getThumbnailPrivew3(html, $target) {
		if (html.files && html.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$target.html('<img src="' + e.target.result + '" border="0" alt="" />');						
			}

			reader.readAsDataURL(html.files[0]);
		}
	}
	function getThumbnailPrivew4(html, $target) {
		if (html.files && html.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$target.html('<img src="' + e.target.result + '" border="0" alt="" />');						
			}

			reader.readAsDataURL(html.files[0]);
		}
	}
</script>

<style type="text/css">
.filebox_big .filebox_big_laber{
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
 	width: 800px;    
	height: 400px;  
  	
}
.filebox_big input[type="file"]{
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
.filebox label {
	margin : 0 auto;
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
 	width: 399px;    
	height: 250px;  

}

.filebox input[type="file"] { /* 파일 필드 숨기기 */
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
	vertical-align: bottom;
 	background-image: url('${contextPath}/img/motel/next.jpg');
    background-position:  0px 0px;
    background-repeat: no-repeat;
    width: 50px;
    height: 45px;
    border: 0px;
 	cursor:pointer;
 	outline: 0;
 	margin-top : 10px;
 	margin-right: 5.5%;
 	float: right;
}
.btn_back{
	vertical-align: bottom;
	background-image: url('${contextPath}/img/motel/back.jpg');
    background-position:  0px 0px;
    background-repeat: no-repeat;
    width: 50px;
    height: 45px;
    border: 0px;
 	cursor:pointer;
 	outline: 0;
 	margin-top : 10px;
 	margin-left: 5.5%;
 	float: left;
}

img {
  width: 100%;
  height: 100%;
}
.photo_all{
	margin-left: 18%;
}
.button{
	margin-bottom: 5%;
	margin-left: 13.6%;
	margin-right: 15%;
}
.registor_main {
	padding-top : 4%;
	padding-bottom : 4%;
	background-repeat: no-reapt;
	height: 100%;
	width: 100%;
	background-image: url("${contextPath}/img/motel/motel_registor.jpg");
	background-position: center;
	background-size: cover;
}
.registor_contain {
	margin : auto;
/*  	margin-top : 15%;  */
	background-position: center;
	width: 90%;
	height: 80%;
	background-color: white;
	border: 1px solid #444444;
	background-position: center;
	padding: 3%;
	float: center;	
}
</style>
</head>
<body>
<%-- registor : ${registor} --%>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->



	<!-- 본문 -->
	<div class="main-container" style="padding-top: 0; padding-bottom: 0;">
		<section id="section-profile-update" class="bg-gray">
			<div class="container" style="width: 100%; padding-left: 10%; padding-right: 10%;" >
				<div class="registor_main">
					<div class="registor_contain">
				<!-- 이 부분에 자신의 페이지 넣기 -->
				<h3 style="text-align: center">게스트에게 보여줄 숙소의 사진을 등록하세요.(사진등록 5개
					필수!!)</h3>
					<form name="form" id="form" action="registor_intro" method="post" class="photo_form"
						enctype="multipart/form-data" autocomplete="off" onsubmit="return form_Check();">
						
						<input type="hidden" value="${_csrf.token}" name="${_csrf.parameterName}">
							
							<!-- 기존에 받은 데이터 -->
						<input type="hidden" value="${motel_type }" name="motel_type">
						<input type="hidden" value="${motel_category }"name="motel_category"> 
						<input type="hidden" value="${motel_bathroom }" name="motel_bathroom"> 
						<input type="hidden" value="${motel_room }" name="motel_room"> 
						<input type="hidden" value="${motel_people }" name="motel_people">
						<input type="hidden" value="${motel_address }" name="motel_address">
						<input type="hidden" value="${motel_city_en }" name="motel_city_en">
						<input type="hidden" value="${motel_city_ko }" name="motel_city_ko">
						<input type="hidden" value="${motel_nation_en }" name="motel_nation_en">
						<input type="hidden" value="${motel_nation_ko }" name="motel_nation_ko">

					<div class="photo_all">
						<div class="filebox_big">
							<label for="cma_file4" id="cma_image4" class="filebox_big_laber">사진
								인증샷 업로드</label> <input type="file" name="files" id="cma_file4"
								accept="image/*" capture="camera" id="filebox_big"
								onchange="getThumbnailPrivew4(this,$('#cma_image4'))" /> <br />
						</div>
						<div class="filebox">
							<label for="cma_file" id="cma_image">사진 인증샷 업로드</label> <input
								type="file" name="files" id="cma_file" accept="image/*"
								capture="camera"
								onchange="getThumbnailPrivew(this,$('#cma_image'))" /> <label
								for="cma_file1" id="cma_image1">사진 인증샷 업로드</label> <input
								type="file" name="files" id="cma_file1" accept="image/*"
								capture="camera"
								onchange="getThumbnailPrivew1(this,$('#cma_image1'))" /> <br />
						</div>
						<div class="filebox">
							<label for="cma_file2" id="cma_image2">사진 인증샷 업로드</label> <input
								type="file" name="files" id="cma_file2" accept="image/*"
								capture="camera"
								onchange="getThumbnailPrivew2(this,$('#cma_image2'))" /> <label
								for="cma_file3" id="cma_image3">사진 인증샷 업로드</label> <input
								type="file" name="files" id="cma_file3" accept="image/*"
								capture="camera"
								onchange="getThumbnailPrivew3(this,$('#cma_image3'))" /> <br />
						</div>
					
					</div>
					<div class="button">
					<input type="submit" value="" class="btn_next"> <input
							type="button" value="" class="btn_back"
							onclick="history.back(-1);">
						<!-- 					<a href="javascript:history.go(-1);">back</a> -->
					</div>	
					</form>
					</div>
					</div>
				</div>
		</section>
	</div>
	<!-- 본문 END-->

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>