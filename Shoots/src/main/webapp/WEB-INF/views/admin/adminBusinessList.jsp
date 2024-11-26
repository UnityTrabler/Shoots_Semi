<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/adminBusinessList.css" type = "text/css">
</head>
<body>
	<c:if test="${listcount > 0 }">	
		<table class="table">
			<caption>기업 목록</caption>
			<thead>
				<tr>
					<th>기업번호</th>
					<th>아이디</th>
					<th>기업명</th>
					<th>사업자번호</th>
					<th>이메일</th>
					<th>주소</th>
					<th>가입일</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="business" items="${totallist}">
					<tr>
						<td>${business.business_idx }</td>
						<td>${business.business_id }</td>
						<td>${business.business_name }</td>
						<td>${business.business_number }</td>
						<td>${business.email }</td>
						<td>${business.address} </td>
						<td>${business.register_date.substring(0, 10) }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${listcount == 0 }">
		<h3 style="text-align:center">등록된 회원이 없습니다.</h3>
	</c:if>
	
	<%--페이징 --%>
	<div class = "center-block">
				<ul class = "pagination justify-content-center">
					<li class = "page-item">
						<a href="javascript:go_business(${page - 1})"
							class = "page-link ${page <= 1 ? 'gray' : '' }">
							&lt;&lt;
						</a>
					</li>
					<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
						<li class = "page-item ${a == page ? 'active' : '' }">
							<a href="javascript:go_business(${a})"
								class = "page-link">${a}</a>
						</li>
					</c:forEach>
					<li class = "page-item">
						<a href="javascript:go_business(${page + 1})"
							class = "page-link ${page >= maxpage ? 'gray' : '' }">
							&gt;&gt;
						</a>
					</li>
				</ul>
			</div>
		<%--페이징 끝 --%>	
</body>
</html>