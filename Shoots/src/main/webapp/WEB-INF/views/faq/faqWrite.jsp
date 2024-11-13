<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>FAQ추가</title>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<script src = "${pageContext.request.contextPath}/js/nf_writeform.js"></script>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeWrite.css" type = "text/css">
</head>

<body>
	<div class="container">
		<form action="add" method="post" enctype="multipart/form-data" name="boardform">
			<h1>FAQ 등록 페이지</h1>
			<div class="form-group">
				<label for="regular_user_id">관리자</label>
				<input name="regular_user_id" id="regular_user_id" value="${id}" 
						type="text" class="form-control" readOnly> 
			</div>
		
			<div class="form-group">
				<label for="title">제목</label>
				<input name="title" id="title" type="text" maxlength="100"
						class="form-control" placeholder="Enter FAQ TITLE" required>
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
					<input type="file" id="upfile" name="faq_file">
				</label>
				<span id="filevalue"></span>
			</div>
			
			<div class="form-group">
				<input type = "submit" value = "UPLOAD" class = "btn btn-danger uploadbBtn">
				<input type = "reset" value = "RESET" class = "resetBtn">
				<input type = "button" class = "backBtn" onClick="history.go(-1)" value = "BACK">
			</div>
		</form>
	</div>
	
</body>
</html>