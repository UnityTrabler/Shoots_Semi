<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자페이지</title>
<jsp:include page="../user/top.jsp"></jsp:include>
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/BusinessMypage.css" type = "text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/adminJS/AdminMypage.js"></script>

</head>
<body>
	<div class = "container0">
	
		<div class = "container0-1">
			<p class = "cP0-1"><a type="button" class = "cA0" id="tab-info" onclick="loadfaq()" > FAQ관리 </a></p>
			<p class = "cP0-2"><a type="button" class = "cA0" id= "tab" onclick="loadnotice()"> 공지사항 관리 </a></p>
		</div>
		
		<div class = "container" id = "content-container"></div>
	</div>
</body>
</html>