<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script src = "https://code.jquery.com/jquery-3.7.1.js"></script>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/matchForm.css" type = "text/css">
</head>
<body>
	<div>
		<form action = "add" method = "post" name = "matchForm">
			<div class = "container"> 
				<h3 class = "mu"> MATCH UPLOAD </h3>
				<input type = "hidden" id = "writer" name = "writer" value = "${idx}">
				<div class = "d1">
					<div class = "d2"> 
						<span> 날짜 </span> <input type = "date" id = "match_date" name = "match_date" required>
					</div>
					<div>
						 <span> 시간 </span> 
						 <select name="match_time" id="match_time" required>
                         </select>
					</div>
				</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
 				<hr>
				<div class = "d1">
					<div class = "d2">
						<span> 인원 </span> 
						<input type = "number" class = "playerMm" id = "player_min" name = "player_min" placeholder = "최소" min = "4" max = "20" required>
						<input type = "number" class = "playerMm" id = "player_max" name = "player_max" placeholder = "최대" min = "6" max = "20" required>
					</div>
					<div>
						<span> 가격 </span> <input type = "number" id = "price" name = "price" min = "1000" max="50000" step="1000">
					</div>
				</div>
				<hr>
				<div>
					<div class = "pD"> <span class = "pS"> 플레이어 성별 </span>
						<label>
							<input type = "radio" id = "player_gender" class = "player_gender" name = "player_gender" value = "a" checked required> 모든성별
						</label>
						<label>
							<input type = "radio" id = "player_gender" class = "player_gender" name = "player_gender" value = "m"> 남자
						</label>
						<label>
							<input type = "radio" id = "player_gender" class = "player_gender" name = "player_gender" value = "f"> 여자
						</label>
					</div>
				</div>
				<hr>
				<div class = "d1">
					<span class = "Ds"> 구장 정보 </span>
					<div class = "Dd2">
						<pre><textarea class = "descriptionT" name = "description" id = "description"> ${user.description} </textarea></pre>
					</div>
				</div>
				<div>
					<input type = "submit" value = "UPLOAD" class = "btn btn-danger uploadbBtn">
					<input type = "reset" value = "RESET" class = "resetBtn">
					<input type = "button" value = "BACK" class = "backBtn">
				</div>
			</div>
		</form>
	</div>
	<script>
	
		function populateTimeOptions() {
			var select = document.getElementById('match_time');
			for (var hour = 9; hour < 24; hour++) {
				for (var minute of [0, 30]) {
					var hourFormatted = hour.toString().padStart(2, '0');
					var minuteFormatted = minute.toString().padStart(2, '0');
					var time = hourFormatted + ":" + minuteFormatted;
	
					var option = document.createElement('option');
					option.value = time;
					option.textContent = time;
	
					select.appendChild(option);
	             }
	         }
	     }
	
		window.onload = populateTimeOptions;		 
		
		document.matchForm.onsubmit = function(event) {
		       var playerMin = parseInt(document.getElementById('player_min').value);
		       var playerMax = parseInt(document.getElementById('player_max').value);
	           var price = parseInt(document.getElementById('price').value);

		       if (playerMin > playerMax) {
		           alert('최소 인원은 최대 인원보다 클 수 없습니다.');
		           event.preventDefault();
		           return;
		       }
		       
		       if (price % 1000 !== 0) {
	                alert('가격은 1000원 단위로 입력해야 합니다.');
	                event.preventDefault();
	                return;
	            }
		       
		       if (price > 50000) {
	                alert('가격은 50,000원 이하로 설정해야 합니다.');
	                event.preventDefault();
	                return;
	            }
		   };
		    
		$('.backBtn').click(function(){
			location.href  = "../matchs/list";
		});
		
	</script>
</body>
</html>