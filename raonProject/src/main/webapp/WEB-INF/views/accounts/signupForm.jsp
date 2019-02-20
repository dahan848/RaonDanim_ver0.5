<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- contextPath 설정 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<!-- 인클루드 심플 헤더 END -->
 <section id="section-authentication">
        <div class="container">
            <div class="form-block">
                <img src="../img/logo-raon.png" alt="">
                <!-- 가입자 폼 -->
                <form action="join" method="post">
                 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <div class="form-group">
                    	<label class="sr-only control-label" for="id_email">이메일</label>
                    		<input class="form-control" id="id_email" name="user_id" placeholder="이메일 주소" title="" type="email" required />
               		</div>
                    <div class="form-group">
                    	<label class="sr-only control-label" for="id_password1">비밀번호</label>
                    		<input class="form-control" id="id_password1" name="user_pw" placeholder="비밀번호" title="" type="password" required />
               		</div>
                    <div class="form-group">
                    	<label class="sr-only control-label" for="id_password2">비밀번호 (확인)</label>
                    		<input class="form-control" id="id_password2" name="user_pw2" placeholder="비밀번호 (확인)" title="" type="password" required />
               		</div>
                    <div class="row row-p5">
                        <div class="col-xs-4">
                            <div class="form-group">
                            	<label class="sr-only control-label" for="id_last_name">성</label>
                            	<input class="form-control" id="id_last_name" name="user_lnm" placeholder="성" title="" type="text" required />
                       		</div>
                        </div>
                        <div class="col-xs-8">
                            <div class="form-group">
                            	<label class="sr-only control-label" for="id_first_name">이름</label>
                            		<input class="form-control" id="id_first_name" name="user_fnm" placeholder="이름" title="" type="text" required />
                       		</div>
                        </div>
                    </div>
                    <div class="form-group">
                    	<div class="checkbox">
                    		<label for="id_is_agreed_1">
                    			<input class="" id="id_is_agreed_1" name="is_agreed_1" type="checkbox" required /> 
                    				회원약관 동의 <a href='/policies/terms/' class='text-potluck' target='_blank'>(보기)</a>
               				</label>
           				</div>
       				</div>
                    <div class="form-group">
                    	<div class="checkbox">
                    		<label for="id_is_agreed_2">
                    			<input class="" id="id_is_agreed_2" name="is_agreed_2" type="checkbox" required /> 개인정보취급방침 동의
                    				 <a href='/policies/privacy/' class='text-potluck' target='_blank'>(보기)</a>
               				 </label>
           				 </div>
       				 </div>
                    <button class="btn btn-potluck btn-block" type="submit">회원가입</button>
					<a href="#" class="btn btn-block btn-social btn-kakao">
					  <span class="fa fa-kakao" style="width: 32px;"></span>
					 		 <span style="display: inline-block; text-align: center; width: 250px;">카카오톡 로그인</span>
					</a>
                    <hr>
                    <p>이미 라온다님 회원인가요?</p>
                    <div class="form-link">
                        <a class="text-potluck" href="login.jsp">로그인</a>
                    </div>
                </form>
            </div>
            <p>라온다님에 오신것을 환영합니다</p>
        </div>
    </section>
<!-- 인클루드-푸터 -->
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<!-- 인클루드-푸터 END -->
</body>
</html>