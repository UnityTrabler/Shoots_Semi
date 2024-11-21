<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/userList.css" type="text/css">
</head>
<body>
	<c:if test="${listcount > 0 }">
		<table class="table">
		<caption></caption>
		<thead>
			<tr>
				<td>작성자</td>
				<td>카테고리</td>
				<td>제목</td>
				<td>등록일</td>
				<td>조회수</td>
				<td>삭제</td>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="post" items="${totallist}">
				<tr>
					<td>${post.writer}</td>
					<td>
						<c:if test="${post.category.equals('A')}">
							자유
						</c:if>
						<c:if test="${post.category.equals('B')}">
							중고
						</c:if>
					</td>
					<td>${post.title }</td>
					<td>${post.register_date }</td>
					<td>${post.readcount }</td>
					<td><a href="../user/mypage"  type="button" class="userDetail">삭제</a></td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
	</c:if>
	
	<%--페이징 --%>
	<div class = "center-block">
				<ul class = "pagination justify-content-center">
					<li class = "page-item">
						<a href="javascript:go_post(${page - 1})"
							class = "page-link ${page <= 1 ? 'gray' : '' }">
							&lt;&lt;
						</a>
					</li>
					<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
						<li class = "page-item ${a == page ? 'active' : '' }">
							<a href="javascript:go_post(${a})"
								class = "page-link">${a}</a>
						</li>
					</c:forEach>
					<li class = "page-item">
						<a href="javascript:go_post(${page + 1})"
							class = "page-link ${page >= maxpage ? 'gray' : '' }">
							&gt;&gt;
						</a>
					</li>
				</ul>
			</div>
		<%--페이징 끝 --%>	

</body>
</html>