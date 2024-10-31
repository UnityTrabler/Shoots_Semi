<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
</head>
<body>
	<div> 
		<form action = "add" method = "post" name = "matchForm">
			<h1> MATCH UPLOAD </h1>
			<input type = "hidden" id = "writer" name = "writer" value = "5">
			<div> 날짜 </div>
			<input type = "date" id = "match_date" name = "match_date" required>
			<div> 시간 </div>
			<input type = "time" id = "match_time" name = "match_time"required>
			<div> 최소 인원 </div>
			<input type = "number" id = "player_min" name = "player_min"required>
			<div> 최대 인원 </div>
			<input type = "number" id = "player_max" name = "player_max"required>
			<div> 가격 </div>
			<input type = "number" id = "price" name = "price">
			<div> 플레이어 성별 </div>
			<input type = "radio" id = "player_gender" name = "player_gender" value = "a" checked> 모든 성별
			<input type = "radio" id = "player_gender" name = "player_gender" value = "m"> 남자
			<input type = "radio" id = "player_gender" name = "player_gender" value = "f"> 여자
			<div>
				<input type = "submit" value = "UPLOAD" class = "btn btn-danger">
				<input type = "reset" value = "RESET">
				<input type = "button" value = "BACK">
			</div>
		</form>
	</div>
</body>
</html>