<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <% request.setAttribute("contextPath", request.getContextPath()); %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행상세</title>

<script type="text/javascript">
var locations = ${cityInfo};

function initMap() {
   // 검색한 지도
   var labels = '123456789';

   var uluru = {
      lat : locations[0].lat,
      lng : locations[0].lng
   };
   // The map, centered at Uluru
   var map = new google.maps.Map(document.getElementById('map'), {
      zoom : 3,
      center : uluru
   });
   // The marker, positioned at Uluru
   var markers = locations.map(function(location, i) {
      return new google.maps.Marker({
         position : location,
         label : labels[i % labels.length],
         animation : google.maps.Animation.DROP
      });
   });
   var markerCluster = new MarkerClusterer(
         map,
         markers,
         {
            imagePath : 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
         });
   
   
   var flightPath = new google.maps.Polyline({
      path : locations,
      geodesic : true,
      strokeColor : '#4286f4',
      strokeOpacity : 1.0,
      strokeWeight : 2
   });

   flightPath.setMap(map);
   
   
}


   
   

//div 토글용 펑션
function toggleDisplay() {
   var leftDiv1 = $("#leftDiv-1");
   var leftDiv2 = $("#leftDiv-2");
   //var leftDiv2Attr = $("leftDiv-2").attr("display");
   leftDiv2.toggle();
   //css속성이라 css로 했어야했는데 attr prop 쓰냐고 헷갈림
   if(leftDiv2.css("display")=="none"){
      leftDiv1.animate({width:"100%"},400,"swing");
   }else if(leftDiv2.css("display")=="block"){
      leftDiv1.animate({width:"50%"}, 400 ,"swing");
   }
}


function drawCityTable() {
  // 동기로 도시 리스트 그리는 부분 화면 좌하단
   var cityNames = ${cityInfo};
   var leftDiv12 = $("#leftDiv-1-2");
   var j = 1;
      
       for(var i =0;i<cityNames.length;i++){
         var col = $("<div class='col-sm-12' style='padding: 0px;'>");   
         var table = $("<table class='table'>");
         var tr = $("<tr>");
         var hiddenLat = $("<input type='hidden' name='lat' value='"+cityNames[i].lat+"' id='lat"+i+"'>");
         var hiddenLng = $("<input type='hidden' name='lng' value='"+cityNames[i].lng+"' id='lng"+i+"'>");
         var moveBtn = $("<input type='button' class='btn btn-primary btn-sm' value='>>' id='moveBtn' onclick='moveToMakerLocation("+i+")'> ")
         $("<th style='width: 20px;'>").text(j+"번").appendTo(tr);
         $("<th style='max-width: 90px; text-align: left; width: 90px;'>").text(cityNames[i].cityName).appendTo(tr);
         $("<th style='max-width: 15px; text-align: right; width: 15px;'> ").append(hiddenLat).append(hiddenLng).append(moveBtn).appendTo(tr);
         tr.appendTo(table);
         table.appendTo(col);
         col.appendTo(leftDiv12);
         j++;
         
         
      } 
      
      
     
}

function moveToMakerLocation(i) {
   //버튼 클릭시 해당 마커로 이동하는 펑션 
   //단점이 맵 을 다시 줌을 작게했을때 마커 사이에 선그린게 없어짐 
   //마커를 지우니 어디 찍고있는지 안보임
   swal({
        icon:"success"
     });
     //alert($("#lat"+i).val());
     var mlat = $("#lat"+i).val();
     var mlng = $("#lng"+i).val();
   
     var move = {lat: parseFloat(mlat), lng: parseFloat(mlng)};
    
     var map = new google.maps.Map(
         document.getElementById('map'), {zoom: 15, center: move});
    
     var marker = new google.maps.Marker({position: move, map: map});
}


