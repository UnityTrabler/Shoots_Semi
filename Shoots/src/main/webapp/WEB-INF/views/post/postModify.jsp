<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<script src="${pageContext.request.contextPath}/js/modifyform.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
 <style>
  h1{font-size:1.5em; text-align:center; color:#1a92b9}
  .container{width:60%}
  label{font-weight:bold}
  #upfile{display:none}
 </style>
</head>
<body>
 <div class="container">
  <form action="modifyProcess" method="post" name="modifyform"
  		enctype="multipart/form-data">
  		<input type="hidden" name="post_id" value="${postdata.post_id}">
  	<h1>게시판 - 수정</h1>
  	<div class="form-group">
  		<label for="writer">작성자</label>
  		<input type="text" class="form-control"
  				value="${postdata.writer}" readOnly>
  	</div>
  	
  	<div class="form-group">
  		<label for="title">제목</label>
  		<textarea name="title" id="title" rows="1"
  				class="form-control" maxlength="100">${postdata.title}</textarea>
  	</div>
  	
  	
  	<div class="form-group">
  		<label for="content">내용</label>
  		<textarea name="content" id="content"
  				class="form-control" rows="10" >${postdata.content}</textarea>
  	</div>
  	
  
	<%-- 원문글인 경우에만 파일 첨부 수정 가능합니다. --%>
	<%--  <c:if test="${postdata.board_re_lev==0}"> --%>
  	<div class="form-group">
  		<label>파일첨부
  		 <img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부" width="20px"> 
  		 <input type="file" id="upfile" name="post_file">
  		</label>
  		<span id="filevalue">${postdata.post_file}</span>
  		<img src="${pageContext.request.contextPath}/img/remove.png"
  			 alt="파일삭제" width="10px" class="remove">
  	</div>
  	<%-- </c:if> --%>


  	<%-- 
  	
  	<div class="form-group">
  		<label for="post_pass">비밀번호</label>
  		<input name="post_pass" 
  				id="post_pass" type="password" size="10" maxlength="30"
  				class="form-control" placeholder="Enter password">
  	</div>
  	
  	--%>
  	
  	
  	<div class="form-group">
  		<button type=submit class="btn btn-primary">수정</button>
  		<button type=reset class="btn btn-danger" onClick="history.go(-1)">취소</button>
  	</div>
  	</form>
 </div> <%-- class="container" end --%>
</body>
</html>