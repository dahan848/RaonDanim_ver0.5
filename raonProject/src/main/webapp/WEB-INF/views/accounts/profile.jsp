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
<!--  <link rel="stylesheet" href="${contextPath}/css/gallery-image.css" type="text/css"> -->
<!-- 프로필 페이지 JS -->
<script src="${contextPath}/js/jquery.color.js" ></script>
<script src="${contextPath}/js/jquery.Jcrop.js" ></script>
<script src="${contextPath}/js/gallery-image.js" ></script>
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc"></script>

<script type="text/javascript">
$(document).ready(function() { 
	//alert("로딩 완료46"); 
	
	createGallery(); //갤러리 그려주는 ()
	
	//버튼 눌리면 파일 선택 창 열리게 .trigger 사용 
	$("#btn-image-upload").click(function () {
	    $("#imgInp").trigger("click");
	});
	
	//확인 버튼 인풋 써밋 trigger 하기 
	/*
	$("#btn-crop-confirm").click(function () {
	    $("#sub-btn").trigger("click");
	});
	*/
	
	//파일 미리보기 로직 : 프로필 사진 
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
            }
          reader.readAsDataURL(input.files[0]);
        };
    };
    
    //프로필 Crop 로직
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

//프로필 업로드 submit 이벤트 
function profilepicSubmit() {
    var formData = new FormData($("#fileForm")[0]); //사진 파일 
    var profileData = $("#fileForm").serialize(); //Form 요소 값 직렬화 : user_num, 사진 자르는데 사용되는 xy...
    var contextPath = '<c:out value="${contextPath}"/>';
        
    //파일을 전송하는 ajax
    $.ajax({
        type : 'post',
        url : contextPath + '/profilePicUpload',
        data : formData,
        beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        processData : false,
        contentType : false,
        success : function(result) {
            if(result){
            	swal({
					  text: "프로필 사진 등록에 성공했습니다.",
					  button: "확인",
					}).then(function() {
  						location.reload(); //프로필 사진 등록에 성공하면 화면 새로고침 
  					});	
            }else{
            	swal({
					  text: "프로필 사진 등록에 실패했습니다.",
					  button: "확인",
					});
            }
        },
        error : function(error) {
        	swal({
				  text: "프로필 사진 등록에 실패했습니다.",
				  button: "확인",
				});
            console.log(error);
            console.log(error.status);
        }
    });
	
    //Form에 적힌 요소를 보내는 ajax...
    $.ajax({
   		type : 'post',
        url : contextPath + '/picInfo',
        data : profileData,
        error : function(error) {
            console.log(error);
            console.log(error.status);
        }
    });
    return false; //폼 서밋 이벤트 멈추기
}//프로필 사진 업로드 END

//갤러리 업로드 submit 이벤트 
function gallerypicSubmit() {
	var formData = new FormData($("#galleryForm")[0]); //사진 파일
	var galleryInfo = $("#galleryForm").serialize(); 
	var contextPath = '<c:out value="${contextPath}"/>';
	 $.ajax({
	        type : 'post',
	        url : contextPath + '/galleryPicUpload',
	        data : formData,
	        processData : false,
	        contentType : false,
	        success : function(result) {
	            if(result){
	            	swal({
						  text: "갤러리 사진 등록에 성공했습니다.",
						  button: "확인",
						}).then(function() {
	  						location.reload(); //프로필 사진 등록에 성공하면 화면 새로고침 
	  					});	
	            }else{
	            	swal({
						  text: "갤러리 사진 등록에 실패했습니다.",
						  button: "확인",
						});
	            }
	        },
	        error : function(error) {
            	swal({text: "갤러리 사진 등록에 실패했습니다.", button: "확인",});
	            console.log(error);
	            console.log(error.status);
	        }
	    });
	 
	    //Form에 적힌 요소를 보내는 ajax...
	    $.ajax({
	   		type : 'post',
	        url : contextPath + '/picInfo',
	        data : galleryInfo,
	        error : function(error) {
	            console.log(error);
	            console.log(error.status);
	        }
	    });
	    return false; //폼 서밋 이벤트 멈추기
}//갤러리 업로드 END

//갤러리 사진 그려주는 함수 
function createGallery() {
	var contextPath = '<c:out value="${contextPath}"/>';
	$.ajax({
		url: contextPath + "/accounts/gallery/${profileUser}",
		type: "get",
		dateType : "json",
		success : function(data){
			for(var i in data){
				var path = "${contextPath}/image?fileName=" + data[i].GALLERY_FILE_NAME;
				var fileNum = data[i].GALLERY_FILE_NUM;
				 //기본 뼈대 그리기 
				 $(".carousel-indicators").append("<li data-target='#myCarousel' data-slide-to=\""+i+"\"></li>");
				 $(".carousel-inner").append("<div class='item'><img src='"+path+"' alt='"+i+"' style='width: 100%'></div>");

				 //클래스 속성 부여하기
		         $(".carousel-indicators li:first").addClass("active");
		         $(".carousel-inner .item:first").addClass("active");
		         $('.carousel').carousel();
			}//반복문 종료 
		}
	});
};


