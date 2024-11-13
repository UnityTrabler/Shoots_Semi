<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>FAQ 더 보기</title>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/faqDetail.css" type = "text/css">
	<script src="${pageContext.request.contextPath}/js/adminJS/AdminMypage.js"></script>
	<script>
		$(function(){
			$("table tr:last-child td a:nth-child(2)").click(function(event){
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
	<input type="hidden" id="loginid" value="${fb.faq_id}" name="loginid">
	<div class="container">
		<table class="table">
			<caption><c:out value="${fb.title}" /></caption>
			<tr>
				<td><div>글쓴이</div></td>
				<td><div>${fb.name}</div></td>
			</tr>
			
			<tr>
				<td><div>내용</div></td>
				<td style="padding-right: 0px">
					<textarea rows="5" readOnly>${fb.content}</textarea>
				</td>
			</tr>
			
			<tr>
				<td><div>첨부파일</div></td>
					
				<%--파일을 첨부한 경우 --%>
				<c:if test="${!empty fb.faq_file}">
					<td><img src="${pageContext.request.contextPath}/img/down.png" width="10px" id="downImg">
						<a href="down?filename=${fb.faq_file}">${fb.faq_file}</a>
					</td>
				</c:if>
				
				<%--파일을 첨부하지 않은 경우 --%>
				<c:if test="${empty fb.faq_file}">
					<td></td>
				</c:if>
			</tr>
			
			<tr>
				<td></td>
				<td>
					<a href="update?id=${fb.faq_id}" type="button" class="updateBtn">수정</a>
					<a href="delete?id=${fb.faq_id}" type="button" class="deleteBtn">삭제</a>
					<a href="../admin/mypage" type="button" class="listBtn">목록</a>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>