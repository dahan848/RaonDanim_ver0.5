<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행후기 상세보기</title>

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  

  
<script type="text/javascript">
	
//------------------- 별점 시작 ------------------- //
$(function(){
    $(".starRev span").click(function(){
         var index = $(".starRev span").index(this);
         console.log(index+1);
         for(i=0; i<5; i++){
            
            $(this).parent().children('span').removeClass('on');
            $(this).addClass('on').prevAll('span').addClass('on');
         }
         $("#WITH_GPA").val(index+1);
	
        return false;
      });    
});
// ------------------- 별점 끝 ------------------- //


	$(function() {
		
		createReplyList();
		
		//------------------ 댓글 달기 ------------------//
		$("#replyForm").on("submit", function () {
			var d = $(this).serialize();
			$.ajax({
				url : "${contextPath}/wiReply/reply",
				data : d,
				type : "post",
				datatype : "json",
				success : function(data) {
					if(data) {
						createReplyList();
						$("#inputReply").val("");
					}
				}
			});
			return false;
		});

		
//  	==========================================================================================
// 		//------------------ 모달 게시글 삭제 ------------------//
// 		$("#modalDelete").on("click",function() {
		
// 			var input_pass = $("#modify-pass").val();
// 			var userNum = ${userNum};
// 			$.ajax({
// 				url : "${contextPath}/review/delete",
// 				data: {"num" : "${review.REVIEW_NUM}", 
// 					   "input_pass" : input_pass,
// 					   "${_csrf.parameterName}":'${_csrf.token}', 
// 					   "userNum":userNum},
// 				type: "post",
// 				dataType: "json",
// 				success: function(data) {
// 					if(data){
// // 						swal({
// // 							icon:"success",
// // 							text:"삭제 되었습니다",
// // 						});
// 						alert("삭제 되었습니다");
// 						location.href="reviewMain";
// 					} else {
// // 						swal({
// // 							icon:"fail",
// // 							text:"비밀번호가 틀렸습니다",
// // 						});
// 						alert("비밀번호가 일치하지 않습니다");
// 						location.href="reviewView?num=${review.REVIEW_NUM}";	
// 					}
// 				}
// 			});
// 		});
		
// 		//------- 수정 했을때 alert --------//
// 		var msg = "${msg}";
// 		if(msg!=null&&msg!=""){
			
// 			swal({
// 				icon:"success",
// 				text:msg,
// 			});
// 		}
// 		==========================================================================================
		
		
		
	});
	
	//------------------ 댓글 리스트 ------------------//
	function createReplyList(page) {
		
		if(page){
			
		}else{
			page = 1;
		}
		
		
		var replyTable = $("#replies");
		$("#replies tr:gt(0)").remove();
		
		$.ajax({
			url : "${contextPath}/wiReply/all/${withBoard.WITH_NUM}",
			type : "get",
			data:{"page":page},
			dataType : "json",
			success : function(data) {
				
				//console.log(data.boardList);
				for(var i in data.boardList) {
					var tr = $("<tr>");
					var href = $("<a href='#' style='text-decoration: none;'>신고</a>");	
					var btnDelete = $("<button class='far fa-trash-alt' id='btnDelete' data-toggle='modal' data-target='#replyModal'></button>");	
					$("<td style='text-align: center; border: 1px solid #cccccc; vertical-align: middle;'>").text(data.boardList[i].USER_LNM+data.boardList[i].USER_FNM).appendTo(tr);
					$("<td style='border: 1px solid #cccccc; vertical-align: middle;'>").text(data.boardList[i].WI_REP_CONTENT).appendTo(tr);					
					$("<td style='text-align: center; border: 1px solid #cccccc;'>").append(btnDelete).appendTo(tr);
					$("<td style='text-align: center; border: 1px solid #cccccc; vertical-align: middle;'>").append(href).appendTo(tr);
					$("<td style='border: white;'>").append("<input type='hidden' name='WI_REPLY_NUM' id='WI_REPLY_NUM"+i+"' value='"+data.boardList[i].WI_REPLY_NUM+"'>").appendTo(tr);
					tr.appendTo(replyTable);
					
					//-------페이저 부분-------//
					var start = data.startPage;		                
					var end =data.endPage;			                
					var total = data.totalPage;			                
					var currentPage = data.page;
			               
					var replyPager = $("#replyPager");
	                
					replyPager.html("");
					
					for(start;start<=total;start++){
						              
	                	var str = $("<li class='page-item'>" + 
	"    					<a class='page-link' onclick='moveTopage("+start+")'>" + 
							start + 
	"    					</a>" +   
	"    				</li>");
						str.appendTo(replyPager);
					}
					
					(function(m) {
						btnDelete.on("click", function() {
							$("#replyModal").show("slow");
							$("#modalReplyDelete").on("click",function(){
								var input_reply_pass = $("#input_reply_pass").val();
								var wi_reply_num = $("#WI_REPLY_NUM"+m).val();
								var userNum = "${userNum}";   
								var num = "${withBoard.WITH_NUM}";
							
								$.ajax({
									url : "${contextPath}/wiReply/delete",
									data: {"input_reply_pass" : input_reply_pass,		//입력한 비밀번호
										   "${_csrf.parameterName}":'${_csrf.token}', 
									  	   "userNum":userNum,			//로그인 한 USER_NUM
									   	   "num":num,
									       "wi_reply_num":wi_reply_num},					//게시글 번호
									type: "post",
									dataType: "json",
									success: function(data){
										if(data){
											alert("삭제 되었습니다");
											location.href="withView?tlUser=${withBoard.TL_USER_NUM}&wrUser=${withBoard.WR_USER_NUM}&withNum=${withBoard.WITH_NUM}";
										} else {
											alert("비밀번호가 일치하지 않습니다");
											location.href="withView?tlUser=${withBoard.TL_USER_NUM}&wrUser=${withBoard.WR_USER_NUM}&withNum=${withBoard.WITH_NUM}";	
										}			
									}
								});
							})
						});
					})(i);
				}
			}
		});
	}
	
	function moveTopage(start) {
		//alert(start);
		createReplyList(start);
	}
