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
				<label for="regular_user_id">작성자</label>
				
				<input name="regular_user_id" id="regular_user_id" value="${id}" 
						type="text" class="writer" readOnly > 
			</div>
		
			<div class="form-group">
				<label for="title" class="titlep">제목</label>
				<input name="title" id="title" type="text" maxlength="100"
						class="titlei" placeholder="Enter TITLE" required>
			</div>
			
			<%--공지사항 내용 --%>
			<div class="form-group">
				<textarea name="content" id="content" rows="10"
						class="content" required></textarea>
			</div>
		
			<div class="form-group">
				<label>
					파일 첨부
					<img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부">
					<input type="file" id="upfile" name="notice_file">
				</label>
				<span id="filevalue"></span>
			</div>
		
			<div class="btnD">
				<input type = "submit" value = "등록" class = "uploadbBtn">
				<input type = "reset" value = "취소" class = "resetBtn">
				<input type = "button" class = "backBtn" onClick="history.go(-1)" value = "목록">
			</div>
			
		</div>
	</form>
</body>
</html>