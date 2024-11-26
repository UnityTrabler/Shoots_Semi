<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<title>1:1문의글 : 수정</title>		
<%--<script src="${pageContext.request.contextPath}/css/inquiry.css"></script> --%>
<jsp:include page = "/WEB-INF/views/user/top.jsp"/>
	<script src="${pageContext.request.contextPath}/js/inquiryJs/inquirymodifyform.js"></script>
	<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiryWrite.css">
</head>
<body>
	<div class="container">
		<form action="modifyProcess" method="post" enctype="multipart/form-data" name="modifyform">
			<input type="hidden" name="inquiry_id" value="${inquirydata.inquiry_id}">
			<input type="hidden" name="existing_file" value="${inquirydata.inquiry_file}"> <!-- 기존 첨부파일명 전달 -->
  			<input type="hidden" name="remove_file" value="false"> <!-- 파일 삭제 여부 플래그 추가 -->
			<h3>문의글 수정</h3>		
			<div class="form-group">
				<label for ="inquiry_ref_idx">문의자</label>
				<input value="${inquirydata.user_id}" type="text" 
				class="titleI" readOnly>
			</div>
			
			<div class="form-group">
				<p class = "titlep">문의 제목</p>
				<input name="title" id ="title" maxlength="100" 
				type="text" class="titleI" value = "${inquirydata.title}">
			</div>
			
			<div class="form-group">
				<label for ="content">내용</label>
				<textarea name="content" id ="content"  rows="10"
				class="contentI">${inquirydata.content}</textarea>
			</div>
			
			 <div class="form-group">
				<label>
					<span class = "filep">파일첨부<span>
					<img src="${pageContext.request.contextPath }/img/attach.png" alt="파일첨부" class = "fileU">
					<input type="file" id="upfile" name="inquiry_file">
				</label>
				<span id="filevalue">${inquirydata.inquiry_file}</span>
				<img src="${pageContext.request.contextPath}/img/remove.png"
				alt="파일삭제" class="remove">
			 </div>
			
			<div class="btnD">
				<button type="submit" class="btn btn-primary registerBtn">수정</button>
				<button type="reset" class="btn btn-danger cancelBtn" onClick="history.go(-1)">취소</button>
			</div>
		</form>
	</div> <%--class="container" end --%>

</body>
</html>