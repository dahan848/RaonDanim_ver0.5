<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%	request.setAttribute("contextPath", request.getContextPath()); %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>


<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.user_num" var="user_num"/>
	<sec:authentication property="principal.user_profile_pic" var="profile_pic"/>
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	td{
		text-align: center;
	}
	.btnPage{
		outline: none; 
  		border: 0; 
  		background-color: transparent ;
	}
</style>
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/accounts/accounts-navbar.jsp"></jsp:include>
	<script src="${contextPath}/js/image-picker.min.js" ></script>
	<script src="${contextPath}/js/gallery-image.js" ></script>
	
	<!-- 인클루드 심플 헤더 END -->
<div class="container">
  <ul class="nav nav-tabs">
<!--     <li class="active"><a href="#">Home</a></li> -->
    <li id="trip_active"><a href="#">여행 활동</a></li>
    
    <li id="tripReview_review"><a href="#">여행 후기</a></li>
<!--     <li id="payment_board"><a href="#">결제 내역</a></li> -->
  </ul>
<!--   <ul id="tripReview" class="nav nav-tabs" style="display: none;"> -->
<!--     	<li id="tripReview_review"><a href="#">여행 후기</a></li> -->
<!--     	<li id="tripReview_localReview"><a href="#">현지인 동행 후기</a></li> -->
<!--     </ul> -->
</div>


