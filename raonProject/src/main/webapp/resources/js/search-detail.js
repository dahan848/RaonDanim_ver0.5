// 조건 추가 클릭시 '현지친구 및 여행자검색' 텍스트를 '상세 검색'으로 변환
$(function(){
	$('.btn-collapse').click(function(){
		if($('.panel-title').html() == '현지친구 및 여행자 검색'){
			$('.panel-title').html('상세 검색');
		}
		else{
			$('.panel-title').html('현지친구 및 여행자 검색');
		}
	});
});

var $label_city = $("[for=id_city]");

$("input:radio[name=traveler_type]").click(function(){
	var traveler_type = $(':radio[name="traveler_type"]:checked').val();
	if(traveler_type === "traveler"){
		$label_city.html('여행 도시');
	} else{
		$label_city.html('거주 도시');
	}
});