//테스트
function initialize() {
	//사용자 거주 도시가 있을 때 화면 
   var searchMap = new google.maps.Map(document.getElementById('googleMap'), {
        zoom: 14,
   });
	
   var geocoder = new google.maps.Geocoder();
   geocodeAddress(geocoder, searchMap);
   function geocodeAddress(geocoder, resultsMap) {
        
        var address = "${user.city}";
	    geocoder.geocode({'address': address}, function(results, status) {        	
        
           
          if (status === 'OK') {
            resultsMap.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
              map: resultsMap,
              position: results[0].geometry.location
            });
          } else {
            //alert('Geocode was not successful for the following reason: ' + status);
          }
        });
      }
}
google.maps.event.addDomListener(window, 'load', initialize);

</script>
<style type="text/css">
.head{
  text-align:left;
  padding-left:25px;
  margin-bottom:0px;
}
.uploadpreview{
  width:150px;
  height:150px;
  display:block;
  border:1px solid #ccc;
  border-radius:10px;
  margin-left:23px;
  margin:0 auto 15px;
  background-size:100% auto;
  background-repeat:no-repeat;
  background-position:center;
}

.upload-wrap{
  float:left;
  width:200px;
}


input[type="file"] {
    color: transparent;
    width: 120px;
    margin: 0 auto;
    margin-left: 60px;
    display: block;
}

</style>
<title>라온다님</title>
</head>
<body>
	<div class="main-container">
		<div class="container">
			<!-- 상단 프로필 타이틀 -->
			<h3 class="section-title" >
				<img class="section-header-icon" src="${contextPath}/img/accounts_Profile.png" alt="" >
            		 나의 프로필
            	<!-- 자신의 페이지 일 때만 [프로필 수정]버튼 보임 -->
				<c:if test="${profileUser eq user_num}">
                	<a href="${contextPath}/accounts/update1Form" class="btn btn-potluck pull-right">프로필 수정</a>
                </c:if>
			</h3>
			<section id="section-user-detail"> <!-- 프로필 section -->
				<div class="user-info"> <!-- 상단 사진, 기본정보 출력 되는 부분 -->
					<div id="myCarousel" class="user-images carousel slide" data-ride="carousel">
						<div id="carousel-user-images" class="carousel slide" data-ride="carousel">
							<ol class="carousel-indicators">
									<!-- ajax 처리 -->
							</ol>
							<div class="carousel-inner">
									<!-- ajax 처리 -->
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
					</div>
					<div class="user-profile"> <!-- 유저 기본 정보 영역 -->
						<a href="#" class="img-profile-container" rel="popover" data-placement="right" data-trigger="focus" data-popover-content="#userInfo">
							<!-- 유저 프로필 사진 -->
    		              	<c:choose>
		              			<c:when test="${user.profile eq 'n'}">
		              				<img src="${contextPath}/img/home_profile_2.jpg" class="img-circle img-avatar">
		              			</c:when>
		              			<c:otherwise>
		              				<img class="img-circle img-avatar" src="${contextPath}/image?fileName=${user.profile}">
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
                       		<!-- 숙박평점 -->
                        	<div class="col-xs-6">
                            	<div class="friends-count">
                            		${user.motel_avg} 
                            	</div>
                            		<small>숙박평점</small> 
                       		</div>
                       		<!-- 후기평점 -->
                        	<div class="col-xs-6">
                            	<div class="friends-count">
                            		${user.with_avg}
                           		</div>
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
	                    	<c:if test="${user.age eq null}">
	                  			<span class="label label-pink label-lg">미작성</span>
							</c:if>
	                    		<p>${user.age}</p> 
	                    </div>
                	</div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">좋아하는 것</label>
                    	<div class="col-sm-9">
                    		<!-- 좋아하는 것(관심사) 반복문으로 출력 -->
      			            <c:if test="${user.interest eq null}">
	                  			<span class="label label-pink label-lg">미작성</span>
	                  		</c:if>
                    		<c:forEach items="${user.interest}" var="interest">
                    			<span class="label label-default label-lg">${interest.INTEREST_KO_NAME}</span>	
                    		</c:forEach>
                    	</div>
                </div>
                <div class="row">
                    <label class="col-sm-3 control-label text-right">사용가능언어</label>
                    	<div class="col-sm-9">
                    		<!-- 사용가능언어 : 조건문 + 반복문 -->
      			            <c:if test="${user.language eq null}">
	                  			<span class="label label-pink label-lg">미작성</span>
	                  		</c:if>
                           	<c:forEach items="${user.language}" var="language">
                    			<span class="label label-default label-lg">${language.LANGUAGE_KO_NAME}</span>	
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
                    <c:if test="${user.city eq null}">
                  	  	<span class="label label-pink label-lg">미작성</span>
                    </c:if>
                        <p>${user.city}</p>
                        <div id="googleMap" style="width: 700px; height: 500px;"></div>
                    </div>
                </div>
