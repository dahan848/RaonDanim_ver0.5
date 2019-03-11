<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 스윗얼럿 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- 부트스트랩 -->

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!-- 부트스트랩 END -->

<!-- 달력 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link href="${contextPath }/css/bootstrap-datepicker2.css" rel="stylesheet">
<link href="${contextPath }/css/bootstrap-datepicker.css" rel="stylesheet">
<script src="${contextPath }/js/bootstrap-datepicker.js" type="text/javascript"></script>
<!-- 달력 END -->



<!-- 서치바 CSS -->
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<!-- CSS -->
<link href="${contextPath}/css/commonness.css" rel="stylesheet">
<!-- 공통 스타일 CSS -->
<link href="${contextPath}/css/bootstrap-social.css" rel="stylesheet">
<!-- 부트스트랩 소셜 -->
<link href="${contextPath}/css/font-awesome.css" rel="stylesheet">
<!-- 폰트어썸 -->


<script type="text/javascript">
	var count = 1;
	var n = 0;
	var cssCount = 0;
	$("#myModal2").modal({
		keyboard:true
	})
	$(function() {
		
		var people = $("#people").text();
		var cPeople = $("#cPeople").text();
		
		$("#con").css("height", "0px");
		
		$(window).on("scroll", function() {
			//현재 문서의 높이
			var scrollHeight = $(document).height();
			//현재 스크롤 위치
			var scrollPosition = $(window).height() + $(window).scrollTop();

			if (scrollPosition > scrollHeight-1) {
				
				createList();
				count++;
			}
		})
		createList();
		
		/* function price(){
			var price = "$('#price1').val() "+"~"+" $('#price2').val()";
			$("#price").val(price);
			onclick="price();" 
		} */
		
		
		
		
		$(".btn-default").on("click", function() {
			/* alert("123");
			var price1 = $(".price1").val();
			alert(price1); */
			var price = $('.price1').val() +"~"+ $('.price2').val();
			$(".price").val(price);
			
		})
		
		/* $("#btnPrice").on("click",function(){
			alert("123");
			var price = "$('#price1').val() "+"~"+" $('#price2').val()";
			$("#price").val(price);
		}) */
		
		
		$('[data-toggle="popover"]').popover();
		$("#datePickerCheckIn").datepicker(
				{
					

				});
		/* $("#datePickerCheckIn").on("click",function(){
		alert($("#datePickerCheckIn").datepicker.option.minDate.val());
			debugger;
		}) */
		$("#datePickerCheckOut").datepicker({
			
			dateFormat : 'yyyy-mm-dd',
			
			weekStart:1,
	    	color: 'red',
		});
		

		$("#plus").on("click", function() {
			if($("#people").text()>14){
				swal({
					text:"최대 숙박 인원은 15명 입니다.",
					icon:"warning",
					buttons:[false,"확인"]
				})
			}else{
				people++;
				$("#people").text(people);
			}
			
		})
		$("#minus").on("click", function() {
			if($("#people").text()<1){
				swal({
					text:"숙박 인원을 1명 이상 설정해 주세요",
					icon:"warning",
					buttons:[false,"확인"]
				})
			}else{
				people--;
				$("#people").text(people);
			}
			
		})
		$("#cPlus").on("click", function() {
			cPeople++;
			$("#cPeople").text(cPeople);
		})
		$("#cMinus").on("click", function() {
			cPeople--;
			$("#cPeople").text(cPeople);
		})

	});

	function getOriginFilename(fileName) {
		//fileName에서 uuid를 제외한 원래 파일명을 반환
		if (fileName == null) {
			return;
		}
		var idx = fileName.indexOf("_") + 1;
		return fileName.substr(idx);
	}
	

	function createList() {
		//회원 목록을 그려주는 역할을 하는 함수
		//회원 목록을 그리기 위해서는
		//회원 목록을 서버에 요청해서 받아와야 한다 : ajax
		var table = $("#listTable");
		var conHeight = $("#con").height();
		var heightNum=0;
		//listTable 요소 중 하위요소인 0보다 큰 tr을 선택하여 remove

		$.ajax({
					url : "${contextPath}/motel/list?page=" + count,
					data:{"${_csrf.parameterName}":"${_csrf.token}"},
					type : "post",
					dataType : "json",
					error : function() {
						alert("실패");
					},
					success : function(data) {
						for ( var i in data.board.boardList) {
							
							$("#con").append('<div class="col-md-4 col-sm-6" id="col'+n+'">');
							var col="#col"+n;
							$(col).append('<div class="item-cover item-cover-sm" id="itemCover'+n+'">');
							var itemCover = "#itemCover"+n;
							$(itemCover).append('<a href="view?num='+data.board.boardList[i].MOTEL_NUM+'&host='+data.board.boardList[i].USER_NUM+'"><div class="cover-background" style="background-image:url(${contextPath}/img/house1.jpg);"></div></a>');
							$(itemCover).append('<div class="cover-profile-image" id="profile'+n+'"> </div>');
							var profile="#profile"+n;
							var $pop=$('<a href="#none" data-toggle="popover" data-html="true" data-content="프로필 보기<br>친구 신청<br>대화 하기" data-trigger="focus"><img src="${contextPath}/img/duny.jpg" class="img-profile"></a>');
							$(profile).append($pop);
							$pop.popover();
							$(itemCover).append('<h4 class="profile-name">'+data.board.boardList[i].USER_FNM+data.board.boardList[i].USER_LNM+'</h4>');
							$(itemCover).append('<p class="profile-city">인원 '+data.board.boardList[i].MOTEL_PEOPLE+'명, 침대 '+data.board.boardList[i].MOTEL_ROOM+'개, 욕실 '+data.board.boardList[i].MOTEL_BATHROOM+'개</p>');
							var motel_price=data.board.boardList[i].MOTEL_PRICE;										
							if(motel_price==0){
								$(itemCover).append('<p class="profile-city">FREE</p>');
							}else{
								$(itemCover).append('<p class="profile-city">'+data.board.boardList[i].MOTEL_PRICE+'/1박</p>');
								if(${date}){									
									$(itemCover).append('<p class="profile-city">총 요금 : '+data.board.boardList[i].MOTEL_PRICE*${date}+'</p>');
								}else{
									$(itemCover).append('<p class="profile-city">여행 날짜를 입력시 총 요금 확인이 가능합니다.</p>');
								}
							}
							
							$(itemCover).append('<h4 class="profile-name">'+data.board.boardList[i].MOTEL_TITLE+'</h4>');
							

							n++;
							cssCount++;
							
							if(i>=0&&i<=2){
								heightNum=1;									
							}
							if(i>2&&i<=5){
								heightNum=2;									
							}
							if(i>5&&i<=8){
								heightNum=3;									
							}
							
							if(i==data.board.boardList.length-1){
								
								
								if(heightNum==1){
									conHeight=conHeight+$("#col0").height();
									/* conHeight=conHeight+360; */
									$("#con").css("height",conHeight+"px");
								}
								if(heightNum==2){
									conHeight=conHeight+$("#col0").height()*2;
									/* conHeight=conHeight+720; */
									$("#con").css("height",conHeight+"px");
								}
								if(heightNum==3){
									conHeight=conHeight+$("#col0").height()*3;
									/* conHeight=conHeight+1080; */
									$("#con").css("height",conHeight+"px");
								}
								heightNum=0;
								
							}
							
							//listTable 요소에 tr 만들어 내용 채우기
							
							/* var fileName = getOriginFilename(data.board.boardList[i].FILENAME); */
							/* if (fileName) {

								$("#con").append('<div class="col-md-4 col-sm-6" id="col'+n+'">');
								var col="#col"+n;
								$(col).append('<div class="item-cover item-cover-sm" id="itemCover'+n+'">');
								var itemCover = "#itemCover"+n;
								$(itemCover).append('<div class="cover-background" style="background-image:url(\'${contextPath}/motel/image?fileName='+data.board.boardList[i].FILENAME+'\');"></div>');
								$(itemCover).append('<div class="cover-profile-image" id="profile'+n+'"> </div>');
								var profile="#profile"+n;
								var $pop=$('<a href="#none" data-toggle="popover" data-html="true" data-content="프로필 보기<br>친구 신청<br>대화 하기" data-trigger="focus"><img src="${contextPath}/img/people.jpg" class="img-profile"></a>');
								$(profile).append($pop);
								$pop.popover();
								 
								$(itemCover).append('<h4 class="profile-name">'+data.board.boardList[i].NAME+'</h4>');
								$(itemCover).append('<p class="profile-city">인원 1명, 침대 1개, 욕실 1개</p>');
								$(itemCover).append('<p class="profile-city">226,944/박</p>');
								$(itemCover).append('<p class="profile-city">총 요금 : 2,269,440</p>');
								$(itemCover).append('<h4 class="profile-name">'+data.board.boardList[i].TITLE+'</h4>');
								

								n++;
								cssCount++;
						
								if(i>=0&&i<=2){
									heightNum=1;
								}
								if(i>2&&i<=5){
									heightNum=2;
								}
								if(i>5&&i<=8){
									heightNum=3;
								}
								
								if(i==data.board.boardList.length-1){
									
									if(heightNum==1){
										conHeight=conHeight+$("#col0").height();
										$("#con").css("height",conHeight+"px");
									}
									if(heightNum==2){
										conHeight=conHeight+$("#col0").height()*2;
										$("#con").css("height",conHeight+"px");
									}
									if(heightNum==3){
										conHeight=conHeight+$("#col0").height()*3;
										alert(conHeight);
										$("#con").css("height",conHeight+"px");										
									}
									
									heightNum=0;
									
								}
							} else {

								$("#con").append('<div class="col-md-4 col-sm-6" id="col'+n+'">');
								var col="#col"+n;
								$(col).append('<div class="item-cover item-cover-sm" id="itemCover'+n+'">');
								var itemCover = "#itemCover"+n;
								$(itemCover).append('<div class="cover-background" style="background-image:url(${contextPath}/img/no.png);"></div>');
								$(itemCover).append('<div class="cover-profile-image" id="profile'+n+'"> </div>');
								var profile="#profile"+n;
								var $pop=$('<a href="#none" data-toggle="popover" data-html="true" data-content="프로필 보기<br>친구 신청<br>대화 하기" data-trigger="focus"><img src="${contextPath}/img/people.jpg" class="img-profile"></a>');
								$(profile).append($pop);
								$pop.popover();
								$(itemCover).append('<h4 class="profile-name">'+data.board.boardList[i].NAME+'</h4>');
								$(itemCover).append('<p class="profile-city">인원 1명, 침대 1개, 욕실 1개</p>');
								$(itemCover).append('<p class="profile-city">226,944/박</p>');
								$(itemCover).append('<p class="profile-city">총 요금 : 2,269,440</p>');
								$(itemCover).append('<h4 class="profile-name">'+data.board.boardList[i].TITLE+'</h4>');
								

								n++;
								cssCount++;
								
								if(i>=0&&i<=2){
									heightNum=1;									
								}
								if(i>2&&i<=5){
									heightNum=2;									
								}
								if(i>5&&i<=8){
									heightNum=3;									
								}
								
								if(i==data.board.boardList.length-1){
									
									
									if(heightNum==1){
										conHeight=conHeight+$("#col0").height();
										
										$("#con").css("height",conHeight+"px");
									}
									if(heightNum==2){
										conHeight=conHeight+$("#col0").height()*2;
										
										$("#con").css("height",conHeight+"px");
									}
									if(heightNum==3){
										conHeight=conHeight+$("#col0").height()*3;
										
										$("#con").css("height",conHeight+"px");
									}
									heightNum=0;
									
								}
							} */

						}
					}
				});
	};
