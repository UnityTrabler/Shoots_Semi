<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
    <script>
        $(function() {
			$('#btn1').click(function() {
				var lon = $('#longitude').val(); //경도
	            var lat = $('#latitude').val(); // 위도
	            var offset  = $('#zoom').val();	// 줌
            	$('#mapFrame').attr("src","https://www.openstreetmap.org/export/embed.html?bbox=" + parseFloat(lon-offset) + "," + parseFloat(lat-offset) + "," + parseFloat(lon+offset) + "," + parseFloat(lat+offset) + "&amp;layer=mapnik");
			});
			
	        // 슬라이더 이벤트
		  $('#longitude').on('input', function() {
		        $('#lonValue').text($(this).val());
		    });

		    $('#latitude').on('input', function() {
		        $('#latValue').text($(this).val());
		    });
		    $('#zoom').on('input', function() {
		        $('#zoomValue').text($(this).val());
		    });
		});
    </script>
</head>
<body>
    <h1>OpenStreetMap 위치 조절</h1>
    
    <label for="longitude">경도 (Longitude): </label>
    <input type="range" id="longitude" min="124" max="130" value="126.9784" step="0.0001" onchange="updateMap()">
    <span id="lonValue">126.9784</span><br/>

    <label for="latitude">위도 (Latitude): </label>
    <input type="range" id="latitude" min="35" max="40" value="37.5665" step="0.0001" onchange="updateMap()">
    <span id="latValue">37.5665</span><br/>

    <label for="zoom">확대/축소: </label>
    <input type="range" id="zoom" min="0" max="1" value="0.1" step="0.01" onchange="updateMap()">
    <span id="zoomValue">0.1</span><br/>

	<button id="btn1" style="width : 300px; height : 200px; font-size: 100px" >search</button><br><br>
	
    <iframe id="mapFrame" width="1080" height="720" src="https://www.openstreetmap.org/export/embed.html?bbox=12.9784,36.5665,127.9784,38.5665&amp;layer=mapnik" style="border: 1px solid black"></iframe>
    <br/>
    <small><a href="https://www.openstreetmap.org/#map=10/37.5665/126.9784">큰 지도 보기</a></small>
    <script>

    </script>
</body>
</html>
