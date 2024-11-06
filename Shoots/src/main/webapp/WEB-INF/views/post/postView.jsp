<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>post - view</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src = "https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<input type="hidden" id="loginid" value="${id}" name="loginid"> <%-- view.js에서 사용하기 위해 추가합니다 --%>
	<div class="container">
		<table class="table">
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
			
			<c:if test="${postdata.category==B}">
			<tr>
				<td><div>가격</div></td>
				<td style="padding-right: 0px">
					<textarea class="form-control" rows="5" readOnly>
						${postdata.price}
					</textarea>
				</td>
			</tr>
			</c:if>
			
		<%-- <c:if test="${boarddata.board_re_lev==0}">
				<%-- 원문글인 경우에만 첨부파일을 추가 할 수 있습니다. --%> 
			<tr>
				<td><div>첨부파일</div></td>
					
				<%-- 파일을 첨부한 경우 --%>
			<c:if test="${!empty postdata.post_file}">
				<td><img src="${pageContext.request.contextPath}/img/down.png" width="10px">
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
					<%-- <c:if test="${postdata.writer == id || id == 'admin' }"> --%>
						<a href="modify?num=${postdata.post_id}">
							<button class="btn btn-info">수정</button>
						</a>
						<%-- href의 주소를 #으로 설정합니다. --%>
						<a href="#">
							<button class="btn btn-danger" data-toggle="modal" data-target="#myModal" id="post_id">삭제</button>
						</a>
					<%-- </c:if> --%>
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
		
		<%-- 모달 --%>
		
		
		<%-- 댓글창 --%>
		<div class="comment-area">
			<div class="comment-head">
				<h3 class="comment-count">
					댓글 <sup id="count"></sup><%--superscript(윗첨자) --%>
				</h3>
				<div class="comment-order">
					<ul class="comment-order-list">
					</ul>
				</div>
			</div><%-- comment-head end --%>
			
			<ul class="comment-list">
			</ul>
			<div class="comment-write">
				<div class="comment-write-area">
					<b class="comment-write-area-name" >${id}</b>
						<span class="comment-write-area-count">0/200</span>
					<textarea placeholder="댓글을 남겨보세요" rows="1"
				class="comment-write-area-text" maxLength="200"></textarea>
				
				</div>
				<div class="register-box">
					<div class="button btn-cancel">취소</div> <%-- 댓글의 취소는 display:none, 등록만 보이도록 --%>
					<div class="button btn-register">등록</div>
				</div>
			</div> <%-- comment-write end --%>
	</div>	<%-- comment-area end --%>
	</div> <%-- class="container" end --%>
</body>

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
	</script>
</html>