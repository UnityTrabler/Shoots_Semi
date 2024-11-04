<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<title>문의글 : 수정</title>		
	<%-- <jsp:include page="header.jsp"/> --%>
	<script src="${pageContext.request.contextPath}/js/inquiryJs/inquirymodifyform.js"></script>
	<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
	<style>
	h1{font-size:1.5rem;  text-align:center; color:#1a92b9}
	.container{width:60%;}
	label{font-weight:bold;}
	#upfile{display:none}
	img{width:20px;}
	</style>	
</head>
<body>
	<div class="container">
		<form action="modifyProcess" method="post" enctype="multipart/form-data" name="modifyform">
			<input type="hidden" name="inquiry_id" value="${inquirydata.inquiry_id}">
			<h1>문의글 수정</h1>		
			<div class="form-group">
				<label for ="inquiry_ref_idx">문의자</label>
				<input value="${inquirydata.inquiry_ref_idx}" type="text" 
				class="form-control" readOnly>
			</div>
			
			
			<div class="form-group">
				<label for ="title">제목</label>
				<textarea name="title" id ="title" maxlength="100"  rows="1"
				class="form-control">${inquirydata.title}</textarea>
			</div>
			
			<div class="form-group">
				<label for ="content">내용</label>
				<textarea name="content" id ="content"  rows="10"
				class="form-control">${inquirydata.content}</textarea>
			</div>
			
			 <div class="form-group">
				<label>
					파일첨부
					<img src="${pageContext.request.contextPath }/img/attach.png" alt="파일첨부" width="20px">
					<input type="file" id="upfile" name="inquiry_file">
				</label>
				<span id="filevalue">${inquirydata.inquiry_file}</span>
				<img src="${pageContext.request.contextPath}/img/remove.png"
				alt="파일삭제" width="10px" class="remove">
			 </div>
			
			<div class="form-group">
				<button type="submit" class="btn btn-primary">수정</button>
				<button type="reset" class="btn btn-danger" onClick="history.go(-1)">취소</button>
			</div>
		</form>
	</div> <%--class="container" end --%>

</body>
</html>