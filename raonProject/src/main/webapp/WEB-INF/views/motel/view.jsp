<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.user_num" var="user_num"/>
</sec:authorize>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>상세페이지</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  
  <!-- 구글맵 -->
  <script
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc">
</script>

<!-- 클립보드 복사 -->
<script src="https://cdn.jsdelivr.net/clipboard.js/1.5.3/clipboard.min.js"></script>





  <script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  <link rel="stylesheet" type="text/css"
	href="${contextPath}/css/star.css">
<script type="text/javascript">
var tmpPrice = ${MOTEL_PRICE};
var price = tmpPrice.toLocaleString();
var tmpTripDate = "${tripDate}";
if(tmpTripDate == ""){
	tmpTripDate = 0
}
var tmpTotalPrice = ${MOTEL_PRICE}*tmpTripDate
var totalPrice = tmpTotalPrice.toLocaleString();
var myCenter = new google.maps.LatLng(-34.397, 150.644);
var $star
var myNumber = "${user_num}";
function initialize() {
	var searchMap = new google.maps.Map(document.getElementById('googleMap'), {
        zoom: 14,
	});
	var geocoder = new google.maps.Geocoder();
	geocodeAddress(geocoder, searchMap);
	function geocodeAddress(geocoder, resultsMap) {
        
        var address = "${MOTEL_ADDRESS}";
        geocoder.geocode({'address': address}, function(results, status) {
           
          if (status === 'OK') {
            resultsMap.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
              map: resultsMap,
              position: results[0].geometry.location
            });
          } else {
            alert('Geocode was not successful for the following reason: ' + status);
          }
        });
      }
}

google.maps.event.addDomListener(window, 'load', initialize);
var count = 1;
var n = 0;
var starResult=0;
function getOriginFilename(fileName) {
	//fileName에서 uuid를 제외한 원래 파일명을 반환
	if (fileName == null) {
		return;
	}
	var idx = fileName.indexOf("_") + 1;
	return fileName.substr(idx);
}
var starRating = function(){
	 $star = $(".star-input"),
	      $result = $star.find("output>b");
	  
	  $(document)
	    .on("focusin", ".star-input>.input", function(){
	    $(this).addClass("focus");
	    
	  })
	    .on("focusout", ".star-input>.input", function(){
	    var $this = $(this);
	    setTimeout(function(){
	      if($this.find(":focus").length === 0){
	        $this.removeClass("focus");
	        
	      }
	    }, 100);
	  })
	    .on("change", ".star-input :radio", function(){
	    $result.text($(this).next().text());
	    	
	    
	  })
	    .on("mouseover", ".star-input label", function(){
	    	
	    $result.text($(this).text());
	   
	  })
	    .on("mouseleave", ".star-input>.input", function(){
	    var $checked = $star.find(":checked");
	    if($checked.length === 0){
	      $result.text("0");
	      
	    } else {
	      $result.text($checked.next().text());
	      starResult=$result.text();
	    }
	  });
	};


