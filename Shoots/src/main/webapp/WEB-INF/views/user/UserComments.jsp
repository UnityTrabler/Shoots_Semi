<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserComments.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
</head>
<body>
	<p class = "cP1"> 내가 쓴 댓글 </p>
	<c:if test = "${empty list}">
		<div class = "Cc">
			<div class = "nm">
				<p> ※ 작성한 댓글이 없습니다 ※ </p>
			</div>
		</div>
	</c:if>
	<c:if test = "${!empty list}">
		<div class = "Cc" id = "comment-list" >
			<c:forEach var="comment" items="${list}" varStatus="status">
				<c:if test="${comment.post_id != prevPostId}">
					<p> <a href="../post/detail?num=${comment.post_id}">
						<img src="${pageContext.request.contextPath}/img/post.png" class="commentI"> 
						<c:choose>
							<c:when test = "${comment.category == 'A'}">
							<span class = "categoryA">[자유]</span>
							</c:when>
							<c:when test = "${comment.category == 'B'}">
							<span class = "categoryB">[중고]</span>
							</c:when>
						</c:choose>
						&nbsp; ${comment.post_title} </a>
					</p>
				</c:if>
				<p> &nbsp;&nbsp;&nbsp;  
					<img src="${pageContext.request.contextPath}/img/comment.png" class="commentI"> 
					<b> ${comment.content} </b> <span class = "cg"> ${comment.register_date} </span>
				</p>
				<c:if test="${status.index == list.size() - 1 || list[status.index + 1].post_id != comment.post_id}">
					<hr>
				</c:if>
				<c:set var="prevPostId" value="${comment.post_id}" />
			</c:forEach>
		</div>
	
		<div class = "center-block">
			<ul class = "pagination justify-content-center">
				<li class = "page-item">
					<a href="javascript:cgo(${page - 1})"
						class = "page-link ${page <= 1 ? 'gray' : '' }">
						&lt;&lt;
					</a>
				</li>
				<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
					<li class = "page-item ${a == page ? 'active' : '' }">
						<a href="javascript:cgo(${a})"
							class = "page-link">${a}</a>
					</li>
				</c:forEach>
				<li class = "page-item">
					<a href="javascript:cgo(${page + 1})"
						class = "page-link" ${page >= maxpage ? 'gray' : '' }">
						&gt;&gt;
					</a>
				</li>
			</ul>
		</div>
	</c:if>
</body>
</html>