function createReplyTable(pageNum) {
	//댓글 리스트 그리는 펑션
	if(pageNum){
		//pageNum 이 undefined면 false 있으면 true 로 계속 진행하면 된다
	}else{
		//undefined시 페이지 번호를 1로 설정
		pageNum = 1;
	}
	
	
	var boardKey = "${boardInfo.TRIP_BOARD_KEY}";
	var replyTable = $("#replyTable");
	replyTable.html("");
	
	$.ajax({
		url:"${contextPath}/tripReply/replyList",
		type:"get",
		data:{"boardKey":boardKey,"pageNum":pageNum},
		dataType:"json",
		success:function(result){
	
			var list = result.replyList;
			
			
			for(var i in list){
	
				var parentReply = "   <input type='hidden' id='replyBoardKey"+i+"' name='trip_Board_Key' value='"+list[i].TRIP_BOARD_KEY+"'>" + 
				"                 <input type='hidden' id='replyUserNum"+i+"' name='user_Num' value='"+list[i].USER_NUM+"'>" + 
				"                 <input type='hidden' id='replyGid"+i+"' name='trip_Reply_Gid' value='"+list[i].TRIP_REPLY_GID+"'>" + 
				"                 <input type='hidden' id='replyDepth"+i+"' name='trip_Reply_Depth' value='"+list[i].TRIP_REPLY_DEPTH+"'>" + 
				"                 <input type='hidden' id='replySorts"+i+"' name='trip_Reply_Sorts' value='"+list[i].TRIP_REPLY_SORTS+"'>"+
				" 				  <input type='hidden' id='replyKey"+i+"' name='Trip_Reply_Key' value='"+list[i].TRIP_REPLY_KEY+"'>";

 				var tr = $("<tr id='row"+i+"' style='border:1px dotted #cccccc;'>");
 				var reBtn = $("<input type='button' class='btn btn-primary' id='colBtn"+i+"' onclick='togglerereply("+i+")' value='답글' style='height: 25px; width: 25px; font-size: 4pt; text-align: center; padding: 0px;'>");
 				
 				$("<th class='tableft'>").html("<p>"+list[i].USER_LNM+list[i].USER_FNM+"</p>").appendTo(tr);
 				if(list[i].TRIP_REPLY_DEPTH==0){
 					$("<th>").html(list[i].TRIP_REPLY_CONTENT+"&nbsp;").append(reBtn).appendTo(tr);
 				}else{
 					$("<th>").html("<img src='${contextPath}/img/trip_arrowimg2.jpg' style='height:20px; width:20px;'>").append(list[i].TRIP_REPLY_CONTENT+"&nbsp;").append(reBtn).appendTo(tr);
 				}

 				$("<th class='tabright'>").html("<p>"+list[i].TRIP_REPLY_WRITEDATE+"</p>").append(parentReply).appendTo(tr);
 				$("<th class='tabright'>").html("<img onclick='checkReply("+i+")'  src='${contextPath}/img/trip_x_Img.jpg' style='height:20px; width:20px;'>").appendTo(tr);
 				tr.appendTo(replyTable);
			
 				if(list[i].TRIP_REPLY_DEPTH>0){
 					//대댓글 용 css 밑에 밑으로 내려갈수록 padding으로 구분
 					var padding = 20*list[i].TRIP_REPLY_DEPTH;
 					$("#row"+i+"> th").css("padding-left",padding+"px");
 					//$(".tab").css("padding-left",padding+"px");
 				}
 				$(".tableft").css("padding-left","0px;");
 				$(".tabright").css("text-align","right");
 				

			}// 댓글 리스트 그리는 반복문 끝
			
			//페이저 부분
				var start = result.start;
				var end =result.end;
				var total = result.total;
				var currentPage = result.page;
				
				
				//var replyModalFooter = $("#replyModalFooter");
				var replyPager = $("#replyPager");
				replyPager.html("");
				for(start;start<=total;start++){
					$("<a onclick='replyPager("+start+")'>"+start+"</a>").append("&nbsp;&nbsp;").appendTo(replyPager);
				}
				
			
		}
		
	});
	
}

function replyPager(start) {
	// 페이지 버튼 클릭시 펑션
	var pageNum = start;
	var boardKey = "${boardInfo.TRIP_BOARD_KEY}";
	// 클릭시 페이지 넘 받아서 createReplyTable 에 파라메터 집어넣고 실행
	createReplyTable(pageNum);

}

