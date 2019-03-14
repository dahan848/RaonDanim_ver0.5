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
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(function() {

		//시작일.
		$('#fromDate').datepicker(
				{
					dateFormat : "yy-mm-dd", // 날짜의 형식
					minDate : 0, // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
					onClose : function(selectedDate) {
						// 시작일(fromDate) datepicker가 닫힐때
						// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
						$("#checkoutDate").datepicker("option", "minDate",
								selectedDate);
					}
				});

		//종료일
		$('#checkoutDate').datepicker({
			dateFormat : "yy-mm-dd",
			minDate : 0, // 오늘 이전 날짜 선택 불가
			onClose : function(selectedDate) {
				// 종료일(toDate) datepicker가 닫힐때
				// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
				$("#fromDate").datepicker("option", "maxDate", selectedDate);
			}
		});

	});

	function form_Check() {
		var motel_intro = $('#motel_intro').val();
		var motel_price = $('#motel_price').val();
		var motel_title = $('#motel_title').val();	
		
		var fromDate = $('#fromDate').val();
		var checkoutDate = $('#checkoutDate').val();
		
// 		alert(fromDate);
// 		alert(checkoutDate);
		//날짜입력에 대한 유효성 검사
		if(fromDate == "" || checkoutDate ==""){
			swal({
	               text:"숙박대여 날짜를 확인해 주세요.",
	               icon:"warning",
	               buttons:[false,"확인"]
	            })
			return false;
		}
		//숙소 소개 글 유효성 검사
		if(motel_intro == "" || motel_intro.length < 15){
			swal({
	               text:"숙소 소개 작성란을 확인해 주세요.",
	               icon:"warning",
	               buttons:[false,"확인"]
	            })
			return false;
		}
		//숙소 제목 유효성검사
		if(motel_title == "" || motel_title.length < 3){
			swal({
	               text:"숙소 소개제목을 확인해 주세요.",
	               icon:"warning",
	               buttons:[false,"확인"]
	            })
			return false;
		}
		// price 숫자입력 및 액수 제한 유효성검사 
		var priceCheck = /^[0-9]+$/;
		if(!priceCheck.test(motel_price)){
			swal({
	               text:"가격을 확인해 주세요.",
	               icon:"warning",
	               buttons:[false,"확인"]
	            })
			return false;
		}

		
		var up;
		up = confirm("등록하시겠습니까 ??");

		if (up) {
			return true;
		} else {
			return false;
		}
		//		swal({
		//         text:"등록하시겠습니까 ????",
		//         icon:"warning",
		//         buttons:[false,"확인"]
		//      })
	}
</script>
<style type="text/css">
textarea {
	margin: auto;
}

.btn_next {
	background-image: url('${contextPath}/img/motel/next.jpg');
	background-position: 0px 0px;
	background-repeat: no-repeat;
	width: 50px;
	height: 45px;
	border: 0px;
	cursor: pointer;
	outline: 0;
	margin-top: 10px;
	float: right;
	/*  	margin-right: 15%; */
}

.btn_back {
	background-image: url('${contextPath}/img/motel/back.jpg');
	background-position: 0px 0px;
	background-repeat: no-repeat;
	width: 50px;
	height: 45px;
	border: 0px;
	cursor: pointer;
	outline: 0;
	margin-top: 10px;
	float: left;
}

.form {
	margin-left: 10%;
	margin-right: 10%;
}

.registor_main {
	padding-top: 9%;
	background-repeat: no-reapt;
	height: 700px;
	width: 100%;
	background-image: url("${contextPath}/img/motel/motel_registor.jpg");
	background-position: center;
	background-size: cover;
}

.registor_contain {
	margin: auto;
	/*  	margin-top : 15%;  */
	background-position: center;
	width: 90%;
	height: 90%;
	background-color: white;
	border: 1px solid #444444;
	background-position: center;
	padding: 5%;
	float: center;
}
</style>
</head>
<body>
	${registor }
	<!-- 본문 -->
	<div class="main-container" style="padding-top: 0; padding-bottom: 0;">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<!-- 이 부분에 자신의 페이지 넣기 -->
				<div class="registor_main">
					<div class="registor_contain">
						<form action="registor_complete" method="post" class="form"
							onsubmit="return form_Check();" style="width: 100%; height: 100%">
							<input type="hidden" value="${_csrf.token}"
								name="${_csrf.parameterName}"> 
								
								<!-- 기존에 받았던 데이터 -->
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
								<input type="text" name="user_num" value="${user_num }">
							<div class="form_all" style="width: 90%; height: 90%;">
								<h4>
									숙소 대여 가능한 기간을 설정해 주세요.<br>
								</h4>

									<input type="text" id="fromDate" name="motel_fromDate" readonly="readonly"> ~ 
									<input type="text" id="checkoutDate" name="motel_checkoutDate" readonly="readonly">

								<h4>
									숙소에 대한 소개를 남겨 주세요.<br>
								</h4>
								<textarea name="motel_intro" id="motel_intro" rows="10" cols="100"></textarea>
								<h4>
									숙소 등록을 위한 제목을 남겨 주세요.<br>
								</h4>
								<input type="text" name="motel_title" id="motel_title" style="width: 725px;">
								<h4>
									숙소의 요금을 설정해 주세요.(설정하지 않을 경우 게스트가 무료로 이용 가능합니다.)<br>
								</h4>
								<input type="text" name="motel_price" id="motel_price" value="0">
								<b id="dollar" style="font-size: 1.6em; padding: 2px;">$</b><br>
								
								
								<div class="button" style="width: 90%;">
									<input type="submit" value="" class="btn_next"> <input
										type="button" value="" class="btn_back"
										onclick="history.back(-1);">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</section>
	</div>
	<!-- 본문 END-->
</body>
</html>