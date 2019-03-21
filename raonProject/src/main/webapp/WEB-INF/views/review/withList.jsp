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
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
    integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
    crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

<style type="text/css">
	#box {
    	float: left;
    	margin: 30px;
    	border: 1px solid #cccccc;
    	width: 250px;
    	height: 350px;
    	text-align: center;
    	font-size: 20px;
    	background: #eeeeee;
    	width: 250px;
    	height: 350px;
	}
    #withReview { 
         float: right; 
         width: 800px;
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
</style>

</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/review/review-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->

<form action="withWriteForm" method="get">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<%-- <input type="hidden" name="userName" value="${withBoard.USER_LNM}${withBoard.USER_FNM}"> --%>
<%-- <input type="hidden" name="user_num" value="${withBoard.USER_NUM}"> --%>
       <div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
            	<div class="tab-content">
 
                <h3>
                    <i class="fas fa-cloud" style="font-size: 38px; color: aqua;"></i>
                    ${withBoard.user_lnm}${withBoard.user_fnm}님의 후기 게시판
                </h3>
 
                <!----------------------------------------- 프로필 시작 -------------------------------------->
                <div class="box" id="box">
                    <div id="userimg"></div>
                    <br> <a>${withBoard.user_lnm}${withBoard.user_fnm}</a> <br>
                    <br> <a>여행지 : <b>${withBoard.user_gender}</b></a> <br>
                    <br> <i class="fas fa-home"> <br> <a>숙소 평점</a> <br>
                        <a><i style="color: blue;">4.2</i> / 5</a>
                    </i> <i class="fas fa-camera" style="margin-left: 20px;"> <br>
                        <a>후기 평점</a> <br> <a><i style="color: blue;">4.8</i> / 5</a>
                    </i>
                </div>
                <!----------------------------------------- 프로필 끝 -------------------------------------->
 				<input type="hidden" name="num" value="${param.num}">
                <input type="button" class="btn btn-primary" id="upload"
                    style="float: right;" onclick="location.href='withWriteForm?num=${param.num}'" value="후기올리기">
                    
                <button type="button" class="btn btn-primary" id="btnMain"
                    style="float: right; margin-right: 20px;" onclick="location.href='withMain'">메인화면</button>
                    
            </div>
 
            <br>
            <br>
            <br>
 
            <!---------------------------------- 동행후기 리스트 시작 ---------------------------------->
            <table class="table table-bordered" id="withReview">
                <tr style="background-color: #eeeeee;">
                    <th style="border: 1px solid #cccccc; text-align: center;">닉네임</th>
                    <th style="border: 1px solid #cccccc; text-align: center;">평점</th>
                    <th style="border: 1px solid #cccccc; text-align: center;">상세보기</th>
                </tr>
 				
                <c:forEach items="${withList}" var="withList" varStatus="status">
                    <tr style="border: 1px solid #cccccc;">
                        <td style="border: 1px solid #cccccc; text-align: center;">
                            <a style="font-size: 20px;">
                                ${withList.USER_LNM}${withList.USER_FNM}
                            </a>
                        </td>
                        <td style="border: 1px solid #cccccc; text-align: center;">
                            <a style="font-size: 20px;">
                                <i style="color: blue;">${withList.WITH_GPA}</i> / 5
                            </a>
                        </td>
                        <td style="border: 1px solid #cccccc; text-align: center;">
                        	<input type="hidden" name="WR_USER_NUM" value="${withList.WR_USER_NUM }">
                        	<input type="hidden" name="WITH_NUM" value="${withList.WITH_NUM}">
                        	<input type="hidden" name="TL_USER_NUM" value="${withList.TL_USER_NUM }">
                            <input type="button" class="btn btn-primary" id="btnWithReview" 
                                onclick="location.href='withView?tlUser=${withList.TL_USER_NUM}&wrUser=${withList.WR_USER_NUM}&withNum=${withList.WITH_NUM}'" 
                                value="상세보기" style="background-color: #eeeeee; color: green;">
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <!---------------------------------- 동행후기 리스트 끝 ---------------------------------->
        </div>
        
            <!---------------------------------- 동행후기 리스트 페이징 시작 ---------------------------------->
            <div style="margin-top: 50px; text-align: center;">
                <ul class="pagination justify-content-center">
                    <li class="page-item"><a class="page-link"
                        href="javascript:void(0);">Previous</a></li>
                    <li class="page-item"><a class="page-link"
                        href="javascript:void(0);">1</a></li>
                    <li class="page-item"><a class="page-link"
                        href="javascript:void(0);">2</a></li>
                    <li class="page-item"><a class="page-link"
                        href="javascript:void(0);">3</a></li>
                    <li class="page-item"><a class="page-link"
                        href="javascript:void(0);">4</a></li>
                    <li class="page-item"><a class="page-link"
                        href="javascript:void(0);">5</a></li>
                    <li class="page-item"><a class="page-link"
                        href="javascript:void(0);">Next</a></li>
                </ul>
            </div>
            <!---------------------------------- 동행후기 리스트 페이징 끝 ---------------------------------->
        </section>
        </div>
    </form>

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>