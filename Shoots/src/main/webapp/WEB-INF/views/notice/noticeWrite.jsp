<%--
	0. 공지사항을 입력하는 페이지 입니다.
	1. 현재 접속한 관리자의 아이디를 사용합니다.(top.jsp에 들어있는 값이 사용자의 id이므로 그 값을 가져옵니다)
	2. writer에 들어가는 것은 user_id가 아닌 idx값이므로 뒤에 NoticeAddAction()에서 해당 값을 수정해줍니다
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항 작성</title>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<script src = "${pageContext.request.contextPath}/js/nf_writeform.js"></script>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeWrite.css" type = "text/css"> 
</head>
<body>
	<form action="add" method="post" enctype="multipart/form-data">
		<div class="container">
			<h1>공지사항 작성</h1>
			<div class="form-group">
				<label for="regular_user_id">관리자</label>
				
				<input name="regular_user_id" id="regular_user_id" value="${id}" 
						type="text" class="form-control" readOnly > 
			</div>
		
			<div class="form-group">
				<label for="title">제목</label>
				<input name="title" id="title" type="text" maxlength="100"
						class="form-control" placeholder="Enter TITLE" required>
			</div>
			
			<div class="form-group">
				<label for="content">내용</label>
				<textarea name="content" id="content" rows="10"
						class="form-control" required></textarea>
			</div>
		
			<div class="form-group">
				<label>
					파일 첨부
					<img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부">
					<input type="file" id="upfile" name="notice_file">
				</label>
				<span id="filevalue"></span>
			</div>
		
			<div class="form-group">
				<input type = "submit" value = "UPLOAD" class = "btn btn-danger uploadbBtn">
				<input type = "reset" value = "RESET" class = "resetBtn">
				<input type = "button" class = "backBtn" onClick="history.go(-1)" value = "BACK">
			</div>
			
		</div>
	</form>
</body>
</html>