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
			<caption>신고자 관리</caption>
			<thead>
				<tr>
					<th>신고유형</th>
					<th>신고자</th>
					<th>신고대상</th>
					<th>신고이유</th>
					<th>날짜</th>
					<th>현황</th>
					<th></th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="report" items="${totallist}">
					<tr>
						
						<td>
							<c:if test="${report.report_type == 'A' }">
								게시글
							</c:if>
							<c:if test="${report.report_type == 'B' }">
								댓글
							</c:if>
							<c:if test="${report.report_type == 'C' }">
								매칭선수
							</c:if>
						</td>
						<td>${report.reporter_name}</td>
						<td>${report.target_name}</td>
						<td>${report.title} </td>
						<td>${report.register_date.substring(0, 10) }</td>
						<td>
							<input type="button" class="status" value="처리중">
						</td>
						<td><a href="../admin/report?id=${report.report_id}" type="button" class="report">자세히 보기</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<%--페이징 --%>
		<div class = "center-block">
			<ul class = "pagination justify-content-center">
				<li class = "page-item">
					<a href="javascript:go_report(${page - 1})"
						class = "page-link ${page <= 1 ? 'gray' : '' }">
						&lt;&lt;
					</a>
				</li>
				<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
					<li class = "page-item ${a == page ? 'active' : '' }">
						<a href="javascript:go_report(${a})"
							class = "page-link">${a}</a>
					</li>
				</c:forEach>
				<li class = "page-item">
					<a href="javascript:go_report(${page + 1})"
						class = "page-link ${page >= maxpage ? 'gray' : '' }">
						&gt;&gt;
					</a>
				</li>
			</ul>
		</div>
		<%--페이징 끝 --%>
	</c:if>
	
	<c:if test="${listcount == 0 }">
		<div class = "Bd">
			<p style="text-align:center">신고 내역이 없습니다</p>
		</div>
	</c:if>

</body>
</html>