<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	request.setAttribute("contextPath", request.getContextPath()); %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/motel/search-form.jsp"></jsp:include>

<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</body>
</html>