</script>



<style type="text/css">
	#btnUpdate{
		background-color: #eeeeee;
		color: green;
		border: 1px solid #cccccc;
	}
	#btnDelete{
		background-color: #eeeeee;
		color: green;
		border: 1px solid #cccccc;
		width: 50px;
		height: 30px;
		margin: 0px;
		padding: 0px;
	}
	#box {
  		float: left;  
		margin: 30px;
		border: 1px solid #cccccc;
		width: 250px;
		height: auto;
		text-align: center;
		font-size: 20px;
		background: #eeeeee;
	}
	#form-group {
		width: 800px;
		float: right;
	}
	#List {
		float: right;
		border: 1px solid #cccccc;
		background-color: #eeeeee;
		color: green;
	}
	#Update {
		float: right;
		border: 1px solid #cccccc;
		background-color: #eeeeee;
		color: green;
		margin-left: 15px;
		margin-right: 15px;
	}
	#Delete {
		float: right;
		border: 1px solid #cccccc;
		background-color: #eeeeee;
		color: green;
	}
	#btnSave {
		display: inline;
		float: right;
	}
	#inputReply {
		width: 1000px; 
		display: inline;
	}
	#contentView {
		 border: 1px solid #cccccc;
/* 		 width: 800px; */
		 width: auto;
		 height: auto;
		 background: #eeeeee;
	}
	#userimg {
 		background-image: url("${contextPath}/img/user.jpg");   
		background-repeat: no-repeat;
		background-position: bottom;
		background-size: cover;
		border-radius: 50%;
		z-index: 2;
 		border: 1px solid black; 
 		margin: 0 auto; 
 		margin-top: 20px; 
		width: 100px;
		height: 100px;
	}
	
	.starR{
        	background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
          	background-size: auto 100%;
          	width: 30px;
          	height: 30px;
          	display: inline-block;
          	text-indent: -9999px;
          	cursor: pointer;
    	}
    	.starR.on{
        	background-position:0 0;
    	}
    	#star {
        	margin-left: 20px; 
    	}
    	#starCase {
      		border: 1px solid #cccccc;
      		background-color: #eeeeee;
      		width: 800px;