function checkReply(i) {
	//댓글 삭제 펑션
	var replyKey = $("#replyKey"+i).val();

	//취소 alert
	swal( {
		  title: "비밀번호 체크",
		  text:"원글 삭제시 댓글도 같이 삭제되니 유의해주세요.",
		  content: {
			    element: "input",
			    attributes: {
			      placeholder: "비밀번호를 입력해주세요.",
			      type: "password",
			    },
			  },
		  buttons: true,
		  buttons: ["취소", "확인"],
		  closeOnClickOutside: false,
		})
		.then((value) =>  {
			 
			if(!value){
				//value== null 이나 value =="" 안먹음 
				swal({
					text:"비밀번호를 입력해주세요",
					icon:"warning",
				});
				return false;
			}
			
		 	$.ajax({
		 		url:"${contextPath}/tripReply/checkPw",
		 		type:"post",
		 		data:{"replyKey":replyKey,"checkReplyPw":value,"${_csrf.parameterName}":'${_csrf.token}'},
		 		dataType:"json",
		 		success:function(result){
		 			// 이걸로 비번체크를 해서 갔다온담에 if로 걸러서 true 일때 다른 펑션을 실행해서 삭제한다 
		 			// 403에러 ajax 는 동작하는듯?
		 			// 원인은 토큰의 문제? 
		 			if(result){
		 				swal({
		 					icon:"success",
		 					text:"비밀번호 일치",
		 				});		
		 				deleteReply(replyKey);
				
		 			}else{
		 				swal({
		 					icon:"warning",
		 					text:"비밀번호 불일치 다시 시도해 주세요",
		 				});
		 			} 			
		 		}	 		
		 	});		
		});
	
	

}

function deleteReply(replyKey) {
	//alert(replyKey);
	
	$.ajax({
		url:"${contextPath}/tripReply/deleteReply",
		type:"get",
		data:{"replyKey":replyKey},
		dataType:"json",
		success:function(result){
			if(result){
				swal({
 					icon:"success",
 					text:"삭제 성공하였습니다.",
 				});
				createReplyTable();
			}else{
				swal({
 					icon:"warning",
 					text:"삭제 실패하였습니다. 다시시도해 주세요",
 				});
			}
		}
		
	});
	
	
	
	
}



function togglerereply(i) {
//대댓글 입력 펑션 댓글에 달린 답글 클릭시 요소를 새로 생성해 추가한다 

 	var reRowTr = $("<tr id='reRow"+i+"' style='border:1px dotted #cccccc;'>");
 	var tr = $("#row"+i);
 	
 	var rereBoardKey = $("#replyBoardKey"+i).val();
 	var rereGid= $("#replyGid"+i).val();
 	var rereDepth= $("#replyDepth"+i).val();
 	var rerSorts= $("#replySorts"+i).val();
 	
 	
	var str = "<form id='rereForm"+i+"'>"
		+ " <input type='text' class='form-control' name='trip_Reply_Content' id='rereContent"+i+"' style='border: 1px solid #8eb7f9;'>"
		+ " <input type='hidden' id='rereBoardKey"+i+"' name='trip_Board_Key' value='"+rereBoardKey+"'>" + 
		"   <input type='hidden' id='rereUserNum"+i+"' name='user_Num' value='${userNum}'>" + 
		"   <input type='hidden' id='rereGid"+i+"' name='trip_Reply_Gid' value='"+rereGid+"'>" + 
		"   <input type='hidden' id='rereDepth"+i+"' name='trip_Reply_Depth' value='"+rereDepth+"'>" + 
		"   <input type='hidden' id='rereSorts"+i+"' name='trip_Reply_Sorts' value='"+rerSorts+"'>"
		+"<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>"
		+ "</form>";
 	
 	
 	$("<td>").html("<img src='${contextPath}/img/trip_arrowimg2.jpg' style='height:30px; width:30px;'>").appendTo(reRowTr);
 	$("<td>").append(str).appendTo(reRowTr);
 	$("<td>").html("<input type='button' class='btn btn-info' value='작성' onclick='reReplyWrite("+i+")' id='rereBtn"+i+"' name=''>").appendTo(reRowTr);
 	tr.after(reRowTr);
	
 	
 	
 	//인풋태그의 엔터 입력시 submit 을 막기
 	// onload 밑 에있을시는 아직 요소가 생성이 안된 상태기 때문에 이 요소를 선택할수 없다 그러니 그려줄때 넣어주니 해결
    $('input[type="text"]').keydown(function(event) {
 	   
 	   if (event.keyCode === 13) {
 		   //preventDefault() 서브밋 막는 녀석
 	        event.preventDefault();      
 		    return false;
 		   	
 	    }
 	});
 	
//콜렙스가 아니라 tr을 추가하는 방식으로 진행해보기	- 요소  추가는 되지만 눈에 안보임 - 폐기
	
//  	var reRowTr = ("<tr id='reRow"+i+"' style='z-index:99; border:5px solid blue; '>");
//  	var tr = $("#row"+i);
//  	$("<td>").html("<img src='${contextPath}/img/trip_arrowImg.jpg'>").appendTo(reRowTr);
//  	$("<td>").html("<input type='text' class='form-control' name='1' id='1' style='border: 1px solid #cccccc;'>").appendTo(reRowTr);
//  	$("<td>").html("<input type='button' class='btn btn-info' value='작성' id='12' name=''>").appendTo(reRowTr);
//  	tr.after(reRowTr);
	
	
	
	
}


