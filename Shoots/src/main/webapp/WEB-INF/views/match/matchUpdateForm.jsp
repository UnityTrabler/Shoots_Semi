<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script src = "https://code.jquery.com/jquery-3.7.1.js"></script>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/matchUpdateForm.css" type = "text/css">
</head>
<body>
	<div> 
		<form action = "updateProcess" method = "post" id = "matchUpdateForm">
			<div class = "container">
				<h3 class = "mu"> MATCH UPDATE </h3>
				<input type = "hidden" id = "match_id" name = "match_id" value = "${match.match_id}">
				<div class = "d1">
					<div class = "d2"> 
						<span> 날짜 </span> <input type = "date" id = "match_date" name = "match_date" value = "${match.match_date.substring(0,10)}" required>
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
						<input type = "number" id = "player_min" class = "playerMm" name = "player_min" value = "${match.player_min}" placeholder = "최소" min = "4" max = "20" required>
						<input type = "number" id = "player_max" class = "playerMm" name = "player_max" value = "${match.player_max}" placeholder = "최대" min = "6" max = "20" required>
					</div>
					<div>
						<span> 가격 </span> <input type = "number" id = "price" name = "price" value = "${match.price}" min = "1000" max="50000" step="1000" required>
					</div>
				</div>
				<hr>
				<div>
					<div class = "pD"> <span class = "pS"> 플레이어 성별 </span>
						<label>
							<input type = "radio" id = "player_gender" class = "player_gender" name = "player_gender" value = "a" required> 모든성별
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
						<pre><textarea class = "descriptionT" name = "description" id = "description"> ${match.description} </textarea></pre>	
					</div>
				</div>
				<div>
					<input type = "submit" class = "uploadbBtn" value = "UPDATE" class = "btn btn-danger">
					<input type = "reset" value = "RESET" class = "resetBtn">
					<input type = "button" class = "backBtn" value = "BACK">
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
	
		window.onload = function() {
			populateTimeOptions();

			var matchTime = "${match.match_time}";
			var select = document.getElementById('match_time');
			for (var option of select.options) {
				if (option.value === matchTime) {
					option.selected = true;
					break;
				}
			}
		};
		
		$("input[name='player_gender'][value='${match.player_gender}']").prop('checked', true);
				
		$('.backBtn').click(function(){
			location.href = location.href = "../matchs/detail?match_id=${match.match_id}";
		});
		
		document.getElementById('matchUpdateForm').onsubmit = function(event) {
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
		       
		       if (confirm("매칭글을 수정하시겠습니까?")) {
		           this.submit();
		       }
		   };
	</script>
</body>
</html>