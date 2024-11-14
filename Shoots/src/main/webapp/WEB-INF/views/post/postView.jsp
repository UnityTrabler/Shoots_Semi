<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../user/top.jsp"></jsp:include>
<meta charset="UTF-8">
<title>post - view</title>
<script src="${pageContext.request.contextPath}/js/view.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src = "https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<input type="hidden" id="loginid" value="${id}" name="loginid"> <%-- view.js에서 사용하기 위해 추가합니다 --%>
	<div class="container">
		<!-- 게시글 정보 -->
		<table class="table">
			<!-- 게시글 정보 표시 -->
			<tr>
				<th colspan="2">view페이지</th>
			</tr>
			<tr>
				<td><div>작성자</div></td>
				<td><div>${postdata.writer}</div></td>
			</tr>
			<tr>
				<td><div>제목</div></td>
				<td><c:out value="${postdata.title}" /></td>
			</tr>
			<tr>
				<td><div>내용</div></td>
				<td style="padding-right: 0px">
					<textarea class="form-control" rows="5" readOnly>
						${postdata.content}
					</textarea>
				</td>
			</tr>
			<!-- 중고게시판은 가격 -->
			<c:if test="${postdata.category=='B'}">
			<tr>
			<td><div>가격</div></td>
				<td><c:out value="${postdata.price}" />원</td>
				
			</tr>
			</c:if>
			
		<%-- <c:if test="${boarddata.board_re_lev==0}">
				<%-- 원문글인 경우에만 첨부파일을 추가 할 수 있습니다. --%> 
			<tr>
				<td><div>첨부파일</div></td>
					
				<%-- 파일을 첨부한 경우 --%>
			<c:if test="${!empty postdata.post_file}">
				<td><img src="${pageContext.request.contextPath}/postupload/${postdata.post_file}" style= "width : 300px;"}>
				<a href="down?filename=${postdata.post_file}">${postdata.post_file}</a>
			</c:if>
			
			<%-- 파일을 첨부하지 않은 경우 --%>
			<c:if test="${empty postdata.post_file}">
				<td></td>
			</c:if>
			</tr>
			<%-- </c:if> --%>
			
			<tr>
				<td colspan="2" class="center">
					 <c:if test="${postdata.writer == idx || id == 'admin' }"> 
						<a href="modify?num=${postdata.post_id}">
							<button class="btn btn-info">수정</button>
						</a>
						<%-- href의 주소를 #으로 설정합니다. --%>
						<a href="#">
							<button class="btn btn-danger" data-toggle="modal" 
									data-target="#myModal" id="post_id">삭제</button>
						</a>
					 </c:if> 
					<a href="list">
						<button class="btn btn-warning">목록</button>
					</a>
					<%-- 
					<a href="reply?num=${boarddata.board_num}">
						<button class="btn btn-success">답변</button>
					</a>
					--%>
				</td>
			</tr>
		</table>
		<%-- 게시판 view end --%>
		
		
		
		
		
		
		
		 <!-- 댓글 리스트 출력 -->
    <div class="comments-section">
        <h2>댓글 목록</h2>
        
        <c:if test="${!empty commentlist}">
            <c:forEach var="co" items="${commentlist}">
                <div class="co">
                
                	<input type="hidden" value="${co.comment_id}" name = "comment_id" class="co-num">  <!-- 댓글의 고유번호값 받아두기 -->
                	
                	<!-- 프로필 사진 -->
                	<img src ="${pageContext.request.contextPath}/img/profile.png" alt="프로필" width="60" height="48">
                	
                	<input type="hidden" value="${co.user_id}" class="comment-writer"> <!-- 각 문의댓글을 남긴 댓글 작성자 값 -->
                	<div class="buttonfront">
                    <p><strong>작성자:</strong> ${co.user_id} <strong>등록일:</strong> ${co.register_date.substring(0,16)}
                    </div>
                    <button type="button" class="btn btn-primary co-modify" style="display:none" value="${co.comment_id}">수정</button>
                    <button type="button" class="btn btn-danger co-delete" style="display:none" value="${co.comment_id}">삭제</button>
                    </p>
                    <span class="comment-content">${co.content}</span>
                </div>
                <hr>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty commentlist}">
            <p>댓글이 없습니다.</p>
        </c:if>
    </div>
	
	
	
<!-- 댓글 폼 시작 -->
<form action="../comments/add" method ="post" name = "commentform" id="commentform">
	<div class="comment-head">
	<h2>댓글</h2>
	</div>
	
	<!-- 댓글 내용 부분 -->
	<div class="comment-body">
		<input type="hidden" name="comment_id" value="${postdata.comment_id}">
		<img src ="${pageContext.request.contextPath}/img/profile.png" alt="프로필" width="60" height="48">
		
		<div class="nickname">
		<input type="hidden" class ="nickname" name="writer" value="${idx}"> <!-- 댓글 작성자의 로그인id :int형, idx 가져옴. -->
		<span class="nickname">${id}</span>  <!-- 댓글 작성자의 닉네임 : 로그인 한 유저 닉네임 -->
		</div>
		
		
		<textarea placeholder = "댓글을 남겨보세요" style = "width : 1200px;" class="comment-content" name="content" maxlength="300" required></textarea>		
		
		<div class="register-box">
			<button class="btn-primary" id="register-comment">등록</button>
			<button class="btn-danger" id="cancel-comment" style="display:none">취소</button>
		</div>
		
	</div>
</form>
	
	
	
	
	
	
	<script>
		
		
		$(function(){
			$('#post_id').click(function(){
				if (confirm("게시글을 삭제하시겠습니까?")) {
					$.ajax({
						type: "POST", 
						url: "delete?num=${postdata.post_id}", 
						success: function(response) {
							alert("삭제되었습니다."); 
							location.href = "../post/list"; 
						},
						error: function() {
							alert("삭제 실패. 다시 시도해주세요.");
						}
					});
				}
			});
		})
		
	<%--js에서 contextPath를 직접 선언할 수 없기에 jsp에서 선언하기 위해 있는 부분 --%>
	const contextPath = "${pageContext.request.contextPath}";
		
	</script>
</body>


</html>