function reReplyWrite(i) {
	//대댓글 입력 펑션
	var rere = $("#rereForm"+i).serialize();
	
	
	$.ajax({
		url:"${contextPath}/tripReply/writeReReply",
		type:"post",
		data:rere,
		dataType:"json",
		success:function(result){
			
			if(result){
				
				createReplyTable();
				
			}else{
				swal({
	                  icon:"warning",
	                  text:"댓글 입력실패 다시 시도해주세요.",
	               });
			}

			
			
		}

		
		
	});
	
}


function goToProfile() {

	/* 	$(".profile").mousedown(function() {
			(".profile").css("background-color", "#ef2d4d");
		})
		
		$(".profile").mouseup(function() {
			location.href = "${contextPath}/accounts/profile?user=${user_Num}";
		}) */
		//location.href = "${contextPath}/accounts/profile?user=${userNum}";
	}



window.onload = function() {
   
   
   initMap();
   drawCityTable();
   createReplyTable();
   
   //수정 삭제 실패시 alert로 사용자에게 알림
   var msg = "${msg}";
   if(msg !=null && msg != ""){
      swal({
         icon:"warning",
         text:msg,
      });
   }
   
   $("#deleteForm").on("submit", function() {
      //게시글 삭제 펑션
      
      var deleteSerialize = $(this).serialize();
      //alert(deleteSerialize);
      var result = false;
      var deletePw = $("#deletePw");
      $.ajax({
         url:"checkPw",
         type:"post",
         data:deleteSerialize,
         dataType:"json",
         async:false,
         success:function(data){
            if(data){
                /*  swal({
                  icon:"success",
                  text:"비밀번호 일치",
               });  */ 
               
               result =true;
            }else{
                 swal({
                  icon:"warning",
                  text:"비밀번호 불일치 다시 시도해 주세요.",
               });  
                 deletePw.val("");
               
            }   
         }
      });
      if(!result){
         return false;
      }
      
   })//게시글 삭제펑션 끝

   $("#modifyForm").on("submit", function() {
      //게시글 수정 펑션
      modifySerialize = $(this).serialize();
      var result = false;
      var modifyPw = $("#modifyPw");
      $.ajax({
         url:"checkPw",
         type:"post",
         data:modifySerialize,
         dataType:"json",
         async:false,
         success:function(data){
            if(data){
                /*  swal({
                  icon:"success",
                  text:"비밀번호 일치",
               });  */ 
               
               result =true;
            }else{
                 swal({
                  icon:"warning",
                  text:"비밀번호 불일치 다시 시도해 주세요.",
               });  
                 modifyPw.val("");
               
            }   
         }
      });
      if(!result){
         return false;
      }
      
      
      
     
      
      
      
      
   })
   
   $("#replyForm").on("submit", function() {
      var reply = $(this).serialize();
      
      $.ajax({
         url:"${contextPath}/tripReply/writeReply",
         type:"post",
         data:reply,
         dataType:"json",
         success:function(result){
            
            if(result){
               swal({
                  icon:"success",
               });
               createReplyTable();
               $("#replyContent").val("");
            }else{
               swal({
                  icon:"warning",
                  text:"댓글 입력실패 다시 시도해주세요.",
               });
            }
         }
         
      });
      return false;
      
   })
   

   $("#declarationBtn").on("click", function() {
   		
	    var dModal = $("#declarationModalBody");
	   
   		dModal.html("");
   		
   		$.ajax({
		   url:"getDeclaration",
		   type:"post",
		   data:{"${_csrf.parameterName}":"${_csrf.token}"},
		   dataType:"json",
		   success:function(data){
	   
			   var str = "	<select class='form-control' name='DECLARATION_KEY' id='searchType' style='width: 100%;'>" + 
				"							<option value='"+data[0].DECLARATION_KEY+"'>"+data[0].DECLARATION_CONTENT+"</option>" + 
				"							<option value='"+data[1].DECLARATION_KEY+"'>"+data[1].DECLARATION_CONTENT+"</option>" + 
				"							<option value='"+data[2].DECLARATION_KEY+"'>"+data[2].DECLARATION_CONTENT+"</option>" + 
				"							<option value='"+data[3].DECLARATION_KEY+"'>"+data[3].DECLARATION_CONTENT+"</option>" + 
				"							<option value='"+data[4].DECLARATION_KEY+"'>"+data[4].DECLARATION_CONTENT+"</option>" + 
				"							<option value='"+data[5].DECLARATION_KEY+"'>"+data[5].DECLARATION_CONTENT+"</option>" +
				"							<option value='"+data[6].DECLARATION_KEY+"'>"+data[6].DECLARATION_CONTENT+"</option>" +
				"		</select>";
			   
			   dModal.html(str);
			   var dContent = $("#dContent");
			   dContent.css("display","none");
		  	   $("#dp").css("display", "none");
			   
			   
			    $("#searchType").on("change", function() {
			  	  
			       
			  	   var TypeVal = $("#searchType option:selected").val();
			  	   if(TypeVal==7){
			  		  dContent.css("display","block");
			  		  $("#dp").css("display", "block");
			  	   }else{
			  		  dContent.css("display","none");
			  		 $("#dp").css("display", "none");
			  	   }
			 	   
			 	   
			     })
				
	   
				
		   }
		   
		   
		   
	   });
	   
	   
	   
   })
   
   
   $("#dSubmit").on("click", function() {
   
	   var dSerialize = $("#declarationForm").serialize();
	   
	   $.ajax({
		   url:"insertDeclaration",
		   type:"post",
		   data:dSerialize,
		   dataType:"json",
		   success:function(result){
			   if(result){
				   
				   swal({
					   icon:"success",
					   text:"신고 접수 완료하였습니다.",
				   });
				   $("#dContent").val("");
			   }else{
				   swal({
					   icon:"warning",
					   text:"게시글당 신고는 한번만 가능합니다.",
				   });
				   $("#dContent").val("");
			   }
		   }
		   
		   
		   
		   
	   });
	   
   })
   

   
  
   
   
   
   
}//onload 끝



