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
<title>라온다님</title>
<style type="text/css">
.input_AllForm{
	width : 532px;
	height: 35px;
}
#btn_next{
	float: right;
	width: 100px;
}
#btn_back{
	float: left;
	width: 100px;
}
</style>
</head>
   <!-- 인클루드 심플 헤더 -->
   <jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/accounts/accounts-navbar.jsp"></jsp:include>
   <!-- 인클루드 심플 헤더 END -->

<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/js/select2.min.js"></script>
<body>


   <div class="main-container">
      <section id="section-profile-update" class="bg-gray">
         <div class="container">
            <h3 class="section-title">
               <img class="section-header-icon"
                  src="/static/potluck/img/icon/Profile.png" alt=""> 3단계: 현지친구 정보 입력하기
            </h3>
            <div class="progress">
               <div class="progress-bar" role="progressbar"
                  aria-valuenow="71.4285714286" aria-valuemin="0"
                  aria-valuemax="100" style="width: 100%;"></div>
            </div>
            <form id="form-profile-update" method="post" action="update_complete" class="form-horizontal"
               enctype="multipart/form-data" novalidate >
               <input type="hidden" value="${_csrf.token}"
							name="${_csrf.parameterName}">
		     <div class="row">
                  <div class="col-sm-4">
                     <div class="border-box border-box-tips">
                        <h4>
                           <i class="fa fa-lightbulb-o"></i> <span>Tips</span>
                        </h4>
                        <ul>
                           <li>해외친구에게 숙박을 제공하면 당신도 다른 현지친구의 집에서 무료 숙박할 수 있어요!</li>
                        </ul>
                     </div>
                  </div>
                  <div class="col-sm-8">
                     <div class="panel panel-default">
                        <div class="panel-heading">
                           <h3 class="panel-title">현지친구 정보</h3>
                        </div>
                        <div class="panel-body pt-30">
                        	<div class="form-group">
                          
                              <label class="col-sm-3 control-label" for="id_nationality">국적</label>
                              <div class="col-sm-9">
								<c:if test="${!empty national}">
									<input list="brow" id="nation" class="input_AllForm" 
										name="profile_nation" value = "">
									<datalist id="brow">

										<c:forEach var="national" items="${national}" varStatus="i">

											<option id="nationDB"
												value="${national.NATIONALITY_NAME}, ${national.NATIONALITY_KOR_NAME}"
												onkeypress='chkCode(this,event.keyCode)'></option>

										</c:forEach>

									</datalist>
								</c:if>
                              </div>
                           </div>
      
                           <div class="form-group">	
     
									<label class="col-sm-3 control-label" for="id_city">나의 거주도시</label>
										<div class="col-sm-9">									
										<c:if test="${!empty city}">
										<input list="brow1" id="city" class="input_AllForm" name="profile_city">
										<datalist id="brow1">

											<c:forEach var="city" items="${city}" varStatus="i">

<%-- 												<option value="${city.CITY_COUNTRY_NUM}. ${city.CITY}, ${city.KO_CITY}"></option> --%>
													<option  value="${city.CITY}, ${city.KO_CITY}"/>
											</c:forEach>

										</datalist>
									</c:if>
                              </div>
                           </div>    
                                <div class="form-group">
                              <label class="col-sm-3 control-label">전화번호</label>
                              <div class="col-sm-4">
                                 <div class="input-group">
                                    <input class="form-control" value="" name="USER_PHONE_NUM">
                                 </div>
                              </div>
                           </div>

                        </div>
                     </div>
                     <input type="submit" value="완료" class="btn btn-potluck btn-submit" id="btn_next" >
                     <input type="button" value="이전" class="btn btn-potluck btn-submit" id="btn_back"
									onclick="history.back(-1);">
<!--                      <button class="btn btn-potluck btn-submit" id="btn_back" data-step="-1">이전</button> -->
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

//서밋 이벤트실행 시 유효성 검사

$("#form-profile-update")
			.on("submit",
					function() {

						var nation = $('#nation').val();
						var city = $('#city').val();
						var address = $('#address').val();
						//alert("nation : " + nation);
						//alert("city : " + city);
						var city_split = city.split(', ');
						var city_en = city_split[0];
						var city_ko = city_split[1];
						//			alert(city);
						//			alert(city_en);
						//			alert(city_ko);

						var nation_split = nation.split(', ');
						var nation_en = nation_split[0];
						var nation_ko = nation_split[1];
						//var isFind = false;
						var checkNum = 0;

						$.ajax({
									url : "${contextPath}/motel/DB_nation",
									type : "get",
									async : false,
									dataType : "json",
									success : function(data) {
										//alert("나라  : " + nation_ko);
										//	 				console.log("나라  : " + nation_ko);
										//	 				console.log("nation : " + nation_en);

										//console.log(data[i].NATIONALITY_KOR_NAME);
										//console.log(data[i].NATIONALITY_NAME);

										for ( var i in data) {

											if (data[i].NATIONALITY_KOR_NAME == nation_ko
													&& data[i].NATIONALITY_NAME == nation_en) {
												//서밋
												//console.log("같다!!!12312312")
												$("#nation").val(i);
													//alert($("#nation"))
												checkNum++;
												break;
											}

										}
									}
								});

						$.ajax({
							url : "${contextPath}/motel/DB_city",
							type : "get",
							async : false,
							dataType : "json",
							success : function(data) {
								for ( var i in data) {

									if (data[i].KO_CITY == city_ko
											&& data[i].CITY == city_en) {
										$("#city").val(i);
										checkNum++

									}

								}
							}
						
						});
//							var profile_nation = $("#nation").attr("name");
//						alert("profile_nation : " + profile_nation);
						
						if (checkNum == 2) {
							//console.log("같다!!!");

						} else {
							//console.log("다르다");
							swal({
								text : "숙소의 국가/도시를 정확히 선택해 주세요.",
								icon : "warning",
								buttons : [ false, "확인" ]
							})
							return false;
						}
					//$("#profile_city").attr();
					
					var phoneNumber = $("#USER_PHONE_NUM").val()
					var regExp = /^[0-9]+$/;
						if(!regExp.test(phoneNumber)){
							swal({
					         text:"전화번호를 정확히 입력하여 주세요.",
					         icon:"warning",
					         buttons:[false,"확인"]
					      })
							return false;
						}
					
					var up;
					up = confirm("저장하시겠습니까 ??");
				
					if (up) {
						return true;
					} else {
						return false;
					}
					});
	//국적 거주도시 검색시 언테키로 서밋실행 막기
	function captureReturnKey(e) {
   	 	if(e.keyCode==13 && e.srcElement.type != 'textarea')
   	 	return false;
	}
	$(function() {

		//국가입력 스크립트
		$(".national").click(function() {
			$(this).next().show();
			$(this).next().hide();
		});
		//도시입력 스크립트
		$(".city").click(function() {
			$(this).next().show();
			$(this).next().hide();
		});



	});
</script>
</html>