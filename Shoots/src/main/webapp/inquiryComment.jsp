<%@ page language="java" contentType="text/html; charset=UTF-8;"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<!-- 댓글 폼 시작 -->
<form action="add" method ="post" name = "iqcommentform" id="iqcommentform">
	<div class="comment-head">
	<h2>댓글</h2>
	</div>
	
	<!-- 댓글 내용 부분 -->
	<div class="comment-body">
		<img src ="${pageContext.request.contextPath}/img/profile.png" alt="프로필" width="24" height="24">
		
		<div class ="nickname" name="writer"> <!-- 댓글 작성자 이름 -->
		임시이름1 + ${id}
		</div>
		
		<textarea placeholder = "문의글에 대한 댓글을 남겨보세요" width="1200" class="iqcomment-content" name="content" maxlength="300" ></textarea>		
		
		<div class="register-box">
			<div class="등록" id="register-comment">등록</div>
			<div class="button btn-cancel" id="cancel-comment">취소</div>
		</div>
		
	</div>

</form>



</body>
</html>