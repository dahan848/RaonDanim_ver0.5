<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.user_num" var="user_num"/>
</sec:authorize>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">


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


<!-- 달력 -->
<%-- <link href="${contextPath }/css/bootstrap-datepicker2.css" rel="stylesheet">--%>
<link href="${contextPath }/css/bootstrap-datetimepicker.css" rel="stylesheet">
<script src="${contextPath }/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${contextPath }/js/bootstrap-datetimepicker.ko.js" type="text/javascript"></script>
<!-- 달력 END -->

<script type="text/javascript">
	var count = 1;
	var n = 0;
	var cssCount = 0;
	var category_value="";
	var type_value = "";
	var city = "${city}";
	var motel_people = "${adults}";
	var startDate = "${startDate}";
	var endDate = "${endDate}";
	var motel_price1=0;
	var motel_price2=0;
	var date = "${date}";
	var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
	var currMonth = currDay * 30;// 월 만듬
	var currYear = currMonth * 12; // 년 만듬
	
	$("#myModal2").modal({
		keyboard:true
	})
	
	 $(function() {
		 
		 //체크인날짜 시간 자르고 input에 넣기
		 $("input[name=startDate]").on("change",function(){
			 var dateFormat = $("input[name=startDate]").val();
			 var day = dateFormat.substring(0,10);
			 $("input[name=startDate]").val(day);
				
		 })
		 //체크아웃날짜 시간 자르고 input에 넣기
		 $("input[name=endDate]").on("change",function(){
			 var dateFormat1 = $("input[name=endDate]").val();
			 var day1 = dateFormat1.substring(0,10);
			 $("input[name=endDate]").val(day1);
		 })
		 //도시 검색 버튼 클릭시 div box 내용을 비우고 새로운 createList 함수 호출
		 $("#btnCity").on("click",function(){
			 	city=""
				 city = $("input[name=city]").val();
				 $("#con").empty();
				 count=1;
				var placeholder = $("input[name=city]");
				placeholder.attr("placeholder","");
				
				placeholder.attr("placeholder",city);
				alert(placeholder.attr("placeholder"));
				placeholder.val("");
				 createList(city);
				 count++;
		 })
		 
		
		 //숙박 카테고리 변경시 div box 내용을 비우고 새로 createList 함수 호출
		 $("#motel_category").on("change",function(){
			 var motel_category = $("#motel_category");
			 category_value="";
			 category_value = motel_category.val();
			 
			 $("#con").empty();
			 count=1;
			 createList(category_value);
			 count++;
		 })
		 //숙박 타입 변경시 div box 내용을 비우고 새로 createList 함수 호출
		 $("#motel_type").on("change",function(){
			 var motel_type = $("#motel_type");
			 type_value="";
			 type_value = motel_type.val();
			 
			$("#con").empty();
			 count=1;
			 createList(type_value);
			 count++;
		 })
		 
		var people = $("#people").text();
		
		
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
		count++;

		
		$(".btn-default").on("click", function() {
			/* alert("123");
			var price1 = $(".price1").val();
			alert(price1); */
			var price = $('.price1').val() +"~"+ $('.price2').val();
			$(".price").val(price);
			var tmpPrice = price.split('~');
			
			motel_price1 = tmpPrice[0];
			motel_price2 = tmpPrice[1];
			
			$("#con").empty();
			count=1;
			 createList(motel_price1, motel_price2);
			 count++;
			
		})
		
		
		
		$('[data-toggle="popover"]').popover();
		/* $(".form_date").datepicker({
					language:"ko",
					dateFormat:'yy-mm-dd',
					minDate:0,
					onSelect:function(){
						alert("1234");
					}

				}); */
		
		/* $(".form_date").datetimepicker({
			minDate:0,
			dateFormat:'yy-mm-dd',
			language:  'ko',
			autoclose: 1,
			todayHighlight: 1,
			onSelect:function(){
				alert("1234");
			}

		}); */
		
		$('#datePickerCheckIn').datetimepicker({
			language:  'ko',
			minDate: 0,
	        weekStart: 1,
	       
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0,
			onSelect:function(){
				
			}
	    });
		
		
		$("#datePickerCheckOut").datetimepicker({
			language:  'ko',
			minDate: 0,
	        weekStart: 1,
	        
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0,
			onSelect:function(){
				
			}
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
				
				$("#con").empty();
				motel_people="";
				motel_people=$("#people").text();
				 count=1;
				 createList(motel_people);
				 count++;
			}
			
		})
		$("#minus").on("click", function() {
			if($("#people").text()<=1){
				swal({
					text:"숙박 인원을 1명 이상 설정해 주세요",
					icon:"warning",
					buttons:[false,"확인"]
				})
			}else{
				people--;
				$("#people").text(people);
				$("#con").empty();
				motel_people="";
				motel_people=$("#people").text();
				 count=1;
				 createList(motel_people);
				 count++;
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
	
	
	function startDateCheck(){
		if($("input[name=startDate]").val()){
			//strDate1 - strDate2 날짜 연산 
			var strDate2 = endDate
			startDate="";
			startDate = $("input[name=startDate]").val()
			var strDate1 = startDate
			var arr1 = strDate1.split('-');
			var arr2 = strDate2.split('-');
			var dat1 = new Date(arr1[0], arr1[1], arr1[2]);
			var dat2 = new Date(arr2[0], arr2[1], arr2[2]);
			var diff = dat2 - dat1;
			date = parseInt(diff/currDay)+1;

			
			$("#con").empty();
			count = 1;
			createList(startDate);
			count++;
		}
	}
	function endDateCheck(){
		if($("input[name=endDate]").val()){
			//strDate1 - strDate2 날짜 연산 
			var strDate1 = startDate
			endDate="";
			endDate = $("input[name=endDate]").val()
			var strDate2 = endDate
			var arr1 = strDate1.split('-');
			var arr2 = strDate2.split('-');
			var dat1 = new Date(arr1[0], arr1[1], arr1[2]);
			var dat2 = new Date(arr2[0], arr2[1], arr2[2]);
			var diff = dat2 - dat1;
			date = parseInt(diff/currDay)+1;

			$("#con").empty();
			count = 1;
			createList(endDate);			
			count++;

		}
	}
	
	function createList() {
		//회원 목록을 그려주는 역할을 하는 함수
		//회원 목록을 그리기 위해서는
		//회원 목록을 서버에 요청해서 받아와야 한다 : ajax
		
		var conHeight = $("#con").height();
		var heightNum=0;
		var naver = "http://www.naver.com";

		
		$.ajax({
					url : "${contextPath}/motel/list?page=" + count+"&city="+city+"&motel_people="+motel_people+"&startDate="+startDate+"&endDate="+endDate+"&motel_type="+type_value+"&motel_category="+category_value+"&motel_price1="+motel_price1+"&motel_price2="+motel_price2,
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
							$(itemCover).append('<a href="view?num='+data.board.boardList[i].MOTEL_NUM+'&host='+data.board.boardList[i].MOTEL_USER_NUM+'&checkIn='+startDate+'&checkOut='+endDate+'&tripDate='+date+'&people='+motel_people+'"><div class="cover-background" style="background-image:url(${contextPath}/img/house1.jpg);"></div></a>');
							$(itemCover).append('<div class="cover-profile-image" id="profile'+n+'"> </div>');
							var profile="#profile"+n;
							var user_numTest1 = "${user_num}";
							var user_numTest2 = data.board.boardList[i].MOTEL_USER_NUM;
							if(user_numTest1 != user_numTest2){
								var $pop=$('<a href="#none" data-toggle="popover" data-html="true" data-content="<a href='+naver+'>프로필 보기</a><br>친구 신청<br>대화 하기" data-trigger="focus"><img src="${contextPath}/img/duny.jpg" class="img-profile"></a>');
								$(profile).append($pop);
								$pop.popover();
							}else{
								var $pop=$('<a href="${contextPath}/accounts/profile?user='+user_numTest2+'"><img src="${contextPath}/img/duny.jpg" class="img-profile"></a>');
								$(profile).append($pop);
							}
							
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
								console.log("1번");
							}
							if(i>2&&i<=5){
								heightNum=2;
								console.log("2번");
							}
							if(i>5&&i<=8){
								heightNum=3;	
								console.log("3번");
							}
							boxNum = heightNum;
							console.log("4번");
							
							if(i==data.board.boardList.length-1){
								
								console.log("5번");
								
								if(heightNum==1){
									conHeight=390;
									$("#con").css("height",conHeight+"px");
								}
								if(heightNum==2){
									conHeight=390*2;
									$("#con").css("height",conHeight+"px");								
								}
								if(heightNum==3){									
									conHeight=390*3;
									$("#con").css("height",conHeight+"px");								
								}
								heightNum=0;
								console.log(conHeight);
								
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
<body id="body">


	
	<div class="container">
	
		<!-- 서치바 -->
		<div class="row" style="margin-left: 18%; margin-top:2%;">
			<div id="custom-search-input">
				<div class="input-group col-md-12">
					<input type="text" class="  search-query form-control" name="city"
						placeholder="${city }" style="width: 500px;" /> 
						<span class="input-group-btn" style="float: left;">
						<button class="btn btn-primary" type="button" id="btnCity">
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
			
			<!-- <div class="form-group">
                
                <div class="input-group date form_date col-md-5" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
				<input type="hidden" id="dtp_input2" value="" /><br/>
            </div> -->
			
			
			
			<input type="text" class="date form_date" id="datePickerCheckIn" name="startDate" readonly="readonly" placeholder="Check In" onchange="startDateCheck()" value="${startDate }" style="top: 50%;">
			~ <input type="text" class="date form_date" placeholder="Check Out" readonly="readonly" name="endDate" value="${endDate }" onchange="endDateCheck()" id="datePickerCheckOut">
			
			
			
                
			<!-- 인원 -->
			<p style="display: inline-block; margin-left: 30px;">인원</p>
			<button id="plus" class="fa fa-plus-circle fa-lg" style="outline: none; border: 0; background-color: white; color: #428bca;"></button>
			<label id="people">${adults}</label>
			<!-- label값 변경할것 -->
			<button id="minus" class="fa fa-minus-circle fa-lg" style="outline: none; border: 0; background-color: white; color: #428bca;"></button>
			<!-- 숙박 종류 -->
			<select class="form-control" id="motel_type" name="motel_type"
				style="width: 150px; margin-left:30px; display: inline-block;">
				<option value="0">숙소 종류</option>
				<option value="1">아파트</option>
				<option value="2">주택</option>
				<option value="3">빌라</option>
			</select>
			<!-- 숙박 유형 -->
			<select class="form-control" id="motel_category" name="motel_category"
				style="width: 150px; margin-left:30px; display: inline-block;">
				<option value="0">숙소 유형</option>
				<option value="1">집 전체</option>
				<option value="2">방 하나</option>
			</select> 
			<input type="text" placeholder="금액" readonly="readonly" data-toggle="modal" class="price" data-target="#myModal"  style="margin-left: 30px;">
		
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