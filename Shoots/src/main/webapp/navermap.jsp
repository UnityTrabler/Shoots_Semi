<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ndnfkf222o"></script>
</head>
<body>
	<div id="map" style="width:100%;height:400px;"></div>

	<script>
		var mapOptions = {
		    center: new naver.maps.LatLng(37.3595704, 127.105399),
		    zoom: 10
		};
		
		var map = new naver.maps.Map('map', mapOptions);
		
		naver.maps.Service.geocode({
	        query: '불정로 6'
	    }, function(status, response) {
	        if (status !== naver.maps.Service.Status.OK) {
	            return alert('Something wrong!');
	        }

	        var result = response.v2, // 검색 결과의 컨테이너
	            items = result.addresses; // 검색 결과의 배열

	        // do Something
	    });
	</script>
</body>
</html>
