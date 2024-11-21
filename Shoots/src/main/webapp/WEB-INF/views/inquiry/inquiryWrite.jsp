<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/js/inquiryJs/inquirywriteform.js"></script>
<jsp:include page = "/WEB-INF/views/user/top.jsp"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiryWrite.css">
<title>1:1 문의글 쓰기</title>	
</head>
<body>
	<div class="container">
		<form action="add" method="post" enctype="multipart/form-data" name="inquiryform">
			<h1>1:1 문의하기</h1>		
			<div class="form-group">
				<%--문의자, hidden --%>
				<input name="inquiry_ref_idx" id ="inquiry_ref_idx" value="${idx}" 
				type="hidden" class="form-control" readOnly> 
				
				<%--문의자 유형. 로그인했을때 유형이 regular 면 값을 A로, business면 값을 B로 바꿔서 전달해줌 : inquiry 테이블은 A,B로만 구분하기 때문 --%>
				<c:choose>
					<c:when test="${userClassification eq 'regular'}">
						<input name="inquiry_type" id ="inquiry_type" value="A" 
						type="hidden" class="form-control" style="width:20px" readOnly>
					</c:when>
					
					<c:when test="${userClassification eq 'business'}">
						<input name="inquiry_type" id ="inquiry_type" value="B" 
						type="hidden" class="form-control" style="width:20px" readOnly>
					</c:when>
				</c:choose>
			</div>
			
			<div class="form-group">
				<label for ="board_subject">문의 제목</label>
				<input name="title" id ="title" maxlength="100" 
				type="text" class="form-control" placeholder="제목을 입력해 주세요">
			</div>
			
			<%--문의 내용 --%>
			<div class="form-group">
				<textarea name="content" id ="content"  rows="10" placeholder="내용을 입력해 주세요"
				class="form-control"></textarea>
			</div>
			
			<div class="form-group">
				<label>
					파일첨부
					<img src="${pageContext.request.contextPath }/img/attach.png" alt="파일첨부">
					<input type="file" id="upfile" name="inquiry_file">
				</label>
				<span id="filevalue" name="check">${inquirydata.inquiry_file}</span>
				<img src="${pageContext.request.contextPath}/img/remove.png"
				alt="파일삭제" width="10px" class="remove">
			 </div>
			
			<div class="form-group">
				<button type="submit" class="btn btn-primary registerBtn">문의 접수</button>
				<button type="button" class="btn btn-danger cancelBtn">취소</button>
			</div>
		</form>
	</div>

</body>
</html>