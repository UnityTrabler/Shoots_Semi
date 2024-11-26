<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
	$(function() {
		$('#logout').on('click', function() {
			sessionStorage.removeItem("id");
		});
	});
</script>
<style>
	nav {width: 70%; margin: 30px auto;display: flex;justify-content: space-between;align-items: center;}
	img {width: 45px;}
	.brand {font-size: 30px; font-weight: bold; color: black; text-decoration: none!important; transition: background 0.3s, color 0.3s;}
	.loginA, .joinA {color: black; text-decoration: none!important; margin-right : 10px ;  transition: background 0.3s, color 0.3s;}
	.brand:hover, .loginA:hover, .joinA:hover {color: #059669;}
	.navbar-nav {margin-top : 13px; font-size : 13px}
	#collapsibleNavbar {line-height : 50px}
</style>
<nav class="navbar navbar-expand-sm navbar-dark">
	<div class="topA">
		<img src="${pageContext.request.contextPath}/img/home.png">
	</div>
	<a class="brand" href="${pageContext.request.contextPath}/index.jsp"> SHOOTS </a>
	<div class="collapse navbar-collapse flex-row-reverse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			<c:if test="${!empty sessionScope.id}">
				<c:if test="${userClassification == 'business'}">
					<li class="nav-item"><a class="loginA" href="${pageContext.request.contextPath}/business/mypage"><b>${id}</b><span style = "font-size : 10px">(BUSINESS)</span></a></li>
				</c:if>
				<c:if test="${userClassification == 'regular'}">
					<c:if test="${role == 'admin'}">
						<li class="nav-item"><a class="loginA" href="${pageContext.request.contextPath}/admin/mypage">
						<c:if test = "${!empty file}">
								<img src="${pageContext.request.contextPath}/userupload/${file}" style = "width : 30px; border-radius : 30px"> &nbsp;
							</c:if>
							<c:if test = "${empty file}">
								<img src="${pageContext.request.contextPath}/img/info.png" style = "width : 30px; border-radius : 30px"> &nbsp;
							</c:if>
						<b>${id}</b>님</a></li>
					</c:if>
					
					<c:if test="${role == 'common'}">
						<li class="nav-item"><a class="loginA" href="${pageContext.request.contextPath}/user/mypage"> 
							<c:if test = "${!empty file}">
								<img src="${pageContext.request.contextPath}/userupload/${file}" style = "width : 30px; border-radius : 30px"> &nbsp;
							</c:if>
							<c:if test = "${empty file}">
								<img src="${pageContext.request.contextPath}/img/info.png" style = "width : 30px; border-radius : 30px"> &nbsp;
							</c:if>
						<b>${id}</b>님</a></li>
					</c:if>
				</c:if>
				
				<li class="nav-item"><a class="loginA" href="${pageContext.request.contextPath}/user/logout" id="logout"> 로그아웃 </a></li>
			</c:if>
			<c:if test="${empty sessionScope.id}">
				<a href="${pageContext.request.contextPath}/user/login" class="loginA"><b>LOGIN</b></a> 
				<a href="${pageContext.request.contextPath}/user/signup" class="joinA"><b>SIGN UP</b></a>
			</c:if>
		</ul>
	</div>  
</nav>
<script>
	
</script>
