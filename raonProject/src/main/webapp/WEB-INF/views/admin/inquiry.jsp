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

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>
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
                            <a href="${contextPath}/accounts/logout">
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
                                <h4 class="title">
                                	<c:if test="${param.type eq 0}">전체 문의</c:if>
									<c:if test="${param.type eq 1}">일반 문의</c:if>
									<c:if test="${param.type eq 2}">회원 문의</c:if>
									<c:if test="${param.type eq 3}">탈퇴 문의</c:if>
									<c:if test="${param.type eq 4}">미답변 문의</c:if>
                               	</h4>
                                <p class="category">
                                	<c:if test="${param.type eq 0}">전체 문의 목록입니다.</c:if>
									<c:if test="${param.type eq 1}">일반 문의 목록입니다.</c:if>
									<c:if test="${param.type eq 2}">회원 문의 목록입니다.</c:if>
									<c:if test="${param.type eq 3}">탈퇴 문의 목록입니다.</c:if>
									<c:if test="${param.type eq 4}">미답변 문의 목록입니다.</c:if>
                                </p>
                                <ul class="nav navbar-nav navbar-right">
	                                <li class="dropdown"> 
	                             		<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
		                                     <p> 
		 										분류
		 										<b class="caret"></b>
		 									</p> 
	                               		</a>
	                               		<form id="inquiryType" action="inquiry">
	                               			<input id="in_type" type="hidden" name="type" value=""> 
		                               		<ul class="dropdown-menu">
		                               			<li><a onclick="inquiryType(0)">전체보기</a></li> 	                               		
				                                <li><a onclick="inquiryType(1)">일반문의</a></li> 
				                                <li><a onclick="inquiryType(2)">회원문의</a></li>
				                                <li><a onclick="inquiryType(3)">탈퇴문의</a></li>
				                                <li><a onclick="inquiryType(4)">미답변 문의</a></li> 
		                               		</ul>
	                               		</form> 
	                         		</li> 
                         		</ul>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th>문의번호</th>
                                    	<th>문의종류</th>
                                    	<th>회원여부</th>
                                    	<th>작성자</th>
                                    	<th>제목</th>
                                    	<th>작성일</th>
                                    	<th>답변상태</th>
                                    	<th>답변번호</th>
                                    </thead>
                                    <tbody>
                                    	<!-- 반복문으로 그려야 하는 부분 -->
                                    	<c:forEach items="${InquiryList}" var="inquiry">
	                              		    <tr>
	                                        	<td>${inquiry.INQUIRY_NUM}</td>
	                                        	<c:if test="${inquiry.INQUIRY_TYPE eq 0}"><td>일반문의</td></c:if>
	                                        	<c:if test="${inquiry.INQUIRY_TYPE eq 1}"><td>회원문의</td></c:if>
	                                        	<c:if test="${inquiry.INQUIRY_TYPE eq 2}"><td>탈퇴문의</td></c:if>
	                                        	<c:if test="${inquiry.INQUIRY_RGE_TYPE eq 0}"><td>비회원</td></c:if>
	                                        	<c:if test="${inquiry.INQUIRY_RGE_TYPE eq 1}"><td>회원</td></c:if>
	                                        	<td>${inquiry.INQUIRY_REG_ID}</td>
	                                        	<td><a class="btn btn-primary" data-toggle="modal" data-target="#modalPoll-${inquiry.INQUIRY_NUM}">${inquiry.INQUIRY_SUBJECT}</a></td>
	                                        	<td>${inquiry.INQUIRY_REG_DATE}</td>
	                                        	<c:if test="${inquiry.ANSWER_ST eq 0}"><td>X</td></c:if>
	                                        	<c:if test="${inquiry.ANSWER_ST ne 0}"><td>O</td></c:if>
	                                        	<td>${inquiry.ANSWER_NUM}</td>
	                                        </tr>
	                                        <!-- 답변 모달창 -->
											<!-- Modal: modalPoll -->
											<div class="modal fade right" id="modalPoll-${inquiry.INQUIRY_NUM}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
											  aria-hidden="true" data-backdrop="false">
											  <div class="modal-dialog modal-full-height modal-right modal-notify modal-info" role="document">
											    <div class="modal-content">
											      <!--Header-->
											      <div class="modal-header">
											        <p class="heading lead">문의내용 확인 및 답변작성
											        </p>
											        <button id="modalClose" type="button" class="close" data-dismiss="modal" aria-label="Close">
											          <span aria-hidden="true" class="white-text">×</span>
											        </button>
											      </div>
											      <!--Body-->
											      <div class="modal-body">
											        <div class="text-center">
											          <i class="far fa-file-alt fa-4x mb-3 animated rotateIn"></i>
											          <p>
											            <strong>분류</strong>
											            <c:if test="${inquiry.INQUIRY_TYPE eq 0}">일반문의</c:if>
											            <c:if test="${inquiry.INQUIRY_TYPE eq 1}">회원문의</c:if>
											            <c:if test="${inquiry.INQUIRY_TYPE eq 2}">탈퇴문의</c:if>
											          </p>
											          <p>
											            <strong>작성자</strong> ${inquiry.INQUIRY_REG_ID}
											          </p>
											          <p>
											            <strong>작성일</strong> ${inquiry.INQUIRY_REG_DATE}
											          </p>
											        </div>
											        <hr>
											        <p class="text-center">
											          <strong>제목</strong> ${inquiry.INQUIRY_SUBJECT}
											        </p>
											        <div class="form-check mb-4">
														<p style="text-align: center;">${inquiry.INQUIRY_CONTENT}</p>
											        </div>
											        <p class="text-center">
											          <strong>답변작성</strong>
											        </p>
											        <!-- 답변이 미등록인 경우 -->
