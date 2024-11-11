<%@ page language="java" contentType="text/html; charset=UTF-8;"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page = "/WEB-INF/views/user/top.jsp"/>
</head>
<body>


 <!-- 댓글 리스트 출력 -->
    <div class="comments-section">
        <h2>댓글 목록</h2>
        
        <c:if test="${!empty iqlist}">
            <c:forEach var="ic" items="${iqlist}">
                <div class="ic">
                    <p><strong>작성자:</strong> ${ic.writer}</p>
                    <p><strong>내용:</strong> ${ic.content}</p>
                    <p><strong>등록일:</strong> ${ic.register_date}</p>
                </div>
                <hr>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty iqlist}">
            <p>댓글이 없습니다.</p>
        </c:if>
    </div>
	
	
	
<!-- 댓글 폼 시작 -->
<form action="iqcomments/add" method ="post" name = "iqcommentform" id="iqcommentform">
	<div class="comment-head">
	<h2>댓글</h2>
	</div>
	
	<!-- 댓글 내용 부분 -->
	<div class="comment-body">
		<input type="hidden" name="inquiry_id" value="${inquirydata.inquiry_id}">
		<img src ="${pageContext.request.contextPath}/img/profile.png" alt="프로필" width="24" height="24">
		
		<div class="nickname">
		<input type="hidden" class ="nickname" name="writer" value="${id}"> <!-- 댓글 작성자의 로그인id :int형 -->
		<span class="nickname">${inquirydata.user_id}</span>  <!-- 댓글 작성자의 닉네임 : 유저 닉네임 -->
		</div>
		
		
		<textarea placeholder = "문의글에 대한 댓글을 남겨보세요" width="1200" class="iqcomment-content" name="content" maxlength="300" required></textarea>		
		
		<div class="register-box">
			<button class="btn-primary" id="register-comment">등록</button>
			<button class="btn-danger" id="cancel-comment" style="display:none">취소</button>
		</div>
		
	</div>
</form>

</body>
</html>