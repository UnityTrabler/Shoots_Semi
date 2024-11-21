<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserInquiry.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
</head>
<body>
	<p class = "cP1"> 문의 내역 </p>
	<c:if test = "${empty list}">
		<div class = "Cc">
			<div class = "nm">
				<p> ※ 문의 내역이 없습니다 ※ </p>
			</div>
		</div>
	</c:if>
	<c:if test = "${!empty list}">
		<table class = "table">
			<thead>
				<tr>
					<th> 문의자 유형 </th>
					<th> 문의 제목 </th>	
					<th> 문의자 </th>	
					<th> 문의 날짜 </th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="inquiry" items="${list}">
					<tr>
						<td>
							<c:choose>
								<c:when test = "${inquiry.inquiry_type == 'A'}">
									<span> 개인문의 </span>
								</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test = "${inquiry.title.length() > 10}">
									<a href = "../inquiry/detail?inquiryid=${inquiry.inquiry_id}">${inquiry.title.substring(0,10)} ...</a>
								</c:when>
								<c:when test = "${inquiry.title.length() <= 10}">
									<a href = "../inquiry/detail?inquiryid=${inquiry.inquiry_id}">${inquiry.title}</a>
								</c:when>
							</c:choose>
						</td>
						<td> ${inquiry.user_id} </td>
						<td> ${inquiry.register_date.substring(0, 10)} </td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class = "center-block">
		<ul class = "pagination justify-content-center">
			<li class = "page-item">
				<a href="javascript:igo(${page - 1})"
					class = "page-link ${page <= 1 ? 'gray' : '' }">
					&lt;&lt;
				</a>
			</li>
			<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
				<li class = "page-item ${a == page ? 'active' : '' }">
					<a href="javascript:igo(${a})"
						class = "page-link">${a}</a>
				</li>
			</c:forEach>
			<li class = "page-item">
				<a href="javascript:igo(${page + 1})"
					class = "page-link" ${page >= maxpage ? 'gray' : '' }">
					&gt;&gt;
				</a>
			</li>
		</ul>
	</div>
	</c:if>
</body>
</html>