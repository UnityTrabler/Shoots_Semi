<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>문의 게시판</title>
<jsp:include page = "/WEB-INF/views/user/top.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/view.css" type="text/css">

<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/js/inquiryJs/inquirycommentM.js"></script>

</head>
<body>

<input type="hidden" value="${id}" id="loginid">  <!-- 수정 삭제 버튼 보이게 하려고 현재 로그인 한 유저의 id값을 받아놓음 -->
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
					<%--수정, 삭제 버튼은 로그인 한 유저의 아이디 = 문의글 작성자 일때 혹은 id가 관리자 일때만 보이게 함 --%>
					<c:if test="${inquirydata.inquiry_ref_idx == idx || id == 'admin' }">
						<a href="modify?inquiryid=${inquirydata.inquiry_id}">
							<button class="btn btn-info">수정</button>
						</a>
						<%--href의 주소를 #으로 설정함. --%>
						<a href ="#">
							<button class="btn btn-danger" data-toggle="modal"
								data-target="#myModal" id="inquiryDelete">삭제</button>
						</a>
					</c:if>
						<a href="list">
							<button class="btn btn-warning">목록</button>
						</a>
					</td>
				</tr>
			</table>
		</div>
	<%--<div class="container"> end --%>
	
	
	 <!-- 댓글 리스트 출력 -->
    <div class="comments-section">
        <h2>댓글 목록</h2>
        
        <c:if test="${!empty iqlist}">
            <c:forEach var="ic" items="${iqlist}">
                <div class="ic">
                
                	<input type="hidden" value="${ic.i_comment_id}" name = "i_comment_id" class="ic-num">  <!-- 문의댓글의 고유번호값 받아두기 -->
                	
                	<!-- 프로필 사진 -->
                	<img src ="${pageContext.request.contextPath}/img/profile.png" alt="프로필" width="60" height="48">
                	
                	<input type="hidden" value="${ic.user_id}" class="iqcomment-writer"> <!-- 각 문의댓글을 남긴 댓글 작성자 값 -->
                    <p><strong>작성자:</strong> ${ic.user_id} <strong>등록일:</strong> ${ic.register_date.substring(0,16)}
                    <button type="button" class="btn btn-primary ic-modify" style="display:none" value="${ic.i_comment_id}">수정</button>
                    <button type="button" class="btn btn-danger ic-delete" style="display:none" value="${ic.i_comment_id}">삭제</button>
                    </p>
                    <span>${ic.content}</span>
                </div>
                <hr>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty iqlist}">
            <p>댓글이 없습니다.</p>
        </c:if>
    </div>
	
	
	
<!-- 댓글 폼 시작 -->
<form action="../iqcomments/add" method ="post" name = "iqcommentform" id="iqcommentform">
	<div class="comment-head">
	<h2>댓글</h2>
	</div>
	
	<!-- 댓글 내용 부분 -->
	<div class="comment-body">
		<input type="hidden" name="inquiry_id" value="${inquirydata.inquiry_id}">
		<img src ="${pageContext.request.contextPath}/img/profile.png" alt="프로필" width="60" height="48">
		
		<div class="nickname">
		<input type="hidden" class ="nickname" name="writer" value="${idx}"> <!-- 댓글 작성자의 로그인id :int형, idx 가져옴. -->
		<span class="nickname">${id}</span>  <!-- 댓글 작성자의 닉네임 : 로그인 한 유저 닉네임 -->
		</div>
		
		
		<textarea placeholder = "문의글에 대한 댓글을 남겨보세요" width="1200" class="iqcomment-content" name="content" maxlength="300" required></textarea>		
		
		<div class="register-box">
			<button class="btn-primary" id="register-comment">등록</button>
			<button class="btn-danger" id="cancel-comment" style="display:none">취소</button>
		</div>
		
	</div>
</form>
	
	
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