</script>
<style type="text/css">
.popover-content{
	width: 150px;
}
#con {
	
	
	margin: 0,auto;
}
#searchBox{
	
	width:90%;
	margin:auto;
}

#backimg {
	background-repeat: no-repeat;
	background-position: left;
	background-size: cover;

	z-index: 1;
}

.userimg {
	background-repeat: no-repeat;
	background-position: bottom;
	background-size: cover;
	border-radius: 50%;
	

}

a:link{
	text-decoration: none;
}
a:visited{
	text-decoration: none;
}
a:hover{
	text-decoration: none;
}
.modal-open{
	padding-right:0;
}
/* #myModal2{width: 150px;} */

/* #modal-content{width: 150px;}
#modal-body{width: 150px;} */
body { padding-right: 0 !important }

input::-webkit-input-placeholder{
	text-align: center;
}
input{
	text-align: center;
}
</style>
</head>
<body>


	
	<div class="container">
	
		<!-- 서치바 -->
		<div class="row" style="margin-left: 18%; margin-top:2%;">
			<div id="custom-search-input">
				<div class="input-group col-md-12">
					<input type="text" class="  search-query form-control"
						placeholder="Search" style="width: 500px;" /> 
						<span class="input-group-btn" style="float: left;">
						<button class="btn btn-primary" type="button">
							<span class=" glyphicon glyphicon-search"></span>
						</button>
					</span>
				</div>
			</div>
		</div>
		<br>
		<!-- 서치바 End -->
		<br>
		<!-- 검색조건 -->
		<div id="searchBox" style="width: 100%;">
		<div >
			<!-- 날짜 -->
			
			<input type="text" id="datePickerCheckIn" placeholder="Check In" style="top: 50%;">
			~ <input type="text" placeholder="Check Out" id="datePickerCheckOut">
			
			<!-- 인원 -->
			<p style="display: inline-block; margin-left: 30px;">인원</p>
			<button id="plus" class="fa fa-plus-circle fa-lg" style="outline: none; border: 0; background-color: white; color: #428bca;"></button>
			<label id="people">0</label>
			<!-- label값 변경할것 -->
			<button id="minus" class="fa fa-minus-circle fa-lg" style="outline: none; border: 0; background-color: white; color: #428bca;"></button>
			<!-- 숙박 종류 -->
			<select class="form-control" id="sel1"
				style="width: 150px; margin-left:30px; display: inline-block;">
				<option value="0">숙소 종류</option>
				<option value="1">아파트</option>
				<option value="2">주택</option>
				<option value="3">빌라</option>
			</select>
			<!-- 숙박 유형 -->
			<select class="form-control" id="sel1"
				style="width: 150px; margin-left:30px; display: inline-block;">
				<option value="0">숙소 유형</option>
				<option value="1">집 전체</option>
				<option value="2">방 하나</option>
			</select> 
			<input type="text" placeholder="금액" data-toggle="modal" class="price" data-target="#myModal"  style="margin-left: 30px;">
		
			<!-- <input type="text" placeholder="금액" data-toggle="modal" data-target="#myModal"  style="margin-left: 30px; width: 100px;"> -->
			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title" style="text-align: center;">금액을 입력해 주세요</h4>
						</div>
						<div class="modal-body">
							<form action="">
							<input type="text" class="price1" name="price1" style="display:inline; width: 150px;"> <b>~</b> <input name="price2" class="price2"type="text" style="display: inline; width: 150px;">
							<!-- <input type="button" name="btnPrice" value="확인" class="btn btn-default" style="margin-left:300px;"> -->
							<button type="button" name="btnPrice" class="btn btn-default" data-dismiss="modal" style="margin-left:300px; margin-top: 10px;">확인</button>
							</form>
						</div>
						
					</div>
				</div>
			</div>
		</div>
		</div>
	</div>
	<br>

		<!-- ajax로 화면 그리기 위한 박스 -->
		<div class="container" id="con" align="center">
		
		</div>
</body>
</html>