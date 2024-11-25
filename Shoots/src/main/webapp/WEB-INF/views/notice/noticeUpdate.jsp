<%--
	0. 공지사항 게시판을 수정하는 페이지 입니다.
	1. 수정하는 사람을 원래 작성자가 아닌 현재 접속중인 관리자의 ID로 합니다.(top.jsp에 들어있는 값이 사용자의 id이므로 그 값을 가져옵니다)
	2. 취소를 할 경우 이전 페이지로 이동합니다.
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	<script src = "${pageContext.request.contextPath}/js/updateform.js"></script>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeUpdate.css" type = "text/css">
	<title>공지사항 수정</title>
	<jsp:include page="../user/top.jsp"></jsp:include>
</head>
<body>
	<form action="updateProcess" method="post" enctype="multipart/form-data" name="modifyform">
		<input type="hidden" name="existing_file" value="${nb.notice_file}"> <!-- 기존 첨부파일명 전달 -->
  		<input type="hidden" name="remove_file" value="false"> <!-- 파일 삭제 여부 플래그 추가 -->
		<div class="container">
			<input type="hidden" name="notice_id" value="${nb.notice_id}">
	
			<div class="form-group">
				<label>작성자</label>
				<input type="text" class="writer" value="${id}" readOnly>
			</div>
				
			<div class="form-group">
				<label for="title" class="titlep">제목</label>
				<input name="title" id="title" rows="1" maxlength="100"
						class="titleI" value="${nb.title}">
			</div>
			
			<%--공지사항 내용 --%>
			<div class="form-group">
				
				<textarea name="content" id="content" rows="10"
						class="content">${nb.content}</textarea>
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
		
			<div class="btnD">
				<input type = "submit" class = "uploadbBtn" value = "수정" class = "btn btn-danger">
				<input type = "button" class = "backBtn" onClick="history.go(-1)" value = "목록">
			</div>
		</div>
	</form>
</body>
</html>