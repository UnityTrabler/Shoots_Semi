<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>공지사항 관리 더 보기</title>
<jsp:include page="../user/top.jsp"></jsp:include>

<style>
#downImg{
	width : 10px
}
</style>
<script>

	$(function(){
		$("table tr:last-child td:nth-child(2) a").click(function(event){
			const answer = confirm("정말 삭제하시겠습니까?");
			console.log(answer);//취소를 클릭한 경우-false
			if (!answer){//취소를 클릭한 경우
				event.preventDefault(); //이동하지 않습니다.	
			}
		});//삭제 클릭 end
	});
</script>
</head>
<body>
	<div class="container">
		<table class="table">
			<tr>
				<td><div>글쓴이</div></td>
				<td><div>${nb.name}</div></td>
			</tr>
			<tr>
				<td><div>제목</div></td>
				<td><c:out value="${nb.title}" /></td>
			</tr>
			<tr>
				<td><div>내용</div></td>
				<td style="padding-right: 0px">
					<textarea class="form-control"
							rows="5" readOnly>${nb.content}</textarea></td>
			</tr>
			
			<tr>
				<td><div>첨부파일</div></td>
					
				<%--파일을 첨부한 경우 --%>
				<c:if test="${!empty nb.notice_file}">
					<td><img src="${pageContext.request.contextPath}/img/down.png" width="10px" id="downImg">
						<a href="down?filename=${nb.notice_file}">${nb.notice_file}</a></td>
				</c:if>
				
				<%--파일을 첨부하지 않은 경우 --%>
				<c:if test="${empty nb.notice_file}">
					<td></td>
				</c:if>
			</tr>
			
			<tr>
				<td><a href="update?id=${nb.notice_id}">수정</a></td>
				<td><a href="delete?id=${nb.notice_id}">삭제</a></td>
			</tr>
		</table>
		<a href="noticeAdmin">
			<button class="btn btn-warning">목록</button>
		</a>
	</div>
</body>
</html>