/* function write_reply(){
	$.ajax({
		url:"${contextPath}/motel/write_reply",
		data:{
			"${_csrf.parameterName}":"${_csrf.token}",
			"star-input":$(".star-input").val(),
			"num":$("#num").val(),
			"content":$("#content").text()
		},
		type : "post",
		dataType : "json",
		error : function(error) {
			alert("실패");
			console.log(error);
            console.log(error.status);
		},
		success:function(data){
			alert("성공");
		}
		})
		return false;
} */

	
	
	
function replyList(){
	//날짜 포캣 함수
	Date.prototype.format = function (f) {
	    if (!this.valueOf()) return " ";
	    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
	    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
	    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
	    var d = this;
	    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {
	        switch ($1) {
	            case "yyyy": return d.getFullYear(); // 년 (4자리)
	            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
	            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
	            case "dd": return d.getDate().zf(2); // 일 (2자리)
	            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
	            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)
	            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
	            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)
	            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
	            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
	            case "mm": return d.getMinutes().zf(2); // 분 (2자리)
	            case "ss": return d.getSeconds().zf(2); // 초 (2자리)
	            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
	            default: return $1;
	        }
	    });
	};
	String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
	String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
	Number.prototype.zf = function (len) { return this.toString().zf(len); };
	//날짜 포맷함수 END
	
	var conHeight = $("#con").height();
	var replyNum = "${MOTEL_NUM}";
	var user_num = "${user_num}";
	
	$.ajax({
		url:"${contextPath}/motel/replyList?page=" + count+"&num="+replyNum+"&user_num="+user_num,
		data:{"${_csrf.parameterName}":"${_csrf.token}"},
		type : "post",
		dataType : "json",
		error : function() {
			alert("실패");
		},
		success:function(data){
			count++;
			for(var i in data.board.boardList){
				

				
//  				
					$("#con").append('<div class="card" id="card'+n+'"></div>');
					var id = "#card"+n;
					$("#con").append('<hr>');
					var db_user_num1 = data.board.boardList[i].USER_NUM;
					for(var j in data.board.replyPicList){
						var db_reply_pic = data.board.replyPicList[j].USER_PROFILE_PIC;
						var db_user_num2 = data.board.replyPicList[j].USER_NUM
						if(db_user_num1 == db_user_num2){
							if(db_reply_pic != 'n'){
								console.log("사진 있음")
								$(id).append('<div class="card-body" id="profile'+n+'" style="border-radius:50%; width:50px; height:50px; border:1px solid black; display:inline-block; background-size:cover; background-image:url(${contextPath}/image?fileName='+db_reply_pic+');"></div>');
							}else{
								console.log("사진 없음")
								$(id).append('<div class="card-body" id="profile'+n+'" style="border-radius:50%; width:50px; height:50px; border:1px solid black; display:inline-block; background-size:cover; background-image:url(${contextPath}/img/home_profile_2.jpg);"></div>');
							}
						}
					}
					
// 					if(reply_pic1 != 'n'){
// 						console.log("사진 있음")
// 						$(id).append('<div class="card-body" id="profile'+n+'" style="border-radius:50%; width:50px; height:50px; border:1px solid black; display:inline-block; background-size:cover; background-image:url(${contextPath}/image?fileName='+reply_pic1+');"></div>');						
// 					}else{
// 						console.log("사진 없음")
// 						$(id).append('<div class="card-body" id="profile'+n+'" style="border-radius:50%; width:50px; height:50px; border:1px solid black; display:inline-block; background-size:cover; background-image:url(${contextPath}/img/home_profile_2.jpg);"></div>');
// 					}
					$(id).append('<div id="name'+n+'" style="display:inline-block;"></div>');
					var name="#name"+n;
					$(id).append('<div><input type="hidden" id="replyNum'+n+'" value="'+data.board.boardList[i].MOTEL_REPLY_SQ+'"></input></div>')
					$(id).append('<div><input type="hidden" id="user_num1'+n+'" value="'+data.board.boardList[i].USER_NUM+'"></input></div>')
					$(name).append('<div><b>'+data.board.boardList[i].USER_LNM+data.board.boardList[i].USER_FNM+'</b></div>');
					function formatDate(date) {
						  return date.getFullYear() + '년 ' + 
						    (date.getMonth() + 1) + '월 ' + 
						    date.getDate() + '일 ';
						}
					var d1 = new Date(data.board.boardList[i].MOTEL_REPLY_DATE).format("yyyy-MM-dd");
					$(name).append('<div>'+d1+'</div>');
					$(id).append('<div><textarea class="replyContent" rows="1" data-autoresize readonly="readonly">'+data.board.boardList[i].CONTENT+'</textarea></div>');
						if($(".replyContent").val()!=""){
							jQuery.each(jQuery('textarea[data-autoresize]'), function() {
								var offset = this.offsetHeight - this.clientHeight;
								var resizeTextarea = function(el) {
									jQuery(el).css('height', 'auto').css('height',
											el.scrollHeight + offset);
								};
								resizeTextarea(this);
								
							});
						}
						if(myNumber==""){
								$(id).append('<div><input type="button" id="btnDeclaration'+n+'" class="btn btn-primary" style="position:relative; left:93%;" value="신고"></input></div>')
						}else{
							if(myNumber==data.board.boardList[i].USER_NUM){
								$(id).append('<div><input type="button" id="btnDelete'+n+'" class="btn btn-primary" style="position:relative; left:93%;" value="삭제"></input></div>')
							}else{
								$(id).append('<div><input type="button" id="btnDeclaration'+n+'" class="btn btn-primary" style="position:relative; left:93%;" value="신고"></input></div>')
							}
							
						}
					(function(n){
						$("#btnDeclaration"+n).on("click",function(){
							
							
							if($("#tmpUser_num").text()==""){
								
								swal({					
									text:"신고 기능은 로그인 후 이용 가능합니다.",					
									icon:"warning",		
									buttons:[false,"확인"]
								}).then(function(isConfirm){
									location.href='/accounts/loginForm';
								})
							}else{
								$("#modal_title_sin").text("");
							$("#modal_title_sin").text("댓글 신고");
							var replyNum = $("#replyNum"+n).val();
							var user_num = $("#user_num1"+n).val();
							$("#type").val("reply");
							
							var type = $("#type").val();
							
							var dModal = $("#declarationModalBody");
							dModal.html("");
							
							$.ajax({
								url:"getDeclaration",
						         type:"post",
						         data:{"${_csrf.parameterName}":"${_csrf.token}"},
						         dataType:"json",
						         success:function(data){
						      
						            var str = "   <select class='form-control' name='DECLARATION_KEY' id='searchType' style='width: 100%;'>" + 
						            "                     <option value='"+data[0].DECLARATION_KEY+"'>"+data[0].DECLARATION_CONTENT+"</option>" + 
						            "                     <option value='"+data[1].DECLARATION_KEY+"'>"+data[1].DECLARATION_CONTENT+"</option>" + 
						            "                     <option value='"+data[2].DECLARATION_KEY+"'>"+data[2].DECLARATION_CONTENT+"</option>" + 
						            "                     <option value='"+data[3].DECLARATION_KEY+"'>"+data[3].DECLARATION_CONTENT+"</option>" + 
						            "                     <option value='"+data[4].DECLARATION_KEY+"'>"+data[4].DECLARATION_CONTENT+"</option>" + 
						            "                     <option value='"+data[5].DECLARATION_KEY+"'>"+data[5].DECLARATION_CONTENT+"</option>" +
						            "                     <option value='"+data[6].DECLARATION_KEY+"'>"+data[6].DECLARATION_CONTENT+"</option>" +
						            "      </select>"+
						            "<textarea id='hiddenArea' name='content' class='form-control' style='display:none;'></textarea>"+
						            "<input type='hidden' name='duser_num' value='"+user_num+"'>"+
						            "<input type='hidden' name='reply_num' value='"+replyNum+"'>";
						            
						            dModal.html(str);
						            var textStr = "";
						            $("#myModal1").modal("show");
									$("#searchType").on("change",function(){
										if($("#searchType").val()!=7){
											$("#hiddenArea").css("display","none");
										}else{
											$("#hiddenArea").css("display","");
										}
									})
									$("#submitDeclaration").on("click",function(){
										$('.modal-backdrop').css("display","");
// 										alert("123123");
										var params = $("#declarationForm").serialize();
										$.ajax({
											url:"${contextPath}/motel/declaration",
											data:params,
											type : "post",
// 											async:false, 
											dataType : "json",
											error : function() {
												
											},
											success:function(data){
												if(data){
													swal({												
													    text:"신고를 완료했습니다.",
													    icon: "success",
													    button:true,
													}).then(function(isConfirm){
														location.reload()
													})
												}else{
													swal({												
													    text:"이미 신고된 컨텐츠 입니다.",
													    icon: "warning",
													    button:true,
													}).then(function(isConfirm){
														location.reload()
													})
												}
												
												
											}
										});
										return false;
									})
						         }
							})
							
							
							}
							
							
						})
						
						
						$("#btnDelete"+n).on("click",function(){							
							var replyNum = $("#replyNum"+n).val();
							var user_num = $("#user_num1"+n).val();
							swal({					
								
							    text:"댓글을 삭제 하시겠습니까?",
							    icon: "info",
							    button:true,
							   
							}).then(function(isConfirm){
								if(isConfirm){
									$.ajax({
										url:"${contextPath}/motel/deleteReply",
										data:{"${_csrf.parameterName}":"${_csrf.token}", "reply":replyNum, "user_num":user_num},
										type : "post",
										dataType : "json",
										error : function() {
											
										},
										success:function(data){
											swal({					
												text:"댓글을 삭제 했습니다.",					
												icon:"success",		
												buttons:[false,"확인"]
											})
											count = 1;
											$("#con").empty();
											replyList(count);
											
										}
									})
								}
								
							})
							
							
						})
					})(n)
					n++;
				
				
			}
		}
	})
	
	
}
// function getOriginFilename(fileName){
// 	//fileName에서 uuid를 제외한 원래 파일명을 반환
// 	if(fileName == null){
// 		return;
// 	}
// 	var idx = fileName.indexOf("_")+1;
// 	return fileName.substr(idx);
// }

	$(function(){
		
		
		
		$("#price").text(price);
		$("#price_1").text(price);
		$("#price_2").val(price);
		$("#totalPrice").text(totalPrice);
		$("#pay_price").val(totalPrice);
		
		
		
		$("#motel_declaration").on("click",function(){
			if($("#tmpUser_num").text()==""){
				
				swal({					
					text:"신고 기능은 로그인 후 이용 가능합니다.",					
					icon:"warning",		
					buttons:[false,"확인"]
				}).then(function(isConfirm){
					location.href='/accounts/loginForm';
				})
			}else{
				$("#modal_title_sin").text("");
				$("#modal_title_sin").text("게시글 신고");
				var replyNum = $("#replyNum"+n).val();
				var user_num = $("#user_num1"+n).val();
				$("#type").val("motel");
				var type = $("#type").val();
				var dModal = $("#declarationModalBody");
				dModal.html("");
				$.ajax({
					url:"getDeclaration",
			         type:"post",
			         data:{"${_csrf.parameterName}":"${_csrf.token}"},
			         dataType:"json",
			         error:function(){
			         },
			         success:function(data){
			            var str = "   <select class='form-control' name='DECLARATION_KEY' id='searchType' style='width: 100%;'>" + 
			            "                     <option value='"+data[0].DECLARATION_KEY+"'>"+data[0].DECLARATION_CONTENT+"</option>" + 
			            "                     <option value='"+data[1].DECLARATION_KEY+"'>"+data[1].DECLARATION_CONTENT+"</option>" + 
			            "                     <option value='"+data[2].DECLARATION_KEY+"'>"+data[2].DECLARATION_CONTENT+"</option>" + 
			            "                     <option value='"+data[3].DECLARATION_KEY+"'>"+data[3].DECLARATION_CONTENT+"</option>" + 
			            "                     <option value='"+data[4].DECLARATION_KEY+"'>"+data[4].DECLARATION_CONTENT+"</option>" + 
			            "                     <option value='"+data[5].DECLARATION_KEY+"'>"+data[5].DECLARATION_CONTENT+"</option>" +
			            "                     <option value='"+data[6].DECLARATION_KEY+"'>"+data[6].DECLARATION_CONTENT+"</option>" +
			            "      </select>"+
			            "<textarea id='hiddenArea' name='content' class='form-control' style='display:none;'></textarea>"+
			            "<input type='hidden' name='duser_num' value='"+user_num+"'>"+
			            "<input type='hidden' name='reply_num' value='"+replyNum+"'>";
			            
			            dModal.html(str);
			            var textStr = "";
			            $("#myModal1").modal("show");
						$("#searchType").on("change",function(){
							if($("#searchType").val()!=7){
								$("#hiddenArea").css("display","none");
							}else{
								$("#hiddenArea").css("display","");
							}
						})
						$("#submitDeclaration").on("click",function(){
							$('.modal-backdrop').css("display","");						
							var params = $("#declarationForm").serialize();
							$.ajax({
								url:"${contextPath}/motel/declaration",
								data:params,
								type : "post",
								dataType : "json",
								error : function() {
									
								},
								success:function(data){
									if(data){
										swal({												
										    text:"신고를 완료했습니다.",
										    icon: "success",
										    button:true,
										}).then(function(isConfirm){
											location.reload()
										})
									}else{
										swal({												
										    text:"이미 신고된 컨텐츠 입니다.",
										    icon: "warning",
										    button:true,
										}).then(function(isConfirm){
											location.reload()
										})
									}
									
									
									
								}
							});
							return false;
						})
			         }
				})
			}
		})
		
		$("#btnDelete_motel").on("click",function(){
			var user_num = "${USER_NUM}";
			var motel_num = "${MOTEL_NUM}";
			swal({												
			    text:"게시글을 삭제 하시겠습니까?",
			    icon: "info",
			    button:true,
			}).then(function(isConfirm){
				$.ajax({
					url:"${contextPath}/motel/delete_motel",
					data:{"${_csrf.parameterName}":"${_csrf.token}","user_num":user_num,"motel_num":motel_num},
					type:"post",
					dataType:"json",
					error:function(data){
						alert("삭제실패")
					},
					success:function(data){
						swal({												
						    text:"게시글을 삭제했습니다.",
						    icon: "success",
						    button:true,
						}).then(function(isConfirm){
							location.href="${contextPath}/motel/search";
						})
					}
					
				})
			})
		})
		
		
		$('[data-toggle="popover"]').popover();
		//숙박 예약시 로그인 되어있지 않을 경우 로그인 화면으로 전환
		$("#formReservation").on("submit",function(){
			
			if($("#tmpUser_num").text()==""){
				swal({					
					text:"숙소 예약은 로그인 후 이용 가능합니다.",					
					icon:"warning",		
					buttons:[false,"확인"]
				}).then(function(isConfirm){
					location.href='/accounts/loginForm';
				})
			}else{
				return true;
			}
			return false;
		})
		//댓글 등록시 content에 값이 입력되어 있지 않을 경우 submit 막음
		$("#ajaxForm").on("submit",function(e){
			if($("#content").val()==""){
				swal({					
					text:"내용을 입력해 주세요",					
					icon:"warning",		
					buttons:[false,"확인"]
				}).then(function(isConfirm){
					return false;
				})
			}else{
				return true;
			}
			return false;
		})
		
		
		replyList();
		//댓글 더보기 버튼 클릭시 replyList 요청
		$("#btnMore").on("click",function(){
			replyList();
		})
		starRating();
		

	//공유하기 버튼 클릭시 text에 현재 url 저장하기 위한 코드
	var newLocation = window.location.href;
	$("#myLocation").text(window.location.href);
	});
	
	function copyClick(){
		var clipboard = new Clipboard('.clipboard');
		swal({					
			text:"URL을 클립보드에 복사 했습니다.",					
			icon:"success",		
			buttons:[false,"확인"]
		}).then(function(isConfirm){
			location.reload()
		})
		
		
	}
	
	
	
