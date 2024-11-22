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
		<caption>게시판 관리</caption>
		<thead>
			<tr>
				<th>작성자</th>
				<th>카테고리</th>
				<th>제목</th>
				<th>등록일</th>
				<th>조회수</th>
				<th>삭제</th>
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
					<td><a href="../post/detail?num=${post.post_id}"  type="button" class="postDetail">${post.title }</a></td>
					<td>${post.register_date.substring(0,10) }</td>
					<td>${post.readcount }</td>
					<td><a href="postDelete?id=${post.post_id}"  type="button" class="postDelete">삭제</a></td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
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
	</c:if>
	
	<c:if test="${listcount == 0 }">
		<h3 style="text-align:center">등록된 게시물이 없습니다.</h3>
	</c:if>
	

</body>
</html>