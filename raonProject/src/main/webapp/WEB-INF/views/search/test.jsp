<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://unpkg.com/infinite-scroll@3/dist/infinite-scroll.pkgd.min.js"></script>

</head>
<body>
	
	<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>

	<div class="container">
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">...</article>
		<article class="post">end</article>
		<script>
			$('.container').infiniteScroll({
				path: '.pagination__next',
				append: '.post',
				history: false,
			});
		</script>
	</div>

</body>
</html>