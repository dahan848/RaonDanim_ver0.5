<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- contextPath 설정 -->
<%	request.setAttribute("contextPath", request.getContextPath()); %>	
<footer class="hidden-xs">
    <div class="container">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-3">
            <ul>
                <li><h5>사이트</h5></li>
                <li><a href="${contextPath}/introduction">소개</a></li>
            </ul>
        </div>
        <div class="col-sm-3">
            <ul>
                <li><h5>약관안내</h5></li>
                <li><a href="#">개인정보처리방침</a></li>
                <li><a href="#">이용약관</a></li>
            </ul>
        </div>
        <div class="col-sm-3">
            <ul>
                <li><h5>고객센터</h5></li>
                <li><a href="${contextPath}/inquiry">문의하기</a></li>
            </ul>
        </div>
    </div>
</footer>