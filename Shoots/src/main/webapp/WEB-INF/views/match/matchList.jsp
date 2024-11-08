<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/matchList.css" type = "text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
	<jsp:include page="../user/top.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/js/matchJS/matchList.js"></script>
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
		<div class = "filterD">
			<form id="filterForm" method="post">
				<label for="year"></label>
				<select name="year" id="year">
				
					<%
					    Calendar cal = Calendar.getInstance();
					    int currentYear = cal.get(Calendar.YEAR);
					    pageContext.setAttribute("currentYear", currentYear);
					%>
					
					<c:set var="startYear" value="${currentYear - 2}" />
					<c:set var="endYear" value="${currentYear + 1}" />
	            	
					<c:forEach var="y" begin="${startYear}" end="${endYear}">
	                	<option value="${y}" ${y == selectedYear ? 'selected' : ''}>${y}</option>
	           		</c:forEach>
				</select>
		
				<label for="month"></label>
				<select name="month" id="month">
					<c:forEach var="m" begin="1" end="12">
						<option value="${m}" ${m == selectedMonth ? 'selected' : ''}>${m}</option>
					</c:forEach>
				</select>
				<input type="button" class = "filterButton" id = "filterButton" onclick = "applyFilter()" value="SERACH" >
			</form>
			
			<input class="form-control" id="searchTable" type="text" placeholder="날짜, 시간, 장소 검색">
		</div>
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
				<tbody id = "searchResults">
					<c:set var="previousDate" value="" />
               		<c:set var="rowspanCount" value="1" />
					<c:forEach var = "match" items= "${list}">
               		<c:set var="matchDate" value="${match.match_date.substring(0, 10)}" />
               		<c:if test="${matchDate == previousDate}">
               			<c:set var="rowspanCount" value="${rowspanCount + 1}" />
               			<tr>
							<td class = "empty-td"></td>
							<td> ${match.match_time} </td>
							<td> <a href = "detail?match_id=${match.match_id}" class = "locatinA"> ${match.business_name} </a> </td>
							<td> ${match.player_max} </td>
							<td> <input type = "button" class = "status" data-match-id="${match.match_id}" value = "신청가능"></td>
						</tr>
               		</c:if>
               		<c:if test="${matchDate != previousDate}">
               			<tr>
							<td rowspan = "${rowspanCount}"> ${match.match_date.substring(0,10).replace('-','/')} </td>
							<td> ${match.match_time} </td>
							<td> <a href = "detail?match_id=${match.match_id}" class = "locatinA"> ${match.business_name} </a> </td>
							<td> ${match.player_max} </td>
							<td> <input type = "button" class = "status" data-match-id="${match.match_id}" value = "신청가능"></td>
						</tr>
               		</c:if>
               		<c:set var="rowspanCount" value="1" />
               		<c:set var="previousDate" value="${matchDate}" />
					</c:forEach>
				</tbody>
			</table>		
		</c:if>
		
		<c:if test = "${listcount == 0}">
			<h3 style = "text-align : center"> 등록된 매칭이 없습니다. </h3>
		</c:if>
		
		<div class = "center-block">
			<ul class = "pagination justify-content-center">
				<li class = "page-item">
					<a href="javascript:go(${page - 1})"
						class = "page-link ${page <= 1 ? 'gray' : '' }">
						&lt;&lt;
					</a>
				</li>
				<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
					<li class = "page-item ${a == page ? 'active' : '' }">
						<a href="javascript:go(${a})"
							class = "page-link">${a}</a>
					</li>
				</c:forEach>
				<li class = "page-item">
					<a href="javascript:go(${page + 1})"
						class = "page-link" ${page >= maxpage ? 'gray' : '' }">
						&gt;&gt;
					</a>
				</li>
			</ul>
		</div>
		
		<div class = "btnD">
			<input type = "button" class = "uploadBtn" value = "매칭 글 작성">
		</div>
		
	</div>
	<jsp:include page="../user/bottom.jsp"></jsp:include>
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
		
		$(document).ready(function(){
			  $("#searchTable").on("keyup", function() {
			    var value = $(this).val().toLowerCase();
			    $("#searchResults tr").filter(function() {
			      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
			    });
			  });
		});
	</script>
</body>
</html>