<script type="text/javascript">



	$(function(){
		var num = "${user_num}";
		var page = 1;
		var n = 0;
		var replyN = 0;
		var replyPage = 1;
		
		var tripReview_review_Page = 1;
		var tripReview_review_Num = 0;
		
		var tripReview_review_reply_Page = 1;
		var tripReview_review_reply_Num = 0;
		
		var tripReview_localReview_Page = 1;
		var tripReview_localReview_Num = 0;
		
		var payment_host_Page = 1;
		var payment_host_Num = 0;
		
		var payment_pay_Page = 1;
		var payment_pay_Num = 0;
		
// 		var tripReview_localReview_reply_Page = 1;
// 		var tripReview_localReview_reply_Num = 0;
		//날짜 포멧 함수
		Date.prototype.format = function (f) {
		    if (!this.valueOf()) return " ";
		    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
		    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
		    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
		    var d = this;
		    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {
		        switch ($1) {
		            case "yyyy": return d.getFullYear(); // 년 (4자리)
		            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
		            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
		            case "dd": return d.getDate().zf(2); // 일 (2자리)
		            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
		            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)
		            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
		            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)
		            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
		            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
		            case "mm": return d.getMinutes().zf(2); // 분 (2자리)
		            case "ss": return d.getSeconds().zf(2); // 초 (2자리)
		            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
		            default: return $1;
		        }
		    });
		};
		String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
		String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
		Number.prototype.zf = function (len) { return this.toString().zf(len); };
		//날짜 포멧 함수 end
		
		//여행탭 게시글 불러오는 ajax
		function trip_list(page){
			var tNums = new Array();
			var tmpNums
			var arrayCount = 0;
		$.ajax({
			url : "${contextPath}/accounts/trip_list",
			data : {"${_csrf.parameterName}":"${_csrf.token}","num":num,"page":page},
			type : "post",
			dataType : "json",
			error : function(){
				alert("실패")
			},
			success : function(data){
				$("#tbody_trip").empty();
				for(var i in data.board.boardList){
					$("#tbody_trip").append('<tr id="row'+n+'">');
					var row = "#row"+n;
					$(row).append('<input type="checkbox" class="tripNumber" name="tripNum" value="'+data.board.boardList[i].TRIP_BOARD_KEY+'" style="margin-top:30%;">');
					
// 					$(row).append('<td>ㅁ</td>');
					$(row).append('<td>'+data.board.boardList[i].TRIP_BOARD_TITLE+'</td>');
					function formatDate(date) {
						  return date.getFullYear() + '년 ' + 
						    (date.getMonth() + 1) + '월 ' + 
						    date.getDate() + '일 ';
						}
					var tmpDate = new Date(data.board.boardList[i].TRIP_WRITEDATE).format("yyyy-MM-dd");
					
					$(row).append('<td>'+tmpDate+'</td>');
					$(row).append('<td>'+data.board.boardList[i].TRIP_BOARD_READCOUNT+'</td>');
					$("#tbody_trip").append('</tr>');
					n++;
				}
				
				
				//페이징처리
				$("#tbody_trip").append('<tr id="tripPage">');
				$("#tripPage").append('<td  colspan="4" ><ul id="trip_Page" class="pagination"></td>');
				$("#trip_Page").append('<li><a><input type="button" class="btnPage"id="TripFirstPage" value="처음"></a></li>');
				var startPage = data.board.startPage
				var endPage = data.board.endPage;
				var tmpTotalPage = data.board.totalPage;
				for(var i=startPage; i<=endPage; i++){
					//총 페이지 갯수와 같거나 작을때 반복해서 페이징 버튼 만들기
					if(tmpTotalPage>=i){
						$("#trip_Page").append('<li><a><input type="button" class="btnPage"id="tPage'+i+'" value="'+i+'"></a></li>');
						//페이지 버튼의 value와 현재 페이지가 같을 경우 해당 버튼을 비활성화 하고 색상을 blue로 변경
						if($("#tPage"+i).attr("value") == page){
							$("#tPage"+i).attr('disabled', true);
							$("#tPage"+i).css("color","blue")
						}
						//페이지 버튼 클릭시 클릭된 버튼의 value값을 page에 넣고 ajax 재호출
						$("#tPage"+i).on("click",function(){
							page = $(this).attr("value");
							trip_list(page);
						})
						
					}
					
				}
				
				$("input[name=tripNum]").on("click",function(){
					if(this.checked){
						if(tNums.length == 0){
							tmpNums = $(this).val();
							tNums[0] = tmpNums;
							arrayCount ++;
						}else{
							tmpNums = $(this).val();
							tNums[arrayCount] = tmpNums;
							arrayCount ++;
						}
						
					}else{
						for(var i in tNums){
							if(tNums[i] == $(this).val()){
								tNums.splice(tNums.indexOf($(this).val()),1);
								
							}
						}
					}
				})
				
				$("#trip_Page").append('<li><a><input type="button" class="btnPage"id="TripNextPage" value="다음"></a></li>');
				$("#trip_Page").append('<input type="hidden" class="btnPage"id="TripNextPageValue" value="'+endPage+'">');
				$("#trip_Page").append('<li><a><input type="button" class="btnPage"id="TripLastPage" value="마지막"></a></li>');
				$("#trip_Page").append('<input type="hidden" class="btnPage"id="TripLastPageValue" value="'+data.board.totalPage+'"></li>');
				$("#tripPage").append('</ul>');
				$("#tbody_trip").append('</tr>');
				
				
				
				
				
				//마지막 버튼 클릭시 마지막 버튼의 value값을 page로 넣어 ajax 재호출
				$("#TripLastPage").on("click",function(){
					
					page = $("#TripLastPageValue").attr("value");
					trip_list(page);
				})
				//처음 버튼 클릭시 page에 1을 넣고 ajax 재호출
						$("#TripFirstPage").on("click",function(){
							page = 1;
							trip_list(page);
							
						})
				//다음버튼 클릭시 다음버튼의 value를 1 증가시켜 page에 넣고 ajax 재호출
				$("#TripNextPage").on("click",function(){
					page = $("#TripNextPageValue").attr("value");
					page++;
					trip_list(page);
				})
			
				//마지막 버튼의 값이 토탈 페이지 값과 같을 경우 다음버튼 클릭 비활성화
				if($("#tPage"+tmpTotalPage).attr('value')==tmpTotalPage){
					$("#TripNextPage").attr('disabled', true);
				}
				
				
				
				
				$("#tbody_trip").append('<tr id="btnBoardDelete">');
				$("#btnBoardDelete").append('<td id="btnBoardDeletetd" colspan=4>');
				$("#btnBoardDeletetd").append('<div style="margin-left: 95%"><input type="button"  id="btnBoardSubmit" class="btn btn-primary" value="삭제"></div>');
				$("#btnBoardDelete").append('</td>');
				$("#tbody_trip").append('</tr>');
				
				
				
				$("#btnBoardSubmit").on("click",function(){
					
					var pUser_num = ${user_num}
					var data = {"${_csrf.parameterName}":"${_csrf.token}","user_num":pUser_num,"tNums":tNums}
					swal({					
						text:"게시글을 삭제 하시겠습니까?",					
						icon:"info",		
						buttons:[false,"확인"]
					}).then(function(isConfirm){
						$.ajax({
							url:"${contextPath}/accounts/tripDelete",
							data:data,
							type:"post",
//								dataType:"json",
							error:function(data){
								
								alert("삭제실패")
							},
							success:function(data){
								swal({
									text:"댓글이 삭제되었습니다.",
									icon:"success",
									buttons:[false,"확인"]
								}).then(function(isConfirm){
									trip_list(1);
								})
								
								
								
								
							}
						})
					})
					return false;
				})
			}
		})
		}
		
		
		
		
		
		
		
		function trip_reply_list(replyPage){
			var rNums = new Array();
			var tmpNums
			var arrayCount = 0;
			$.ajax({
				url : "${contextPath}/accounts/trip_reply_list",
				data : {"${_csrf.parameterName}":"${_csrf.token}","num":num,"page":replyPage},
				type : "post",
				dataType : "json",
				error : function(){
					alert("실패")
				},
				success : function(data){
					$("#tbody_trip_reply").empty();
					for(var i in data.board.boardList){
						$("#tbody_trip_reply").append('<tr id="reply_row'+replyN+'">');
						var reply_row = "#reply_row"+replyN;
						//myForm에 append 시켜야 하는데 안붙는다
						$(reply_row).append('<input type="checkbox" class="replyNumber" name="rNum" value="'+data.board.boardList[i].TRIP_REPLY_KEY+'" style="margin-top:30%;">');
						
						$(reply_row).append('<input type="hidden" name="tNum" value="'+data.board.boardList[i].TRIP_BOARD_KEY+'">');

						$(reply_row).append('<td>'+data.board.boardList[i].TRIP_REPLY_CONTENT+'</td>');
						
						function formatDate(date) {
							  return date.getFullYear() + '년 ' + 
							    (date.getMonth() + 1) + '월 ' + 
							    date.getDate() + '일 ';
							}
						var tmpDate = new Date(data.board.boardList[i].TRIP_REPLY_WRITEDATE).format("yyyy-MM-dd");
						
						$(reply_row).append('<td>'+tmpDate+'</td>');
						$(reply_row).append('<td style="display:none;"><input type="text" id="reply_key'+n+'" name="reply_key'+data.board.boardList[i].TRIP_REPLY_KEY+'" value="'+data.board.boardList[i].TRIP_REPLY_KEY+'"></td>');
						$(reply_row).append('<td style="display:none;"><input type="text" id="board_key'+n+'" name="board_key'+data.board.boardList[i].TRIP_BOARD_KEY+'" value="'+data.board.boardList[i].TRIP_BOARD_KEY+'"></td>');
						var checkBoard = data.board.boardList[i].TRIP_BOARD_ST;


						$(reply_row).append('<td><span></span></td>');
						$("#trip_reply_list").append('</tr>');
						
						
						replyN++;
					}
					
					//페이징처리
					$("#tbody_trip_reply").append('<tr id="replyPage">');
					$("#replyPage").append('<td  colspan="4" ><ul id="reply_Page" class="pagination"></td>');
					$("#reply_Page").append('<li><a><input type="button" class="btnPage"id="FirstPage" value="처음"></a></li>');
					$("#reply_Page").append('<input type="hidden" class="btnPage"id="FirstPageValue" value="1">');
					var startPage = data.board.startPage
					var endPage = data.board.endPage;
					var tmpTotalPage = data.board.totalPage;
					for(var i=startPage; i<=endPage; i++){
						//총 페이지 갯수와 같거나 작을때 반복해서 페이징 버튼 만들기
						if(tmpTotalPage>=i){
							$("#reply_Page").append('<li><a><input type="button" class="btnPage"id="rPage'+i+'" value="'+i+'"></a></li>');
							//페이지 버튼의 value와 현재 페이지가 같을 경우 해당 버튼을 비활성화 하고 색상을 blue로 변경
							if($("#rPage"+i).attr("value") == replyPage){
								
								$("#rPage"+i).attr('disabled', true);
								$("#rPage"+i).css("color","blue")
							}
							
							//페이지 버튼 클릭시 클릭된 버튼의 value값을 page에 넣고 ajax 재호출
							$("#rPage"+i).on("click",function(){
								replyPage = $(this).attr("value");
								$("#trip_reply_list").empty();
								trip_reply_list(replyPage);
								
							})
							
						}
						
					}
					
					$("input[name=rNum]").on("click",function(){
						if(this.checked){
							if(rNums.length == 0){
								tmpNums = $(this).val();
								rNums[0] = tmpNums;
								arrayCount ++;
							}else{
								tmpNums = $(this).val();
								rNums[arrayCount] = tmpNums;
								arrayCount ++;
							}
							
						}else{
							for(var i in rNums){
								if(rNums[i] == $(this).val()){
									rNums.splice(rNums.indexOf($(this).val()),1);
									
								}
							}
						}
					})
					
					$("#reply_Page").append('<input type="hidden" class="btnPage"id="NextPageValue" value="'+endPage+'">');
					$("#reply_Page").append('<li><a><input type="button" class="btnPage"id="NextPage" value="다음"></a></li>');
					$("#reply_Page").append('<input type="hidden" class="btnPage"id="LastPageValue" value="'+data.board.totalPage+'">');
					$("#reply_Page").append('<li><a><input type="button" class="btnPage"id="LastPage" value="마지막"></a></li>');
					$("#replyPage").append('</ul>');
					$("#tbody_trip_reply").append('</tr>');

					//마지막 버튼 클릭시 마지막 버튼의 value값을 page로 넣어 ajax 재호출
					$("#LastPage").on("click",function(){
						
						replyPage = $("#LastPageValue").attr("value");
						trip_reply_list(replyPage);
						
					})
					
					//처음 버튼 클릭시 page에 1을 넣고 ajax 재호출
							$("#FirstPage").on("click",function(){
								trip_reply_list(1);
								
							})
					
					//다음버튼 클릭시 다음버튼의 value를 1 증가시켜 page에 넣고 ajax 재호출
					$("#NextPage").on("click",function(){
						replyPage = $("#NextPageValue").attr("value");
						replyPage++;
						trip_reply_list(replyPage);
						
					})
					
					//마지막 버튼의 값이 토탈 페이지 값과 같을 경우 다음버튼 클릭 비활성화
					if($("#rPage"+tmpTotalPage).attr('value')==tmpTotalPage){
						$("#NextPage").attr('disabled', true);
					}
					$("#tbody_trip_reply").append('<tr id="btnReplyDelete">');
					$("#btnReplyDelete").append('<td id="btnReplyDeletetd" colspan=4>');
					$("#btnReplyDeletetd").append('<div style="margin-left: 95%"><input type="button"  id="btnReplySubmit" class="btn btn-primary" value="삭제"></div>');
					$("#btnReplyDelete").append('</td>');
					$("#tbody_trip_reply").append('</tr>');
					
					


					

					

					$("#btnReplySubmit").on("click",function(){
						var pUser_num = ${user_num}
						var data = {"${_csrf.parameterName}":"${_csrf.token}","user_num":pUser_num,"rNums":rNums}
						swal({					
							text:"댓글을 삭제 하시겠습니까?",					
							icon:"info",		
							buttons:[false,"확인"]
						}).then(function(isConfirm){
							$.ajax({
								url:"${contextPath}/accounts/replyDelete",
								data:data,
								type:"post",
// 								dataType:"json",
								error:function(data){
									
									alert("삭제실패")
								},
								success:function(data){
									swal({
										text:"댓글이 삭제되었습니다.",
										icon:"success",
										buttons:[false,"확인"]
									}).then(function(isConfirm){
										trip_reply_list(1);
									})
									
									
									
									
								}
							})
						})
						return false;
					})
					
				}
			})
			}
		
		//여행후기 탭 여행후기 리스트 불러오는 ajax
		function tripReview_review(tripReview_review_Page){
			
// 			var tripReview_review_Page = 1;
// 			var tripReview_review_Num = 0;
			var tNums = new Array();
			var tmpNums
			var arrayCount = 0;
		$.ajax({
			url : "${contextPath}/accounts/tripReview_review",
			data : {"${_csrf.parameterName}":"${_csrf.token}","num":num,"page":tripReview_review_Page},
			type : "post",
			dataType : "json",
			error : function(){
				alert("실패")
			},
			success : function(data){
				$("#tbody_trip").empty();
				for(var i in data.board.boardList){
					$("#tbody_trip").append('<tr id="row'+tripReview_review_Num+'">');
					var row = "#row"+tripReview_review_Num;
					$(row).append('<input type="checkbox" class="tripNumber" name="tripNum" value="'+data.board.boardList[i].REVIEW_NUM+'" style="margin-top:30%;">');
					
// 					$(row).append('<td>ㅁ</td>');
					$(row).append('<td>'+data.board.boardList[i].REV_TITLE+'</td>');
					function formatDate(date) {
						  return date.getFullYear() + '년 ' + 
						    (date.getMonth() + 1) + '월 ' + 
						    date.getDate() + '일 ';
						}
					var tmpDate = new Date(data.board.boardList[i].RE_REG_DATE).format("yyyy-MM-dd");
					
					$(row).append('<td>'+tmpDate+'</td>');
					$(row).append('<td>'+data.board.boardList[i].RE_COUNT+'</td>');
					$("#tbody_trip").append('</tr>');
					tripReview_review_Num++;
				}
				
				
				//페이징처리
				$("#tbody_trip").append('<tr id="tripPage">');
				$("#tripPage").append('<td  colspan="4" ><ul id="trip_Page" class="pagination"></td>');
				$("#trip_Page").append('<li><a><input type="button" class="btnPage"id="TripFirstPage" value="처음"></a></li>');
				var startPage = data.board.startPage
				var endPage = data.board.endPage;
				var tmpTotalPage = data.board.totalPage;
				for(var i=startPage; i<=endPage; i++){
					//총 페이지 갯수와 같거나 작을때 반복해서 페이징 버튼 만들기
					if(tmpTotalPage>=i){
						$("#trip_Page").append('<li><a><input type="button" class="btnPage"id="tPage'+i+'" value="'+i+'"></a></li>');
						//페이지 버튼의 value와 현재 페이지가 같을 경우 해당 버튼을 비활성화 하고 색상을 blue로 변경
						if($("#tPage"+i).attr("value") == tripReview_review_Page){
							$("#tPage"+i).attr('disabled', true);
							$("#tPage"+i).css("color","blue")
						}
						//페이지 버튼 클릭시 클릭된 버튼의 value값을 page에 넣고 ajax 재호출
						$("#tPage"+i).on("click",function(){
							tripReview_review_Page = $(this).attr("value");
							tripReview_review(tripReview_review_Page);
						})
						
					}
					
				}
				
				$("input[name=tripNum]").on("click",function(){
					if(this.checked){
						if(tNums.length == 0){
							tmpNums = $(this).val();
							tNums[0] = tmpNums;
							arrayCount ++;
						}else{
							tmpNums = $(this).val();
							tNums[arrayCount] = tmpNums;
							arrayCount ++;
						}
						
					}else{
						for(var i in tNums){
							if(tNums[i] == $(this).val()){
								tNums.splice(tNums.indexOf($(this).val()),1);
								
							}
						}
					}
				})
				
				$("#trip_Page").append('<li><a><input type="button" class="btnPage"id="TripNextPage" value="다음"></a></li>');
				$("#trip_Page").append('<input type="hidden" class="btnPage"id="TripNextPageValue" value="'+endPage+'">');
				$("#trip_Page").append('<li><a><input type="button" class="btnPage"id="TripLastPage" value="마지막"></a></li>');
				$("#trip_Page").append('<input type="hidden" class="btnPage"id="TripLastPageValue" value="'+data.board.totalPage+'"></li>');
				$("#tripPage").append('</ul>');
				$("#tbody_trip").append('</tr>');
				
				
				
				
				
				//마지막 버튼 클릭시 마지막 버튼의 value값을 page로 넣어 ajax 재호출
				$("#TripLastPage").on("click",function(){
					
					tripReview_review_Page = $("#TripLastPageValue").attr("value");
					tripReview_review(tripReview_review_Page);
				})
				//처음 버튼 클릭시 page에 1을 넣고 ajax 재호출
						$("#TripFirstPage").on("click",function(){
							tripReview_review_Page = 1;
							tripReview_review(tripReview_review_Page);
							
						})
				//다음버튼 클릭시 다음버튼의 value를 1 증가시켜 page에 넣고 ajax 재호출
				$("#TripNextPage").on("click",function(){
					tripReview_review_Page = $("#TripNextPageValue").attr("value");
					tripReview_review_Page++;
					tripReview_review(tripReview_review_Page);
				})
			
				//마지막 버튼의 값이 토탈 페이지 값과 같을 경우 다음버튼 클릭 비활성화
				if($("#tPage"+tmpTotalPage).attr('value')==tmpTotalPage){
					$("#TripNextPage").attr('disabled', true);
				}
				
				
				
				
				$("#tbody_trip").append('<tr id="btnBoardDelete">');
				$("#btnBoardDelete").append('<td id="btnBoardDeletetd" colspan=4>');
				$("#btnBoardDeletetd").append('<div style="margin-left: 95%"><input type="button"  id="btnBoardSubmit" class="btn btn-primary" value="삭제"></div>');
				$("#btnBoardDelete").append('</td>');
				$("#tbody_trip").append('</tr>');
				
				
				
				$("#btnBoardSubmit").on("click",function(){
					
					var pUser_num = ${user_num}
					var data = {"${_csrf.parameterName}":"${_csrf.token}","user_num":pUser_num,"tNums":tNums}
					swal({					
						text:"게시글을 삭제 하시겠습니까?",					
						icon:"info",		
						buttons:[false,"확인"]
					}).then(function(isConfirm){
						$.ajax({
							url:"${contextPath}/accounts/deleteTripReview_review",
							data:data,
							type:"post",
//								dataType:"json",
							error:function(data){
								
								alert("삭제실패")
							},
							success:function(data){
								swal({
									text:"댓글이 삭제되었습니다.",
									icon:"success",
									buttons:[false,"확인"]
								}).then(function(isConfirm){
									tripReview_review(1);
								})
								
								
								
								
							}
						})
					})
					return false;
				})
			}
		})
		}
		
		function tripReview_review_reply(tripReview_review_reply_Page){
// 			var tripReview_review_reply_Page = 1;
// 			var tripReview_review_reply_Num = 0;
			var rNums = new Array();
			var tmpNums
			var arrayCount = 0;
			$.ajax({
				url : "${contextPath}/accounts/tripReview_review_reply",
				data : {"${_csrf.parameterName}":"${_csrf.token}","num":num,"page":tripReview_review_reply_Page},
				type : "post",
				dataType : "json",
				error : function(){
					alert("실패")
				},
				success : function(data){
					$("#tbody_trip_reply").empty();
					for(var i in data.board.boardList){
						$("#tbody_trip_reply").append('<tr id="reply_row'+tripReview_review_reply_Num+'">');
						var reply_row = "#reply_row"+tripReview_review_reply_Num;
						//myForm에 append 시켜야 하는데 안붙는다
						$(reply_row).append('<input type="checkbox" class="replyNumber" name="rNum" value="'+data.board.boardList[i].RE_REPLY_NUM+'" style="margin-top:30%;">');
						
						$(reply_row).append('<input type="hidden" name="tNum" value="'+data.board.boardList[i].REVIEW_NUM+'">');

						$(reply_row).append('<td>'+data.board.boardList[i].REV_REP_CONTENT+'</td>');
						
						function formatDate(date) {
							  return date.getFullYear() + '년 ' + 
							    (date.getMonth() + 1) + '월 ' + 
							    date.getDate() + '일 ';
							}
						var tmpDate = new Date(data.board.boardList[i].RE_REPLY_DATE).format("yyyy-MM-dd");
						
						$(reply_row).append('<td>'+tmpDate+'</td>');
						$(reply_row).append('<td style="display:none;"><input type="text" id="reply_key'+n+'" name="reply_key'+data.board.boardList[i].TRIP_REPLY_KEY+'" value="'+data.board.boardList[i].TRIP_REPLY_KEY+'"></td>');
						$(reply_row).append('<td style="display:none;"><input type="text" id="board_key'+n+'" name="board_key'+data.board.boardList[i].TRIP_BOARD_KEY+'" value="'+data.board.boardList[i].TRIP_BOARD_KEY+'"></td>');
						var checkBoard = data.board.boardList[i].RE_ST;

						if(checkBoard == 0){
							$(reply_row).append('<td><button class="btn btn-primary">원문 보기</button></td>');
						}else if(checkBoard == 1){
							$(reply_row).append('<td><button class="btn btn-primary">삭제된 게시글</button></td>');
						}
						
						$("#trip_reply_list").append('</tr>');
						
						
						tripReview_review_reply_Num++;
					}
					
					//페이징처리
					$("#tbody_trip_reply").append('<tr id="replyPage">');
					$("#replyPage").append('<td  colspan="4" ><ul id="reply_Page" class="pagination"></td>');
					$("#reply_Page").append('<li><a><input type="button" class="btnPage"id="FirstPage" value="처음"></a></li>');
					$("#reply_Page").append('<input type="hidden" class="btnPage"id="FirstPageValue" value="1">');
					var startPage = data.board.startPage
					var endPage = data.board.endPage;
					var tmpTotalPage = data.board.totalPage;
					for(var i=startPage; i<=endPage; i++){
						//총 페이지 갯수와 같거나 작을때 반복해서 페이징 버튼 만들기
						if(tmpTotalPage>=i){
							$("#reply_Page").append('<li><a><input type="button" class="btnPage"id="rPage'+i+'" value="'+i+'"></a></li>');
							//페이지 버튼의 value와 현재 페이지가 같을 경우 해당 버튼을 비활성화 하고 색상을 blue로 변경
							if($("#rPage"+i).attr("value") == tripReview_review_reply_Page){
								
								$("#rPage"+i).attr('disabled', true);
								$("#rPage"+i).css("color","blue")
							}
							
							//페이지 버튼 클릭시 클릭된 버튼의 value값을 page에 넣고 ajax 재호출
							$("#rPage"+i).on("click",function(){
								tripReview_review_reply_Page = $(this).attr("value");
								$("#trip_reply_list").empty();
								tripReview_review_reply(tripReview_review_reply_Page);
								
							})
							
						}
						
					}
					
					$("input[name=rNum]").on("click",function(){
						if(this.checked){
							if(rNums.length == 0){
								tmpNums = $(this).val();
								rNums[0] = tmpNums;
								arrayCount ++;
							}else{
								tmpNums = $(this).val();
								rNums[arrayCount] = tmpNums;
								arrayCount ++;
							}
							
						}else{
							for(var i in rNums){
								if(rNums[i] == $(this).val()){
									rNums.splice(rNums.indexOf($(this).val()),1);
									
								}
							}
						}
					})
					
					$("#reply_Page").append('<input type="hidden" class="btnPage"id="NextPageValue" value="'+endPage+'">');
					$("#reply_Page").append('<li><a><input type="button" class="btnPage"id="NextPage" value="다음"></a></li>');
					$("#reply_Page").append('<input type="hidden" class="btnPage"id="LastPageValue" value="'+data.board.totalPage+'">');
					$("#reply_Page").append('<li><a><input type="button" class="btnPage"id="LastPage" value="마지막"></a></li>');
					$("#replyPage").append('</ul>');
					$("#tbody_trip_reply").append('</tr>');

					//마지막 버튼 클릭시 마지막 버튼의 value값을 page로 넣어 ajax 재호출
					$("#LastPage").on("click",function(){
						
						tripReview_review_reply_Page = $("#LastPageValue").attr("value");
						tripReview_review_reply(tripReview_review_reply_Page);
						
					})
					
					//처음 버튼 클릭시 page에 1을 넣고 ajax 재호출
							$("#FirstPage").on("click",function(){
								tripReview_review_reply(1);
								
							})
					
					//다음버튼 클릭시 다음버튼의 value를 1 증가시켜 page에 넣고 ajax 재호출
					$("#NextPage").on("click",function(){
						tripReview_review_reply_Page = $("#NextPageValue").attr("value");
						tripReview_review_reply_Page++;
						tripReview_review_reply(tripReview_review_reply_Page);
						
					})
					
					//마지막 버튼의 값이 토탈 페이지 값과 같을 경우 다음버튼 클릭 비활성화
					if($("#rPage"+tmpTotalPage).attr('value')==tmpTotalPage){
						$("#NextPage").attr('disabled', true);
					}
					$("#tbody_trip_reply").append('<tr id="btnReplyDelete">');
					$("#btnReplyDelete").append('<td id="btnReplyDeletetd" colspan=4>');
					$("#btnReplyDeletetd").append('<div style="margin-left: 95%"><input type="button"  id="btnReplySubmit" class="btn btn-primary" value="삭제"></div>');
					$("#btnReplyDelete").append('</td>');
					$("#tbody_trip_reply").append('</tr>');
					
					


					

					

					$("#btnReplySubmit").on("click",function(){
						var pUser_num = ${user_num}
						var data = {"${_csrf.parameterName}":"${_csrf.token}","user_num":pUser_num,"rNums":rNums}
						alert(data);
						swal({					
							text:"댓글을 삭제 하시겠습니까?",					
							icon:"info",		
							buttons:[false,"확인"]
						}).then(function(isConfirm){
							$.ajax({
								url:"${contextPath}/accounts/tripReview_review_reply_delete",
								data:data,
								type:"post",
// 								dataType:"json",
								error:function(data){
									
									alert("삭제실패")
								},
								success:function(data){
									swal({
										text:"댓글이 삭제되었습니다.",
										icon:"success",
										buttons:[false,"확인"]
									}).then(function(isConfirm){
										tripReview_review_reply(1);
									})
									
									
									
									
								}
							})
						})
						return false;
					})
					
				}
			})
			}
		
		

		
		
		
		
		
		
		trip_list(1);
		trip_reply_list(1);
		
		$("#trip_active").on("click",function(){
			$("#tripReview").css("display","none");
			$("#tbody_trip").css("display","")
			$("#tbody_trip_reply").css("display","")
			$("#titleText1").css("display","");
			$("#titleText2").css("display","");
			trip_list(1);
			trip_reply_list(1);
		})
		$("#trip_review").on("click",function(){
			$("#tbody_trip").css("display","none")
			$("#tbody_trip_reply").css("display","none")
			$("#titleText1").css("display","none");
			$("#titleText2").css("display","none");
			$("#tripReview").css("display","");
			$("#tbody_trip").css("display","")
			$("#tbody_trip_reply").css("display","")
			tripReview_review(1);
			tripReview_review_reply(1);
		})
		
		$("#tripReview_localReview").on("click",function(){
			$("#tbody_trip").css("display","none")
			$("#tbody_trip_reply").css("display","none")
		})
		$("#tripReview_review").on("click",function(){
			$("#tbody_trip").css("display","")
			$("#tbody_trip_reply").css("display","")
			tripReview_review(1);
			tripReview_review_reply(1);
		})

		
		
		
