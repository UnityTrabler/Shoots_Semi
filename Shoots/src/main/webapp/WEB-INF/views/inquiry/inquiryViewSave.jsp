<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>문의 게시판</title>
<%--<script src="${pageContext.request.contextPath}/css/inquiry.css"></script> --%>
<jsp:include page = "/WEB-INF/views/user/top.jsp"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/js/inquiryJs/inquirycomment.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/view.css" type="text/css">
</head>
<body>

	<input type="hidden" id="loginid" value="${inquiry_ref_idx}" name="loginid">
	<%--view.js에서 사용하기 위해 추가 --%>
	<div class="container">
		<table class="table">
				<tr>
					<th colspan="2">1:1 문의 게시판</th>
				</tr>
				<tr>
					<td><div>문의자</div></td>
					<td><div>${inquirydata.user_id}</div></td>
					
				</tr>
				<tr>
					<td><div>제목</div></td>
					<td><c:out value = "${inquirydata.title}"/></td>
				</tr>
				<tr>
					<td><div>내용</div></td>
					<td style ="padding-right:0px">
						<textarea class="form-control" rows="5"
						 readOnly>${inquirydata.content}</textarea></td>
				</tr>
				
				<tr>
						<td><div>첨부파일</div></td>
					
					<%--파일 첨부한 경우 --%>
					<c:if test="${!empty inquirydata.inquiry_file}">
						<td><img src="${pageContext.request.contextPath}/img/down.png" width="10px">
							<a href="down?filename=${inquirydata.inquiry_file}">${inquirydata.inquiry_file}</a></td>
					</c:if>
					
					
					<%--파일 첨부 안한경우 --%>
					<c:if test="${empty inquirydata.inquiry_file}">
						<td></td>
					</c:if>
				</tr>
			
			<tr>
				<td colspan="2" class="center">
					<%--수정 삭제 완료시 원복 <c:if test="${inquirydata.inquiry_ref_idx ==id || id == 'admin' }"> --%>
						<a href="modify?num=${inquirydata.inquiry_id}">
							<button class="btn btn-info">수정</button>
						</a>
						<%--href의 주소를 #으로 설정함. --%>
						<a href ="#">
							<button class="btn btn-danger" data-toggle="modal"
								data-target="#myModal" id="inquiryDelete">삭제</button>
						</a>
					<%--수정 삭제 완료시 원복 </c:if>   --%>
						<a href="list">
							<button class="btn btn-warning">목록</button>
						</a>
					</td>
				</tr>
			</table>
		</div>
	<%--<div class="container"> end --%>
	
	
	<%--댓글창 시작 --%>
   <div class="container">
	<div class="comment-area">
	<div class="comment-head">
		<h3 class="comment-count">
			댓글 <sup id="count" style="font-family: arial, sans-serif;"></sup>
		</h3>
		<div class="comment-order">
			<ul class="comment-order-list">
			</ul>
		</div>
	</div><!-- comment-head end-->
	<ul class="comment-list">
	</ul>
	 <div class="comment-write">
			<div class="comment-write-area">
				<b class="comment-write-area-name">${id}</b> 
				<span class="comment-write-area-count">0/200</span>
				<textarea placeholder="댓글을 남겨보세요" rows="3" class="comment-write-area-text" maxlength="200"></textarea>
					
			</div>
			<div class="register-box">
				<div class="button btn-cancel">취소</div>
				<div class="button btn-register">등록</div>
			</div>
		</div>
	</div>
	</div>
	
	
<script>
$(function(){
	$('#inquiryDelete').click(function(){
		if (confirm("문의글을 삭제하시겠습니까?")) {
			$.ajax({
				type: "POST", 
				url: "delete?num=${inquirydata.inquiry_id}", 
				success: function(response) {
					alert("삭제되었습니다."); 
					location.href = "../inquiry/list"; 
				},
				error: function() {
					alert("삭제 실패. 다시 시도해주세요.");
				}
			});
		}
	});
})
</script>
</body>
</html>