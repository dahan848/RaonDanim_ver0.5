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


<style type="text/css">
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


</style>
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
							
               <input type="hidden" name="step" value="1">
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
<!--                            <div class="form-group"> -->
                          
<!--                               <label class="col-sm-3 control-label" for="id_nationality">국적</label> -->
<!--                               <div class="col-sm-9"> -->
<%-- 								<c:if test="${!empty national}"> --%>
<!-- 									<input list="brow" id="input_AllForm" class="national" -->
<!-- 										name="motel_nation" value = "ddddd"> -->
<!-- 									<datalist id="brow"> -->

<%-- 										<c:forEach var="national" items="${national}" varStatus="i"> --%>

<!-- 											<option id="nationDB" -->
<%-- 												value="${national.NATIONALITY_NAME}, ${national.NATIONALITY_KOR_NAME}" --%>
<!-- 												onkeypress='chkCode(this,event.keyCode)'></option> -->

<%-- 										</c:forEach> --%>

<!-- 									</datalist> -->
<%-- 								</c:if> --%>
<!--                               </div> -->
<!--                            </div> -->

<!-- 							<div class="form-group"> -->
<!-- 										<div class="container-fluid"> -->
<!-- 											<label class="col-sm-3 control-label" for="e2_2">사용가능언어</label> -->
<!-- 											<select id="e2_2" multiple="multiple" style="width: 100%" name="userLanguage" -->
<!-- 												class="select2-multi-col"> -->
												
<!-- 													<option value="AK">Alaska</option> -->
<!-- 													<option value="HI">Hawaii</option> -->
												
												
<!-- 													<option value="CA">California</option> -->
<!-- 													<option value="NV">Nevada</option> -->
<!-- 													<option value="OR">Oregon</option> -->
<!-- 													<option value="WA">Washington</option> -->
							
											
<!-- 													<option value="AZ">Arizona</option> -->
<!-- 													<option value="CO">Colorado</option> -->
<!-- 													<option value="ID">Idaho</option> -->
<!-- 													<option value="MT">Montana</option> -->
<!-- 													<option value="NE">Nebraska</option> -->
<!-- 													<option value="NM">New Mexico</option> -->
<!-- 													<option value="ND">North Dakota</option> -->
<!-- 													<option value="UT">Utah</option> -->
<!-- 													<option value="WY">Wyoming</option> -->
												
											
<!-- 													<option value="AL">Alabama</option> -->
<!-- 													<option value="AR">Arkansas</option> -->
<!-- 													<option value="IL">Illinois</option> -->
<!-- 													<option value="IA">Iowa</option> -->
<!-- 													<option value="KS">Kansas</option> -->
<!-- 													<option value="KY">Kentucky</option> -->
<!-- 													<option value="LA">Louisiana</option> -->
<!-- 													<option value="MN">Minnesota</option> -->
<!-- 													<option value="MS">Mississippi</option> -->
<!-- 													<option value="MO">Missouri</option> -->
<!-- 													<option value="OK">Oklahoma</option> -->
<!-- 													<option value="SD">South Dakota</option> -->
<!-- 													<option value="TX">Texas</option> -->
<!-- 													<option value="TN">Tennessee</option> -->
<!-- 													<option value="WI">Wisconsin</option> -->
												
												
<!-- 													<option value="CT">Connecticut</option> -->
<!-- 													<option value="DE">Delaware</option> -->
<!-- 													<option value="FL">Florida</option> -->
<!-- 													<option value="GA">Georgia</option> -->
<!-- 													<option value="IN">Indiana</option> -->
<!-- 													<option value="ME">Maine</option> -->
<!-- 													<option value="MD">Maryland</option> -->
<!-- 													<option value="MA">Massachusetts</option> -->
<!-- 													<option value="MI">Michigan</option> -->
<!-- 													<option value="NH">New Hampshire</option> -->
<!-- 													<option value="NJ">New Jersey</option> -->
<!-- 													<option value="NY">New York</option> -->
<!-- 													<option value="NC">North Carolina</option> -->
<!-- 													<option value="OH">Ohio</option> -->
<!-- 													<option value="PA">Pennsylvania</option> -->
<!-- 													<option value="RI">Rhode Island</option> -->
<!-- 													<option value="SC">South Carolina</option> -->
<!-- 													<option value="VT">Vermont</option> -->
<!-- 													<option value="VA">Virginia</option> -->
<!-- 													<option value="WV">West Virginia</option> -->
												
