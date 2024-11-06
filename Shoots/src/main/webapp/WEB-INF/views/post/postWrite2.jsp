<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/writeform.js"></script>
 <style>
  h1{font-size:1.5em; text-align:center; color:#1a92b9}
  .container{width:60%}
  label{font-weight:bold}
 </style>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
</head>
<body>
<div class="container">
  <form action="add" method="post" enctype="multipart/form-data"
  		name="postform">
  	<h1>게시판 글쓰기</h1>
  	
  	
  	
  	<div class="form-group">
  		<label for="category" ></label>
  			<input type="radio" name="category" value="A" required><span>자유게시판</span>
			<input type="radio" name="category" value="B" ><span>중고게시판</span>
  	</div>
  	
  	<div class="form-group">
  		<label for="title">글 작성</label>
  		<input name="title" id="title" type="text" maxlength="100"
  				class="form-control" placeholder="제목을 입력해주세요">
  	</div>
  	
  	
  	
  	<div class="form-group">
  		<label for="content">내용</label>
  		<textarea name="content" id="content"
  				rows="20" class="form-control" placeholder="내용을 입력하세요."></textarea>
  	</div>
  	
  	<div class="form-group">
  		<label>
  		파일첨부
  		 <img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부">
  		 <input type="file" id="upfile" name="post_file">
  		</label>
  		<span id="filevalue"></span>
  	</div>
  	
  	<div class="form-group">
  		<button type=reset class="btn btn-danger">취소</button>
  		<button type=submit class="btn btn-primary">등록</button>
  	</div>
  	</form>
 </div>
</body>
</html>