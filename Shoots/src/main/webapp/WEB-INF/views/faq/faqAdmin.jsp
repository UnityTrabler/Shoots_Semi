<%--
	0. FAQ 관리자 모드는 관리자로 로그인 했을 때 마이페이지를 통해 들어올 수 있습니다
	경로 지정은 마이페이지가 있는 jsp에서 해주세요
	경로명 :  ${pageContext.request.contextPath}/faq/faqAdmin
	1. faq 테이블에 저장되어 있는 faq 내용을 모두 가져옵니다.
	2. 해당 페이지에서 수정, 삭제, 추가 관리를 할 수 있습니다.
	3. faqAdmin.css를 가져왔습니다.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>	
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/faqAdmin.css" type = "text/css">
	
	<title>FAQ 관리(관리자모드)</title>
</head>

<body>
	<c:if test="${listcount > 0 }">
		<table class="table">
			<caption>FAQ 관리</caption>
			<thead>
				<tr>
					<th>제목</th>
					<th>등록일</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="f" items="${totallist}">
					<tr>
						<td>
							<a href="../faq/detail?id=${f.faq_id}" class="faqDetail">
							<c:if test="${f.title.length()>=20 }">
									<c:out value="${f.title.substring(0,20 )}..." />
								</c:if> 
										
								<c:if test="${f.title.length()<20 }">
									<c:out value="${f.title}" />
								</c:if>
							</a>
						</td>
						<td>${f.register_date}</td>
						<td><a href="../faq/update?id=${f.faq_id}" type="button" class="faqUpdate">수정</a></td>
						<td><a href="../faq/delete?id=${f.faq_id}"  type="button" class="faqDelete">삭제</a></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5" style="text-align:center;">
						<a href="../faq/write" type="button" class="btnWrite">글 쓰 기</a>
					</td>
				</tr>
			</tbody>
		</table>
	</c:if>
	<c:if test="${listcount == 0 }">
		<h3 style="text-align:center">등록된 글이 없습니다.</h3>
		<a href="../faq/write" type="button" class="btnWrite">글 쓰 기</a>
	</c:if>
</body>
</html>