// 		if(replyPage == 1){
// 			alert(replyPage)
// 			alert($("#rPage1").attr("value"));
// 			$("#rPage1").attr('disabled', true);
// 			$("#rPage1").css("color","blue")
// 		}
	})
</script>


<div class="container" id="con">
	
	<span id="titleText1">여행 작성글</span>
	
	<form id="tripDelete" method="post">
  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
  		<input type="hidden" name="user_num" value="${user_num}">
	<table class="table">
    <thead>
      <tr>
      	<th style="width: 5%"></th>
        <th style="text-align: center; width: 50%">제목</th>
        <th style="text-align: center; width: 20%">작성일</th>
        <th style="text-align: center; width: 20%">조회수</th>
      </tr>
    </thead>
    
    <tbody id="tbody_trip">
   
    </tbody>
    
  </table>
  </form>
  <div style="margin-left: 95%">
  </div>
  <hr><br>
  <span id="titleText2">댓글</span>
  
  <form id="replyDelete" method="post">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
  <input type="hidden" name="user_num" value="${user_num}">
	<table class="table">
    <thead>
      <tr>
      	<th style="width: 5%"></th>
        <th style="text-align: center; width: 50%">댓글</th>
        <th style="text-align: center; width: 20%">작성일</th>
        <th style="text-align: center; width: 20%"></th>
      </tr>
    </thead>
    <tbody id="tbody_trip_reply">
      
    </tbody>
  </table>
  </form>

</div>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</body>
</html>