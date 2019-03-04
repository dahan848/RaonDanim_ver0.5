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
	//사진 등록 함수 
	function getThumbnailPrivew(html, $target) {
		if (html.files && html.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				//$target.css('display', '');
				//$('.filebox').css('background-image', 'url(\"' + e.target.result + '\")');
// 				$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
						
//  				$target.css('background-repeat',"no-repeat");
//  				$target.css('background-size',"contain");
 				
 				

// 				$target.css('height','300px');
// 				$target.css('width','300px');
				// 				$(".label").text("");
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
 	width: 1000px;    
	height: 500px;  
/*   	max-width: 500px;  */
  	
  	
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
 	width: 500px;    
	height: 300px;  

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
 	float: left;
}

img {
  width: 100%;
  height: 100%;
}

</style>
</head>
<body>registor : ${registor}
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->



	<!-- 본문 -->
	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<!-- 이 부분에 자신의 페이지 넣기 -->
				<h3 style="text-align: center">게스트에게 보여줄 숙소의 사진을 등록하세요.(사진등록 5개
					필수!!)</h3>
				<form name="form" id="form" action="registor_intro" method="post"
					enctype="multipart/form-data" autocomplete="off">
					<input type="hidden" value="${_csrf.token}" name="${_csrf.parameterName}">
					<input type="hidden" value="${registor}" name="motel_info">
					<div class="filebox_big">
						<label for="cma_file4" id="cma_image4" class="filebox_big_laber">사진 인증샷
							업로드</label> <input type="file" name="cma_file4" id="cma_file4"
							accept="image/*" capture="camera" id="filebox_big"
							onchange="getThumbnailPrivew4(this,$('#cma_image4'))" /> <br />
					</div>
					<div class="filebox">
						<label for="cma_file" id="cma_image" >사진 인증샷
							업로드</label> <input type="file" name="cma_file" id="cma_file"
							accept="image/*" capture="camera"
							onchange="getThumbnailPrivew(this,$('#cma_image'))" />
						<label for="cma_file1" id="cma_image1" >사진 인증샷
							업로드</label> <input type="file" name="cma_file1" id="cma_file1"
							accept="image/*" capture="camera"
							onchange="getThumbnailPrivew1(this,$('#cma_image1'))" /> <br />
					</div>
					<div class="filebox">
						<label for="cma_file2" id="cma_image2" >사진 인증샷
							업로드</label> <input type="file" name="cma_file2" id="cma_file2"
							accept="image/*" capture="camera"
							onchange="getThumbnailPrivew2(this,$('#cma_image2'))" /> 
						<label for="cma_file3" id="cma_image3" >사진 인증샷
							업로드</label> <input type="file" name="cma_file2" id="cma_file3"
							accept="image/*" capture="camera"
							onchange="getThumbnailPrivew3(this,$('#cma_image3'))" /> <br />
					</div>
					<input type="submit" value="" class="btn_next">
					<input type="button" value= "" class="btn_back" onclick="history.back(-1);">
<!-- 					<a href="javascript:history.go(-1);">back</a> -->
				</form>
			</div>
		</section>
	</div>
	<!-- 본문 END-->

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>