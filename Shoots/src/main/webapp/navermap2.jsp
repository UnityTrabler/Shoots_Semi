<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script src="${pageContext.request.contextPath}js/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ndnfkf222o"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script>
    	$(function() {
    		// 네이버 지도 API를 이용한 지도 생성
            var map = new naver.maps.Map('map', {
                zoom: 10,
                center: new naver.maps.LatLng(37.5665, 126.9780)  // 기본적으로 서울시청을 중심으로 설정
            });
    		
    		$('#currentLocationBtn').click(function() {
   		       if (navigator.geolocation) {
   	                navigator.geolocation.getCurrentPosition(function(position) {
   	                    var lat = position.coords.latitude;  // 위도
   	                    var lng = position.coords.longitude; // 경도

   	                    // 사용자 위치로 지도 중심 이동
   	                    var userLocation = new naver.maps.LatLng(lat, lng);
   	                    map.setCenter(userLocation); // 지도의 중심을 현재 위치로 설정

   	                    // 사용자 위치에 마커 추가
   	                    var marker = new naver.maps.Marker({
   	                        position: userLocation,
   	                        map: map,
   	                        title: "현재 위치"
   	                    });

   	                    // 지도를 현재 위치로 확대
   	                    map.setZoom(15);

   	                }, function(error) {
   	                    alert("현재 위치를 가져올 수 없습니다: " + error.message);
   	                });
   	            } 
   	            else 
   	                alert("이 브라우저는 Geolocation을 지원하지 않습니다.");
   		       
   		       //---
   		       
			var locationBtnHtml = '<a href="#" class="btn_mylct"><span class="spr_trff spr_ico_mylct">NAVER 그린팩토리</span></a>';
			var map = new naver.maps.Map('map', {zoom: 13});
   		    naver.maps.Event.once(map, 'init', function() {
   		     //customControl 객체 이용하기
   		     var customControl = new naver.maps.CustomControl(locationBtnHtml, {
   		         position: naver.maps.Position.TOP_LEFT
   		     });

   		     customControl.setMap(map);

   		     naver.maps.Event.addDOMListener(customControl.getElement(), 'click', function() {
   		         map.setCenter(new naver.maps.LatLng(37.3595953, 127.1053971));
   		     });

   		     //Map 객체의 controls 활용하기
   		     var $locationBtn = $(locationBtnHtml),
   		         locationBtnEl = $locationBtn[0];

   		     map.controls[naver.maps.Position.LEFT_CENTER].push(locationBtnEl);

   		     naver.maps.Event.addDOMListener(locationBtnEl, 'click', function() {
   		         map.setCenter(new naver.maps.LatLng(37.3595953, 127.1553971));
   		     });
   		 });
			});
    		
         	// 브라우저의 geolocation API를 사용해 현재 위치 얻기
     
            
		});//ready 
        
    </script>
</head>
<body class="container">
	<div id="map" style="width : 100%; height: 720px"></div>
	<img id="currentLocationBtn" name="currentLocationBtn" class="btn btn-success" src="${pageContext.request.contextPath}/img/currentLocation.png" style="width: 150px; height: 150px; object-fit: contain;">
	</body>
</html>