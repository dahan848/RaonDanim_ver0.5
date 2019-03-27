<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<!-- contextPath 설정 -->
<%   request.setAttribute("contextPath", request.getContextPath()); %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라온다님</title>
</head>
   <jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/accounts/accounts-navbar.jsp"></jsp:include>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/js/select2.min.js"></script>
<body>
   <!-- 인클루드 심플 헤더 -->
   <!-- 인클루드 심플 헤더 END -->


<%-- 	allLanguage : ${allLanguage} --%>
   <div class="main-container">
      <section id="section-profile-update" class="bg-gray">
         <div class="container">
            <h3 class="section-title">
               <img class="section-header-icon" src="${contextPath}/img/accounts_Profile.png" alt="">
               1단계: 기본 정보 입력하기
            </h3>
            <div class="progress">
               <div class="progress-bar" role="progressbar"
                  aria-valuenow="14.2857142857" aria-valuemin="0"
                  aria-valuemax="100" style="width: 33.333%;"></div>
            </div>
            <form id="form-profile-update" action="update2Form" method="post" class="form-horizontal"
               enctype="multipart/form-data" novalidate onsubmit="return form_Check();">
                <input type="hidden" value="${_csrf.token}" name="${_csrf.parameterName}">
				<input type="hidden" id="user_allLanguage" name="user_allLanguage" value="">	
				<input type="hidden" id="user_allInterest" name="user_allInterest" value="">
				<input type="hidden" id="user_allTripStyle" name="user_allTripStyle" value="">		
<!--                <input type="hidden" name="step" value="1"> -->
               <div class="row">
                  <div class="col-sm-4">
                     <div class="border-box border-box-tips">
                        <h4>
                           <i class="fa fa-lightbulb-o"></i> <span>Tips</span>
                        </h4>
                        <ul>
                           <li>닉네임은 영어로 입력하세요.</li>
                           <li>* 닉네임이 아닌 실제 이름은 친구로 맺어진 회원에게만 노출 됩니다.</li>
                        </ul>
                     </div>
                  </div>
                  <div class="col-sm-8">
                     <div class="panel panel-default">
                        <div class="panel-body pt-30">								
									<div class="form-group">
										<div class="container-fluid">
											<label class="col-sm-3 control-label" for="e2_2" style="">사용가능언어</label>
											<select id="userLanguage" multiple="multiple" style="width: 100%;"
												class="select2-multi-col ">
												<c:forEach var="allLanguage" items="${allLanguage}">
													<option value="${allLanguage.LANGUAGE_NUM}"
														<c:if test="${allLanguage.SELECT_NUM eq allLanguage.LANGUAGE_NUM}">selected</c:if>
													>
														${allLanguage.LANGUAGE_KO_NAME},
														${allLanguage.LANGUAGE_EN_NAME}
													</option>
												</c:forEach>

											</select>
										</div>
									</div>
									<div class="form-group">
										<div class="container-fluid">
											<label class="col-sm-3 control-label" for="e2_22" style="">좋아하는 것</label>
											<select id="userInterest" multiple="multiple"
												style="width: 100%;" 
												class="select2-multi-col ">
												<c:forEach var="interest" items="${allInterest}">
													<option value="${interest.INTEREST_NUM}"
														<c:if test="${interest.SELECT_NUM eq interest.INTEREST_NUM}">selected</c:if>
													>
														${interest.INTEREST_KO_NAME},
														${interest.INTEREST_EN_NAME}
													</option>
												</c:forEach>
											</select>
										</div>
									</div>
									
									
									<div class="form-group">
										<div class="container-fluid">
											<label class="col-sm-3 control-label" for="e2_22" style="">여행스타일</label>
											<select id="userTripStyle" multiple="multiple"
												style="width: 100%;"
												class="select2-multi-col ">
												<c:forEach var="allTripStyle" items="${allTripStyle}">
													<option value="${allTripStyle.TRAVLE_STYLE_NUM}"
														<c:if test="${allTripStyle.SELECT_NUM eq allTripStyle.TRAVLE_STYLE_NUM}">selected</c:if>
													>
														${allTripStyle.TRAVLE_STYLE_NAME}
													</option>
												</c:forEach>
											</select>
										</div>
									</div>
                        </div>
                     </div>
                 	    <input type="submit" value="다음" class="btn btn-potluck btn-submit" id="btn_next">
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
	//select 관련 스크립트 
	function format(state) {
	  if (!state.id) return state.text; // optgroup
	  return "<img class='flag' src='//select2.github.io/vendor/images/flags/" + state.id.toLowerCase() + ".png'>" + state.text;
	}
	
	//사용가능언어 select2
	$("#userLanguage").select2({
		  placeholder: "",
		  formatResult: format,
		  formatSelection: format,
		  escapeMarkup: function(m) { return m; }
	});
	
	//관심사 select2
	$("#userInterest").select2({
		  placeholder: "",
		  formatResult: format,
		  formatSelection: format,
		  escapeMarkup: function(m) { return m; }
	});
	
	//여행스타일 select2
	$("#userTripStyle").select2({
		  placeholder: "",
		  formatResult: format,
		  formatSelection: format,
		  escapeMarkup: function(m) { return m; }
	});
	
	//다음 버튼 눌렀을때 실행되는 함수
 	function form_Check(){
		//사용가능 언어 value 넘기기
		var userLanguage = $("#userLanguage").val();
		var user_allLanguage = $("#user_allLanguage").val(userLanguage);
	
		
		//좋아하는 것 value 넘기기
		var userInterest = $("#userInterest").val();
		var user_allInterest = $("#user_allInterest").val(userInterest);
	
		
		//여행스타일 value 넘기기
		var userTripstyle = $("#userTripStyle").val();
		var user_allTripStyle = $("#user_allTripStyle").val(userTripstyle);
		
		var up;
		up = confirm("저장하시겠습니까 ??");

		if (up) {
			return true;
		} else {
			return false;
		}
 	}
</script>
<style type="text/css">
#userLanguage{
	width: 800px;
}


#btn_next{
	float: right;
	width: 100px;
}
#input_AllForm{
	width : 532px;
	height: 35px;
}

/* select 관련 css */

.container-fluid {
	padding-top: 30px;
}

.select2-results-dept-0 { /* do the columns */
  float: left;
  width: 20%;
}

img.flag {
  height: 10px;
  padding-right: 5px;
  width: 15px;
}

/* move close cross [x] from left to right on the selected value (tag) */
#s2id_e2_2.select2-container-multi .select2-choices .select2-search-choice {
	
  padding: 3px 18px 3px 5px;
}

#s2id_e2_2.select2-container-multi .select2-search-choice-close {

  left: auto;
  right: 3px;
}
/* #userLanguage{ */
/* 	width: 1000px !important; */
/* } */
.select2-selection--multiple{
	width: 530px;
}
</style>
</html>