</script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
  <style type="text/css">
  img{
  	
  }
  .modal-backdrop.in{
  	display: none;
  }
  .replyContent{
  	border:0px; 
  	overflow:hidden; 
  	width:100%;
  	resize: none;
  }
  .replyContent:focus {
  outline: none;
}
  .yellow{
  	color:white;
  	font-size:30px;
  }
 
  .carousel-caption.back{
  	
  	/* background-color: #2E2E2E; */
  	/* width: 36px;
	height: 30px;
  	top: 0px;
  	margin-left: 520px;
  	opacity: 0.7; */
	margin: 0,auto;
  }

	.fa.fa-qq.fa-lg{
	font-size: 30px;
	}
	.fas.fa-shower.fa-lg{
	font-size: 30px;
	}
  .fa.fa-bed.fa-lg{
  	font-size: 30px;
  }
  .fa.fa-users.fa-lg{
  	font-size: 30px;
  }
  .modal-dialog.modal-sm.modal-center{
  	width: 20%;
  }
  .fa-exclamation-triangle{
  	color:#FA5858;
  }
  .fa-share-square{
  	outline: none; 
  	border: 0; 
  	background-color: transparent ;
  	
  }
  .fa-exclamation-triangle{
  	outline: none; 
  	border: 0; 
  	background-color: transparent ;
  }
  .fonta{
  	outline: none; 
  	border: 0; 
  	background-color: transparent ;
  	
  }


  </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