<!-- 											</select> -->
<!-- 										</div> -->
<!-- 									</div>	 -->
									
													
									<div class="form-group">
										<div class="container-fluid">
											<label class="col-sm-3 control-label" for="e2_2">사용가능언어</label>
											<select id="e2_21" multiple="multiple" style="width: 100%" name="userLanguage"
												class="select2-multi-col">
												
												<c:forEach var="allLanguage" items="${allLanguage}">

													<option value="${allLanguage.LANGUAGE_NUM}">${allLanguage.LANGUAGE_KO_NAME}</option>

												</c:forEach>

											</select>
										</div>



									</div>
									
									
									

<!--                            <div class="form-group"> -->
<!--                               <label class="col-sm-3 control-label" for="id_languages">사용가능언어</label> -->
                                 		
<!--                               <div class="col-sm-9"> -->
<!--                                  <select  -->
<!--                                     class="form-control" -->
<!--                                     id="id_languages" name="languages" title=""> -->
<!--                                     <option value="1" selected="selected">한국어</option> -->
<!--                                     <option value="2" selected="selected">일본어</option> -->
<!--                                     <option value="3" selected="selected">중국어</option> -->
<!--                                     <option value="4" selected="selected">영어</option> -->
<!--                                     <option value="5" selected="selected">스페인어</option> -->
<!--                                     <option value="6" selected="selected">아랍어</option> -->
<!--                                     <option value="7" selected="selected">포르투갈어</option> -->
<!--                                     <option value="8" selected="selected">러시아어</option> -->
<!--                                     <option value="9" selected="selected">독일어</option> -->
<!--                                     <option value="10" selected="selected">말레이어</option> -->
<!--                                     <option value="11" selected="selected">몽골어</option> -->
<!--                                     <option value="12" selected="selected">베트남어</option> -->
<!--                                     <option value="13" selected="selected">인도네시아어</option> -->
<!--                                     <option value="14" selected="selected">이탈리아어</option> -->
<!--                                     <option value="15" selected="selected">프랑스어</option> -->
<!--                                     <option value="16" selected="selected">힌디어</option> -->
<!--                                     <option value="17" selected="selected">벵골어</option> -->
<!--                                     <option value="18" selected="selected">그리스어</option> -->
<!--                                     <option value="19" selected="selected">네덜란드어</option> -->
<!--                                     <option value="20" selected="selected">노르웨이어</option> -->
<!--                                     <option value="21" selected="selected">네팔어</option> -->
<!--                                     <option value="22" selected="selected">태국어</option> -->
<!--                                     <option value="23" selected="selected">터키어</option> -->
<!--                                     <option value="24" selected="selected">폴란드어</option> -->
<!--                                     <option value="25" selected="selected">자바어</option> -->
<!--                                     <option value="26" selected="selected">덴마크어</option> -->
<!--                                     <option value="27" selected="selected">보스니아어</option> -->
<!--                                     <option value="28" selected="selected">에스토니아어</option> -->
<!--                                     <option value="29" selected="selected">아일랜드어</option> -->
<!--                                     <option value="30" selected="selected">크로아티아어</option> -->
<!--                                     <option value="31" selected="selected">아이슬란드어</option> -->
<!--                                     <option value="32" selected="selected">라트비아어</option> -->
<!--                                     <option value="33" selected="selected">리투아니아어</option> -->
<!--                                     <option value="34" selected="selected">라틴어</option> -->
<!--                                     <option value="35" selected="selected">몰타어</option> -->
<!--                                     <option value="36" selected="selected">알바니아어</option> -->
<!--                                     <option value="37" selected="selected">핀란드어</option> -->
<!--                                     <option value="38" selected="selected">스웨덴어</option> -->
<!--                                     <option value="39" selected="selected">마케도니아어</option> -->
<!--                                     <option value="40" selected="selected">세르비아어</option> -->
<!--                                     <option value="41" selected="selected">아제르바이잔어</option> -->
<!--                                     <option value="42" selected="selected">체코어</option> -->
<!--                                     <option value="43" selected="selected">헝가리어</option> -->
<!--                                     <option value="44" selected="selected">루마니아어</option> -->
<!--                                     <option value="45" selected="selected">슬로바키아어</option> -->
<!--                                     <option value="46" selected="selected">슬로베니아어</option> -->
<!--                                     <option value="47" selected="selected">불가리아어</option> -->
<!--                                     <option value="48" selected="selected">카자흐어</option> -->
<!--                                     <option value="49" selected="selected">우크라이나어</option> -->
<!--                                     <option value="50" selected="selected">조지아어</option> -->
<!--                                     <option value="51" selected="selected">아르메니아어</option> -->
<!--                                     <option value="52" selected="selected">아제르바이잔어</option> -->
<!--                                     <option value="53" selected="selected">필리핀어</option> -->
<!--                                     <option value="54" selected="selected">우즈베크어</option> -->
<!--                                     <option value="55" selected="selected">카자흐어</option> -->
<!--                                     <option value="56" selected="selected">조지아어</option> -->
<!--                                     <option value="57" selected="selected">라오스어</option> -->
<!--                                     <option value="58" selected="selected">버마어</option> -->
<!--                                     <option value="59" selected="selected">소말리아어</option> -->
<!--                                  </select> -->
<!--                               </div> -->
<!--                            </div> -->
                           <div class="form-group">
                              <label class="col-sm-3 control-label">전화번호</label>
                              <div class="col-sm-4">
                                 <div class="input-group">
                                    <input class="form-control" value="" name="USER_PHONE_NUM">
                                 </div>
                              </div>
                           </div>
                           <div class="form-group">
                              <label class="col-sm-3 control-label" for="id_interests">좋아하는 것</label>
                              <div class="col-sm-9">
                                 <select class="form-control" id="id_interests" name="INTEREST_NUM" title="">
                                    <option value="1" selected="selected">축구</option>
                                    <option value="999" selected="selected">음악</option>
                                 </select>
                              </div>
                           </div>
                           <div class="form-group">
                              <label class="col-sm-3 control-label" for="id_cities_desired">여행 희망도시</label>
                              <div class="col-sm-9">
                                 <select
                                    class="form-control"
                                    id="id_cities_desired" name="cities_desired" title="">
                                    <option value="1" selected="selected">마드리드</option>
                                    <option value="999" selected="selected">런던</option>
                                 </select>
                              </div>
                           </div>
                           <div class="form-group">
                              <label class="col-sm-3 control-label" for="id_tour_styles">여행 스타일</label>
                              <div class="col-sm-9">
                                 <select
                                    class="form-control"
                                    id="id_tour_styles" name="tour_styles" title="">
                                    <option value="1" selected="selected">현지인과 어울리기</option>
                                    <option value="999" selected="selected">력셔리</option>
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

	$("#e2_2").select2({
	  placeholder: "Select a state or many…",
	  formatResult: format,
	  formatSelection: format,
	  escapeMarkup: function(m) { return m; }
	});
	$("#e2_21").select2({
		  placeholder: "선택하세요",
		  formatResult: format,
		  formatSelection: format,
		  escapeMarkup: function(m) { return m; }
	});
	
	//다음 버튼 눌렀을때 실행되는 함수
 	function form_Check(){
// 		swal({
//             text:"변경사항을 저장하시겠습니까??",
//             icon:"warning",
//             buttons:[true,"확인"],[false,"취소"]
			
//          })
// 		return false;
		var up;
		up = confirm("저장하시겠습니까 ??");

		if (up) {
			return true;
		} else {
			return false;
		}
 	}


</script>
</html>