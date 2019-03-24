<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- contextPath 설정 -->
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
	<!-- 인클루드 심플 헤더 END -->
	<div class="main-container">
		<section id="section-inquiry">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon"
						src="${contextPath}/img/home_Message.png" alt=""> 문의하기 
				</h3>
				<form id="inquiryForm">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">문의내용</h3>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-8 col-sm-offset-2">
									<div class="form-group">
										<label class="control-label" for="id_category">카테고리</label><select
											class="form-control" id="id_category" name="inquiry_type"
											title="" required>
											<option value="0">일반문의</option>
											<option value="1">계정문의</option>
											<option value="2">탈퇴문의</option>
										</select>
									</div>
									<div class="form-group">
										<label class="control-label" for="id_email">이메일</label><input
											class="form-control" id="id_email" maxlength="200"
											name="inquiry_reg_id" placeholder="이메일" title="" type="email" />
									</div>
									<div class="form-group">
										<label class="control-label" for="id_subject">제목</label><input
											class="form-control" id="id_subject" maxlength="200"
											name="inquiry_subject" placeholder="제목" title="" type="text" required />
									</div>
									<div class="form-group">
										<label class="control-label" for="id_content">문의내용</label>
										<textarea class="form-control" cols="40" id="id_content"
											name="inquiry_content" placeholder="문의내용" rows="10" title=""></textarea>
									</div>
									<button class="btn btn-potluck btn-block">보내기</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</section>
	</div>
	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
	<script type="text/javascript">
	$("#inquiryForm").on("submit", function() {
		var data = $(this).serialize();
		//alert(data);
		
		$.ajax({
			url:"${contextPath}/writeInquiry",
			type:"POST",
			data: data,
			dataType:"json",
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
		
		return false;
	});
	

	</script>
</html>