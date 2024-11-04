<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/matchList.css" type = "text/css">
	<jsp:include page="../user/top.jsp"></jsp:include>
</head>
<body>
	<div class = "imgb">
		<div class = "imgL">
			<img  class = "Limg" src = "${pageContext.request.contextPath}/img/matchL.jpg">
			<div class="overlay">
				<p class = "p1"> 언제, 어디서나 빠르고 간편한 매칭을 원한다면? </p>
				<p class = "imgP2 p1"> SHOOT MATCHING ! </p>
				<p> 지금 가입해서 즐겨보세요 </p>
			</div>
		</div>
	</div>
	<div class = "container">
		<c:if test = '${listcount > 0 }'>
			<table class = "table text-center">
				<thead>
					<tr>
						<th> 날짜 </th>
						<th> 시간 </th>
						<th> 장소 </th>
						<th> 인원 </th>
						<th> 신청현황 </th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var = "match" items= "${list}">
					<tr>
						<td> ${match.match_date.substring(0,10)} </td>
						<td> ${match.match_time} </td>
						<td> <a href = "detail?match_id=${match.match_id}" class = "locatinA"> ${match.business_name} </a> </td>
						<td> ${match.player_max} </td>
						<td> <input type = "button" class = "status" data-match-id="${match.match_id}" value = "신청가능"></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>		
		</c:if>
		
		<c:if test = "${listcount == 0}">
			<h3 style = "text-align : center"> 등록된 글이 없습니다. </h3>
		</c:if>
		
	</div>
	
	<div class = "btnD">
		<input type = "button" class = "uploadBtn" value = "매칭 글 작성">
	</div>
	
	<script>
	$(function(){
		$('.uploadBtn').click(function(){
			location.href = "write";
		});
		
		$('.status').click(function(){
			var matchId = $(this).data('match-id'); 
			location.href = "detail?match_id=" + matchId;
		});
	})
	</script>
</body>
</html>