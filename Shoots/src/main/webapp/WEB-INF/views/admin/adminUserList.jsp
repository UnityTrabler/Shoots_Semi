<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <td>${user.tel.substring(0,3)}-${user.tel.substring(3,7)}-${user.tel.substring(7) }</td> -->
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/userList.css" type="text/css">
</head>
<body>
	<c:if test="${listcount > 0 }">	
		<table class="table">
			<caption>회원 목록</caption>
			<thead>
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>생년월일</th>
					<th>성별</th>
					<th>전화번호</th>
					<th>email</th>
					<th>가입일</th>
					<th>권한</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="user" items="${totallist}">
					<c:if test="${user.id != id }">
						<tr>
							<td>${user.idx }</td>
							<td>${user.id }</td>
							<td>${user.name }</td>
							<td>${user.RRN }</td>
							<td>
								<c:choose>
    								<c:when test="${user.gender == 1 or user.gender == 3}">
        								<c:out value="남자"/>
   		 							</c:when>
    								<c:otherwise>
       	 								<c:out value="여자"/>
    								</c:otherwise>
								</c:choose>
							</td>
							<td>${String(user.tel).substring(0,3)}-${String(user.tel).substring(3,7)}-${String(user.tel).substring(7)}</td>
							<td>${user.email }</td>
							<td>${user.register_date.substring(0, 10) }</td>
							<td>
								<c:if test="${user.role == 'common'}">
    								<a href="../admin/grant?id=${user.id}" type="button" class="grantadmin">일반</a>
  								</c:if>
  								
  								<c:if test="${user.role == 'admin'}">
    								<a href="../admin/revoke?id=${user.id}" type="button" class="revokeadmin">관리자</a>
  								</c:if>
							</td>
						</tr>
					</c:if>
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
						<a href="javascript:go_user(${page - 1})"
							class = "page-link ${page <= 1 ? 'gray' : '' }">
							&lt;&lt;
						</a>
					</li>
					<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
						<li class = "page-item ${a == page ? 'active' : '' }">
							<a href="javascript:go_user(${a})"
								class = "page-link">${a}</a>
						</li>
					</c:forEach>
					<li class = "page-item">
						<a href="javascript:go_user(${page + 1})"
							class = "page-link ${page >= maxpage ? 'gray' : '' }">
							&gt;&gt;
						</a>
					</li>
				</ul>
			</div>
		<%--페이징 끝 --%>	
	
</body>
</html>