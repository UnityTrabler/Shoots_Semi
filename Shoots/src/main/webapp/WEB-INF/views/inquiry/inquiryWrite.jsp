<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%-- <jsp:include page="header.jsp"/> --%>
	<script src="${pageContext.request.contextPath}/js/inquiryJs/inquirywriteform.js"></script>
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
		<form action="add" method="post" enctype="multipart/form-data" name="inquiryform">
			<h1>1:1 문의글 작성</h1>		
			<div class="form-group">
				<%--문의자, hidden --%>
				<input name="inquiry_ref_idx" id ="inquiry_ref_idx" value="2" 
				type="hidden" class="form-control" readOnly> 
				
				<%--문의자 유형, hidden --%>
				<input name="inquiry_type" id ="inquiry_type" value="A" 
				type="hidden" class="form-control" style="width:20px" readOnly>
			</div>
			
			<div class="form-group">
				<label for ="board_subject">문의 제목</label>
				<input name="title" id ="title" maxlength="100" 
				type="text" class="form-control" placeholder="Enter board_subject">
			</div>
			
			<%--문의 내용 --%>
			<div class="form-group">
				<textarea name="content" id ="content"  rows="10"
				class="form-control"></textarea>
			</div>
			
			<div class="form-group">
				<label>
					파일첨부
					<img src="${pageContext.request.contextPath }/img/attach.png" alt="파일첨부">
					<input type="file" id="upfile" name="inquiry_file">
				</label>
				<span id="filevalue"></span>
			</div>
			
			<div class="form-group">
				<button type="submit" class="btn btn-primary">등록</button>
				<button type="reset" class="btn btn-danger">취소</button>
			</div>
		</form>
	</div>

</body>
</html>