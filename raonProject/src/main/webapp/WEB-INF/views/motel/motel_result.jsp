<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <script
   src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc">
</script>
  <script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  <link rel="stylesheet" type="text/css"
   href="${contextPath}/css/star.css">
<script type="text/javascript">

var myCenter = new google.maps.LatLng(-34.397, 150.644);

function initialize() {
   var searchMap = new google.maps.Map(document.getElementById('googleMap'), {
        zoom: 14,
   });
   var geocoder = new google.maps.Geocoder();
   geocodeAddress(geocoder, searchMap);
   function geocodeAddress(geocoder, resultsMap) {
        
        var address = "${MOTEL_COUNTRY} ${MOTEL_CITY} ${MOTEL_ADRESS}";
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
   
   
   
   
   
/*    var mapProp = {
      center : myCenter,
      zoom : 12,
      mapTypeId : google.maps.MapTypeId.ROADMAP
   };

   var map = new google.maps.Map(document.getElementById("googleMap"),
         mapProp);

   var marker = new google.maps.Marker({
      position : myCenter,
   });
   marker.setMap(map); */
}

google.maps.event.addDomListener(window, 'load', initialize);
var count = 1;
var n = 0;
function getOriginFilename(fileName) {
   //fileName에서 uuid를 제외한 원래 파일명을 반환
   if (fileName == null) {
      return;
   }
   var idx = fileName.indexOf("_") + 1;
   return fileName.substr(idx);
}
var starRating = function(){
     var $star = $(".star-input"),
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
   $.ajax({
      url:"${contextPath}/motel/replyList?page=" + count+"&num="+replyNum,
      data:{"${_csrf.parameterName}":"${_csrf.token}"},
      type : "post",
      dataType : "json",
      error : function() {
         alert("실패");
      },
      success:function(data){
         count++;
         for(var i in data.board.boardList){
            /* alert(data.board.boardList[i].TITLE); */
            
            var fileName = getOriginFilename(data.board.boardList[i].FILENAME);
            if(fileName){
               
               $("#con").append('<div class="card" id="card'+n+'"></div>');
               var id = "#card"+n;
               $("#con").append('<hr>');
               $(id).append('<div class="card-body" id="profile'+n+'" style="border-radius:50%; width:50px; height:50px; border:1px solid black; display:inline-block; background-size:cover; background-image:url(\'${contextPath}/motel/image?fileName='
                     + data.board.boardList[i].FILENAME
                     + '\');"></div>');
               $(id).append('<div id="name'+n+'" style="display:inline-block;"></div>');
               var name="#name"+n;
               
               $(name).append('<div>'+data.board.boardList[i].USER_ID+'</div>');
               $(name).append('<div>'+data.board.boardList[i].WRITE_DATE+'</div>');
               $(id).append('<div>아무말대잔치다ㅏㅏㅏ</div>');
               n++;
            }else{
               
               $("#con").append('<div class="card" id="card'+n+'"></div>');
               var id = "#card"+n;
               $("#con").append('<hr>');
               $(id).append('<div class="card-body" id="profile'+n+'" style="border-radius:50%; width:50px; height:50px; border:1px solid black; display:inline-block; background-size:cover; background-image:url(${contextPath}/img/duny.jpg);"></div>');
               $(id).append('<div id="name'+n+'" style="display:inline-block;"></div>');
               var name="#name"+n;
               
               $(name).append('<div><b>'+data.board.boardList[i].USER_FNM+data.board.boardList[i].USER_LNM+'</b></div>');
               function formatDate(date) {
                    return date.getFullYear() + '년 ' + 
                      (date.getMonth() + 1) + '월 ' + 
                      date.getDate() + '일 ';
                  }
               var d1 = new Date(data.board.boardList[i].MOTEL_REPLY_DATE).format("yyyy-MM-dd");
               $(name).append('<div>'+d1+'</div>');
               $(id).append('<div>'+data.board.boardList[i].CONTENT+'</div>');
               n++;
            }
         }
      }
   
   })
}
   $(function(){
      
      
      replyList();
      $("#btnMore").on("click",function(){
         replyList();
      })
      starRating();
   
      /* function copyToClipboard(element) {
         var $temp = $("<input>");
           $("body").append($temp);
           $temp.val($(element).text()).select();
         document.execCommand("copy");
           $temp.remove();
         alert("copy complete"); //Optional Alert, 삭제해도 됨
         } */
   var newLocation = window.location.href;
   /* alert($("#myLocation").text); */
   $("#myLocation").text(window.location.href);
   });
   
</script>
  <style type="text/css">
  img{
     
  }
  .yellow{
     color:white;
     font-size:30px;
  }
 
  .carousel-caption.back{
     
     /* background-color: #2E2E2E; */
     width: 36px;
   height: 30px;
     top: 0px;
     margin-left: 520px;
     opacity: 0.7;

  }

   .fa.fa-qq.fa-lg{
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
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/navbar-main.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/navbar-sub.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/motel/motel-navbar.jsp"></jsp:include>
<div class="container" style="margin-left: 550px; width: 800px; top: 40px;">
  <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="false" style="width:700px; height:500px;">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
      <li data-target="#myCarousel" data-slide-to="3"></li>
      <li data-target="#myCarousel" data-slide-to="4"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
     
      <div class="item active" style="width:700px; height:500px;">
        <img src="${contextPath}/img/house1.jpg" alt="Los Angeles" style="width:100%; height:100%;">
        <div class="carousel-caption back">
         <label class="glyphicon glyphicon-share-alt yellow" data-toggle="modal" data-target="#myModal" style="display: inline-block;"></label>
         <i class="fa fa-heart fa-lg" style="display: inline-block;"></i>
      </div>
   
  
      </div>

      <div class="item" style="width:700px; height:500px;">
        <img src="${contextPath}/img/house2.jpg" alt="Chicago" style="width:100%; height:100%;">
        <div class="carousel-caption back">
         <label class="glyphicon glyphicon-share-alt yellow" data-toggle="modal" data-target="#myModal"></label>
      </div>
      </div>
    
      <div class="item" style="width:700px; height:500px;">
        <img src="${contextPath}/img/house3.jpg" alt="New york" style="width:100%; height:100%;">
        <div class="carousel-caption back">
         <label class="glyphicon glyphicon-share-alt yellow" data-toggle="modal" data-target="#myModal"></label>
      </div>
      </div>
      
      <div class="item" style="width:700px; height:500px;">
        <img src="${contextPath}/img/house4.jpg" alt="New york" style="width:100%; height:100%;">
        <div class="carousel-caption back">
         <label class="glyphicon glyphicon-share-alt yellow" data-toggle="modal" data-target="#myModal"></label>
      </div>
      </div>
      
      <div class="item" style="width:700px; height:500px;">
      
        <img src="${contextPath}/img/house5.jpg" alt="New york" style="width:100%; height:100%;">
        <div class="carousel-caption back">
         <label class="glyphicon glyphicon-share-alt yellow" data-toggle="modal" data-target="#myModal"></label>
      </div>
      </div>
      
    </div>

    <!-- Left and right controls -->
 <!--    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a> -->
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
                <button type="button" id="btnClipboard">복사</button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- 숙박유형, 주소, 인원, 침실, 욕실, 프로필사진  -->
        <div style="width: 700px;">
           <div>
              <div style="display: inline-block; height: 100px; width: 70%;">
              
                 <i><b style="font-size: 40px;">${MOTEL_TITLE}</b></i>
              </div>
              <div style="border-radius: 50%; width: 100px; height: 100px; display: inline-block;  margin-left: 100px; background-image: url('${contextPath}/img/duny.jpg'); background-size:cover;">
                 
              </div>
              <div>
                    <p style="margin-left: 630px;">${USER_FNM} ${USER_LNM }</p>
                 </div>
           </div>
           
        
           <div style="float: left; padding-right: 15px; padding-top: 30px;" >
              <b style="font-size: 30px;">${MOTEL_CATEGORY}</b><br>
              <p style="font-size:x-small;">${MOTEL_COUNTRY} ${MOTEL_CITY}</p>
           </div>
           <div style="float: left; padding-right: 15px; padding-top: 30px;">
              <i class="fa fa-users fa-lg"></i>
              <b style="font-size: 30px;">인원 ${MOTEL_PEOPLE}명</b>
              
           </div>
           <div style="float: left; padding-right: 15px; padding-top: 30px;">
              <i class="fa fa-bed fa-lg"></i>
              <b style="font-size: 30px;">침실 ${MOTEL_BED }개</b>
           </div>
           <div style=" padding-right: 15px; padding-top: 30px;">
              
                 <i class="fa fa-qq fa-lg"></i>
              <b style="font-size: 30px;">욕실  ${MOTEL_BATHROOM }개</b>
           </div>
           
        </div>
        
        <!-- 숙소 소개 -->
        <div style="width: 700px;; margin-top: 40px; clear: both;">
         <div >
            <b style="font-size: 30px;">숙소</b>
         </div>
           <div>
              <p>${MOTEL_INTRODUCE }</p>
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
                    <b style="font-size: 20px;">${MOTEL_AVG }</b>
                 </div>
              </div>
        </div>
        
        <!-- 댓글, 평점달기 -->
        
        <div>
           <form action="write_reply" method="post">
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
              <input type="hidden" name="motel_num" value="${MOTEL_NUM }">
              <textarea rows="5" cols="" class="form-control" id="content" placeholder="내용" name="content"></textarea>
             </div>
             <div style="margin-left: 650px; margin-top: 0">
                <button type="submit" id="btnReply" onclick="write_reply();" class="btn btn-default">저장</button>
             </div>
           </form>
        </div>
        
                <!-- 댓글 리스트 불러오기 - ajax -->
        <div>
        <div id="con" style="width: 100%;">
           
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
        <div style="width: 700px;  height:100px; margin-left: 650px; margin-bottom: 50px; margin-top: 40px;">
           <button class="btn btn-primary" data-toggle="modal" data-target="#myModal2">예약 요청</button>
        </div>
        <!-- 모달 -->
        <div class="modal modal-center fade" id="myModal2" role="dialog" >
             <div class="modal-dialog modal-sm modal-center" >
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">예약 하기</h4>
              </div>
              <div class="modal-body">
                   <form action="${contextPath}/motel/checkout">
                      <input type="hidden" name="item" value="연필" readonly="readonly">
                      <p>226,944/박</p>
                      <p>날짜</p>
                      <p>2019/02/10 ~ 2019/02/20</p>
                      <p>인원</p>
                      <p>성인1명 어린이0명</p>
                      <p>226,944 X 10박   2,269,440</p>
                  <input type="hidden" name="price" value="1" readonly="readonly"><br>
                  <input type="hidden" name="num" value="${num }"> 
                  <input style="margin-left: 280px;" type="submit" value="예약하기">
                   </form>
              </div>
              <div class="modal-footer">
                <button type="button" id="btnClipboard">닫기</button>
              </div>
            </div>
          </div>
        </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</body>
</html>