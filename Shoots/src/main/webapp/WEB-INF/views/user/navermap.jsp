<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script type="text/javascript" src="../js/navemapJSCSS/examples-base.js"></script>
    <script type="text/javascript" src="../js/navemapJSCSS/highlight.min.js"></script>
    <!-- ncpClientId는 등록 환경에 따라 일반(ncpClientId), 공공(govClientId), 금융(finClientId)으로 나뉩니다. 사용하는 환경에 따라 키 이름을 변경하여 사용하세요. 참고: clientId(네이버 개발자 센터)는 지원 종료 -->
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=83bfuniegk&submodules=geocoder"></script>
    <link rel="stylesheet" type="text/css" href="../js/navemapJSCSS/examples-base.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style type="text/css">
		.search { position:absolute;z-index:1000;top:20px; }
		.search #address { width:150px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
		.search #submit { height:30px;line-height:30px;padding:0 10px;font-size:12px;border:solid 1px #555;border-radius:3px;cursor:pointer;box-sizing:content-box; }
		#h1Title{
			top:20px;
		    text-align: center;
		}
	</style>
</head>

<body>
<jsp:include page="../user/top.jsp"></jsp:include>
<h1 id="h1Title">전국 풋살장 위치</h1>
<!-- @category Overlay/Marker -->
<div id="wrap" class="section container">
    <div id="map" style="width:100%;height:600px;">
    	<div class="search" style="">
            <input id="address" type="text" placeholder="검색할 주소" value="불정로 6" />
            <input id="submit" type="button" value="주소 검색" />
        </div>
    </div>
</div>

<script id="code">
var HOME_PATH = '../js/navemapJSCSS';
var HOME_PATH = window.HOME_PATH || '.';
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
    
//search------------------------------------------------------------
var infoWindow = new naver.maps.InfoWindow({
    anchorSkew: true
});

map.setCursor('pointer');

function searchCoordinateToAddress(latlng) {

    infoWindow.close();

    naver.maps.Service.reverseGeocode({
        coords: latlng,
        orders: [
            naver.maps.Service.OrderType.ADDR,
            naver.maps.Service.OrderType.ROAD_ADDR
        ].join(',')
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) 
            return alert('Something Wrong!');

        var items = response.v2.results,
            address = '',
            htmlAddresses = [];

        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
            item = items[i];
            address = makeAddress(item) || '';
            addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';
            htmlAddresses.push((i+1) +'. '+ addrType +' '+ address);
        }

        infoWindow.setContent([
            '<div style="padding:10px;min-width:200px;line-height:150%;">',
            '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
            htmlAddresses.join('<br />'),
            '</div>'
        ].join('\n'));

        infoWindow.open(map, latlng);
    });
}//searchCoordinateToAddress

function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        query: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) 
            return alert('Something Wrong!');

        if (response.v2.meta.totalCount === 0) {
            return alert('totalCount' + response.v2.meta.totalCount);
        }

        var htmlAddresses = [],
            item = response.v2.addresses[0],
            point = new naver.maps.Point(item.x, item.y);
		
		$.ajax({
			url : "https://openapi.naver.com/v1/search/local.xml?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&sort=random",
			beforeSend : function(xhr){
				xhr.setRequestHeader("X-Naver-Client-Id", ""); 
				xhr.setRequestHeader("X-Naver-Client-Secret","");
			},
			type : "POST",
			dataType : "json",
			success : function(data){
				console.log('ajax success');
				console.log(data);
			}, 
			error:function(){
				console.log('ajax error');
			}
		});
        
        if (item.roadAddress) 
            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
        if (item.jibunAddress) 
            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
        if (item.englishAddress) 
            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);

        infoWindow.setContent([
            '<div style="padding:10px;min-width:200px;line-height:150%;">',
            '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',//검색주소 : 불정로 6
            htmlAddresses.join('<br />'), // 도로명 + 지번 + 영문명
            '</div>'
        ].join('\n'));

        map.setCenter(point); //중앙으로
        infoWindow.open(map, point); // message box 맵 포인트에
    });//naver.maps.Service.geocode
}//searchAddressToCoordinate

function initGeocoder() {
    map.addListener('click', function(e) {
    	infoWindow.close();
    });

    $('#address').on('keydown', function(e) {
        var keyCode = e.which;
        if (keyCode === 13)  // Enter Key
            searchAddressToCoordinate($('#address').val());
    });

    $('#submit').on('click', function(e) {
        e.preventDefault();
        searchAddressToCoordinate($('#address').val());
    });

}

function makeAddress(item) {
    if (!item) {
        return;
    }

    var name = item.name,
        region = item.region,
        land = item.land,
        isRoadAddress = name === 'roadaddr';

    var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';

    if (hasArea(region.area1)) {
        sido = region.area1.name;
    }

    if (hasArea(region.area2)) {
        sigugun = region.area2.name;
    }

    if (hasArea(region.area3)) {
        dongmyun = region.area3.name;
    }

    if (hasArea(region.area4)) {
        ri = region.area4.name;
    }

    if (land) {
        if (hasData(land.number1)) {
            if (hasData(land.type) && land.type === '2') {
                rest += '산';
            }

            rest += land.number1;

            if (hasData(land.number2)) {
                rest += ('-' + land.number2);
            }
        }

        if (isRoadAddress === true) {
            if (checkLastString(dongmyun, '면')) {
                ri = land.name;
            } else {
                dongmyun = land.name;
                ri = '';
            }

            if (hasAddition(land.addition0)) {
                rest += ' ' + land.addition0.value;
            }
        }
    }

    return [sido, sigugun, dongmyun, ri, rest].join(' ');
}

function hasArea(area) {
    return !!(area && area.name && area.name !== '');
}

function hasData(data) {
    return !!(data && data !== '');
}

function checkLastString (word, lastString) {
    return new RegExp(lastString + '$').test(word);
}

function hasAddition (addition) {
    return !!(addition && addition.value);
}

naver.maps.onJSContentLoaded = initGeocoder;

</script>
<script type="text/javascript" src="../js/navemapJSCSS/accidentdeath.js"></script> 
<script type="text/javascript" src="../js/navemapJSCSS/MarkerClustering.js" onload="onLoad()"></script> 
</body>
</html>
