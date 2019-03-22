<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 후기 메인</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

<style type="text/css">
	#box {
 		float: left; 
		margin: 10px;
		border: 1px solid black;
		width: 350px;
		height: 350px;
	}
	#backimg { 
   		background-image: url("${contextPath}/img/search-back.jpg");   
 		background-repeat: no-repeat; 
 		background-position: left; 
 		background-size: cover; 
	  	border: 1px solid red;  
 		z-index: 1; 
 		width: 348px; 
 		height: 190px; 
 		margin: auto; 
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
   		margin-top: -50px;   
 		width: 100px; 
 		height: 100px; 
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
				<h3 id="h3" style="font-family: 'Nanum Pen Script', cursive; font-size: 50px;"><b>동행후기</b></h3>
				<h5 style="font-family: 'Nanum Pen Script', cursive;  font-size: 30px;">함께 여행한 친구의 타임라인에 후기를 남겨주세요</h5>
				
				<br>
				
				<!------------ 검색 시작 ------------>
<!--            		<div class="input-group md-form form-sm form-2 pl-0" > -->
<!--   					<input class="form-control my-0 py-1 red-border" type="text" placeholder="함께 여행한 친구의 이름,아이디를 검색하세요."  -->
<!--   							aria-label="Search" style="display: inline-block; width: 1000px;" name="keyword"> -->
<!--   					<div class="input-group-append"  style="float: right; display: inline-block;"> -->
<!--     					<button class="input-group-text red lighten-3" id="basic-text1"> -->
<!--     						<i class="fas fa-search text-grey" aria-hidden="true"></i> -->
<!--   						</button> -->
<!--   					</div> -->
<!-- 				</div> -->



<!-- 				<div style="display: inline;"> -->
<!-- 					<select name="type"> -->
<!-- 						<option value="1">이름</option> -->
<!-- 						<option value="2">아이디</option> -->
<!-- 					</select> -->
<!-- 				</div> -->



				<div style="display: inline;">
<!-- 				<input type="text" name="keyword" placeholder="Search.."> -->
					<input type="text" name="keyword" placeholder="검색어를 입력하세요">
				</div>
				<div style="display: inline;">
					<input type="submit">
				</div>
            	<!------------ 검색 끝 ------------>
            
            <br><br><br>
            
            <!------------ 회원 프로필 화면 시작 ------------>
            <c:forEach items="${with}" var="with" varStatus="status"> 
            <input type="hidden" name="num" value="${with.USER_NUM }">
               <div class="box" id="box">
                  <div id="backimg"></div>
                  <div id="userimg"></div>  
                  <div id="profile">
                     	<a href="withList?num=${with.USER_NUM}" style="text-align: center; display: inline-block;">${with.USER_LNM}${with.USER_FNM}</a>
                     	<br>
                    	 <i class="fas fa-home">
                        	<br>
                        	<a>숙소 평점</a>
                       		<br>
                        	<a><i style="color: blue;">4.2</i> / 5</a>
                     	</i>
                    	<i class="fas fa-camera" style="margin-left: 20px;">
                        	<br>
                        	<a>후기 평점</a>
                        	<br>
                        	<a><i style="color: blue;">4.8</i> / 5</a>
                    	 </i>
                  	</div>
               </div>      
            </c:forEach>
            <!------------ 회원 프로필 화면 끝 ------------>
				
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