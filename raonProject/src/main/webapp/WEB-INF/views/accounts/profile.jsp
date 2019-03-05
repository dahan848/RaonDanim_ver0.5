<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 스프링 시큐리티 taglib -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!-- 스프링 시큐리티 taglib 이용 로그인 된 사용자 user_num 변수에 담기 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.user_num" var="user_num"/>
</sec:authorize>
<!DOCTYPE html>

<html>
<head>
<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
<!-- 프로필 페이지 CSS -->
<link rel="stylesheet" href="${contextPath}/css/jquery.Jcrop.min.css" type="text/css"> 
<!-- 프로필 페이지 JS -->
<script src="${contextPath}/js/jquery.color.js" ></script>
<script src="${contextPath}/js/jquery.Jcrop.js" ></script>
<script type="text/javascript">
$(document).ready(function() { 
	alert("로딩 완료42"); 
	
	//버튼 눌리면 파일 선택 창 열리게 .trigger 사용 
	$("#btn-image-upload").click(function () {
	    $("#imgInp").trigger("click");
	});
	
	//확인 버튼 인풋 써밋 trigger 하기 
	$("#btn-crop-confirm").click(function () {
	    $("#sub-btn").trigger("click");
	});
	
    $(function() {
        $("#imgInp").on('change', function(){
            readURL(this);
        });
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
        	
        var reader = new FileReader();
         
        reader.onload = function (e) {
                $('#blah').attr('src', e.target.result);
                alert("짜잔!" + $('#blah').attr('src'));
            }
          reader.readAsDataURL(input.files[0]);
        };
    };
    /////////////////////////////////////////
	$("#blah").on("load",function(){
	    $(function(){
	    	$('#blah').Jcrop({
	    		aspectRatio: 1,
	    		onSelect: updateCoords
	    	});
	    });

	    function updateCoords(c)
	    {
	    	$('#x').val(c.x);
	    	$('#y').val(c.y);
	    	$('#w').val(c.w);
	    	$('#h').val(c.h);
	    };

	    function checkCoords()
	    {
	    	if (parseInt(jQuery('#w').val())>0) return true;
	    	alert('자를 영역을 선택 한 다음 확인 버튼을 눌러주세요.');
	    	return false;
	    };
	});
});//onload END
</script>

