<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ndnfkf222o&submodules=geocoder"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script>
    	$(function() {
    		// 네이버 지도 API를 이용한 지도 생성
            var map = new naver.maps.Map('map', {
                zoom: 10,
                center: new naver.maps.LatLng(37.5665, 126.9780),  // 기본적으로 서울시청을 중심으로 설정
                zoomControl: true,
                zoomControlOptions: {
                    position: naver.maps.Position.RIGHT_BOTTOM	,
                    style: naver.maps.ZoomControlStyle.SMALL
                }
            });
    		
            naver.maps.Event.addListener(map, 'init', function() { //초기화 후 사용해야함!! ready 같은것
    		
	    		 //-------------------------------------------------------------------
	    		 
	   		    var locationBtnHtml = '<img id="currentLocationBtn" name="currentLocationBtn" class="btn btn-success" src="${pageContext.request.contextPath}/img/currentLocation.png" style="width: 50px; height: 50px; margin-right: 10px; object-fit: contain;">';
	  		     var customControl = new naver.maps.CustomControl(locationBtnHtml, {
	  		         position: naver.maps.Position.RIGHT_BOTTOM
	  		     });
	  		     customControl.setMap(map);
			     naver.maps.Event.addDOMListener(customControl.getElement(), 'click', function() {
	   		         map.setCenter(new naver.maps.LatLng(37.3595953, 127.1053971));
	   		     });
		     	//------------------------------------------------------------------
	    		
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
	   		   
				});//btn click
            }); //init
		});//ready 
        
    </script>
</head>
<body class="container">
	<div id="map" style="width : 100%; height: 540px; margin-top: 60px"></div>
	
	</body>
</html>