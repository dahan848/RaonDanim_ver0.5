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
</script>

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
/*       		border: 1px solid #cccccc; */
/*       		background-color: #eeeeee; */
      		width: 500px;
/*       		float: right; */
/*       		margin-bottom: 10px; */
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
                    ${withBoard.User.user_lnm}${withBoard.User.user_fnm}님의 후기 게시판
                </h3>
 
                <!----------------------------------------- 프로필 시작 -------------------------------------->
                <div class="box" id="box">
                    <c:choose>
				  			<c:when test="${withBoard.User.user_profile_pic eq 'n'}">
								<a href="" rel="popover" data-placement="bottom" data-trigger="focus"
										data-popover-content="#userInfo${status.index}"> 
									<img id="userimg"  class="img-circle" src="${contextPath}/img/home_profile_2.jpg">
								</a>
							</c:when>
							<c:otherwise>
								<a href="" rel="popover" data-placement="bottom"
										data-popover-content="#userInfo${status.index}"> 
									<img id="userimg" class="img-circle" src="${contextPath}/image?fileName=${withBoard.User.user_profile_pic}">
								</a>
							</c:otherwise>
				  		 </c:choose>
                    <br>
                    <span style="text-align: center; display: inline-block;">${withBoard.User.user_lnm}${withBoard.User.user_fnm}</span>
                    <br>
                    <span style="text-align: center; display: inline-block; font-size: 18px;">-${withBoard.User.user_id}-</span>
                    
                    
                    <br>
                    <c:if test="${withBoard.User.user_gender == 1}">
                     	<i class="fas fa-mars"></i>
                     </c:if>
                     <c:if test="${withBoard.User.user_gender == 2}">
                     	<i class="fas fa-venus"></i>
                     </c:if>
                     <c:if test="${withBoard.User.user_gender == 0}">
                     	<i class="fas fa-skull-crossbones"></i>
                     </c:if>
                    <br> <i class="fas fa-home"> <br> <a>숙소 평점</a> <br>
                        <span><i style="color: blue;">4.2</i> / 5</span>
                    </i> <i class="fas fa-camera" style="margin-left: 20px;"> <br>
                        <span>후기 평점</span> <br> <span><i style="color: blue;">${avgStar.reviewAvg}</i> / 5</span>
                    </i>
                </div>
                <!----------------------------------------- 프로필 끝 -------------------------------------->
 				<input type="hidden" name="num" value="${param.num}">
                <button type="button" class="btn btn-primary" id="upload"
                    style="float: right; background-color: #eeeeee; color: green;" onclick="location.href='withWriteForm?num=${param.num}'">
                	<i class="far fa-edit"></i> 후기올리기
                </button>
                <button type="button" class="btn btn-primary" id="btnMain"
                    style="float: right; background-color: #eeeeee; color: green; margin-right: 20px;" onclick="location.href='withMain'">
                    	<i class="fas fa-align-justify"></i> 메인화면
                </button>
                    
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
                            <span style="font-size: 20px; vertical-align: middle;">
                                ${withList.USER_LNM}${withList.USER_FNM}
                            </span>
                        </td>
<!--                         <td style="border: 1px solid #cccccc; text-align: center;"> -->
<!--                             <a style="font-size: 20px;"> -->
<%--                                 <i style="color: blue;">${withList.WITH_GPA}</i> / 5 --%>
<!--                             </a> -->
<!--                         </td> -->
                        <!----------------------------------------- 별점 시작 -------------------------------------->
						<td>
							<div id="starCase">		
								<div class="starRevWookJin" id="reviewScore">
									<c:set var="cnt" value="1" />
									<c:forEach begin="1" end="5">
										<c:if test="${cnt<= withList.WITH_GPA}">
											<span class="starR on" id="star">Wookjin</span>
										</c:if>
										<c:if test="${cnt> withList.WITH_GPA}">
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
                   	 	</td>
                        <td style="border: 1px solid #cccccc; text-align: center;">
                        	<input type="hidden" name="WR_USER_NUM" value="${withList.WR_USER_NUM }">
                        	<input type="hidden" name="WITH_NUM" value="${withList.WITH_NUM}">
                        	<input type="hidden" name="TL_USER_NUM" value="${withList.TL_USER_NUM }">
                        	<input type="hidden" name="userNum" value="${withBoard.userNum}">
                            <button type="button" class="btn btn-primary" id="btnWithReview" 
                                onclick="location.href='withView?tlUser=${withList.TL_USER_NUM}&wrUser=${withList.WR_USER_NUM}&withNum=${withList.WITH_NUM}&userNum=${withBoard.userNum}'" 
                                style="background-color: #eeeeee; color: green;">
                                <i class="fas fa-check-circle"></i> 상세보기 
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <!---------------------------------- 동행후기 리스트 끝 ---------------------------------->
        </div>
        
            <!---------------------------------- 동행후기 리스트 페이징 시작 ---------------------------------->
            <div style="margin-top: 50px; text-align: center;">
                <ul class="pagination justify-content-center">
                    
                    <li class="page-item">
                    	<c:if test="${startPage != 1}">
                    		<a class="page-link" href="withList?page=1">                        
                        		START
                    		</a>
                   		</c:if>
                   	</li>
                    <li class="page-item">
                    	<c:forEach var="pageNum" begin="${startPage}" end="${endPage < totalPage ? endPage : totalPage}">
                    		<c:choose>
                    			<c:when test="${pageNum == page}">
                    				<a class="page-link">
                    					${pageNum}
                    				</a>	
                    			</c:when>
                    			<c:otherwise>
                    				<a class="page-link" href="withList?page=${pageNum}">
                    					${pageNum}	
                    				</a>	
                    			</c:otherwise>
                    		</c:choose>
                    	</c:forEach>
                    </li>
                    <li class="page-item">
                    	<c:if test="${totalPage > endPage}">
                    		<a class="page-link" href="withList?page=${totalPage}">
                    			END
                    		</a>
                    	</c:if>
                    </li>
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