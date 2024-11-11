<%--
	0. 공지사항의 자세한 내용을 볼 수 있는 관리자가 아닌 일반 사용자용 페이지 입니다.
	1. 제목, 작성한 관리자 이름, 작성일, 조회수, 내용을 확인 할 수 있습니다.
	2. 목록 버튼을 누르면 noticeList 페이지도 이동합니다.
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항</title>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeDetail.css" type = "text/css">
</head>
<body>
	<div class="container">
		<table class="table">
			<caption>${nb.title}</caption>
			
			<tr>
				<td>작성자 : ${nb.name }</td>
				<td>작성일 : ${nb.register_date }</td>
				<td>조회수 : ${nb.readcount }</td>
				
			</tr>
			
			<tr>
				<th>내용</th>
				<td colspan='2' style="padding-right: 0px">
					<textarea rows="5" readOnly>${nb.content}</textarea></td>
			</tr>
			
			<tr>
				<td><div>첨부파일</div></td>
					
				<%--파일을 첨부한 경우 --%>
				<c:if test="${!empty nb.notice_file}">
					<td colspan='2'><img src="${pageContext.request.contextPath}/img/down.png" width="10px" id="downImg">
						<a href="down?filename=${nb.notice_file}">${nb.notice_file}</a></td>
				</c:if>
				
				<%--파일을 첨부하지 않은 경우 --%>
				<c:if test="${empty nb.notice_file}">
					<td colspan='2'></td>
				</c:if>
			</tr>
			
			<tr>
				<td colspan='3'><a href="../support" type="button" class="listBtn">목록</a></td>
			</tr>
		</table>
		
	</div>
</body>
</html>