<span id="tmpUser_num" style="display: none;">${user_num}</span>









<div class="container" style="margin-left: 550px; width: 800px; top: 40px;">

  <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="false" style="width:700px; height:500px;">
    <!-- Indicators -->

    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
      <li data-target="#myCarousel" data-slide-to="3"></li>
      <li data-target="#myCarousel" data-slide-to="4"></li>  

      <!-- <br>
      <li class="glyphicon glyphicon-share-alt yellow" data-toggle="modal" data-target="#myModal"> -->
      <!-- <label class="glyphicon glyphicon-share-alt yellow" data-toggle="modal" data-target="#myModal" style="display: inline-block;"></label> -->
      <!-- </li> -->
    </ol>
   
<!-- <span class="fa fa-share-square fa-lg" data-toggle="modal" data-target="#myModal" style="display: inline-block;"></span> -->


	
    <!-- Wrapper for slides -->
    <div class="carousel-inner">
     
      <div class="item active" style="width:700px; height:500px;">
        <img id="pic1" src="${contextPath }/motel/image?fileName=${image.MOTEL_PIC_1}" style="width:100%; height:100%;">
        <div class="carousel-caption back">
			<button class="fa fa-share-square fa-lg" data-toggle="modal" data-target="#myModal" style="margin: 0, auto;"></button>
 			
 			<c:set var="test_num1" value="${user_num}"/>
			<c:set var="test_num2" value="${USER_NUM}"/>
			
			<c:choose>
				<c:when test="${test_num1 != test_num2 }">
					<button class="fa fa-exclamation-triangle fa-lg" data-toggle="modal" id="motel_declaration"></button>
				</c:when>
			</c:choose>
		</div>
      </div>

      <div class="item" style="width:700px; height:500px;">
        <img id="pic2" src="${contextPath }/motel/image?fileName=${image.MOTEL_PIC_2}" style="width:100%; height:100%;">
        <div class="carousel-caption back">
			<button class="fa fa-share-square fa-lg" data-toggle="modal" data-target="#myModal" style="margin: 0, auto;"></button>
			<c:choose>
				<c:when test="${test_num1 != test_num2 }">
					<button class="fa fa-exclamation-triangle fa-lg" data-toggle="modal" id="motel_declaration"></button>
				</c:when>
			</c:choose>
		</div>
      </div>
    
      <div class="item" style="width:700px; height:500px;">
        <img id="pic3" src="${contextPath }/motel/image?fileName=${image.MOTEL_PIC_3}" style="width:100%; height:100%;">
        <div class="carousel-caption back">
			<button class="fa fa-share-square fa-lg" data-toggle="modal" data-target="#myModal" style="margin: 0, auto;"></button>
			<c:choose>
				<c:when test="${test_num1 != test_num2 }">
					<button class="fa fa-exclamation-triangle fa-lg" data-toggle="modal" id="motel_declaration"></button>
				</c:when>
			</c:choose>
		</div>
      </div>
      
      <div class="item" style="width:700px; height:500px;">
        <img id="pic4" src="${contextPath }/motel/image?fileName=${image.MOTEL_PIC_4}" style="width:100%; height:100%;">
        <div class="carousel-caption back">
			<button class="fa fa-share-square fa-lg" data-toggle="modal" data-target="#myModal" style="margin: 0, auto;"></button>
			<c:choose>
				<c:when test="${test_num1 != test_num2 }">
					<button class="fa fa-exclamation-triangle fa-lg" data-toggle="modal" id="motel_declaration"></button>
				</c:when>
			</c:choose>
		</div>
      </div>
      
      <div class="item" style="width:700px; height:500px;">
      
        <img id="pic5" src="${contextPath }/motel/image?fileName=${image.MOTEL_PIC_5}" style="width:100%; height:100%;">
        <div class="carousel-caption back">
			<button class="fa fa-share-square fa-lg" data-toggle="modal" data-target="#myModal" style="margin: 0, auto;"></button>
			<c:choose>
				<c:when test="${test_num1 != test_num2 }">
					<button class="fa fa-exclamation-triangle fa-lg" data-toggle="modal" id="motel_declaration"></button>
				</c:when>
			</c:choose>
		</div>
      </div>
      
    </div>


    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <!-- <span class="sr-only">Previous</span> -->
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <!-- <span class="sr-only">Next</span> -->
    </a>
  </div>
  	<!-- 모달 -->
			<div class="modal modal-center fade" id="myModal" role="dialog" >
		   	 <div class="modal-dialog modal-sm modal-center" >
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title">공유하기</h4>
		        </div>
		        <div class="modal-body">
		          <p id="myLocation">123</p>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="clipboard" onclick="copyClick()" data-clipboard-target="#myLocation" id="btnClipboard">복사</button>
		        </div>
		      </div>
		    </div>
		  </div>
		  
		  <!-- 숙박유형, 주소, 인원, 침실, 욕실, 프로필사진  -->
		  <div style="width: 700px;">
		  	<div>
		  		<div style="display: inline-block; height: 100px; width: 70%; margin-top:0px;">
		  			<i><b style="font-size: 20px;">${MOTEL_TITLE}</b></i>
		  		</div>
		  		<div style="border-radius: 50%; margin-top:15px; width: 100px; height: 100px; display: inline-block;  margin-left: 100px;">
		  		
		  		
		  		
		  			
		  			<c:choose>
		  				<c:when test="${test_num1 != test_num2 }">
		  					<a href="#none" data-toggle="popover" data-html="true" data-content='<a href="http://www.naver.com">프로필 보기</a><br>친구 신청<br>대화 하기' data-trigger="focus">		
		  						<c:choose>
		  						<c:when test="${user_pic == 'n'}">
		  							<img src="${contextPath}/img/home_profile_2.jpg" class="img-profile" style="width: 100%; height: 100%; border-radius: 50%;">
		  						</c:when>	
		  						<c:otherwise>
		  							<img src="${contextPath}/image?fileName=${user_pic}" class="img-profile" style="width: 100%; height: 100%; border-radius: 50%;">
		  						</c:otherwise>
		  					</c:choose>
		  					</a>
		  				</c:when>

		  				<c:when test="${test_num1 == test_num2 }">
		  					<a href="${contextPath}/accounts/profile?user=${test_num1}">		
		  					<c:choose>
		  						<c:when test="${user_pic == 'n'}">
		  							<img src="${contextPath}/img/home_profile_2.jpg" class="img-profile" style="width: 100%; height: 100%; border-radius: 50%;">
		  						</c:when>	
		  						<c:otherwise>
		  							<img src="${contextPath}/image?fileName=${user_pic}" class="img-profile" style="width: 100%; height: 100%; border-radius: 50%;">
		  						</c:otherwise>
		  					</c:choose>
		  					</a>
		  				</c:when>
		  			</c:choose>
		  			
		  			
		  			
		  			
		  		</div>
		  		<div>
		  			<p style="margin-left: 620px;"><b>${USER_LNM }${USER_FNM}</b></p>  				
		  		</div>
		  	</div>
		  	
		  
		  	<div style="float: left; padding-right: 15px; padding-top: 30px;" >
		  		<b style="font-size: 30px;">${MOTEL_CATEGORY}</b><br>
		  		<p style="font-size:x-small;">${MOTEL_NATION_EN} ${MOTEL_CITY_EN}</p>
		  	</div>
		  	<div style="float: left; padding-right: 15px; padding-top: 30px;">
		  		<i class="fa fa-users fa-lg"></i>
		  		<b style="font-size: 30px;">인원 ${MOTEL_PEOPLE}명</b>
		  		
		  	</div>
		  	<div style="float: left; padding-right: 15px; padding-top: 30px;">
		  		<i class="fa fa-bed fa-lg"></i>
		  		<b style="font-size: 30px;">침실 ${MOTEL_BATHROOM}개</b>
		  	</div>
		  	<div style=" padding-right: 15px; padding-top: 30px;">
		  		
		  			
		  			<i class="fas fa-shower fa-lg"></i>
		  		<b style="font-size: 30px;">욕실  ${MOTEL_BATHROOM }개</b>
		  	</div>
		  	
		  </div>
		  
		  <!-- 숙소 소개 -->
		  <div style="width: 700px;; margin-top: 40px; clear: both;">
			<div >
				<b style="font-size: 30px;">숙소</b>
			</div>
		  	<div>
		  		<p>${MOTEL_INTRO}</p>
		  	</div>
		  </div>
		  
		  <!-- 후기 -->
		  <div style="width: 700px; height:100px; margin-top: 40px;">
		  	
		  	<div id="1"style="width:100px; height:100px; float:left;">
		  		<div style="display: table; width: 100%; height: 100%;">
		  		<b style="font-size: 30px; display: table-cell; text-align: center; vertical-align: middle;">후기</b>
		  		</div>
		  	</div>
		  	<!-- <b style="font-size: 30px; margin-top: 10px;">후기</b> -->
		  		<%-- <img alt="" src="${contextPath}/img/star.png" style="width: 100px; height: 100px;"> --%>
		  		<div id="2" style="float:left; background-image: url('${contextPath}/img/star.png'); background-size:cover; width:100px; height:100px; display:inline-block;">
		  			<div style="margin-top: 38px; margin-left: 40px;">
		  				<b style="font-size: 20px;">${MOTEL_AVG}</b>
		  			</div>
		  		</div>
		  </div>
		  
		  <!-- 댓글, 평점달기 -->
		  
		  <div>
		  	<form id="ajaxForm" name="ajaxForm" action="write_reply" method="post">
		  	<span class="star-input">
  <span class="input">
    <!-- <input type="radio" name="star-input" id="p0" value="0"><label for="p0">0</label> -->
    <input type="radio" name="star-input" id="p0.5" value="0.5"><label for="p0.5">0.5</label>
    <input type="radio" name="star-input" id="p1" value="1"><label for="p1">1</label>
    <input type="radio" name="star-input" id="p1.5" value="1.5"><label for="p1.5">1.5</label>
    <input type="radio" name="star-input" id="p2" value="2"><label for="p2">2</label>
    <input type="radio" name="star-input" id="p2.5" value="2.5"><label for="p2.5">2.5</label>
    <input type="radio" name="star-input" id="p3" value="3"><label for="p3">3</label>
    <input type="radio" name="star-input" id="p3.5" value="3.5"><label for="p3.5">3.5</label>
    <input type="radio" name="star-input" id="p4" value="4"><label for="p4">4</label>
    <input type="radio" name="star-input" id="p4.5" value="4.5"><label for="p4.5">4.5</label>
    <input type="radio" name="star-input" id="p5" value="5"><label for="p5">5</label>
  </span>
  <output for="star-input"><b>0</b>점</output>
