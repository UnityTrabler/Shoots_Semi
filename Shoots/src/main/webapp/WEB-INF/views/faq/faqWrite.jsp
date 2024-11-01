<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>FAQ추가</title>
<style>
	h1{font-size:1.5rem; text-align:center; color:#1a92b9}
	.container{width:60%}
	label{font-weight:bold}
	#upfile{display:none}
	img{width:20px;}
</style>
</head>
<body>
<div class="container">
	<form action="add" method="post" enctype="multipart/form-data" name="boardform">
		<h1>FAQ 등록 페이지</h1>
		<div class="form-group">
			<label for="writer">관리자</label>
			<input name="writer" id="writer" value="${writer}" 
					type="text" class="form-control"> <%--readOnly를 사용해야 하지만 로그인이 되어 있지 않은 상태이기 때문에 writer를 얻어올 수 없어 일단 제외시켰습니다 --%>
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
				<img src="${pageContext.request.contextPath}/image/attach.png" alt="파일첨부">
				<input type="file" id="upfile" name="faq_file">
			</label>
			<span id="filevalue"></span>
		</div>
		
		<div class="form-group">
			<button type=submit class="btn btn-primary">등록</button>
			<button type=reset class="btn btn-danger">취소</button>
		</div>
		
	</form>
</div>
</body>
</html>