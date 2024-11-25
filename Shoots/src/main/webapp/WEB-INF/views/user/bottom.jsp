<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.bottom1 {width : 100%; margin-top : 100px; text-align : center; margin-bottom : 100px}
	a {margin-right : 15px; color : #4A4C4C}
	a:hover {margin-right : 15px; color : #4A4C4C; font-weight : bold}
	.home {font-size : 15px; color : #4A4C4C;}
	.bI {width : 25px}
</style>
<div class = "bottom1">
		<br>
		<img src = "${pageContext.request.contextPath}/img/home.png" class = "bI"><span class = "home">shoots</span> &nbsp;&nbsp;&nbsp; 
		<a href = "${pageContext.request.contextPath}/index.jsp">home</a> 
		<a href = "${pageContext.request.contextPath}/user/map">map</a> 
		<a href = "${pageContext.request.contextPath}/matchs/list">match</a> 
		<a href = "${pageContext.request.contextPath}/post/list">community</a> 
		<a href = "${pageContext.request.contextPath}/customer/support">support</a>
</div>s