<!--                 <div class="row"> -->
<!--                     <label class="col-sm-3 control-label text-right">숙박 제공 가능 여부</label> -->
<!--                     	<div class="col-sm-9"> -->
<%--                     		<c:if test="${user.accom_st eq 0 }"><span class="label label-gray label-lg">불가능</span></c:if> --%>
<%--                     		<c:if test="${user.accom_st eq 2 }"><span class="label label-skyblue label-lg">가능(무료)</span></c:if> --%>
<%--                     		<c:if test="${user.accom_st eq 3 }"><span class="label label-pink label-lg">가능(유료)</span></c:if> --%>
<!-- 						</div> -->
<!--                 </div> -->
				</div> <!-- 유저 상세 정보 출력 부  END-->
			</section> <!-- 프로필 section END-->
		</div>
	</div>
	<!-- POPOVER DIV -->
	<div id="userInfo" class="hide" style="margin-left: auto; margin-right: auto; text-align: center;">
	   <c:choose>
			<c:when test="${profileUser eq user_num}">
	        	<a href="#" data-toggle="modal" data-target="#modal-profile-image">프로필 사진</a><br>
	        	<a href="#" data-toggle="modal" data-target="#modal-gallery-image">갤러리 사진</a><br>
	        	<a href="${contextPath}/accounts/gallerySettings">갤러리 관리</a>
	   		</c:when>
        	<c:otherwise>
				<sec:authorize access="isAuthenticated()"> <!-- 로그인 상태 일때만 표시 -->    	    		
        		<a onclick="chatClickbyUser(${profileUser},${user_num})">대화하기</a>
				</sec:authorize>
				<sec:authorize access="isAnonymous()"> <!-- 로그인 상태 X -->
				<a href="#">로그인 이후 사용 가능합니다.</a>
				</sec:authorize>    	    		
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
					    <form id="fileForm" action="#" method="post" enctype="multipart/form-data">
					        <input type='file' id="imgInp" name ="file" class="hidden" />
					        <input type="hidden" name="user_num" value="${user_num}">
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
                            <button id="btn-crop-confirm" class="btn btn-potluck btn-block" onclick="profilepicSubmit();">확인</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 갤러리 사진 등록 모달창 -->
	 <div id="modal-gallery-image" class="modal fade" tabindex="-1" role="dialog">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
               <div class="modal-header">
                    	파일을 선택해주세요.
                </div>
	            <div class="modal-body">
	                <div class="imgContainer"> <!-- 이 놈이 모달창 속 사진의 크기를 강제로 묶음 -->
	                    <div class="container"> 
	                        <br> 
	                        <div class="col-sm-7" style="width: auto; padding: 0px; margin-left: -30px;"> 
	                            <form id="galleryForm" role="form"> 
	                            	<input type="hidden" name="user_num" value="${user_num}">
									<div class="upload-wrap"><p class="head">
									  <div class="uploadpreview 01"></div>
									  <input name ="fileUp1" id="01" type="file" accept="image/*">
									</div>
									
									<div class="upload-wrap"><p class="head">
									  <div class="uploadpreview 02"></div>
									  <input name ="fileUp2" id="02" type="file" accept="image/*">
									</div>
									
									<div class="upload-wrap"><p class="head">
									  <div class="uploadpreview 03"></div>
									  <input name ="fileUp3" id="03" type="file" accept="image/*">
									</div>
	                            </form> 
	                        </div> 
	                    </div>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <div class="row">
	                    <div class="col-xs-6">
	                        <button class="btn btn-default btn-block" data-dismiss="modal">취소</button>
	                    </div>
	                    <div class="col-xs-6">
	                        <button id="btn-crop-confirm" class="btn btn-potluck btn-block" onclick="gallerypicSubmit();">확인</button>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
<!-- 인클루드-푸터 -->
<jsp:include page="/WEB-INF/views/test.jsp"></jsp:include> <!-- 채팅방 모달창 -->
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<!-- 인클루드-푸터 END -->
</body>
</html>