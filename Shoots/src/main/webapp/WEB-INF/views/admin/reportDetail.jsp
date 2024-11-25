<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>신고 내역 보기</title>
	<script src="${pageContext.request.contextPath}/js/adminJS/AdminMypage.js"></script>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeDetail.css" type = "text/css">
</head>
<body>
	<div class="container">
		<table class="table">
			<caption><c:out value="${rb.title}" /></caption>
			<tr>
				<td><div>신고자</div></td>
				<td><div>${rb.reporter_name}</div></td>
			</tr>
			<tr>
				<td><div>target</div></td>
				<td><div>${rb.target_name}</div></td>
			</tr>
			
			<tr>
				<td style="padding-right: 0px;" colspan="2">
					<textarea rows="5" readOnly style="width:100%">${rb.content}</textarea></td>
			</tr>
			
			<tr>
				<td><div>첨부파일</div></td>
					
				<%--파일을 첨부한 경우 --%>
				<c:if test="${!empty rb.report_file}">
					<td><img src="${pageContext.request.contextPath}/img/down.png" width="10px" id="downImg">
						<a href="down?filename=${rb.report_file}">${rb.report_file}</a></td>
				</c:if>
				
				<%--파일을 첨부하지 않은 경우 --%>
				<c:if test="${empty rb.report_file}">
					<td></td>
				</c:if>
			</tr>
			<tr>
				
				<td colspan="2" class="btnD">
                    <input type = "button" class = "backBtn" onClick="history.go(-1)" value = "목록">  
                </td>
			</tr>
		</table>
	</div>
</body>
</html>