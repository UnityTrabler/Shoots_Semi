<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
<jsp:include page="../user/top.jsp"></jsp:include>

<style>
#downImg{
	width : 10px
}
</style>

</head>
<body>
	<div class="container">
		<table class="table">
			<tr>
				<th>제목</th>
				<td>${nb.title}</td>
			</tr>
			<tr>
				<td>작성자 : ${nb.writer }</td>
				<td> 작성일 : ${nb.register_date }</td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td style="padding-right: 0px">
					<textarea class="form-control"
							rows="5" readOnly>${nb.title}</textarea></td>
			</tr>
			
			<tr>
				<td><div>첨부파일</div></td>
					
				<%--파일을 첨부한 경우 --%>
				<c:if test="${!empty nb.notice_file}">
					<td><img src="${pageContext.request.contextPath}/img/down.png" width="10px" id="downImg">
						<a href="down?filename=${nb.notice_file}">${nb.notice_file}</a></td>
				</c:if>
				
				<%--파일을 첨부하지 않은 경우 --%>
				<c:if test="${empty nb.notice_file}">
					<td></td>
				</c:if>
			</tr>
			
		</table>
		
		<a href="noticeList">
			<button class="btn btn-warning">목록</button>
		</a>
	</div>

</body>
</html>