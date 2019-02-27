<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%	
	request.setAttribute("contextPath", request.getContextPath()); 
%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<script type="text/javascript">	
    $(document).ready(function(){
    	//온로드 
    	var birthday =  null;
    	setBirthday(birthday);
     });//onLoad END

    function setBirthday(birthday) {

		var toDay = new Date();
		var year  = ''+toDay.getFullYear();
		var month = ''+(toDay.getMonth()+1);
		var day   = ''+toDay.getDate();
		var str = "";

		//전달받은 birthday이 'null'이면 birthday에 오늘 날짜 넣어줌
		if(birthday == null){
			//오늘 '월'이 10 보다 작으면 '0'을 붙여줌 
			if(month < 10){
				month = '0'+(toDay.getMonth()+1);
			}
			//오늘 '일'이 10보다 작으면 '0을' 붙여줌 
			if(day < 10){
				day = '0'+toDay.getDate();
			}
			//총 8자리의 날짜 생성 완료 
			birthday = year + month + day;
		}
		// 년도 설정
		for (var i=year; i>=1900; i--) {
			if (birthday.substr(0,4) == i) {
				str += "<option value='" + i + "' selected='selected'>" + i + "</option>";
			} else {
				str += "<option value='" + i + "' >" + i + "</option>";
			}
		}
		$("#id_birthday_year").html(str);
		
		//일 설정
		for (var i=1; i<=31; i++) {
			//'일' 이 한 자리 수면 '0' 붙이기 
			var val = "";
			if (i < 10) {
				val = "0" + new String(i);
			} else {
				val = new String(i);
			}
			if (birthday.substr(6,2) == i) {
				$("<option value='" + val + "' selected>" + val + "</option>").appendTo("#id_birthday_day");
			} else {
				$("<option value='" + val + "'>" + val + "</option>").appendTo("#id_birthday_day");
			}
		}
		
		//월 설정
		for (var i = 1; i<=12; i++){
			//'월' 이 한 자리 수면 '0' 붙이기 
			var val = "";
			if (i < 10) {
				val = "0" + new String(i);
			} else {
				val = new String(i);
			}
			//월 설정
			if (i <= 12) { 
				if (birthday.substr(4,2) == i) {
					$("<option value='" + val + "' selected>" + val + "</option>").appendTo("#id_birthday_month");
				} else {
					$("<option value='" + val + "'>" + val + "</option>").appendTo("#id_birthday_month");
				}
			}
		}
	}//setBirthday END
	</script>
	생일 : ${user.user_birth_date }
	<div class="main-container">
		<section id="section-profile-personal-update" class="bg-gray">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon"
						src="${contextPath}/img/accounts_Profile.png"> 개인정보 수정
				</h3>
				<form method="post" class="form-horizontal"
					enctype="multipart/form-data" novalidate>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">개인정보</h3>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-3 control-label" for="id_first_name">이름</label>
								<div class="col-sm-9">
									<input class="form-control" id="id_first_name"
										name="first_name" placeholder="이름" title="" type="text"
										value="${user.user_fnm}" required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="id_last_name">성</label>
								<div class="col-sm-9">
									<input class="form-control" id="id_last_name" name="last_name"
										placeholder="성" title="" type="text" value="${user.user_lnm}" required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="id_gender">성별</label>
								<div class="col-sm-9">
									<select class="form-control" id="id_gender" name="gender"
										title="" required>
										<option value=0 >---</option>
										<option value=1 >남</option>										
										<option value=2 >여</option>
										<option value=3 >기타</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="id_birthday_year">생년월일</label>
								<div class="col-sm-9">
									<div class="row bootstrap3-multi-input">
										<div class="col-xs-4">
											<select class="form-control" id="id_birthday_year"
												name="birthday_year" title="">
												
											</select>
										</div>
										<div class="col-xs-4">
											<select class="form-control" id="id_birthday_month"
												name="birthday_month" title="">

											</select>
										</div>
										<div class="col-xs-4">
											<select class="form-control" id="id_birthday_day"
												name="birthday_day" title="">

											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="id_email">이메일</label>
								<div class="col-sm-9">
									<input class="form-control" id="id_email" name="email"
										placeholder="이메일" readonly="readonly" title="" type="text"
										value="${user.user_id}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="id_contact">비밀번호</label>
								<div class="col-sm-4">
									<div class="input-group">
										<input type="password" class="form-control" value=""
											readonly> <span class="input-group-btn"> <a
											href="/accounts/password/change/" class="btn btn-default">변경하기</a>
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="text-right mb-15">
						<button type="submit" class="btn btn-potluck btn-block-xs">저장하기</button>
					</div>
				</form>
			</div>
		</section>
	</div>

	<!-- 인클루드-푸터 -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<!-- 인클루드-푸터 END -->
</body>
</html>