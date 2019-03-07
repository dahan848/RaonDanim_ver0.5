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
	
	<!-- 인클루드 심플 헤더 END -->


	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon"
						src="${contextPath}/img/accounts_Profile.png"> 갤러리 관리
				</h3>
				<form id="form-profile-update" method="post" class="hidden"
					data-user-id="1705" enctype="multipart/form-data" novalidate>
					<input type='hidden' name='csrfmiddlewaretoken'
						value='PHbeNsdQBkMcG9CeMMc2KZvWWLYX9ZZzPE1sWqVyVskH9tvHnyuFW5yjKFdjbTzZ' />
					<input type="hidden" name="step" value="1">
					<div class="form-group">
						<label class="control-label" for="id_image_cropping">Image
							cropping</label><input class="form-control image-ratio"
							data-adapt-rotation="false" data-allow-fullsize="false"
							data-box-max-height="300" data-box-max-width="300"
							data-image-field="image"
							data-jquery-url="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"
							data-min-height="300" data-min-width="300"
							data-my-name="image_cropping" data-points-given="0"
							data-ratio="1.0" data-size-warning="false" id="id_image_cropping"
							maxlength="255" name="image_cropping"
							placeholder="Image cropping" title="" type="text" />
					</div>
					<div class="form-group">
						<label class="control-label" for="id_images">Images</label>
						<div class="row bootstrap3-multi-input">
							<div class="col-xs-12">
								<input accept="image/*" class="" data-points-given="0"
									id="id_images" multiple="multiple" name="images" title=""
									type="file" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="checkbox">
							<label for="id_do_save_image"><input class=""
								data-points-given="0" id="id_do_save_image" name="do_save_image"
								type="checkbox" /> Do save image</label>
						</div>
					</div>
				</form>

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
								<h3 class="panel-title">나의 소개 사진 (취미활동, 나의 집, 가족, 반려동물 등 나를
									표현할 수 있는 사진)</h3>
							</div>
							<div class="panel-body pt-30">
								<div class="row">
									<div class="col-sm-10 col-sm-offset-1">
										<div class="form-media-add">
											<button class="btn btn-potluck-o btn-image-add">업로드</button>
											<button class="btn btn-potluck btn-gallery">갤러리 보기</button>
										</div>
										<p class="images-status"></p>
										<form class="form-media-delete" method="post"
											action="사진삭제요청">
											<select name="medias" class="image-picker" multiple="multiple">
												<!-- forEach로 사진 목록 옵션 그리기 -->
												<c:forEach items="${userPic}" var="pic">
												<option
													data-img-src="${contextPath}/image?fileName=${pic.GALLERY_FILE_NAME}"
													class="image_picker_image"
													style="width: 129.75px; height: 129.75px;"
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
    var images = $(this).val();
    var btn_delete_image = $(this).closest('.panel-body').find('.btn-image-delete');
    if (images){
        btn_delete_image.show();
    }
    else{
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
</script>

</html>