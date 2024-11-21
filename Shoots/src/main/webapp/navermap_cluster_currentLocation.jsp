<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script type="text/javascript" src="js/navemapJSCSS/examples-base.js"></script>
    <script type="text/javascript" src="js/navemapJSCSS/highlight.min.js"></script>
    <!-- ncpClientId는 등록 환경에 따라 일반(ncpClientId), 공공(govClientId), 금융(finClientId)으로 나뉩니다. 사용하는 환경에 따라 키 이름을 변경하여 사용하세요. 참고: clientId(네이버 개발자 센터)는 지원 종료 -->
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=83bfuniegk"></script>
    <link rel="stylesheet" type="text/css" href="js/navemapJSCSS/examples-base.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script>
        var HOME_PATH = 'js/navemapJSCSS';
    </script>
</head>
<body>

<!-- @category Overlay/Marker -->
<div id="wrap" class="section">
    <div id="map" style="width:100%;height:600px;"></div>
</div>

<script type="text/javascript">
var HOME_PATH = window.HOME_PATH || '.';
</script>
<script id="code">
var map = new naver.maps.Map("map", {
        zoom: 6,
        center: new naver.maps.LatLng(36.2253017, 127.6460516),
        zoomControl: true,
        zoomControlOptions: {
            position: naver.maps.Position.RIGHT_BOTTOM,
            style: naver.maps.ZoomControlStyle.SMALL
        }
    }),
    markers = [];
	
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
	
var htmlMarker1 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/cluster-marker-1.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
    },
    htmlMarker2 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/cluster-marker-2.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
    },
    htmlMarker3 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/cluster-marker-3.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
    },
    htmlMarker4 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/cluster-marker-4.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
    },
    htmlMarker5 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url('+ HOME_PATH +'/img/cluster-marker-5.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
    };

function onLoad() {
    var data = accidentDeath.searchResult.accidentDeath;

    for (var i = 0, ii = data.length; i < ii; i++) {
        var spot = data[i],
            latlng = new naver.maps.LatLng(spot.grd_la, spot.grd_lo),
            marker = new naver.maps.Marker({
                position: latlng,
                draggable: true
            });

        markers.push(marker);
    }

    var markerClustering = new MarkerClustering({
        minClusterSize: 2,
        maxZoom: 8,
        map: map,
        markers: markers,
        disableClickZoom: false,
        gridSize: 120,
        icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
        indexGenerator: [10, 100, 200, 500, 1000],
        stylingFunction: function(clusterMarker, count) {
            $(clusterMarker.getElement()).find('div:first-child').text(count);
        }
    });
}
</script>

<script type="text/javascript">
    var loaded = 0;
    var list = [
        '/data/accidentdeath.js',
        '/js/MarkerClustering.js'
    ];

    $(list).each(function(i, itm) {
        $.getScript(HOME_PATH + itm, function() {
            loaded++;
            if (loaded == 2) {
                onLoad();
            }
        });
    })
</script>
 <script type="text/javascript" src="js/navemapJSCSS/accidentdeath.js"></script> 
<script type="text/javascript" src="js/navemapJSCSS/MarkerClustering.js" onload="onLoad()"></script> 
</body>
</html>
