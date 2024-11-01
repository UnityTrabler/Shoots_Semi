<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<script src = "https://code.jquery.com/jquery-3.7.1.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/matchDetail.css" type = "text/css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<input type = "hidden" id = "match_id" name = "match_id" value = ${match.match_id}>
	<div class = "imgD">
		<img class = "Mimg" src = "${pageContext.request.contextPath}/img/matchD.jpg">
	</div>
	<div class = "container">
		<div class = "container1">
			<p class = "mP"> 매치포인트 </p>
			<div class = "mpDiv">
				<c:forEach var="i" begin="0" end="${match.player_min - 1}">
					<img class = "picon" src="${pageContext.request.contextPath}/img/player_icon1.png" />
				</c:forEach>
			    <p class = "mpP"> 최소 ${match.player_min}명 &nbsp; 최대 ${match.player_max}명 </p>
				<c:choose>
				<c:when test="${match.player_gender == 'm'}">
					<p class = "mpP"> 남자만 참여할 수 있어요 </p>
				</c:when>
				<c:when test="${match.player_gender == 'f'}">
					<p class = "mpP"> 여자만 참여만 참여할 수 있어요 </p>
				</c:when>
				<c:when test="${match.player_gender == 'a'}">
					<p class = "mpP"> 남녀 모두 참여할 수 있어요 </p>
				</c:when>
				</c:choose>
			</div>
			<hr class = "hr2">
			<p class = "mP"> 구장설명 </p>
			<pre class = "preP"> </pre>
		</div>
		<div class = "container2">
			<p class = "datetime"> ${match.match_date.substring(0,4)}년 ${match.match_date.substring(5,7)}월 ${match.match_date.substring(8,10)}일 ${match.match_time} </p>
		 	<p class = "name"> ${match.business_name} </p>
		 	<p class  = "address"> ${match.address} </p>
		 	<hr class = "hr1">
		 	<p class = "price"> ${match.price}원 <span class = "time">  / 2시간 </span></p>
		 	<div class = "btndiv">
		 		<input type = "button" class = "btn1" value = "신청하기">
		 	</div>
		</div>
	</div>
	<div class = "btnC">
		<input type = "button" class = "listBtn" value = "목록보기">
		<input type = "button" class = "updateBtn" value = "수정하기">
		<input type = "button" class = "deleteBtn" value = "삭제하기">
	</div>
	<script>
		$(function(){
			
			$('.listBtn').click(function(){
				location.href = location.href = "../matchs/list";
			});
			
			$('.updateBtn').click(function(){
				location.href = "update?match_id=${match.match_id}";
			})
			
			$('.deleteBtn').click(function(){
				if (confirm("매칭글을 삭제하시겠습니까?")) {
					$.ajax({
						type: "POST", 
						url: "delete?match_id=${match.match_id}", 
						success: function(response) {
							alert("삭제되었습니다."); 
							location.href = "../matchs/list"; 
						},
						error: function() {
							alert("삭제 실패. 다시 시도해주세요.");
						}
					});
				}
			});
			
		})
	</script>
</body>
</html>