/*       		float: right; */
      		margin-bottom: 10px;
    	}
	
	
</style>

  
</head>
<body>

	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/review/review-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->



<form action="withView" method="get">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<div class="main-container">
	
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<div class="tab-content">
			<!----------------------------------------- 프로필 시작 -------------------------------------->
			<div class="box" id="box">
				<div id="userimg"></div>
				<br>
				<span>${tlUser.user_lnm}${tlUser.user_fnm}</span>
				<br><br>
				<span>성별 : <b>${tlUser.user_gender}</b></span>
				<br><br>
				<i class="fas fa-home">
					<br>
					<span>숙소 평점</span>
					<br>
					<span><i style="color: blue;">4.2</i> / 5</span>
				</i>
				<i class="fas fa-camera" style="margin-left: 20px;">
					<br>
					<span>후기 평점</span>
					<br>
					<span><i style="color: blue;">4.8</i> / 5</span>
				</i>
				<br><br>
			</div>
			<!----------------------------------------- 프로필 끝 -------------------------------------->
			
			<h3>
				<i class="fas fa-cloud" style="font-size:38px;color:aqua;"></i>
				${tlUser.user_lnm}${tlUser.user_fnm}님의 여행후기입니다
			</h3>
			
			<!------- 조회수 시작------->
			<div style="float: right;">
				<i class="far fa-eye" style="font-size: 20px; color: #cccccc;"></i>
				<span style="margin-left: 10px; font-size: 20px; color: #cccccc;">${withBoard.WITH_COUNT}</span>
			</div>
			<!------- 조회수 끝------->
			
			<br><br>
			
			<button type="button" class="btn btn-primary" id="List" onclick="location.href='#'">후기 목록</button>
			<button type="button" class="btn btn-primary" id="Update" onclick="location.href='updateForm?num=${withBoard.REVIEW_NUM}'">수정하기</button>
			
			<!------- 삭제 버튼, 모달  시작------->
			<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal" id="Delete">삭제하기</button>
			<input type="hidden" name="num" value="${review.REVIEW_NUM}">
			<input type="hidden" name=userNum value="${userNum}">
			<div class="modal fade" id="myModal" role="dialog">
    			<div class="modal-dialog modal-lg">
      				<div class="modal-content">
        				<div class="modal-header">
          					<button type="button" class="close" data-dismiss="modal">&times;</button>
          					<h4 class="modal-title">삭제</h4>
        				</div>
        				<div class="modal-body">
          					<input class="form-control input-lg" name="input_pass" 
          						id="modify-pass" type="password" placeholder="비밀번호를 입력하세요.">
        				</div>
        				<div class="modal-footer">
          					<input type="button" class="btn btn-default" id="modalDelete" value="삭제">
        				</div>
      				</div>
    			</div>
  			</div>
  			<!------- 삭제 버튼, 모달  끝------->
			
			
			<!------------ 등록한 정보 출력 시작 ------------>
				<div class="form-group" id="form-group">
					<label for="inputlg1">후기 작성자</label> 
					<input class="form-control input-lg" id="inputlg1" type="text" readonly="readonly" value="${withBoard.USER_LNM}${withBoard.USER_FNM}">
				</div>
			
				<div class="form-group" id="form-group">
					<label for="inputlg2">평점</label> 
