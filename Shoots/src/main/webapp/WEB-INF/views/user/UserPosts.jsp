<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserPosts.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
</head>
<body>
	<p class = "cP1"> 내가 쓴 게시글 </p>
	<c:if test = "${empty list}">
		<div class = "nm">
			<p> ※ 작성한 게시글이 없습니다 ※ </p>
		</div>
	</c:if>
	<c:if test = "${!empty list}">
	<div class = "postC">
		<table class = "table">
			<thead>
				<tr>
					<th> 카테고리 </th>
					<th> 제목 </th>
					<th> 작성자 </th>
					<th> 작성일 </th>
					<th> 조회수 </th>
					<th> 수정 </th>
					<th> 삭제 </th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var = "post" items= "${list}">
					<tr>
						<td> <c:choose>
								<c:when test = "${post.category == 'A'}">
									<span class = "a"> [자유] </span>
								</c:when>
								<c:when test = "${post.category == 'B'}">
									<span class = "b"> [중고] </span>
								</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test = "${post.title.length() > 12}">
									<a href = "../post/detail?num=${post.post_id}">${post.title.substring(0,12)} ...</a>
								</c:when>
								<c:when test = "${post.title.length() <= 12}">
									<a href = "../post/detail?num=${post.post_id}">${post.title}</a>
								</c:when>
							</c:choose>
						</td>
						<td> ${post.user_id} </td>
						<td> ${post.register_date.substring(0, 10)} </td>
						<td> ${post.readcount} </td>
						<td> <input type = "button" value = "수정" class= "updateBtn" onclick = "redirectToUpdatePost(${post.post_id})"> </td>
						<td> <input type = "button" value = "삭제" class= "deleteBtn" onclick = "redirectToDeletePost(${post.post_id})"> </td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
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
	</c:if>
</body>
</html>