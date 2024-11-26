<%--<td>${business.tel.substring(0,3)}-${business.tel.substring(3,7)}-${business.tel.substring(7) }</td> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/businessApprovalList.css" type = "text/css">
</head>
<body>
	<c:if test="${listcount > 0 }">	
		<table class="table">
			<caption>기업 승인 목록</caption>
			<thead>
				<tr>
					
					<th>기업명</th>
					<th>사업자번호</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>신청일</th>
					<th>승인상태</th>
					<th></th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="business" items="${totallist}">
					<tr>
						
						<td>${business.business_name }</td>
						<td>${business.business_number }</td>
						<td>${business.email }</td>
						<td>${String(business.tel).substring(0,3)}-${String(business.tel).substring(3,7)}-${String(business.tel).substring(7)}</td>
						<td>${business.register_date.substring(0, 10) }</td>
						<td>
							<c:if test="${business.login_status == 'pending' }">
								<b class="pending">대기중</b>
							</c:if>
							<c:if test="${business.login_status == 'approved' }">
								<a href="../admin/refuse?id=${business.business_id}" type="button" class="approved"><b>승인됨</b></a>
							</c:if>
							<c:if test="${business.login_status == 'refused' }">
								<a href="../admin/approve?id=${business.business_id}" type="button" class="refused"><b>거절됨</b></a>
							</c:if>
						</td>
						<c:choose>
    							<c:when test="${business.login_status == 'pending'}">
        							<td>
        								<a href="../admin/approve?id=${business.business_id}" type="button" class="approve">승인</a>
        								<a href="../admin/refuse?id=${business.business_id}" type="button" class="refuse">거절</a>
        							</td>
   		 						</c:when>
    							<c:otherwise>
       	 							<td></td>
    							</c:otherwise>
						</c:choose>
						
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<%--페이징 --%>
		<div class = "center-block">
			<ul class = "pagination justify-content-center">
				<li class = "page-item">
					<a href="javascript:go_approve(${page - 1})"
						class = "page-link ${page <= 1 ? 'gray' : '' }">
						&lt;&lt;
					</a>
				</li>
				<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
					<li class = "page-item ${a == page ? 'active' : '' }">
						<a href="javascript:go_approve(${a})"
							class = "page-link">${a}</a>
					</li>
				</c:forEach>
				<li class = "page-item">
					<a href="javascript:go_approve(${page + 1})"
						class = "page-link ${page >= maxpage ? 'gray' : '' }">
						&gt;&gt;
					</a>
				</li>
			</ul>
		</div>
		<%--페이징 끝 --%>
	</c:if>
	
	<c:if test="${listcount == 0 }">
		<h3 style="text-align:center">등록된 회원이 없습니다.</h3>
	</c:if>
		
</body>
</html>