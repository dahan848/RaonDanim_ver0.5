<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%	request.setAttribute("contextPath", request.getContextPath()); %>	
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<link rel="icon" type="image/png" href="${contextPath}/img/favicon.ico">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>관리자 화면</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="${contextPath}/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="${contextPath}/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="${contextPath}/css/light-bootstrap-dashboard.css?v=1.4.0" rel="stylesheet"/>


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="${contextPath}/css/pe-icon-7-stroke.css" rel="stylesheet" />

<!-- 차트 js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>


</head>
<body>

<div class="wrapper">
    <!-- 좌측 메뉴바부분 시작 -->
    <div class="sidebar" data-color="blue" data-image="${contextPath}/img/sidebar-5.jpg">

    <!--

        Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag

    -->

    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="${contextPath}/" class="simple-text">
                    Raon Danim
                </a>
            </div>
			
            <ul class="nav">
                <li class="active">
                    <a href="main">
                        <i class="pe-7s-graph"></i>
                        <p>메인</p>
                    </a>
                </li>
                <li>
                    <a href="user">
                        <i class="pe-7s-user"></i>
                        <p>유저</p>
                    </a>
                </li>
                <li>
                    <a href="board">
                        <i class="pe-7s-note2"></i>
                        <p>게시글 관리</p>
                    </a>
                </li>
<!--                 <li>
                    <a href="#">
                        <i class="pe-7s-news-paper"></i>
                        	<p>결제</p>
                    </a>
                </li> -->
                 <li>
                    <a href="inquiry">
                        <i class="pe-7s-note2"></i>
                        <p>회원문의</p>
                    </a>
                </li>

            </ul>
    	</div>
    </div>
 <!-- 좌측 메뉴바부분 끝 -->
 
    <div class="main-panel">
<!--     네비바 좌측 시작 -->
        <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Dashboard</a>
                </div>

                <div class="collapse navbar-collapse">

<!-- 					네비바 우측 -->
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                           <a href="">
                               <p>Account</p>
                            </a>
                        </li>
<!--                         <li class="dropdown"> -->
<!--                               <a href="#" class="dropdown-toggle" data-toggle="dropdown"> -->
<!--                                     <p> -->
<!-- 										Dropdown -->
<!-- 										<b class="caret"></b> -->
<!-- 									</p> -->

<!--                               </a> -->
<!--                               <ul class="dropdown-menu"> -->
<!--                                 <li><a href="#">Action</a></li> -->
<!--                                 <li><a href="#">Another action</a></li> -->
<!--                                 <li><a href="#">Something</a></li> -->
<!--                                 <li><a href="#">Another action</a></li> -->
<!--                                 <li><a href="#">Something</a></li> -->
<!--                                 <li class="divider"></li> -->
<!--                                 <li><a href="#">Separated link</a></li> -->
<!--                               </ul> -->
<!--                         </li> -->
                        <li>
                            <a href="">
                                <p>Log out</p>
                            </a>
                        </li>
						<li class="separator hidden-lg"></li>
                    </ul>
                </div>
            </div>
        </nav>
<!-- 네비바 우측 끝 -->

              <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">게시글 신고 관리</h4>
                                <p class="category">신고접수된 게시글 목록입니다.</p>
                                <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown"> 
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
                                     <p> 
 										게시글 선택
 										<b class="caret"></b>
 									</p> 

                               </a> 
                               <ul class="dropdown-menu">
                                 <li><a href="board">여행게시글</a></li> 
                                 <li><a href="motelBoard">숙박게시글</a></li> 
                               </ul> 
                         </li> 
                         </ul>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table id="deleteTable" class="table table-striped">
                                    <thead>
                                    	<tr>
	                                    	<th>회원번호</th>
	                                    	<th>아이디</th>
	                                    	<th>이름</th>
	                                    	<th>신고게시글 제목</th>
	                                    	<th>신고 사유</th>
	                                    	<th></th>
                                    	</tr>                                   
                                    </thead>
                                    <tbody>
                                       <c:forEach items="${tripData.dBoardList}" var="list" varStatus="status">
                                       		<tr id="boardDelete${status.index}">
                                       			<td>${list.USER_NUM}번</td>
                                       			<td>${list.USER_ID}</td>
                                       			<td>${list.USER_LNM}${list.USER_FNM}</td>
                                       			<td>${list.TRIP_BOARD_TITLE}</td>
                                       			<td>${list.DECLARATION_CONTENT}</td>
                                       			<td> <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal${status.index}">상세내용</button></td>
                                       		</tr>

                                       
                                       </c:forEach>
                                       

                                    </tbody>
                                </table>
                                
                                	<div class="container" style="text-align: center;">
										
										<ul class="pager" style="display: inline-block;">
											<c:if test="${tripData.page!=1}">
												<li><a
													href="board?page=${param.pageNum-1}">Previous</a></li>
											</c:if>
											<c:forEach var="pageNum" begin="${tripData.start}"
												end="${tripData.end < tripData.total ? tripData.end: tripData.total}">
												<a href="board?page=${pageNum}&type=${param.type}&keyword=${param.keyword}&lName=${param.lName}&fName=${param.fName}">${pageNum}&nbsp;&nbsp;&nbsp;</a>
											</c:forEach>
											<c:if test="${tripData.page!=tripData.total}">
												<li><a href="board?page=${param.pageNum+1}&type=${param.type}&keyword=${param.keyword}">Next</a></li>
											</c:if>
										</ul>
									</div>



                            </div>
                        </div>
                    </div>




                </div>
            </div>
        </div>

