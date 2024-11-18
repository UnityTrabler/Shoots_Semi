<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/BusinessMypage.css" type = "text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
	<script src="${pageContext.request.contextPath}/js/businessJS/BusinessMypage.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
<body>
	<div class = "container0">
	
		<div class = "container0-1">
			<p class = "cP0-1"><a class = "cA0" id="tab-info" onclick="loadBusinessInfo()" > 우리구장 </a></p>
			<div class="sub-tabs">
				<p class = "cP0-t"><a class = "cA0" onclick="toggleTab('stats-tab', this)"> 매칭관리 </a></p>
					<div id = "stats-tab" class = "tab-content" style = "display:none;">
						<p class = "cP0-t1"><a class = "cA0" onclick="loadBusinessStatistics()"> 통계 </a></p>
						<p class = "cP0-t2"><a class = "cA0" onclick="loadBusinessSales()"> 매출 </a></p>
						<p class = "cP0-t3"><a class = "cA0" onclick="loadBusinessMyposts()"> 매칭 글 조회 </a></p>
					</div>
			</div>
			<p class = "cP0-2"><a class = "cA0" onclick="loadBusinessCustomer()"> 고객관리 </a></p>
		</div>
		
		<div class = "container" id = "content-container">
		</div>
	</div>
</body>
</html>