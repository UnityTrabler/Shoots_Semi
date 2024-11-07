<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/BusinessMypage.css" type = "text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
	<script src="${pageContext.request.contextPath}/js/businessJS/BusinessMypage.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
<body>
	<div class = "container0">
	
		<div class = "container0-1">
			<p class = "cP0-1"><a class = "cA0" > 우리구장 </a></p>
			<div class="sub-tabs">
				<p class = "cP0-t"><a class = "cA0" onclick="toggleTab('stats-tab', this)"> 매칭관리 </a></p>
					<div id = "stats-tab" class = "tab-content" style = "display:none;">
						<p><a class = "cA0" onclick="loadBusinessStatistics()"> 통계 </a></p>
						<p><a class = "cA0" onclick="loadBusinessSales()"> 매출 </a></p>
						<p><a class = "cA0" onclick="loadBusinessMyposts()"> 매칭 글 조회 </a></p>
					</div>
			</div>
			<p class = "cP0"><a class = "cA0" onclick="loadBusinessCustomer()"> 고객관리 </a></p>
		</div>
		
		<div class = "container" id = "content-container">
			<p class = "cP1"> 구장정보 </p>
			<table class = "table">
				<tr>
					<th> 기업명 </th> <td> ${businessUser.business_name} </td>
				</tr>
				<tr>
					<th> 사업자 번호 </th> <td> ${businessUser.business_number} </td>
				</tr>
				<tr>
					<th> 위치 </th> <td> ${businessUser.address} </td>
				</tr>
				<tr>
					<th> 대표 번호 </th> <td> ${businessUser.req} </td>
				</tr>
				<tr>
					<th> 기업 이메일 </th> <td> ${businessUser.email} </td>
				</tr>
				<tr>
					<th> 주소 </th> <td> (${businessUser.post})  ${businessUser.address} </td>
				</tr>
				<tr>
					<th> 구장정보 </th> <td> ${businessUser.description} </td>
				</tr>
				<tr>
					<th> 파일 </th> <td> ${businessUser.business_file} </td>
				</tr>
				<tr>
					<th> 가입일 </th> <td> ${businessUser.register_date.substring(0,4)}년 ${businessUser.register_date.substring(5,7)}월 ${businessUser.register_date.substring(8,10)}일 </td>
				</tr>
			</table>
			<div class = "container2">
				<input type = "button" class = "updateBtn" value = "구장 정보 수정">
			</div>
		</div>
	</div>
</body>
</html>