</script>
<style type="text/css">
#con1 {
   height: 1000px;
}

#leftDiv {
   min-height: 1000px;
   max-height: 1000px;
   overflow: auto;
   padding: 0px;
   background-color: #eeeeee;
}
#leftDiv-1{
   min-height: 1000px;
   max-height: 1000px;
   height:100%;
   width: 100%;
   padding:0px;
   margin:0px;
   overflow: hidden;
}
#leftDiv-1-1{
   min-height: 200px;
   max-height: 200px;
   height:20%;
   width: 100%;
   border-right:1px solid #cccccc;
   margin:0px;
   overflow: hidden;
}
#leftDiv-1-2{
   min-height: 800px;
   max-height: 800px;
   height:800%;
   width: 100%;
   border: 1px solid #cccccc;
   margin:0px;
   overflow: auto;
}
#leftTable{
   min-height: 200px;
   max-height: 200px;
   height: 100%;
   overflow: hidden;
}
#leftDiv-2{
   min-height: 1000px;
   max-height: 1000px;
   height:100%;
   width: 50%;
   border: 1px solid #cccccc;
   padding: 0px;
   overflow: auto;
   display: none;
}
th{
   padding: 0px;
}
/* #leftDiv-2-1{ */


/* } */

#rightDiv {
   min-height: 1000px;
   max-height: 1000px;
   padding: 1px;
}
/*#rightRow1{
   min-height: 1000px;
   max-height: 1000px;
   width:100%;
   margin: 0px;
}
 #rightRow2{
   min-height: 200px;
   max-height: 200px;
   width:100%;
   border-top:1px dotted;
   margin: 0px;
} */
#boardContent{
   min-height: 200px;
   max-height: 200px;
   width: 100%;
   height: 100%;
   overflow: auto;
   
}
#boardContent-1{
   font-size: 12pt;
}

#replyModalBody{
   min-height: 500px;
}

#sogaeTable{
   max-width: 300px;
   width: 300px;
   overflow: scroll;
}

#tripsogae{

   font-size: 13pt;
}

#map{
   height:   1000px;
   width: 100%;

}


.swal-text {
  background-color: #FEFAE3;
  padding: 17px;
  border: 1px solid #F0E1A1;
  display: block;
  margin: 22px;
  text-align: center;
  color: #f94563;
  font-size: 12pt;
}
#sogaeTable > tr th td{
	width: 500px;
}
#boardInfoContent{
    min-height: 520px;
    max-height: 520px;
    min-width : 330px;
    max-width : 330px;
    width: 100%;
	height : 100%;
    word-wrap: break-word;
    overflow: auto;
    white-space: pre-wrap;

}

