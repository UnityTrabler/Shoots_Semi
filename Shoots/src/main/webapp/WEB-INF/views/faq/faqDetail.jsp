<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>FAQ 더 보기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
	<input type="hidden" id="loginid" value="${fb.faq_id}" name="loginid"><%--혹시 id를 사용할 수도 있나요?. --%>
	
	<div class="container">
		<table class="table">
			<tr>
				<td><div>글쓴이</div></td>
				<td><div>${fb.writer}</div></td>
			</tr>
			<tr>
				<td><div>제목</div></td>
				<td><c:out value="${fb.title}" /></td>
			</tr>
			<tr>
				<td><div>내용</div></td>
				<td style="padding-right: 0px">
					<textarea class="form-control"
							rows="5" readOnly>${fb.content}</textarea></td>
			</tr>
			
			<tr>
				<td><div>첨부파일</div></td>
					
				<%--파일을 첨부한 경우 --%>
				<c:if test="${!empty fb.faq_file}">
					<td><img src="${pageContext.request.contextPath}/img/down.png" width="10px">
						<a href="down?filename=${fb.faq_file}">${fb.faq_file}</a></td>
				</c:if>
				
				<%--파일을 첨부하지 않은 경우 --%>
				<c:if test="${empty fb.faq_file}">
					<td></td>
				</c:if>
			</tr>
			
			<tr>
				<td><a href="update?id=${fb.faq_id}">수정</a></td>
				<td><a href="delete?id=${fb.faq_id}">삭제</a></td>
			</tr>
			
		</table>
		
		<a href="faqAdmin">
			<button class="btn btn-warning">목록</button>
		</a>
		
	</div>
	
	
</body>
</html>