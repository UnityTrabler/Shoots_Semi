<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../user/top.jsp"></jsp:include>

<title>수정</title>
<script src="${pageContext.request.contextPath}/js/modifyform.js"></script>
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
  		 <input type="hidden" name="existing_file" value="${postdata.post_file}"> <!-- 기존 첨부파일명 전달 -->
  		
  	<h1>게시판 - 수정</h1>
  	
  	
  	
  	<%--
  	
  	<div class="form-group">
  		<label for="category"></label>
  		<input type="radio" name="category" id ="A" value="A" checked><span>자유게시판</span>
		<input type="radio" name="category" id ="B" value="B"><span>중고게시판</span>
  	</div>
  	
  	
  	 --%>
  	<div class="form-group">
  		<label for="writer">작성자</label>
  		<input type="text" class="form-control" name="writer" id ="writer"
  				value="${postdata.writer}" readOnly>
  				<%-- postdata.writer --%>
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
  	
  	
  	<%--
  	
  	<!-- 가격 입력 (중고게시판일 경우에만 보이게 설정) -->
  	<div class="form-group fade active show" id="price">
  		<label for="price">가격</label>
  		<input name="price" id="priceInput" type="text" class="form-control" placeholder="가격을 입력해주세요"></input >
  	</div>
  	
  	<!-- 중고게시판일 경우 가격 입력란 보이기 -->
            <div class="form-group" id="price" style="${postdata.category == 'B' ? '' : 'display: none;'}">
                <label for="price">가격</label>
                <input name="price" id="priceInput" type="text" class="form-control" value="${postdata.price}" placeholder="가격을 입력해주세요">
            </div>
  	
  	 --%>
  	
  	
  	<!-- 중고게시판일 경우 가격 입력란 보이기 -->
            <div class="form-group" id="price" style="${postdata.category == 'B' ? '' : 'display: none;'}">
                <label for="priceInput">가격</label>
                <input name="price" id="priceInput" type="text" class="form-control" value="${postdata.price}" placeholder="가격을 입력해주세요">
            </div>
  	
  
  
  
	<%-- 원문글인 경우에만 파일 첨부 수정 가능합니다. --%>
	<%--  <c:if test="${postdata.board_re_lev==0}"> --%>
  	<div class="form-group">
  		<label>파일첨부
  		 <img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부" width="20px"> 
  		 <input type="file" id="upfile" name="post_file">
  		</label>
  		<span id="filevalue">${postdata.post_file}</span> <!-- 기존 파일명 출력 -->
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