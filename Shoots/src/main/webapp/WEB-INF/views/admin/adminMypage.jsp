<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자페이지</title>
<jsp:include page="../user/top.jsp"></jsp:include>
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/adminMypage.css" type = "text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/adminJS/AdminMypage.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
	<div class = "container0">
	
		<div class = "container0-1">
			<p class = "cP0-1"><a type="button" class = "cA0" id= "tab-info" onclick="loaduser()"> 회원목록 </a></p>
			<p class = "cP0-2"><a type="button" class = "cA0" id= "tab" onclick="loadbusiness()"> 기업목록 </a></p>
			<p class = "cP0-3"><a type="button" class = "cA0" id= "tab" onclick="loadbusinessApproval()"> 기업로그인 승인 </a></p>
			<p class = "cP0-4"><a type="button" class = "cA0" id= "tab" onclick="loadfaq()"> FAQ관리 </a></p>
			<p class = "cP0-5"><a type="button" class = "cA0" id= "tab" onclick="loadnotice()"> 공지사항 관리 </a></p>
			<p class = "cP0-6"><a type="button" class = "cA0" id= "tab" onclick="loadinquiry()"> 1:1 문의글 관리 </a></p>
			<p class = "cP0-7"><a type="button" class = "cA0" id= "tab" onclick="loadpost()"> 게시판 관리 </a></p>
		</div>
		
		<div class = "container" id = "content-container"></div>
	</div>
</body>
</html>