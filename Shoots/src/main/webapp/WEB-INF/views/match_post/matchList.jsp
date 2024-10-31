<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<script src = "https://code.jquery.com/jquery-3.7.1.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1> MATCH LIST </h1>
	
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
						<td> ${match.business_name} </td>
						<td> ${match.player_max} </td>
						<td> 신청가능 </td>
					</tr>
					</c:forEach>
				</tbody>
			</table>		
		</c:if>
		
		<c:if test = "${listcount == 0}">
			<h3 style = "text-align : center"> 등록된 글이 없습니다. </h3>
		</c:if>
		
	</div>
	
	
	<button type = "button" class = "btn btn-danger"> 매칭 글 작성 </button>
	
	<script>
	$(function(){
		$('button').click(function(){
			location.href = "write";
		})
	})
	</script>
</body>
</html>