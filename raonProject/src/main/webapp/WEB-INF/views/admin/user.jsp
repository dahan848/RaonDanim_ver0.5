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
                                <h4 class="title">유저 관리</h4>
                                <p class="category">계정잠근된 유저목록입니다</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th>아이디</th>
                                    	<th>이름</th>
                                    	<th>가입일</th>
                                    	<th>잠금일</th>
                                    	<th>잠금해제</th>
                                    </thead>
                                    <tbody>
                                    	<!-- 반복문으로 그려야 하는 부분 -->
                                    	<c:forEach items="${userList}" var="user">
	                              		    <tr>
	                                        	<td>${user.USER_ID}</td>
	                                        	<td>${user.USER_LNM} ${user.USER_FNM}</td>
	                                        	<td>${user.USER_REG_DATE}</td>
	                                        	<td>${user.USER_LAST_TRY_LOGIN_TIME}</td>
	                                        	<td><button onclick="userUnlock(${user.USER_NUM })">해제</button></td>
	                                        </tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>
</div>

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
	
	<!-- 스윗얼랏 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<script type="text/javascript">
    	$(document).ready(function(){

        	demo.initChartist();

        	$.notify({
            	icon: 'pe-7s-gift',
            	message: "<b>유저관리 화면에 오신걸 환영합니다.</b>"

            },{
                type: 'info',
                timer: 4000
            });

    	});
    	
    	//잠금해제 버튼클릭 이벤트 ()
    	function userUnlock(usernum) {
    		//인자로 잠금을 해제 할 user의 num을 받아 변수에 참조 
			var user = usernum;
    		//ajax로 비동기적 잠금해제 요청 
			$.ajax({
				url:"userUnlock",
				type:"get",
				data:{"usernum":user},
				dataType:"json",
				success:function(result){
					if(result){
    	            	swal({
  						  text: "유저 잠금해제에 성공했습니다.",
  						  button: "확인",
  						}).then(function() {
  	  						location.reload(); //화면 새로고침
  	  					});	
					}else{
						swal({
							icon:"warning",
							text:"삭제 처리 실패",
						});
					}
				},
				 error : function(error) {
	                	swal({text: "에러 발생 콘솔로그 확인.", button: "확인",});
	    	            console.log(error);
	    	            console.log(error.status);
    	        }
			});
		}
	</script>

</html>