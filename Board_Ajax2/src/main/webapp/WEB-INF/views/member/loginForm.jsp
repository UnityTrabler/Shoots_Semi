<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm.jsp</title>
<link rel="icon" href="${pageContext.request.contextPath}/image/orange.svg">
<link href="${pageContext.request.contextPath}/css/login.css" type="text/css" rel=stylesheet>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<style>
	.container{margin:3em auto; box-shadow:3px 3px 30px gray;width:500px;}
</style>
<script>
	$(function() {
		$(".join").click(function(){
			location.href = "${pageContext.request.contextPath}/members/join";
		});
		
		const id = '${cookieId}';
		if(id){
			$("#id").val(id);
			$("#remember").prop('checked', true);
		}
	});
</script>
</head>
<body class="container">
	<form action = "${pageContext.request.contextPath}/members/loginProcess" 
	method="post">
	
		<h1>login</h1>
		<hr>
		<b>id</b>
		<input type="text" name="id" placeholder="Enter id" id="id" required>
		
		<b>password</b>
		<input type="password" name="pass" placeholder="Enter password" required>
		<input type="checkbox" id="remember" name="remember" value="store">
		<span>remember</span>		
		
		<div class="clearfix">
			<button type="submit" class="submitbtn">login</button>
			<button type="button" class="join">sign up</button>
		</div>
	</form>
</body>
</html>