</style>
</head>
<body>

   <!-- 인클루드 심플 헤더 -->
   <jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/trip/trip-navbar.jsp"></jsp:include>
   <!-- 인클루드 심플 헤더 END -->
   <!--  -->
 <script type="text/javascript"
   src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc&libraries=places"></script>
<script
   src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">   
</script>
   
   <div class="container-fluid" id="con1">
      <div class="row" id="mainRow">
         <!--왼쪽 사이드 div  -->
         <div class="col-lg-4" id="leftDiv">
            
            <div class="col-lg-6" id="leftDiv-1">
                
                <div class="row" id="leftDiv-1-1">

                   <table class="table" id="leftTable">
                      <tr>
                         <th colspan="4">
                            <h4>${boardInfo.TRIP_BOARD_TITLE}</h4>
                         </th>
                      </tr>
                      <tr>
                         <th>
                            <c:choose>
									<c:when test="${boardInfo.USER_PROFILE_PIC eq 'n'}">
										<a href="" rel="popover" class="img-circle" data-placement="bottom"
											data-popover-content="#userInfo"> <img
											src="${contextPath}/img/trip_Profile.png">
										</a>

									</c:when>
									<c:otherwise>
										<a href="" rel="popover" class="img-circle" data-placement="bottom"
											data-popover-content="#userInfo"> <img
											src="${contextPath}/image?fileName=${boardInfo.USER_PROFILE_PIC}"
											style="width: 40px; height: 40px;">
										</a>
									</c:otherwise>
								</c:choose>
                            &nbsp;&nbsp;
                            <span>${boardInfo.USER_LNM}${boardInfo.USER_FNM}</span>
                            
                         </th>
                      </tr>
                      <tr>
                         <td><input  type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#replyModal" value="동행">
                         <input type="button" onclick="toggleDisplay()" class="btn btn-primary btn-xs" value="소개">
                         <input type="button" id="declarationBtn"  class="btn btn-primary btn-xs" data-toggle="modal" data-target="#declarationModal" value="신고">
                         <input type="button"  class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal"value="수정">
                         <input type="button"  class="btn btn-primary btn-xs" data-toggle="modal" data-target="#deleteModal" value="삭제">
<!--                           <input type="button" class="btn btn-primary" value="답글" id="" onclick="" style="height: 25px; width: 25px; font-size: 4pt; text-align: center; padding: 0px;" >  -->
                         </td>
                      </tr>
                   </table>
   
                
                </div>
                <div class="row" id="leftDiv-1-2">
                      <!--도시 리스트 그려지는 부분  -->
                </div>
                
            </div>
            
            <!--중앙 div 콜렙스 될부분  -->
            <div class="col-lg-6 container-fluid"  id="leftDiv-2">
                
                   <table class="table" id="sogaeTable" >
                      <tr>
                         <th>
                            <h2><b><small><mark>관심사</mark></small></b></h2>
                         </th>
                      
                      </tr>
                      <tr>
                         <td>
                         <c:choose>
							<c:when test="${userInfo.UserInterest != null}">			
								<c:forEach items="${userInfo.UserInterest}" var="i">
									<span class="label label-mint label-lg"><b>${i.INTEREST_NAME}</b></span>
								</c:forEach>	
							</c:when>
							<c:otherwise>			
								<span class="label label-pink label-lg profile" onclick="goToProfile()" data-toggle="tooltip" data-placement="right" title="프로필 설정은 나의 정보에서 가능합니다.">미등록</span>
							</c:otherwise>
						</c:choose>
                         </td>
                      </tr>
                      <tr>
                         <th>
                            <h2><b><small><mark>여행스타일</mark></small></b></h2>
                         </th>            
                      </tr>
                      <tr>
                         <td>
                         <c:choose>
							<c:when test="${userInfo.UserTrStyle != null}">
								<c:forEach items="${userInfo.UserTrStyle}" var="tr">
									<span class="label label-mint label-lg"><b>${tr.TR_STYLE}</b></span>
								</c:forEach>	
							</c:when>
							<c:otherwise>
								<span class="label label-pink label-lg profile" onclick="goToProfile()" data-toggle="tooltip" data-placement="right" title="프로필 설정은 나의 정보에서 가능합니다.">미등록</span>
							</c:otherwise>
						</c:choose>
                         </td>
                      </tr>
                      
                      
                      <tr>
                      
                      </tr>
                      <tr>
                         <th>
                            <h2><b><small><mark>여행소개</mark></small></b></h2>
                         </th>
                      </tr>
                      <tr>
                         <td id="tripsogae">
                         		<%-- <div id="boardInfoContent">
                         			${boardInfo.TRIP_BOARD_COUNTENT}
                         		</div> --%>
                         		<pre id="boardInfoContent">${boardInfo.TRIP_BOARD_COUNTENT}</pre>
                               
                         </td>
                      </tr>
                   </table>
          
                
            </div>
            
         </div>
         
         <!--지도 들어갈 div  -->
         <div class="col-lg-8" id="rightDiv">
            <div id="map">지도</div> 
         <%--   
            우측 div를 상하단으로 8/2비율로 나눌때 
         <div class="row" id="rightRow1">
               
            </div>
             <div class="row" id="rightRow2">
                <div id="boardContent">
                   <span id="boardContent-1">${boardInfo.TRIP_BOARD_COUNTENT}</span>      
                </div> 
            </div> --%>
         </div>
      
      
      
      
      </div>
   </div>
   
   <!--댓글창 모달  -->
