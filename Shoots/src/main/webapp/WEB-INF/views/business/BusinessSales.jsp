<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/BusinessSales.css" type="text/css">	
	
</head>
<body>
	<div class = "topPB">
		<p class = "cP1"> 매출 </p>
		<div class = "excelD">
			<form id="excelForm" action="downloadExcel" method="post">
				<input type = "hidden" id = "idx" name =  "idx" value = "${idx}">
				<input type="hidden" name="year" id="selectedYear" value="${selectedYear}">
		        <input type="hidden" name="month" id="selectedMonth" value="${selectedMonth}">
		        <button type="submit" class="excelB">
		            <img src="${pageContext.request.contextPath}/img/excel.png" class="excel">
	        </button>
   		</form>
		</div>
	</div>
	<input type = "hidden" id = "idx" name =  "idx" value = "${idx}">
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
			<input type = "hidden" class = "d" value = "d">
			<input type = "button" class = "c" value = "SEARCH" onclick = "sapplyFilter()" >
		</form>
		
		<c:if test = '${listcount > 0 }'>
			<div class="table-wrapper">
				<table class = "table text-center tablehd" id = "stable">
					<thead>
						<tr>
							<th> 날짜 </th>
							<th> 시간 </th>
							<th> 가격 </th>
							<th> 참가인원수 </th>
							<th> 매출 </th>
						</tr>
					</thead>
				</table>
				<table class = "table text-center tabletd" id = "stable">
					<tbody>
						<c:set var="previousDate" value="" />
	               		<c:set var="rowspanCount" value="1" />
	               		
	               		<c:set var="dailyTotal" value="0" />
	               		<c:set var="totalPlayerCount" value="0" />
						<c:set var="totalSales" value="0" />
						
						<c:forEach var = "match" items= "${list}">
		               		<c:set var="matchDate" value="${match.match_date.substring(0, 10)}" />
		               		<c:set var="totalPlayerCount" value="${totalPlayerCount + match.playerCount}" />
							<c:set var="totalSales" value="${totalSales + (match.price * match.playerCount)}" />
		               		<c:if test="${matchDate == previousDate}">
		               			<c:set var="rowspanCount" value="${rowspanCount + 1}" />
		               			<c:set var="dailyTotal" value="${dailyTotal + (match.price * match.playerCount)}" />
		               			<tr>
									<td class = "empty-td"></td>
									<td> ${match.match_time} </td>
									<td> ${match.price} </td>
									<td> ${match.playerCount} </td>
									<td> ${match.total} </td>
								</tr>
		               		</c:if>
		               		<c:if test="${matchDate != previousDate}">
			               		<c:if test="${previousDate != ''}">
									<tr>
										<td colspan="3"></td>
										<td style="font-weight: bold;"> 날짜 별 총 매출 </td>
										<td> ${dailyTotal} </td>
									</tr>
								</c:if>
		               			<tr>
									<td rowspan = "${rowspanCount}"> ${match.match_date.substring(0,10).replace('-','/')} </td>
									<td> ${match.match_time} </td>
									<td> ${match.price} </td>
									<td> ${match.playerCount} </td>
									<td> ${match.total} </td>
								</tr>
								<c:set var="dailyTotal" value="${match.price * match.playerCount}" />
							</c:if>
							
		               		<c:set var="rowspanCount" value="1" />
		               		<c:set var="previousDate" value="${matchDate}" />
		               		
						</c:forEach>
						<c:if test="${previousDate != ''}">
							<tr>
								<td colspan="3"></td>
								<td style="font-weight: bold;"> 날짜 별 총 매출 </td>
								<td> ${dailyTotal} </td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>		
		</c:if>
		
		<c:if test = "${listcount == 0}">
			<p style = "text-align : center"> 등록된 글이 없습니다. </p>
		</c:if>
		<div class = "totalD">
			<strong> 이번달 총 참여인원 &nbsp; ${totalPlayerCount}명 </strong> &nbsp;&nbsp;&nbsp; <strong> 이번달 총 매출 &nbsp; ${totalSales}원 </strong>
		</div>
</body>
</html>