<%-- 											        <c:if test="${inquiry.ANSWER_ST eq 0}"> --%>
												        <div class="md-form">
												          <textarea type="text" id="answer_content" class="md-textarea form-control" rows="3"></textarea>
												        </div>
<%-- 											        </c:if> --%>
											        <!-- 답변이 등력 된 경우 -->
<%-- 											        <c:if test="${inquiry.ANSWER_ST ne 0}"> --%>
											        	
<%-- 											        </c:if> --%>
											      </div>
											      <!--Footer-->
											      <div class="modal-footer justify-content-center">
											        <a type="button" class="btn btn-primary waves-effect waves-light" onclick="answer(${inquiry.INQUIRY_NUM})">답변완료
											          <i class="fa fa-paper-plane ml-1"></i>
											        </a>
											        <a type="button" class="btn btn-outline-primary waves-effect" data-dismiss="modal">돌아가기</a>
											      </div>
											    </div>
											  </div>
											</div>
                                    	</c:forEach>
                                    	<!-- 페이징 처리 -->
                                    	<tr>
											<td colspan="8">
											<c:if test="${startPage !=1}">
												<a href="inquiry?page=1&type=${param.type}">[처음]</a>
												<a href="inquiry?page=${startPage-1}&type=${param.type}">[이전]</a>
											</c:if> 
											<c:forEach var="pageNum" begin="${startPage}"
												end="${endPage < totalPage ? endPage : totalPage}">
												<c:choose>
													<c:when test="${pageNum == page}">
														<b>[${pageNum}]</b>
													</c:when>
													<c:otherwise>
														<a href="inquiry?page=${pageNum}
															<c:if test="${param.type != null}">
																&type=${param.type}
															</c:if>
														">[${pageNum}]</a>
													</c:otherwise>
												</c:choose>
											</c:forEach> 
											<c:if test="${totalPage > endPage }">
												<a href="inquiry?page=${endPage+1}&type=${param.type}">[다음]</a>
												<a href="inquiry?page=${totalPage}&type=${param.type}">[마지막]</a>
											</c:if>
											</td>
										</tr>
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
    		//alert("테스트중10");

        	demo.initChartist();

        	$.notify({
            	icon: 'pe-7s-gift',
            	message: "<b>회원문의 관리 화면에 오신걸 환영합니다.</b>"

            },{
                type: 'info',
                timer: 4000
            });

    	});
    
    	//각 게시물 타입 별 열람 (그려지는 목록이 달라지는)
    	function inquiryType(type) {
			var typenum = type;
			//form 요소의 hidden 값으로 전달 받은 type을 넣어준다.
    		$("#in_type").val(typenum);
			//그 이후 해당 form의 submit 이벤트를 발생 시킴.
    		$("#inquiryType").submit();
		}
    	
    	//답변완료 버튼 클릭
    	function answer(inquiry_num) {
    		//각 모달 창 마다 id가 다르기 때문에 변수에 참조 시킴
    		var modal_id = '#modalPoll-' + inquiry_num;
    		//해당 모달 창의 자식 요소로 있는 text를 변수에 담는다
			var content = $(modal_id).find('#answer_content').val();
    		
    		//데이터 담기
			var answer = {"inquiry_num": inquiry_num,"content": content};

    		//Ajax로 비동기 처리 
			$.ajax({
			url:"${contextPath}/admin/writeAnswer",
			type:"POST",
			data: answer,
			async : false, //ajax 동기 선언
			dataType:"json",
            beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			success:function(result){
				if(result){
	            	swal({
						  text: "문의글 등록이 완료되었습니다.",
						  button: "확인",
						}).then(function() {
	  						location.reload(); //화면 새로고침
	  					});	
				}else{
					swal({
						icon:"warning",
						text:"문의글 등록에 실패했습니다.",
					});
				}
			},
			 error : function(error) {
                	swal({text: "글 등록 중 오류가 발생했습니다.", button: "확인",});
    	            console.log(error);
    	            console.log(error.status);
	        }
		});//ajaxEND
			
		}
	</script>

</html>