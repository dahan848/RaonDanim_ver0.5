<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%	request.setAttribute("contextPath", request.getContextPath()); %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>


<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.user_num" var="user_num"/>
	<sec:authentication property="principal.user_profile_pic" var="profile_pic"/>
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
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
<link href="${contextPath}/css/image-picker.css" rel="stylesheet">
<meta charset="UTF-8">
<title>라온다님</title>
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/accounts/accounts-navbar.jsp"></jsp:include>
	<script src="${contextPath}/js/image-picker.min.js" ></script>
	<script src="${contextPath}/js/gallery-image.js" ></script>
	
	<!-- 인클루드 심플 헤더 END -->


	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon"
						src="${contextPath}/img/accounts_Profile.png"> 갤러리 관리
				</h3>
				<div class="row">
					<div class="col-sm-4">
						<div class="border-box border-box-tips">
							<h4>
								<i class="fa fa-lightbulb-o"></i> <span>Tips</span>
							</h4>
							<ul>
								<li>사진은 교류 상대방에게 나를 소개하는 중요한 정보입니다.</li>
								<li>본인의 얼굴이 나온 사진 사용을 추천합니다.</li>
								<li>다른 회원들에게 나를 표현할 수 있는 사진을 입력하세요.</li>
								<li>취미활동 여행지에서의 사진 등 어떤 사진이라도 좋습니다.</li>
							</ul>
						</div>
					</div>
					<div class="col-sm-8">
						<div class="panel panel-default panel-profile-image">
							<div class="panel-heading">
								<h3 class="panel-title">얼굴 사진</h3>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-sm-4">
										<div class="profile-image">
											<div class="profile-avatar"
												style="background-image: url(${contextPath}/image?fileName=${profile_pic})">
												<div id="crop-preview"></div>
											</div>
										</div>
									</div>
									<div class="col-sm-8">
										<p>
											사진은 교류 상대방에게 나를 소개하는 중요한 정보입니다!<br>본인의 얼굴이 나온 사진 사용을
											추천합니다.
										</p>
										<button id="btn-profile-image" class="btn btn-potluck-o" data-toggle="modal" data-target="#modal-profile-image">업로드</button>
									</div>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
								나의 소개 사진 (취미활동, 나의 집, 가족, 반려동물 등 나를 표현할 수 있는 사진)<br>
								*미리보기 이미지는 실제 이미지와 비율이 다릅니다.
								</h3>
							</div>
							<div class="panel-body pt-30">
								<div class="row">
									<div class="col-sm-10 col-sm-offset-1">
										<div class="form-media-add">
											<button class="btn btn-potluck-o btn-image-add" href="#" data-toggle="modal" data-target="#modal-gallery-image">업로드</button>
										</div>
										<p class="images-status"></p>
										<form class="form-media-delete" method="post"
											action="사진삭제요청">
											<select id="deletePic" name="medias" class="image-picker" multiple="multiple">
												<!-- forEach로 사진 목록 옵션 그리기 -->
												<c:forEach items="${userPic}" var="pic">
												<option
													data-img-src="${contextPath}/image?fileName=${pic.GALLERY_FILE_NAME}"
													class="image_picker_image"
													value="${pic.GALLERY_FILE_NUM}">
												</option>
												</c:forEach>
											</select>
										</form>
										<button class="btn btn-warning btn-image-delete" style="display: none;">
											<i class="fa fa-trash-o"></i> 선택한 사진 삭제
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	
	<!-- 프로필 사진 업로드 모달 -->
	<div id="modal-profile-image" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    	파일을 선택해주세요.
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
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
<script type="text/javascript">
	
	//이미지 피커 기본 설정 
	var $image_picker = $(".image-picker");
	$image_picker.imagepicker();
	//이미지 클릭하면 삭제 버튼 나오게 
	$image_picker.change(function(){
		
		var selectedCount = ($(this).children(":selected").length);
		//alert(selectedCount);
	    var images = $(this).val();
	    var btn_delete_image = $(this).closest('.panel-body').find('.btn-image-delete');
	    if (images){
	        btn_delete_image.show();
	    }
	   	if(selectedCount == 0){
	   		btn_delete_image.hide();
	   	}
	        
	    
	});
	//모달 창 내 업로드 버튼 누르면, 히든 인풋 트리거 	
	$("#btn-image-upload").click(function () {
	    $("#imgInp").trigger("click");
	});
	//등록하는 사진 미리보기 
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
</script>

</html>