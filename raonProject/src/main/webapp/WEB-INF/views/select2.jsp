<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.capitalize {
	text-transform: capitalize;
}

.select2-container-multi .select2-choices .select2-search-choice {
	padding: 5px 5px 5px 18px;
}
</style>
<title>무한 스크롤과 select2</title>
<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
<head>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.4/select2.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2-bootstrap-css/1.4.6/select2-bootstrap.min.css" />
</head>
<body>
	<div class="container" style="margin-left: 30px; margin-bottom: 10px;">
		<input id="test" style="width: 100%;"
			placeholder="숫자를 입력하고 스크롤하여 자세한 결과를 확인하십시오." />
	</div>
<script type="text/javascript" src='//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
<script	src="//cdnjs.cloudflare.com/ajax/libs/lodash.js/4.15.0/lodash.min.js"></script>
<script	src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.4/select2.min.js"></script>
</body>

<!-- 스크립트 -->
<script type="text/javascript">
	//데모 데이터를 위한 문자열 (랜덤 섞) 입력하는 부분인 것 같다
	//실제 코드에서는 필요 없는 부분 
	function shuffle(str) {
		return str.split('').sort(function() {
			return 0.5 - Math.random();
		}).join('');
	}

	//화면에 표시 될 데이터를 넣어주는 부분 Ajax를 활용하여 데이터를 서버로 부터 받아오는 식으로 넣어주면 될 것 같다.
	//_.map() 함수 설명 : https://medium.com/@cheonmyung0217/underscore-js-map-%ED%95%A8%EC%88%98-cd3d47774d96
	//_.range() 함수 설명 : https://mylife365.tistory.com/192
	//그려질 배열의 총 길이를 설정하는 부분이라 생각하면 될 것 같음.
	function mockData() {
		//시작 숫자와 끝 숫자는 DB 데이터의 KEY 넘의 시작과 끝 번호로 넣어주면 됨
		return _.map(_.range(1, 20000), function(i) {
			return {
				id : i, //이 부분에 DB에 저장 된 KEY 값으로 넣어주고 
				text : shuffle('안녕하세요') + ' ' + i, //이 부분에는 DB상에 저장 된 문자 (EX: 서울, 대한민국)
			};
		});
	}
	
	//무한 스크롤을 발생 시키는 코드 
	(function() {
		// 셀렉트2를 생성하는 부분으로 여기서 선택 된 test라는 아이디는 화면상에 그려진 input의 아이디 이다.
		$('#test').select2(
				{
					data : mockData(),
					placeholder : 'search',
					multiple : true,
					// query with pagination
					query : function(q) {
						var pageSize, results, that = this;
						pageSize = 20; // or whatever pagesize
						results = [];
						if (q.term && q.term !== '') {
							// HEADS UP; for the _.filter function i use underscore (actually lo-dash) here
							results = _.filter(that.data, function(e) {
								return e.text.toUpperCase().indexOf(
										q.term.toUpperCase()) >= 0;
							});
						} else if (q.term === '') {
							results = that.data;
						}
						q.callback({
							results : results.slice((q.page - 1) * pageSize,
									q.page * pageSize),
							more : results.length >= q.page * pageSize,
						});
					},
				});
	})();
</script>
</html>