</span>
		  		<div class="form-group" style="width: 700px;">
		  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  		<input type="hidden" name="user_num" value="${user_num}">
		  		<input type="hidden" name="host" value="${USER_NUM}">
		  		<input type="hidden" name="motel_num" value="${MOTEL_NUM }">
		  		<input type="hidden" name="checkIn" value="${checkIn}">
		  		<input type="hidden" name="checkOut" value="${checkOut}">
		  		<input type="hidden" name="tripDate" value="${tripDate}">
		  		<input type="hidden" name="people" value="${people}">
		  		<textarea rows="5" cols="" class="form-control" id="content" placeholder="내용" name="content"></textarea>
    			</div>
    			<div style="margin-left: 650px; margin-top: 0">
    				<button type="submit" id="btnReply" class="btn btn-default">저장</button>
    			</div>
		  	</form>
		  </div>
	  	
	  		  	<!-- 댓글 리스트 불러오기 - ajax -->
	  	<div>
	  	<div id="con" style="width: 100%;">
	  	
	  	<!-- 신고 모달 -->
				<div class="modal fade" id="myModal1" role="dialog">
					<div class="modal-dialog">

						<!-- Modal content-->
						<div class="modal-content">
						
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 id="modal_title_sin" class="modal-title"><b>댓글 신고</b></h4>
							</div>
							<form id="declarationForm">
							<div class="modal-body">								
									<div id="declarationModalBody">
										
									</div>
							</div>
							<div class="modal-footer">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                 			<input type="hidden" name="user_num" value="${user_num}">
					  		<input type="hidden" name="host" value="${USER_NUM}">
					  		<input type="hidden" name="num" value="${MOTEL_NUM }">
					  		<input type="hidden" name="checkIn" value="${checkIn}">
					  		<input type="hidden" name="checkOut" value="${checkOut}">
					  		<input type="hidden" name="tripDate" value="${tripDate}">
					  		<input type="hidden" name="people" value="${people}">
					  		<input type="hidden" id="type" name="type" value="">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">닫기</button>
								<button type="submit" id="submitDeclaration" class="btn btn-default" data-backdrop="false" data-dismiss="modal"
									>신고</button>
							</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			
	  	<div style="margin-left: 300px;">
	  	<button type="button" id="btnMore" class="btn btn-primary">더보기</button>
	  	</div>
  		</div>
  		
  		<!-- 숙소 위치 지도찍기 -->
  		<!-- 스크립트 부분 myCenter 변수 실제 집주소의 좌표 가져와서 적용할것 -->
  		<div style="margin-top: 40px;">
  		<div>
  			<b style="font-size: 40px;">숙소 위치</b>
  		</div>
  		<input type="hidden" name="ad" value="${MOTEL_COUNTRY}${MOTEL_COTY}${MOTEL_ADRESS}">
  		<div id="googleMap" style="width: 700px; height: 500px;"></div>
  		</div>
  		<!-- 예약 요청 -->
  		
  		<!-- 작성자가 상세페이지 진입시 예약 요청 버튼이 아닌 삭제 버튼 노출 -->
  		<c:set var="test_num1" value="${user_num}"/>
			<c:set var="test_num2" value="${USER_NUM}"/>
  		<c:choose>
			<c:when test="${test_num1 != test_num2 }">
				<div style="width: 700px;  height:100px; margin-left: 650px; margin-bottom: 50px; margin-top: 40px;">
  					<button class="btn btn-primary" data-toggle="modal" data-target="#myModal2">예약 요청</button>
  				</div>
			</c:when>
			<c:otherwise>
				<div style="width: 700px;  height:100px; margin-left: 650px; margin-bottom: 50px; margin-top: 40px;">
  					<button class="btn btn-primary" id="btnDelete_motel">삭제</button>
  				</div>
			</c:otherwise>
		</c:choose>
		

  		<!-- 모달 -->
  		<div class="modal modal-center fade" id="myModal2" role="dialog" >
		   	 <div class="modal-dialog modal-sm modal-center" >
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title">예약 하기</h4>
		        </div>
		        <div class="modal-body">
		          	<form id="formReservation" method="post" action="${contextPath}/motel/checkout">
		          		<!-- <input type="hidden" name="item" value="연필" readonly="readonly"> -->
		          		<p><b>Price</b></p>
		          		<p><span id="price"></span>/박</p>
		          		<p><b>날짜</b></p>
		          		<p>${checkIn} ~ ${checkOut}</p>
		          		<p><b>인원</b></p>
		          		<p>${people}명</p>
		          		<p><b>Total Price</b></p>
		          		<p><span id="price_1"></span> X ${tripDate}박	<span id="totalPrice"></span></p>
						<input type="hidden" id="pay_price" name="price" value="totalPrice" readonly="readonly"><br>
						<input type="hidden" name="motel_pic1" value="${image.MOTEL_PIC_1}">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<input type="hidden" name="motel_title" value="${MOTEL_TITLE}">
						<input type="hidden" name="motel_people" value="${people}">
						<input type="hidden" name="motel_checkin" value="${checkIn}">
						<input type="hidden" name="motel_checkout" value="${checkOut}">
						<input type="hidden" id="price_2" name="motel_price" value="">
						<input type="hidden" name="trip_date" value="${tripDate}">
						<input type="hidden" name="motel_num" value="${MOTEL_NUM}">
						<input type="hidden" name="host" value="${USER_NUM}">
						<input type="hidden" name="motel_city_en" value="${MOTEL_CITY_EN}">
						<input type="hidden" name="motel_category" value="${MOTEL_CATEGORY}">
						<input type="hidden" id="ad" name="ad" value="${MOTEL_ADDRESS}">				
						<input style="margin-left: 280px;" id="btnReservation" type="submit" value="예약하기">
		          	</form>
		        </div>
		      </div>
		    </div>
		  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>

</body>
</html>