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
	<!-- 인클루드 심플 헤더 END -->

	<!-- 서브 네브바 -->
	<div
		class="navbar navbar-inverse navbar-sub navbar-sub-light hidden-xs">
		<div class="container">
			<ul class="nav navbar-nav navbar-core">
				<li><a href="${contextPath}/statics/profile/update1">프로필 수정</a></li>
				<li><a href="${contextPath}/statics/profile/personal">계정설정</a></li>
				<li><a href="#">대시보드</a></li>
			</ul>
		</div>
	</div>
	<!-- 서브 네브바 END -->
	<div class="main-container">
		<section id="section-profile-personal-update" class="bg-gray">
			<div class="container">
				<h3 class="section-title">
					<img class="section-header-icon"
						src="${contextPath}/img/Profile.png"> 개인정보 수정
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
										value="" required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="id_last_name">성</label>
								<div class="col-sm-9">
									<input class="form-control" id="id_last_name" name="last_name"
										placeholder="성" title="" type="text" value="" required />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="id_gender">성별</label>
								<div class="col-sm-9">
									<select class="form-control" id="id_gender" name="gender"
										title="" required>
										<option value="1">남</option>
										<option value="2">여</option>
										<option value="3">기타</option>
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
												<option value="0">---</option>
												<option value="2016">2016</option>
												<option value="2015">2015</option>
												<option value="2014">2014</option>
												<option value="2013">2013</option>
												<option value="2012">2012</option>
												<option value="2011">2011</option>
												<option value="2010">2010</option>
												<option value="2009">2009</option>
												<option value="2008">2008</option>
												<option value="2007">2007</option>
												<option value="2006">2006</option>
												<option value="2005">2005</option>
												<option value="2004">2004</option>
												<option value="2003">2003</option>
												<option value="2002">2002</option>
												<option value="2001">2001</option>
												<option value="2000">2000</option>
												<option value="1999">1999</option>
												<option value="1998">1998</option>
												<option value="1997">1997</option>
												<option value="1996">1996</option>
												<option value="1995">1995</option>
												<option value="1994">1994</option>
												<option value="1993">1993</option>
												<option value="1992">1992</option>
												<option value="1991">1991</option>
												<option value="1990">1990</option>
												<option value="1989">1989</option>
												<option value="1988">1988</option>
												<option value="1987">1987</option>
												<option value="1986">1986</option>
												<option value="1985">1985</option>
												<option value="1984">1984</option>
												<option value="1983">1983</option>
												<option value="1982">1982</option>
												<option value="1981">1981</option>
												<option value="1980">1980</option>
												<option value="1979">1979</option>
												<option value="1978">1978</option>
												<option value="1977">1977</option>
												<option value="1976">1976</option>
												<option value="1975">1975</option>
												<option value="1974">1974</option>
												<option value="1973">1973</option>
												<option value="1972">1972</option>
												<option value="1971">1971</option>
												<option value="1970">1970</option>
												<option value="1969">1969</option>
												<option value="1968">1968</option>
												<option value="1967">1967</option>
												<option value="1966">1966</option>
												<option value="1965">1965</option>
												<option value="1964">1964</option>
												<option value="1963">1963</option>
												<option value="1962">1962</option>
												<option value="1961">1961</option>
												<option value="1960">1960</option>
												<option value="1959">1959</option>
												<option value="1958">1958</option>
												<option value="1957">1957</option>
												<option value="1956">1956</option>
												<option value="1955">1955</option>
												<option value="1954">1954</option>
												<option value="1953">1953</option>
												<option value="1952">1952</option>
												<option value="1951">1951</option>
												<option value="1950">1950</option>
												<option value="1949">1949</option>
												<option value="1948">1948</option>
												<option value="1947">1947</option>
												<option value="1946">1946</option>
												<option value="1945">1945</option>
												<option value="1944">1944</option>
												<option value="1943">1943</option>
												<option value="1942">1942</option>
												<option value="1941">1941</option>
											</select>
										</div>
										<div class="col-xs-4">
											<select class="form-control" id="id_birthday_month"
												name="birthday_month" title="">
												<option value="0">---</option>
												<option value="1">1월</option>
												<option value="2">2월</option>
												<option value="3">3월</option>
												<option value="4">4월</option>
												<option value="5">5월</option>
												<option value="6">6월</option>
												<option value="7">7월</option>
												<option value="8">8월</option>
												<option value="9">9월</option>
												<option value="10">10월</option>
												<option value="11">11월</option>
												<option value="12">12월</option>
											</select>
										</div>
										<div class="col-xs-4">
											<select class="form-control" id="id_birthday_day"
												name="birthday_day" title="">
												<option value="0">---</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
												<option value="8">8</option>
												<option value="9">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
												<option value="24">24</option>
												<option value="25">25</option>
												<option value="26">26</option>
												<option value="27">27</option>
												<option value="28">28</option>
												<option value="29">29</option>
												<option value="30">30</option>
												<option value="31">31</option>
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
										value="" />
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
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">이메일 수신</h3>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-3 control-label" for="id_do_email_info">&#160;</label>
								<div class="col-sm-9">
									<div class="checkbox">
										<label for="id_do_email_info" title="공지사항, 이벤트 안내를 이메일로 받음"><input
											checked="checked" class="" id="id_do_email_info"
											name="do_email_info" type="checkbox" /> 라온다님 정보</label>
									</div>
									<div class="help-block">공지사항, 이벤트 안내를 이메일로 받음</div>
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