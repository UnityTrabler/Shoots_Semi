<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script src = "${pageContext.request.contextPath}/js/modifyform.js"></script>
<title>공지사항 수정</title>
</head>
<body>
	<form action="updateProcess" method="post" enctype="multipart/form-data" name="modifyform">
		<input type="hidden" name="notice_id" value="${nb.notice_id}">
	
		<div class="form-group">
			<label>글쓴이</label>
			<input type="text" class="form-control" value="${nb.writer}" readOnly>
		</div>
			
		<div class="form-group">
			<label for="title">제목</label>
			<textarea name="title" id="title" rows="1" maxlength="100"
					class="form-control">${nb.title}</textarea>
		</div>
			
		<div class="form-group">
			<label for="content">내용</label>
			<textarea name="content" id="content" rows="10"
					class="form-control">${nb.content}</textarea>
		</div>
			
		<div class="form-group">
				<label>파일 첨부
					<img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부" width="20px">
					<input type="file" id="upfile" name="notice_file">
				</label>
				<br>
				<span id="filevalue">${nb.notice_file}</span>
				<img src="${pageContext.request.contextPath}/img/remove.png" 
					alt="파일삭제" width="10px" class="remove">
		</div>
		
		<div class="form-group">
			<button type=submit class="btn btn-primary">수정</button>
			<button type=reset class="btn btn-danger" onClick="history.go(-1)">취소</button>
		</div>
	</form>
</body>
</html>