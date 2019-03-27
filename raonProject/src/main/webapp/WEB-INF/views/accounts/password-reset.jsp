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
<script src="${contextPath}/js/password-reset.js" ></script> <!-- Ajax -->
<!-- 인클루드 심플 헤더 END -->
<section id="section-authentication">
        <div class="container">
            <div class="form-block">
                <img src="${contextPath}/img/home_logo-raon.png" alt="">
                <p>비밀번호를 잊으셨나요?<br>회원가입하신 이메일을 넣어주시면, <br>비밀번호를 초기화 링크를 메일로 보내드립니다.</p>
                <form id="form_reset" method="post">
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <input type='hidden' name='csrfmiddlewaretoken' value='AHUFpxHjSMnhhEjZazQ4OR0EdgGVTXwRzif7O1wOUwTkPHMqM1EMpHhdR5FKXIVW' />
                    <div class="form-group"><label class="sr-only control-label" for="id_email">이메일</label><input class="form-control" id="id_email" name="email" placeholder="이메일 주소" size="30" title="" type="email" required /></div>
                    <button id="btn_reset" class="btn btn-potluck btn-block">비밀번호 초기화</button>
                    <hr>
                    <p>라온다님에 이미 가입하신 회원인가요?</p>
                    <div class="form-link">
                        <a class="text-potluck" href="${contextPath}/accounts/loginForm">로그인</a>
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