<div class="container">
  <!-- Modal -->
  <div class="modal fade" id="replyModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content" id="replyModal">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">
             <img alt="" src="${contextPath}/img/trip_withimg1.jpg" style="width: 20%; height: 50%;">
          </h4>
        </div>
        <div class="modal-body" id="replyModalBody">
            <form action="#" method="post" id="replyForm">
                 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                 <textarea class="form-control" rows="2" id="replyContent" name="trip_Reply_Content" required="required"></textarea>
                 <input type="hidden" id="replyBoardKey" name="trip_Board_Key" value="${boardInfo.TRIP_BOARD_KEY}">
                 <input type="hidden" id="replyUserNum" name="user_Num" value="${userNum}">
                 <input type="hidden" id="replyGid" name="trip_Reply_Gid" value="0">
                 <input type="hidden" id="replyDepth" name="trip_Reply_Depth" value="0">
                 <input type="hidden" id="replySorts" name="trip_Reply_Sorts" value="0">
                 <input type="submit" value="입력" class="btn btn-info">
            </form>
            <!--댓글리스트 출력 부분  -->
            <br>
            <br>
<!--             <div id="replyTable" class="container-fluid">        -->
<!--             <div class="row">  -->
<!--                <div class="col-lg-2" style="border: 1px solid #cccccc; min-height: 40px; max-height: 40px; overflow: hidden;">이름</div>  -->
<!--                 <div class="col-lg-8" style="border: 1px solid #cccccc; min-height: 40px; max-height: 40px; overflow: hidden;">내용<a data-toggle="collapse" data-target="#rereply">시붕</a></div>  -->
<!--                 <div class="col-lg-2" style="border: 1px solid #cccccc; min-height: 40px; max-height: 40px; overflow: hidden;">날짜</div>  -->
<!--             </div>  -->
<!--             <div class="row collapse" id="rereply">   -->
<!--                <div class="col-lg-2" style="border: 1px solid #cccccc; min-height: 40px; max-height: 40px; overflow: hidden;">이름</div>  -->
<!--                 <div class="col-lg-8" style="border: 1px solid #cccccc; min-height: 40px; max-height: 40px; overflow: hidden;">내용</div>  -->
<!--                 <div class="col-lg-2" style="border: 1px solid #cccccc; min-height: 40px; max-height: 40px; overflow: hidden;">입력</div>  -->
<!--            </div>  -->
         
<!--             </div> -->
  <div class="table-responsive">   
  		<table class="table">
  			<tr>
  				<th><mark>동행신청</mark></th>
  				
  			</tr>
  		</table>
  
  	 <table class="table" id="replyTable" ></table>
  </div>
        
        <div id="replyPager">
        
        </div>
 
         
         
        </div>
        <div class="modal-footer" >
        
<!--           <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button> -->
        </div>
      </div>
    </div>
  </div>
</div>


   <!--신고창 모달  -->
<div class="container">
  

  <div class="modal fade" id="declarationModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">
				<b>게시글 신고</b>
			</h4>
        </div>
       <form action="#" id="declarationForm" method="post">
	       	 <div class="modal-body" id="declarationModalBody">
