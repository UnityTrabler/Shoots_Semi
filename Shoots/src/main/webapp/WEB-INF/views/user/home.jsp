<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
<head>
	<jsp:include page="top.jsp"></jsp:include>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
		rel="stylesheet" integrity="sha384-MpZfP/6MTDQnQmUbyyZgo8reJ1RjqjbyzMy8I/KE6R2ksjBoLdR6E+OguKKE15bA" 
		crossorigin="anonymous">
</head>
<body class="container">
	<div class="d-flex justify-content-center align-items-center">
		<img style="background: green; height: 500px; width:100%; border-radius: 40px;" class="img-fluid img-thumbnail" src="${pageContext.request.contextPath}/img/home_thumbnail.png"><%--thumbnail --%>
	</div>
	<a href="${pageContext.request.contextPath}/matchs/list"><b>matchList</b></a>
</body>
</html>