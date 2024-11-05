<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../user/top.jsp"></jsp:include>
<title>공지사항</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
</head>
<body>
	<div class="container">
		<h1>공지사항</h1>
		<table>
			<thead>
				<tr>
					<th>작성자</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="notice" items="${totallist}">
					<tr>
						<td>${notice.writer}</td>
						<td>
						<a href="detail?id=${notice.notice_id}" class="noticeDetail">${notice.title}</a>
						</td>
						<td>${notice.register_date }</td>
					</tr>
				</c:forEach>
			</tbody>
			
		</table>
		
	</div>
</body>
</html>