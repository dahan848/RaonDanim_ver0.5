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

// 여행자 클릭시 '거주도시' 텍스트를 '여행도시'로 변환 
var $label_city = $("[for=id_city]");

$("input:radio[name=traveler_type]").click(function(){
	var traveler_type = $(':radio[name="traveler_type"]:checked').val();
	if(traveler_type === "traveler"){
		$label_city.html('여행 도시');
	} else{
		$label_city.html('거주 도시');
	}
});

// 회원 정보에서 여행희망도시 라벨 색 랜덤 반환
$(".cover-tags-certification").each(function (index, data) {
    var rand_list = ['pink', 'gray', 'violet', 'skyblue', 'orange', 'mint'];
    var counter = 6;

    while(counter > 0){
        var rand_num = Math.floor(Math.random() * counter);
        counter--;

        temp = rand_list[counter];
        rand_list[counter] = rand_list[rand_num];
        rand_list[rand_num] = temp;
    }

    $(".cover-tags-certification .label").each(function (index, data) {
        index = index % 6;
        $(data).addClass("label-" + rand_list[index])
    });
});