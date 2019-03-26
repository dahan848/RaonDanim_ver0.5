<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 후기 메인</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

<script type="text/javascript">
//-------------- 프로필 팝오버 --------------//		
$(function(){ 
    $('[rel="popover"]').popover({
        container: 'body',
        html: true,
        content: function () {
            var clone = $($(this).data('popover-content')).clone(true).removeClass('hide');
            return clone;
        }
    }).click(function(e) {
        e.preventDefault();
    });
});

//-------------- 무한 스크롤 --------------//	
$(window).on("scroll",function() {
	var scrollHeight = $(document).height();
	var scrollPosition = $(window).height() + $(window).scrollTop();
	
	if(scrollPosition > scrollHeight - 300) {
		$("#scroll").append('<div class="box" id="box"></div>');
	}
});
</script>




<style type="text/css">
	#box {
 		float: left; 
		margin: 10px;
/* 		border: 1px solid black; */
		width: 350px;
		height: 350px;
		background-color: #eeeeee;
	}
	#backimg { 
   		background-image: url("${contextPath}/img/search-back.jpg");   
 		background-repeat: no-repeat; 
 		background-position: left; 
 		background-size: cover; 
/*  	  	border: 1px solid red;   */
 		z-index: 1; 
 		width: 348px; 
 		height: 120px; 
 		margin: auto; 
 	} 
 	#userimg { 
/*   		background-repeat: no-repeat;   */
/*   		background-position: bottom;   */
/*  		background-size: cover;  */
 		border-radius: 50%; 
 		z-index: 2; 
/*  		border: 1px solid black;  */
  		margin: 0 auto;  
   		margin-top: -50px;    
 		width: 100px; 
 		height: 100px; 
/*  		margin-left: 100px; */
		margin-left: 35%;
 	} 
 	#profile { 
 		font-size: 20px; 
 		text-align: center; 
 		z-index: 1;
	} 
/* 	.input-group.md-form.form-sm.form-1 input{ */
/*     border: 1px solid #bdbdbd; */
/*     border-top-right-radius: 0.25rem; */
/*     border-bottom-right-radius: 0.25rem; */
/* 	} */
/* 	.input-group.md-form.form-sm.form-2 input { */
/*     	border: 1px solid #bdbdbd; */
/*     	border-top-left-radius: 0.25rem; */
/*     	border-bottom-left-radius: 0.25rem; */
/* 	} */
/* 	.input-group.md-form.form-sm.form-2 input.red-border  { */
/*     	border: 1px solid #ef9a9a; */
/* 	} */
/* 	.input-group.md-form.form-sm.form-2 input.lime-border  { */
/*     	border: 1px solid #cddc39; */
/* 	} */
/* 	.input-group.md-form.form-sm.form-2 input.amber-border  { */
/*     	border: 1px solid #ffca28; */
/* 	} */
/* 	#basic-text1 { */
/* 		width: 30px;  */
/* 		height: 30px; */
/* 		margin-left: 10px; */
/* 		border-radius: 50%; */
/* 	} */


/*
input[type=text] {
  width: 130px;
  box-sizing: border-box;
  border: 2px solid #ccc;
  border-radius: 4px;
  font-size: 16px;
  background-color: white;
  background-image: url('searchicon.png');
  background-position: 10px 10px; 
  background-repeat: no-repeat;
  padding: 12px 20px 12px 40px;
  -webkit-transition: width 0.4s ease-in-out;
  transition: width 0.4s ease-in-out;
}

input[type=text]:focus {
  width: 50%;
}
*/

</style>

</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/review/review-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->
<form action="withMain">
	<!-- 본문 -->
	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<h3 id="h3" style="font-family: 'Jua', sans-serif; font-size: 40px;"><b>동행후기</b></h3>
				<h5 style="font-family: 'Jua', sans-serif;  font-size: 20px; color: gray;">함께 여행한 친구의 타임라인에 후기를 남겨주세요</h5>
				
				<br>
				
				<!------------ 검색 시작 ------------>
				<div style="display: inline;">
					<input type="text" class="form-control input-lg" name="keyword" placeholder="아이디를 검색하세요" style="width: 50%; display: inline;">
				</div>
				<div style="display: inline;">
					<button type="submit" class="btn btn-primary"
					style="background-color: #eeeeee; color: green; display: inline; margin-left: 10px; border: 0.5px solid green;">
						<i class="fas fa-search"></i>
					</button>
					
				</div>
            	<!------------ 검색 끝 ------------>
            
            <br><br><br>
            
            <div id="scroll">
            <!------------ 회원 프로필 화면 시작 ------------>
            <c:forEach items="${with.searchList}" var="with" varStatus="status"> 
            <input type="hidden" name="num" value="${with.USER_NUM }">
               <div class="box" id="box">
                  <div id="backimg"></div>
                  		<c:choose>
				  			<c:when test="${with.USER_PROFILE_PIC eq 'n'}">
								<a href="" rel="popover" data-placement="bottom" data-trigger="focus"
										data-popover-content="#userInfo${status.index}"> 
									<img id="userimg"  class="img-circle" src="${contextPath}/img/home_profile_2.jpg">
								</a>
							</c:when>
							<c:otherwise>
								<a href="" rel="popover" data-placement="bottom"
										data-popover-content="#userInfo${status.index}"> 
									<img id="userimg" class="img-circle" src="${contextPath}/image?fileName=${user.USER_PROFILE_PIC}">
								</a>
							</c:otherwise>
				  		 </c:choose>
                  
                  <div id="userInfo${status.index}" class="hide" style="margin-left: auto; margin-right: auto; text-align: center;">
						${with.USER_LNM} ${with.USER_FNM} <br>
						<a href="${contextPath}/accounts/profile?user=${with.USER_NUM}">프로필보기</a><br>
						<sec:authorize access="isAuthenticated()"> <!-- 로그인 상태 일때만 표시 -->
<%-- 							<a onclick="chatClickbyUser(${user_num},${with.USER_NUM})">대화하기</a> --%>
						</sec:authorize>
				 </div>
				 <br>
                  <div id="profile">
                     	<a href="withList?num=${with.USER_NUM}" style="text-align: center; display: inline-block;">${with.USER_LNM}${with.USER_FNM}</a>
                     	<br>
                     	<span style="text-align: center; display: inline-block; font-size: 18px;">${with.USER_ID}</span>
                     	<br>
                     	<span style="text-align: center; display: inline-block; font-size: 15px;">NATIONALITY : ${with.USER_NATIONALITY}</span>
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
                  	</div>
               </div>      
            </c:forEach>
            <!------------ 회원 프로필 화면 끝 ------------>
			</div>	
				<!------------ 화면 맨 위로 시작 ------------>
				<div style="position: fixed; bottom: 20px; right: 150px;">
					<a href="#" style="font-size: 50px;">
						<i class="fas fa-arrow-alt-circle-up" style="color: #cccccc;"></i>
					</a>
				</div>
				<!------------ 화면 맨 위로 끝 ------------>
			</div>
		</section>
	</div>
</form>
	<!-- 본문 END-->
	
	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>