<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/BusinessMyposts.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
</head>
<body>
	<p class = "cP1"> 매칭 글 조회 </p>
	
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
			<input type="button" class = "filterButton" id = "filterButton" value="SERACH" >
		</form>
		
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
</body>
</html>