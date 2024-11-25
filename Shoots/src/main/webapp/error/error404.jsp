<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>parameter print</title>
<style>
	body{background: #e6c6cc}
	
	@keyframes textColorAnimation{
		0%{color:red;}
		20%{color:orange;}
		40%{color:yellow;}
		60%{color:green;}
		80%{color:blue;}
		100%{color:magenta;}
	}
	
	span{
		font-weight: bold;
		font-size: 40px;
		animation-name : textColorAnimation;
		animation-duration : 5s;
		animation-iteration-count : infinite;
		display:block;
		text-align: center;
		margin-top: 100px;
	}
</style>
</head>
<body>
<span>404 error</span>
<strong>요청한 페이지가 없음</strong>
</body>
</html>