<title>라온다님</title>
</head>
<body>
	<div class="main-container">
		<div class="container">
			<!-- 상단 프로필 타이틀 -->
			<h3 class="section-title">
				<img class="section-header-icon" src="${contextPath}/img/accounts_Profile.png" alt="">
            		 나의 프로필
            	<!-- 자신의 페이지 일 때만 [프로필 수정]버튼 보임 -->
				<c:if test="${userNum eq user_num}">
                	<a href="${contextPath}/accounts/update1Form" class="btn btn-potluck pull-right">프로필 수정</a>
                </c:if>
			</h3>
			<section id="section-user-detail"> <!-- 프로필 section -->
				<div class="user-info"> <!-- 상단 사진, 기본정보 출력 되는 부분 -->
					<div class="user-images"><!-- 유저 이미지 영역 -->
						<div id="carousel-user-images" class="carousel slide" data-ride="carousel">
						  <ol class="carousel-indicators">
						    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						    <li data-target="#myCarousel" data-slide-to="1"></li>
						    <li data-target="#myCarousel" data-slide-to="2"></li>
						  </ol>
						<!-- 갤러리 이미지 불러와야 할 부분 -->
						  <div class="carousel-inner">
						    <div class="item active">
						      <img src="" alt="Los Angeles">
						    </div>
						    <div class="item">
						      <img src="" alt="Chicago">
						    </div>
						    <div class="item">
						      <img src="" alt="New York">
						    </div>
						  </div>
						  <!-- Left and right controls -->
						  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
						    <span class="glyphicon glyphicon-chevron-left"></span>
						    <span class="sr-only">Previous</span>
						  </a>
						  <a class="right carousel-control" href="#myCarousel" data-slide="next">
						    <span class="glyphicon glyphicon-chevron-right"></span>
						    <span class="sr-only">Next</span>
						  </a>
						</div>
					</div><!-- 유저 이미지 영역 END -->

					<div class="user-profile"> <!-- 유저 기본 정보 영역 -->
						<a href="#" class="img-profile-container" rel="popover" data-placement="right" data-trigger="focus" data-popover-content="#userInfo">
							<!-- 유저 프로필 사진 -->
    		              	<c:choose>
		              			<c:when test="${user.profile eq 'n'}">
		              				<img src="${contextPath}/img/home_profile_2.jpg" class="img-circle img-avatar">
		              			</c:when>
		              			<c:otherwise>
		              				<img src="${contextPath}/img/home_Message.png">
		              			</c:otherwise>
		              		</c:choose>
				   		</a>
				   		<!-- 이름  -->
				        <h4>${user.name}</h4>
				        <!-- 도시, 국가 : 거주도시 -->
					    <p class="mb-0">Seoul, South Korea</p>
				   		<!-- 성별 : c:if-->
				     	<c:if test="${user.gender eq 0 }"><p>기타</p></c:if>
				     	<c:if test="${user.gender eq 1 }"><p><i class="fa fa-mars-stroke-v fa-lg"></i></p></c:if>
				     	<c:if test="${user.gender eq 2 }"><p><i class="fa fa-venus fa-lg"></i></p></c:if> 
						<!-- 마지막 로그인 정보 -->
						<c:if test="${user.lastLogin eq 666 }"> <p><small>로그인 정보가 없습니다.</small></p></c:if>
				  		<c:if test="${user.lastLogin ne 666 }"><p><small>Last login ${user.lastLogin} minutes ago</small></p></c:if> 
                   		<hr>
                   		<div class="row">
                        	<div class="col-xs-6">
                            	<div class="friends-count"><i class="ion ion-ios-heart"></i> ${user.motel_avg}</div>
                            		<!-- 숙박평점 -->
                            		<small>숙박평점</small> 
                       		</div>
                        	<div class="col-xs-6">
                            	<div class="friends-count"><i class="ion ion-android-person"></i> ${user.with_avg}</div>
                            		<!-- 후기평점 -->
                            		<small>후기평점</small>	
                        	</div>
                    	</div>
					</div> <!-- 유저기본 정보 영역 END -->
				</div> <!-- 상단 사진, 기본정보 출력 되는 부분 END -->
				
				<div class="user-descriptions"> <!-- 유저 상세 정보 출력 부  -->
	          		<div class="row">
	              		<label class="col-sm-3 control-label text-right">나의소개</label>
	              			<div class="col-sm-9">
	              				<!-- 자기소개 : 값 없으면 [미작성] -->
	                  			<c:if test="${user.intro eq null}">
	                  				<span class="label label-pink label-lg">미작성</span>
	                  			</c:if>
	                  			<p>${user.intro}</p>	
	              			</div>
	          		</div>
               		<div class="row">
                    	<label class="col-sm-3 control-label text-right">나이</label>
	                    <div class="col-sm-9">
	                    	<!-- 나이 -->
	                    	<p>${user.age}</p> 
	                    </div>
                	</div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">좋아하는 것</label>
                    	<div class="col-sm-9">
                    		<!-- 좋아하는 것(관심사) 반복문으로 출력 -->
                    		<c:forEach items="${user.interest}" var="interest">
                    			<span class="label label-default label-lg">${interest.INTEREST_NAME}</span>	
                    		</c:forEach>
                    	</div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">사용가능언어</label>
                    	<div class="col-sm-9">
                    		<!-- 사용가능언어 : 반복문 -->
                           	<c:forEach items="${user.language}" var="language">
                    			<span class="label label-default label-lg">${language.LANGUAGE_NAME}</span>	
                    		</c:forEach>
                   		</div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">국적</label>
                    <div class="col-sm-9">
                    	<!-- 국적 : 값 없으면 [미작성] -->
	                  		<c:if test="${user.nationality eq null}">
	                  			<span class="label label-pink label-lg">미작성</span>
	                  		</c:if>
                        <p>${user.nationality}</p>
                    </div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">거주 도시</label>
                    <div class="col-sm-9">
                        <p>프로필 화면 테스트 더미 데이터</p>
                    </div>
                </div>
                <div class="row">	<!-- 나와의 거리 영역 지도 필요 -->
                	<label class="col-sm-3 control-label text-right">나와의 거리</label>
                    	<div class="col-sm-9">
                        	<p id="map-address-info"
                            	data-mylat="37.56600"
                            	data-mylng="126.97840"
                            	data-friendlat="37.56600"
                            	data-friendlng="126.97840">
                             	Seoul, South Korea - Seoul, South Korea
                             <strong id="distance"></strong>KM</p>
                         	<div id="map-canvas" style="height: 300px;"></div>
                     	</div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">숙박 제공 가능 여부</label>
                    	<div class="col-sm-9">
                    		<c:if test="${user.accom_st eq 0 }"><span class="label label-gray label-lg">불가능</span></c:if>
                    		<c:if test="${user.accom_st eq 2 }"><span class="label label-skyblue label-lg">가능(무료)</span></c:if>
                    		<c:if test="${user.accom_st eq 3 }"><span class="label label-pink label-lg">가능(유료)</span></c:if>
						</div>
                </div>
				</div> <!-- 유저 상세 정보 출력 부  END-->
			</section> <!-- 프로필 section END-->
		</div>
	</div>
	<!-- POPOVER DIV -->
	<div id="userInfo" class="hide" style="margin-left: auto; margin-right: auto; text-align: center;">
	   <c:choose>
		<c:when test="${userNum eq user_num}">
	
        	<a  href="#" data-toggle="modal" data-target="#modal-profile-image">프로필 사진 변경</a><br>
        		</c:when>
        	<c:otherwise>
        		<a href="#">대화하기</a>
        	</c:otherwise>
        </c:choose>
	</div>   
	<!-- 프로필 이미지 변경 모달 창 -->
	 <div id="modal-profile-image" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    	자를 영역을 선택해주세요.
                    <button id="btn-image-upload" class="btn btn-potluck btn-sm pull-right">파일찾기</button>
                </div>
                
                <!-- 프로필 이미지 미리보기가 출력되는 DIV -->
                <div class="modal-body">
                	<div class="imgContainer"> <!-- 이 놈이 모달창 속 사진의 크기를 강제로 묶음 -->
					    <form action="#" method="post" onsubmit="return checkCoords();">
					        <input type='file' id="imgInp" class="hidden" />
					        <img id="blah" style="max-width: 570px;" src="#" />
							<input type="hidden" id="x" name="x" />
							<input type="hidden" id="y" name="y" />
							<input type="hidden" id="w" name="w" />
							<input type="hidden" id="h" name="h" />
							<input type="submit" style="display: none;" id="sub-btn"/>
					    </form>
				    </div>
                </div>
                
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-xs-6">
                            <button class="btn btn-default btn-block" data-dismiss="modal">취소</button>
                        </div>
                        <div class="col-xs-6">
                            <button id="btn-crop-confirm" class="btn btn-potluck btn-block">확인</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
<!-- 인클루드-푸터 -->
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<!-- 인클루드-푸터 END -->
</body>
</html>