</div>
</div>


<c:forEach items="${tripData.dBoardList}" var="list" varStatus="status">
  								<div class="container">
										  <!-- Trigger the modal with a button -->
										 
										  <!-- Modal -->
										  <div class="modal fade" id="myModal${status.index}" role="dialog">
										    <div class="modal-dialog modal-lg">
										      <div class="modal-content">
										        <div class="modal-header">
										        
										       <button type="button" class="close" data-dismiss="modal">&times;</button>
									          <h4 class="modal-title navbar-brand">신고 게시글 상세내용</h4> 
										        </div>
										        <div class="modal-body">
										      
										         	<table class="table">
										         		<tr>
										         			<td>
										         			<label> 글 제목:</label> 
										         		 <h5>${list.TRIP_BOARD_TITLE}</h5>
										         		 <input type="hidden" id="boardKey${status.index}" value="${list.TRIP_BOARD_KEY}">
										         		 </td>
										         		</tr>
										         		<tr>
										         			<td><label> 글 제목:</label> 
										         		 <h5>${list.TRIP_BOARD_COUNTENT}</h5></td>
										         		</tr>
										         		<tr>
										         			<td>
										         			<label> 신고 사유:</label> 
										         			 <h5>${list.DECLARATION_CONTENT}</h5>
										         			
										         			</td>
										         		</tr>
										         		<tr>
										         			<td>
										          		<input type="button" id="delete${status.index}" onclick="dummyDelete(${status.index})" class="btn btn-danger"  value="삭제"/>
										          		<input type="button" data-dismiss="modal" id="cancel${status.index}" class="btn btn-danger" value="삭제취소"/></td>
										         		</tr>
		         	
										         	</table>
										         						       
										        </div>
										        <div class="modal-footer">
										          
										          
										        </div>
										      </div>
										    </div>
										  </div>
										</div>


</c:forEach>





</body>


    <!--   Core JS Files   -->
<%--     <script src="${contextPath}/js/jquery.3.2.1.min.js" type="text/javascript"></script> --%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
    integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
    crossorigin="anonymous"></script>
	<script src="${contextPath}/js/bootstrap.min.js" type="text/javascript"></script>

	<!--  Charts Plugin -->
	<script src="${contextPath}/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="${contextPath}/js/bootstrap-notify.js"></script>

<!--      Google Maps Plugin    -->
<!--     <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script> -->

    <!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
	<script src="${contextPath}/js/light-bootstrap-dashboard.js"></script>

	<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
	<script src="${contextPath}/js/demo.js"></script>

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


	<script type="text/javascript">
    	$(document).ready(function(){

        	demo.initChartist();

        	$.notify({
            	icon: 'pe-7s-gift',
            	message: "<b>게시글 관리 화면에 오신걸 환영합니다.</b>"

            },{
                type: 'info',
                timer: 4000
            });

    	});
    	
    	function dummyDelete(i) {
			
			var boardKey = $("#boardKey"+i).val();
			
			$.ajax({
				url:"tripBoardDelete",
				type:"get",
				data:{"boardKey":boardKey},
				dataType:"json",
				success:function(result){
					if(result){
						location.href="board";
		
					}else{
						swal({
							icon:"warning",
							text:"삭제 처리 실패",
						});
					}
				}
				
				
			});
		
    		
		}
    	
    	
    	
	</script>

</html>