<%-- 					<input class="form-control input-lg" id="inputlg2" type="text" readonly="readonly" value="${withBoard.WITH_GPA}"> --%>
					<!----------------------------------------- 별점 시작 -------------------------------------->
					<div id="starCase">		
					
						<div class="starRevWookJin" style="" id="reviewScore">
						
						<c:set var="cnt" value="1" />
						<c:forEach begin="1" end="5">
							<c:if test="${cnt<= withBoard.WITH_GPA}">
								<span class="starR on" id="star">Wookjin</span>
							</c:if>
							<c:if test="${cnt> withBoard.WITH_GPA}">
								<span class="starR" id="star">Wookjin</span>
							</c:if>
							<c:set var="cnt" value="${cnt+1}"/>
							
						</c:forEach>	
						
<!-- 							<span class="starR on" id="star">별1</span>  -->
<!-- 							<span class="starR" id="star">별2</span>  -->
<!-- 							<span class="starR" id="star">별3</span>  -->
<!-- 							<span class="starR" id="star">별4</span>  -->
<!-- 							<span class="starR" id="star">별5</span> -->
							<input type="hidden" name="WITH_GPA" id="WITH_GPA" value="1">
						</div>
					</div>
					<!----------------------------------------- 별점 끝 -------------------------------------->
					
					
				</div>
				
				
				
				
			
				<div class="form-group" id="form-group">
					<label for="inputlg">후기</label> 
					<div class="form-control input-lg" id="contentView">
						${withBoard.WITH_CONTENT}
					</div>
				</div>
			<!------------ 등록한 정보 출력 끝 ------------>
				
			</div>
		</div>
		
	</section>
	</div>	
</form>

<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
		<div class="tab-content">
		
		<!------------ 댓글 리스트 시작 ------------>
			<table class="table table-striped" id="replies">
      				<tr style="border: 1px solid #cccccc;">
        				<th style="width: 130px; border: 1px solid #cccccc; text-align: center;">닉네임</th>
        				<th style="width: 850px; border: 1px solid #cccccc; text-align: center;">댓글</th>
        				<th style="border: 1px solid #cccccc; text-align: center;"></th>
        				<th style="border: 1px solid #cccccc;"></th>
      				</tr>
  			</table>
  		<!------------ 댓글 리스트 끝 ------------>	
  		
  		<!------------ 댓글 삭제 모달 시작 ------------>	
  			<div class="modal fade" id="replyModal" role="dialog">
    			<div class="modal-dialog modal-lg">
      				<div class="modal-content">
        				<div class="modal-header">
          					<button type="button" class="close" data-dismiss="modal">&times;</button>
          					<h4 class="modal-title">삭제</h4>
        				</div>
        				<div class="modal-body">
          					<input class="form-control input-lg" name="input_reply_pass" 
          						id="input_reply_pass" type="password" placeholder="비밀번호를 입력하세요.">
        				</div>
        				<div class="modal-footer">
          					<input type="button" class="btn btn-default" id="modalReplyDelete" value="삭제">
        				</div>
      				</div>
    			</div>
  			</div>
  		<!------------ 댓글 삭제 모달 끝 ------------>
  			
  			<!------------ 댓글 리스트 페이징 시작 ------------>
  			<div align="center">
  				<ul class="pagination justify-content-center" id="replyPager">
  					
  				</ul>
  			</div>
			<!------------ 댓글 리스트 페이징 끝 ------------>
	
  			<!------------ 댓글 달기 시작 ------------>
  			<form name="replyForm" id="replyForm" method="post" action="#">
  				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
  				<input type="hidden" name="WITH_NUM" value="${withBoard.WITH_NUM}">
  				<input type="hidden" name="USER_NUM" value="${withBoard.USER_NUM}">
  				<input type="text" class="form-control form-control-sm" placeholder="댓글을 입력하세요" id="inputReply" name="WI_REP_CONTENT">
				<input type="submit" class="btn btn-primary" id="btnSave" value="등록">
			</form>
			<!------------ 댓글 달기 끝 ------------>
			
		</div>	
	</div>
	</section>
	</div>
	<br><br><br>
	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>