<!-- 	         	신고데이터 테이블에서 데이터 끌고와 넣는곳 -->

	        </div>
	        <div class="modal-footer" id="dForm">
	       	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	       	 	<input type="hidden" name="TRIP_BOARD_KEY" value="${boardInfo.TRIP_BOARD_KEY}">
	         	<input type="hidden" name="D_USER_NUM" value="${boardInfo.USER_NUM}">
	         	<input type="hidden" name="USER_NUM" value="${userNum}">   	
	         	<p style="text-align: left;" id="dp" >상세 신고내용</p>
	         	<textarea rows="10" cols="30" style="width: 100%;" id="dContent"  name="TRIP_D_DETAILCONTENT"></textarea>
	         	<input type="button" id="dSubmit" class="btn btn-info" value="신고작성">
	         
	
	        </div>
       </form>
      </div>
      
    </div>
  </div>
  
</div>

   <!--수정창 모달  -->
<div class="container">
  
  <div class="modal fade" id="modifyModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">비밀번호 확인</h4>
        </div>
        <form action="modify1" method="post" id="modifyForm">
        <div class="modal-body" id="deleteModalBody">
           
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
              <input type="hidden" value="${boardInfo.TRIP_BOARD_KEY}" name="boardKey">
             <div class="form-group">
               <label for="pwd">비밀번호:</label>
               <input type="password" class="form-control" id="modifyPw" placeholder="비밀번호를 입력해주세요." name="user_pwCheck">
             </div>
         
          
        </div>
        <div class="modal-footer">
          <input type="button" class="btn btn-info" data-dismiss="modal" value="닫기">
          <input type="submit" class="btn btn-danger" value="확인">
        </div>
           
    </form>
      </div>
      
    </div>
  </div>
  
</div>   
   
<!--삭제창 모달  -->
<div class="container">
  
  <div class="modal fade" id="deleteModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">비밀번호 확인</h4>
        </div>
        <form action="boardDelete" method="post" id="deleteForm">
        <div class="modal-body" id="deleteModalBody">
           
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
             <div class="form-group">
               <input type="hidden" value="${boardInfo.TRIP_BOARD_KEY}" name="boardKey">
               <label for="pwd">비밀번호:</label>
               <input type="password" class="form-control" id="deletePw" placeholder="비밀번호를 입력해주세요." name=user_pwCheck>
             </div>
         
          
        </div>
        <div class="modal-footer">
          <input type="button" class="btn btn-info" data-dismiss="modal" value="닫기">
          <input type="submit" class="btn btn-danger" value="확인">
        </div>
           
    </form>
      </div>
      
    </div>
  </div>
  
</div>      
   <!--댓글 삭제 모달  -->
   <div class="container">
  
  <div class="modal fade" id="deleteReplyModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">비밀번호 확인</h4>
        </div>
        <form action="#" method="post" id="deleteReplyForm">
        <div class="modal-body" id="deleteReplyModalBody">
           
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
              <input type="hidden" value="" name="userNum">
             <div class="form-group">
               <label for="pwd">비밀번호:</label>
               <input type="password" class="form-control" id="deleteReplyPw" placeholder="비밀번호를 입력해주세요." name="user_pwCheck">
             </div>
         
          
        </div>
        <div class="modal-footer">
          <input type="submit" class="btn btn-danger" value="확인">
          <input type="button" class="btn btn-info" data-dismiss="modal" value="닫기">
        </div>
           
    </form>
      </div>
      
    </div>
  </div>
  
</div> 

<!--팝오버  -->
 <div id="userInfo" class="hide" style="margin-left: auto; margin-right: auto; text-align: center;">
									${boardInfo.USER_LNM} ${boardInfo.USER_FNM} <br>
									<a href="${contextPath}/accounts/profile?user=${boardInfo.USER_NUM}">프로필보기</a><br>
									<sec:authorize access="isAuthenticated()"> <!-- 로그인 상태 일때만 표시 -->
									<a href="#">대화하기</a>
									</sec:authorize>
										   
								</div> 

	<!--팝오버 끝  -->


  
<script type="text/javascript">
	
$(function(){
    $('[rel="popover"]').popover({
        container: 'body',
        html: true,
        content: function () {
            var clone = $($(this).data('popover-content')).clone(true).removeClass('hide');
            return clone;
        }
    }).click(function(e) {
        e.preventDefault();
    });
});


</script>
   <!-- 인클루드-푸터 -->
   <jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
   <!-- 인클루드-푸터 END -->

</body>
</html>