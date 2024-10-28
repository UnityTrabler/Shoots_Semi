<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<link rel="icon" href="${pageContext.request.contextPath}/image/orange.svg">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
</head>
<body class="container">
	<jsp:include page="../board/header.jsp"></jsp:include>
	<table class="table table-striped table-hover text-center table-bordered">
		<thead>
		</thead>
		<tbody>
			<tr>
				<td>id</td>
				<td>${member.id}</td>
			</tr>				
			<tr>
				<td>name</td>
				<td>${member.name}</td>
			</tr>				
			<tr>
				<td>age</td>
				<td>${member.age}</td>
			</tr>				
			<tr>
				<td>gender</td>
				<td>${member.gender}</td>
			</tr>				
			<tr>
				<td>email</td>
				<td>${member.email}</td>
			</tr>
			<tr>
				<td colspan="2"><a href="list">back to list</a></td>
			</tr>				
		</tbody>
	</table>
	<script>
		$(function() {
		});
	</script>
</body>
</html>