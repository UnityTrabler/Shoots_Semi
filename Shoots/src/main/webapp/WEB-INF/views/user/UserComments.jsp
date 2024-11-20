<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserComments.css" type="text/css">
</head>
<body>
	<p class = "cP1"> 내가 쓴 댓글 </p>
	<c:if test = "${empty list}">
		<div class = "Cc">
			<div class = "nm">
				<p> 작성한 댓글이 없습니다 </p>
			</div>
		</div>
	</c:if>
	<c:if test = "${!empty list}">
		<div class = "Cc">
			<c:forEach var = "comment" items= "${list}">
				<div>
					<p> <img src = "${pageContext.request.contextPath}/img/comment.png" class = "commentI"> <b> ${comment.content} </b>
					<p> <a href = "../post/detail?num=${comment.post_id}"> ${comment.post_title} </a> </p>
					<p> ${comment.register_date} </p>
					<hr>
				</div>
			</c:forEach>
		</div>
	</c:if>
</body>
</html>