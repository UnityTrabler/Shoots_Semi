<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script src = "https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<div> 
		<form action = "updateProcess" method = "post" id = "matchUpdateForm">
			<h1> MATCH UPLOAD </h1>
			<input type = "hidden" id = "match_id" name = "match_id" value = "${match.match_id}">
			<div> 날짜 </div>
			<input type = "date" id = "match_date" name = "match_date" value = "${match.match_date.substring(0,10)}" required>
			<div> 시간 </div>
			<input type = "time" id = "match_time" name = "match_time" value = "${match.match_time}" required>
			<div> 최소 인원 </div>
			<input type = "number" id = "player_min" name = "player_min" value = "${match.player_min}" required>
			<div> 최대 인원 </div>
			<input type = "number" id = "player_max" name = "player_max" value = "${match.player_max}" required>
			<div> 가격 </div>
			<input type = "number" id = "price" name = "price" value = "${match.price}" required>
			<div> 플레이어 성별 </div>
			<input type = "radio" id = "player_gender" name = "player_gender" value = "a"> 모든 성별
			<input type = "radio" id = "player_gender" name = "player_gender" value = "m"> 남자
			<input type = "radio" id = "player_gender" name = "player_gender" value = "f"> 여자
			<div>
				<input type = "submit" class = ".update" value = "UPDATE" class = "btn btn-danger">
				<input type = "reset" value = "RESET">
				<input type = "button" class = "back" value = "BACK">
			</div>
		</form>
	</div>
	<script>
		$("input[name='player_gender'][value='${match.player_gender}']").prop('checked', true);
		
		$('.back').click(function(){
			location.href = location.href = "../matchs/detail?match_id=${match.match_id}";
		});
		
		$(function(){
			$('#matchUpdateForm').submit(function(event){
				event.preventDefault();
				if (confirm("매칭글을 수정하시겠습니까?")) {
					$.ajax({
						type: "POST", 
						url: "update?match_id=${match.match_id}", 
						success: function(response) {
							alert("수정되었습니다."); 
							location.href = "../matchs/list"; 
						},
						error: function() {
							alert("수정 실패. 다시 시도해주세요.");
						}
					});
				}
			});
		})
	</script>
</body>
</html>