<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Geocoding Service</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
    
        <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK7HNKK_tIyPeV3pVUZKvX3f_arONYrzc&callback=initMap">
    </script>
        <script>
      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 1,
          center: {lat: -34.397, lng: 150.644}
        });
        var searchMap = new google.maps.Map(document.getElementById('searchMap'), {
            zoom: 14,
            center: {lat: -34.397, lng: 150.644}
          });
        
        var geocoder = new google.maps.Geocoder();

        document.getElementById('submit').addEventListener('click', function() {
          geocodeAddress(geocoder, searchMap);
          $("#map").hide();
          $("#searchMap").show();
        });
      }

      function geocodeAddress(geocoder, resultsMap) {
         
        var address = document.getElementById('address').value;
        geocoder.geocode({'address': address}, function(results, status) {
           debugger;
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
    </script>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 500px;
        width: 500px;
        margin-top: 100px;
        
      }
      #searchMap{
         display:none;
         height: 500px;
         width: 500px;
         margin-top: 100px;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
    </style>
  </head>
  <body>
    <div id="floating-panel">
      <input id="address" type="textbox" placeholder="주소를 입력하세요">
      <input id="submit" type="button" value="검색">
    </div>
    <div id="map"></div>
    <div id="searchMap"></div>


  </body>
</html>