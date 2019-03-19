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
                <a href="" class="simple-text">
                    Raon Danim
                </a>
            </div>

            <ul class="nav">
                <li class="active">
                    <a href="">
                        <i class="pe-7s-graph"></i>
                        <p>메인</p>
                    </a>
                </li>
                <li>
                    <a href="">
                        <i class="pe-7s-user"></i>
                        <p>게시글 관리</p>
                    </a>
                </li>
                <li>
                    <a href="">
                        <i class="pe-7s-note2"></i>
                        <p>신고</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-news-paper"></i>
                        	<p>결제</p>
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
                    <div class="col-md-4">
                        <div class="card">

                            <div class="header">
                                <h4 class="title">월별 가입자 현황</h4>
<!--                                 <p class="category">Last Campaign Performance</p> -->
                            </div>
                            <div class="content">
<!--                                 <div id="chartPreferences" class="ct-chart ct-perfect-fourth"></div> -->
								<canvas id="myChart"></canvas>
								<script type="text/javascript">
									var ctx = document.getElementById('myChart').getContext('2d');
									var myChart = new Chart(ctx, {
									    type: 'bar',
									    data: {
									        labels: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
									        datasets: [{
									            label: '가입자 증가 비율',
									            data: [15,10,30,50,70,40,50,0,0,0,0],
									            backgroundColor: [
									                'rgba(255, 99, 132, 0.2)',
									                'rgba(54, 162, 235, 0.2)',
									                'rgba(255, 206, 86, 0.2)',
									                'rgba(75, 192, 192, 0.2)',
									                'rgba(153, 102, 255, 0.2)',
									                'rgba(255, 159, 64, 0.2)',
									                'rgba(250, 99, 132, 0.2)',
									                'rgba(57, 162, 235, 0.2)',
									                'rgba(235, 206, 86, 0.2)',
									                'rgba(175, 192, 192, 0.2)',
									                'rgba(173, 102, 255, 0.2)',
									                'rgba(205, 159, 64, 0.2)'
									            ],
									            borderColor: [
									                'rgba(255, 99, 132, 1)',
									                'rgba(54, 162, 235, 1)',
									                'rgba(255, 206, 86, 1)',
									                'rgba(75, 192, 192, 1)',
									                'rgba(153, 102, 255, 1)',
									                'rgba(255, 159, 64, 1)',
									                'rgba(205, 99, 132, 1)',
									                'rgba(154, 162, 235, 1)',
									                'rgba(155, 206, 86, 1)',
									                'rgba(45, 192, 192, 1)',
									                'rgba(173, 102, 255, 1)',
									                'rgba(205, 159, 64, 1)'
									            ],
									            borderWidth: 1
									        }]
									    },
									    options: {
									        scales: {
									            yAxes: [{
									                ticks: {
									                    beginAtZero: true
									                }
									            }]
									        }
									    }
									});
								
								</script>

                                <div class="footer">
                                    <div class="stats">
                                        <i class="fa fa-clock-o"></i> 2019.01~2019.12 기준
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">월별 게시글 작성 현황</h4>      
                            </div>
                            <div class="content">
                            
                                <canvas id="myChart2"></canvas>
								<script type="text/javascript">
									var boardList = "${boardList}";
									
									var ctx = document.getElementById('myChart2').getContext('2d');
									var myChart = new Chart(ctx, {
									    type: 'line',
									    data: {
									        labels: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
									        datasets: [{
									            label: '게시글 작성 비율',
									            data: [20,25,50,16,12,21,16],
									            backgroundColor: [
									                'rgba(255, 99, 132, 0.2)',
									                'rgba(54, 162, 235, 0.2)',
									                'rgba(255, 206, 86, 0.2)',
									                'rgba(75, 192, 192, 0.2)',
									                'rgba(153, 102, 255, 0.2)',
									                'rgba(255, 159, 64, 0.2)',
									                'rgba(250, 99, 132, 0.2)',
									                'rgba(57, 162, 235, 0.2)',
									                'rgba(235, 206, 86, 0.2)',
									                'rgba(175, 192, 192, 0.2)',
									                'rgba(173, 102, 255, 0.2)',
									                'rgba(205, 159, 64, 0.2)'
									            ],
									            borderColor: [
									                'rgba(255, 99, 132, 1)',
									                'rgba(54, 162, 235, 1)',
									                'rgba(255, 206, 86, 1)',
									                'rgba(75, 192, 192, 1)',
									                'rgba(153, 102, 255, 1)',
									                'rgba(255, 159, 64, 1)',
									                'rgba(205, 99, 132, 1)',
									                'rgba(154, 162, 235, 1)',
									                'rgba(155, 206, 86, 1)',
									                'rgba(45, 192, 192, 1)',
									                'rgba(173, 102, 255, 1)',
									                'rgba(205, 159, 64, 1)'
									            ],
									            borderWidth: 1
									        }]
									    },
									    options: {
									        scales: {
									            yAxes: [{
									                ticks: {
									                    beginAtZero: true
									                }
									            }]
									        }
									    }
									});
								
								</script>

                                
                                <div class="footer">


                                    <div class="stats">
                                        <i class="fa fa-history"></i> 2019.01~2019.12 기준
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="row">
                    <div class="col-md-6">
                        <div class="card ">
                            <div class="header">
                                <h4 class="title">2014 Sales</h4>
                                <p class="category">All products including Taxes</p>
                            </div>
                            <div class="content">
                                <div id="chartActivity" class="ct-chart"></div>

                                <div class="footer">
                                 
                                    <hr>
                                    <div class="stats">
                                        <i class="fa fa-check"></i> 2019.01~2019.12 기준
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card ">
                            <div class="header">
                                <h4 class="title">Tasks</h4>
                                <p class="category">알림</p>
                            </div>
                            <div class="content">
                                <div class="table-full-width">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <td>
													<div class="checkbox">
						  							  	<input id="checkbox1" type="checkbox">
						  							  	<label for="checkbox1"></label>
					  						  		</div>
                                                </td>
                                                <td>Sign contract for "What are conference organizers afraid of?"</td>
                                                <td class="td-actions text-right">
                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-xs">
                                                        <i class="fa fa-edit"></i>
                                                    </button>
                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-xs">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
													<div class="checkbox">
						  							  	<input id="checkbox2" type="checkbox" checked>
						  							  	<label for="checkbox2"></label>
					  						  		</div>
                                                </td>
                                                <td>Lines From Great Russian Literature? Or E-mails From My Boss?</td>
                                                <td class="td-actions text-right">
                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-xs">
                                                        <i class="fa fa-edit"></i>
                                                    </button>
                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-xs">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
													<div class="checkbox">
						  							  	<input id="checkbox3" type="checkbox">
						  							  	<label for="checkbox3"></label>
					  						  		</div>
                                                </td>
                                                <td>Flooded: One year later, assessing what was lost and what was found when a ravaging rain swept through metro Detroit
												</td>
                                                <td class="td-actions text-right">
                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-xs">
                                                        <i class="fa fa-edit"></i>
                                                    </button>
                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-xs">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
													<div class="checkbox">
						  							  	<input id="checkbox4" type="checkbox" checked>
						  							  	<label for="checkbox4"></label>
					  						  		</div>
                                                </td>
                                                <td>Create 4 Invisible User Experiences you Never Knew About</td>
                                                <td class="td-actions text-right">
                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-xs">
                                                        <i class="fa fa-edit"></i>
                                                    </button>
                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-xs">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
													<div class="checkbox">
						  							  	<input id="checkbox5" type="checkbox">
						  							  	<label for="checkbox5"></label>
					  						  		</div>
                                                </td>
                                                <td>Read "Following makes Medium better"</td>
                                                <td class="td-actions text-right">
                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-xs">
                                                        <i class="fa fa-edit"></i>
                                                    </button>
                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-xs">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
													<div class="checkbox">
						  							  	<input id="checkbox6" type="checkbox" checked>
						  							  	<label for="checkbox6"></label>
					  						  		</div>
                                                </td>
                                                <td>Unfollow 5 enemies from twitter</td>
                                                <td class="td-actions text-right">
                                                    <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-xs">
                                                        <i class="fa fa-edit"></i>
                                                    </button>
                                                    <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-xs">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="footer">
                                    <hr>
                                    <div class="stats">
                                        <i class="fa fa-history"></i> Updated 3 minutes ago
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <footer class="footer">
           

        </footer>

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

	<script type="text/javascript">
    	$(document).ready(function(){

        	demo.initChartist();

        	$.notify({
            	icon: 'pe-7s-gift',
            	message: "<b>관리자 화면에 오신걸 환영합니다.</b>"

            },{
                type: 'info',
                timer: 4000
            });

    	});
	</script>

</html>