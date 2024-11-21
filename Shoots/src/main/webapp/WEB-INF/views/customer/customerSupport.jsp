<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../user/top.jsp"></jsp:include>
<title>고객센터</title>
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/customerSupport.css" type = "text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
<body>
	<div class="container" id ="content-container">
		<div class="tab">
			<button class="tablink" onclick="loadfaq('tab1', this)" >FAQ</button>
			<button class="tablink" onclick="loadnotice('tab2', this)" id="defaultOpen">공지사항</button>
			<button class="tablink" onclick="loadinquiry('tab3', this)">1:1 문의</button>
		</div>
		
		<div id="tab1" class="tabcontent">
 			 
		</div>

		<div id="tab2" class="tabcontent">
 			
		</div>

		<div id="tab3" class="tabcontent">
 			
		</div>
	</div>
<script src="${pageContext.request.contextPath}/js/customerJS/CustomerSupport.js"></script>
</body>
</html>