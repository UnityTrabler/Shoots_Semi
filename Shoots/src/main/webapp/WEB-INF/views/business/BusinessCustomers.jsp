<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/BusinessCustomers.css" type="text/css">
</head>
<body>
	<p class = "cP1"> 고객관리 </p>
	<input type = "hidden" name = "idx" values = "${idx}">
	<div class = "custD">
		<span class = "cust">전체 회원</span> <span class = "custt">vip</span>
	</div>
	<div class = "d1">
		<div class = "d2">
			<c:forEach var = "acustomers" items= "${acustomers}">
				<div class = "fileD">
					<c:if test="${empty acustomers.userfile}">
                        <img src="${pageContext.request.contextPath}/img/info.png" class="infoI">
                    </c:if>

                    <c:if test="${not empty acustomers.userfile}">
                        <img src="${pageContext.request.contextPath}/userupload/${acustomers.userfile}" class="infoIs">
                    </c:if>
				</div>
				<div class = "infoD">
					<p> <b> ${acustomers.name} </b> (${acustomers.id} / ${acustomers.RRN}) </p>
					<p> ${acustomers.tel} </p>
					<p> ${acustomers.email} </p>
					<hr>
				</div>
			</c:forEach>
			<c:if test="${empty acustomers}">
				<div class = "ec">
					<p> ※ 조회된 데이터가 없습니다 ※ </p>
				</div>
            </c:if>
		</div>
		<div class = "d3">
			<c:forEach var = "customers" items= "${customers}">
				<div class = "fileD">
					<c:if test="${empty customers.userfile}">
                        <img src="${pageContext.request.contextPath}/img/info.png" class="infoI">
                    </c:if>

                    <c:if test="${not empty customers.userfile}">
                        <img src="${pageContext.request.contextPath}/userupload/${customers.userfile}" class="infoIs">
                    </c:if>
				</div>
				<div class = "infoD">
					<p> <b> ${customers.name} </b> (${customers.id} / ${customers.RRN}) </p>
					<p> ${customers.tel} </p>
					<p> ${customers.email} </p>
					<hr>
				</div>
			</c:forEach>
			<c:if test="${empty customers}">
				<div class = "ec">
					<p> ※ 조회된 데이터가 없습니다 ※ </p>
				</div>
            </c:if>
		</div>
	</div>
</body>
</html>