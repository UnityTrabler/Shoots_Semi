<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/UserMypage.css" type = "text/css">
	<script src="${pageContext.request.contextPath}/js/userJS/UserMypage.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
<body>
	<div class = "container0">
		<div class = "container0-1">
			<p class = "cP0-1"><a class = "cA0" onclick="loadUserInfo()" id="tab-info"> 내 정보 </a></p>
			<p class = "cP0-1"><a class = "cA0" onclick="loadUserMatchs()" id="tab-matchs"> 매칭기록 </a></p>
			<p class = "cP0-1"><a class = "cA0" onclick="loadUserPosts()" id="tab-posts"> 게시글 </a></p>
			<p class = "cP0-1"><a class = "cA0" onclick="loadUserComments()" id="tab-comments"> 작성댓글 </a></p>
			<p class = "cP0-1"><a class = "cA0" onclick="loadUserInquiry()" id="tab-inquiry"> 문의내역 </a></p>
		</div>
		<div class = "container" id = "content-container">
		</div>
	</div>
</body>
<jsp:include page="../user/bottom.jsp"></jsp:include>
</html>