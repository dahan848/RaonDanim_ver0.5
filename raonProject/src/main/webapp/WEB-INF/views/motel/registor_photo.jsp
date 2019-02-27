<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

	function getThumbnailPrivew(html, $target) {
		if (html.files && html.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$target.css('display', '');
				//$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
				$target
						.html('<img src="' + e.target.result + '" border="0" alt="" height : "100%" />');
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
	width: 100%;
	height : 300px;
	max-width: 100%;
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
</style>
</head>
<body>${registor}
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
				<form name="form" id="form" action="" method="post"
					enctype="multipart/form-data" autocomplete="off">
					<div class="filebox">
						<label for="cma_file" id="cma_image">사진 인증샷 업로드</label> <input
							type="file" name="cma_file" id="cma_file" accept="image/*"
							capture="camera"
							onchange="getThumbnailPrivew(this,$('#cma_image'))" /> <br />
						<br />
					</div>
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