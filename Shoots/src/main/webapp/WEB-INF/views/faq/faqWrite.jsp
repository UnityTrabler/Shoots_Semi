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
				<label for="regular_user_id">작성자</label>
				<input name="regular_user_id" id="regular_user_id" value="${id}" 
						type="text" class="writer" readOnly> 
			</div>
		
			<div class="form-group">
				<label for="titlep">제목</label>
				<input name="title" id="title" type="text" maxlength="100"
						class="titlei" placeholder="Enter FAQ TITLE" required>
			</div>
			
			<%--문의 내용 --%>
			<div class="form-group">
				<textarea name="content" id="content" rows="10"
						class="content" placeholder="내용을 입력해 주세요" required></textarea>
			</div>
		
			<div class="form-group">
				<label>
					<span class = "filep">파일첨부</span>
					<img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부">
					<input type="file" id="upfile" name="faq_file">
				</label>
				<span id="filevalue"></span>
			</div>
			
			<div class="btnD">
				<input type = "submit" value = "등록" class = "uploadbBtn">
				<input type = "reset" value = "취소" class = "resetBtn">
				<input type = "button" class = "backBtn" onClick="history.go(-1)" value = "목록">
			</div>
		</form>
	</div>
	
</body>
</html>