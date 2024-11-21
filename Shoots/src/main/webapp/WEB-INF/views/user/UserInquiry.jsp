<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserInquiry.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
</head>
<body>
	<p class = "cP1"> 문의 내역 </p>
	<c:if test = "${empty list}">
		<div class = "Cc">
			<div class = "nm">
				<p> ※ 문의 내역이 없습니다 ※ </p>
			</div>
		</div>
	</c:if>
	<c:if test = "${!empty list}">
		<c:forEach var="inquiry" items="${list}">
			<table class = "table">
				<thead>
					<tr>
						<th> 문의자 유형 </th>
						<th> 문의 제목 </th>	
						<th> 문의자 </th>	
						<th> 문의 날짜 </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td> ${inquiry.inquiry_type} </td>
						<td> ${inquiry.title} </td>
						<td> ${inquiry.writer} </td>
						<td> ${inquiry.register_date} </td>
					</tr>
				</tbody>
			</table>
		</c:forEach>
		
		<div class = "center-block">
		<ul class = "pagination justify-content-center">
			<li class = "page-item">
				<a href="javascript:igo(${page - 1})"
					class = "page-link ${page <= 1 ? 'gray' : '' }">
					&lt;&lt;
				</a>
			</li>
			<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
				<li class = "page-item ${a == page ? 'active' : '' }">
					<a href="javascript:igo(${a})"
						class = "page-link">${a}</a>
				</li>
			</c:forEach>
			<li class = "page-item">
				<a href="javascript:igo(${page + 1})"
					class = "page-link" ${page >= maxpage ? 'gray' : '' }">
					&gt;&gt;
				</a>
			</li>
		</ul>
	</div>
	</c:if>
</body>
</html>