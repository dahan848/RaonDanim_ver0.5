<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%	request.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라온다님</title>
</head>
<body>
	<!-- 인클루드 심플 헤더 -->
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/accounts/accounts-navbar.jsp"></jsp:include>
	<!-- 인클루드 심플 헤더 END -->


	<div class="main-container">
		<section id="section-profile-update" class="bg-gray">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon"
						src="/static/potluck/img/icon/Profile.png" alt=""> 3단계: 사진
					추가하기
				</h3>
				<div class="progress">
					<div class="progress-bar" role="progressbar"
						aria-valuenow="57.1428571429" aria-valuemin="0"
						aria-valuemax="100" style="width: 100%;"></div>
				</div>
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
												style="background-image: url(/static/potluck/img/defaults/profile_2.jpg)">
												<div id="crop-preview"></div>
											</div>
										</div>
									</div>
									<div class="col-sm-8">
										<p>
											사진은 교류 상대방에게 나를 소개하는 중요한 정보입니다!<br>본인의 얼굴이 나온 사진 사용을
											추천합니다.
										</p>
										<button id="btn-profile-image" class="btn btn-potluck-o">업로드</button>
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
											<input type='hidden' name='csrfmiddlewaretoken'
												value='PHbeNsdQBkMcG9CeMMc2KZvWWLYX9ZZzPE1sWqVyVskH9tvHnyuFW5yjKFdjbTzZ' />
											<button class="btn btn-potluck-o btn-image-add">업로드</button>
											<button class="btn btn-potluck btn-gallery">갤러리 보기</button>
										</div>
										<p class="images-status"></p>
										<form class="form-media-delete" method="post"
											action="/accounts/user/medias/delete">
											<input type='hidden' name='csrfmiddlewaretoken'
												value='PHbeNsdQBkMcG9CeMMc2KZvWWLYX9ZZzPE1sWqVyVskH9tvHnyuFW5yjKFdjbTzZ' />
											<input type="hidden" name="next"
												value="/accounts/profiles/update/?step=4">
											<div class="user-gallery hidden">
												<a
													href="/media/user_media/96441cac-50e2-467b-bd11-08cf2c722620.jpg"><img
													src="/media/user_media/96441cac-50e2-467b-bd11-08cf2c722620.jpg.150x150_q85_crop-50%2C%2050_detail_upscale.jpg"></a>
												<a
													href="/media/user_media/19b325fb-7007-4a2e-8ece-59dec0addcee.png"><img
													src="/media/user_media/19b325fb-7007-4a2e-8ece-59dec0addcee.png.150x150_q85_crop-50%2C%2050_detail_upscale.png"></a>

											</div>
											<select name="medias" class="image-picker"
												multiple="multiple">
												<option
													data-img-src="/media/user_media/96441cac-50e2-467b-bd11-08cf2c722620.jpg.150x150_q85_crop-50%2C%2050_detail_upscale.jpg"
													value="2990"></option>
												<option
													data-img-src="/media/user_media/19b325fb-7007-4a2e-8ece-59dec0addcee.png.150x150_q85_crop-50%2C%2050_detail_upscale.png"
													value="2989"></option>
											</select>
										</form>
										<button class="btn btn-warning btn-image-delete"
											style="display: none;">
											<i class="fa fa-trash-o"></i> 선택한 사진 삭제
										</button>
									</div>
								</div>
							</div>
						</div>
						<p id="points-earned" data-step="4" class="text-mint text-right "></p>
						<div class="btn-group-form-submit">
							<button class="btn btn-default btn-submit" data-step="-1">이전</button>
							<button class="btn btn-potluck btn-submit" data-step="1">완료</button>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>