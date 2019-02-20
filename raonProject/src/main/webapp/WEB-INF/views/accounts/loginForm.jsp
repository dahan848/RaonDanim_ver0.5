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
                <img src="${contextPath}/img/logo-raon.png" alt="">
                <form action="login" method="post"> <!-- 로그인 폼  -->
                	<!-- 시큐리티 사용하기 위한 파라미터 (토큰) -->
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <div class="form-group">
                    	<label class="sr-only control-label" for="id_login">이메일</label>
                    		<input autofocus="autofocus" class="form-control" id="id_login" name="user_id" placeholder="이메일 주소" title="" type="email" required />
               		</div>
                    <div class="form-group"><label class="sr-only control-label" for="id_password">비밀번호</label>
                    	<input class="form-control" id="id_password" name="user_pw" placeholder="비밀번호" title="" type="password" required />
                   	</div>
                    <div class="form-group">
                    	<div class="checkbox">
                    		<label for="id_remember">
                    			<input class="" id="id_remember" name="remember" type="checkbox" /> 자동 로그인
                   			</label>
               			</div>
           			</div>
                    <button class="btn btn-potluck btn-block" type="submit">로그인</button>
					<a href="#" class="btn btn-block btn-social btn-kakao">
					  <span class="fa fa-kakao" style="width: 32px;"></span>
					 		 <span style="display: inline-block; text-align: center; width: 250px;">카카오톡 로그인</span>
					</a>
                    <hr>
                    <div class="form-link">
                        <a class="text-gray" href="#">비밀번호 찾기</a>
                        <a class="text-gray" href="join.jsp">회원가입</a>
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