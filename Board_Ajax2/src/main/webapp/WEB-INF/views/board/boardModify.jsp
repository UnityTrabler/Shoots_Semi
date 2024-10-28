<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<jsp:include page="header.jsp"/>
	<script src="${pageContext.request.contextPath}/js/modifyform.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	<style>
		h1{font-size:1.5rem; text-align:center; color: #1a92b9}
		.container{width: 60%;}
		label{font-weight: bold;}
		#upfile{display: none;}
		img{width:20px;}
	</style>
</head>
<body class="container">
	<form action="modifyProcess" method="post" enctype="multipart/form-data" name="modifyform">
		<input type="hidden" name="board_num" value="${boarddata.board_num}">
		<h1>MVC 게시판 - 수정</h1>
		
		<div class="form-group">
			<label for="board_name">글쓴이</label>
			<input name="board_name" id="board_name" value="${boarddata.board_name}" readonly
				   type="text"		 class="form-control"
				   placeholder="Enter board_name">
		</div>
		
		<div class="form-group">
			<label for="board_subject">제목</label>
			<input name="board_subject" id="board_subject" maxlength="100"
				   type="text"		 class="form-control"
				   placeholder="Enter board_subject" value="${boarddata.board_subject}">
		</div>
		
		<div class="form-group">
			<label for="board_content">내용</label>
			<textarea name="board_content" id="board_content" rows="10"
				   class="form-control">${boarddata.board_content}</textarea>
		</div>
		
		<%-- 원문글인 경우만 파일첨부 수정 가능 --%>
		<c:if test="${boarddata.board_re_lev==0}">
			<div class="form-group">
				<label>
					파일 첨부
					<img src="${pageContext.request.contextPath}/image/attach.png" alt="파일첨부">
					<input type="file" id="upfile" name="board_file">
				</label>
				<span id = "filevalue">${boarddata.board_file}</span>
				<img src="${pageContext.request.contextPath}/image/remove.png" alt="파일삭제" width="10px" class="remove">
			</div>
		</c:if>
		
		<div class="form-group">
			<label for="board_pass">비밀번호</label>
			<input name="board_pass" id="board_pass" maxlength="30"
				   type="password"   class="form-control"
				   size="10" placeholder="Enter password" >
		</div>
		
		<div class="form-group">
			<button type="submit" class="btn btn-primary">수정</button>
			<button type="reset" class="btn btn-danger" onClick="history.go(-1)">취소</button>
		</div>
		
	</form>
</body>