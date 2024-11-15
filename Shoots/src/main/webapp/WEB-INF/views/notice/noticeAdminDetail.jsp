<%--
	0. 공지사항의 자세한 내용을 확인할 수 있는 관리자 페이지 입니다.
	1. 일반 사용자의 noticeDetail페이지 내용에 수정, 삭제를 할 수 있는 버튼이 추가 되어 있습니다.
	
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항 관리 더 보기</title>
	<script src="${pageContext.request.contextPath}/js/adminJS/AdminMypage.js"></script>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeDetail.css" type = "text/css">
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
	<div class="container">
		<table class="table">
			<caption><c:out value="${nb.title}" /></caption>
			<tr>
				<td><div>글쓴이</div></td>
				<td><div>${nb.name}</div></td>
			</tr>
			
			<tr>
				<td><div>내용</div></td>
				<td style="padding-right: 0px">
					<textarea rows="5" readOnly>${nb.content}</textarea></td>
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
				<td></td>
				<td>
                    <a href="update?id=${nb.notice_id}" type="button" class="updateBtn">수정</a>
                    <a href="delete?id=${nb.notice_id}" type="button" class="deleteBtn">삭제</a>
                    <input type="button" class = "backBtn" id = "backBtn" onclick = "backBtn()" value="목록" >   
                </td>
			</tr>
		</table>
	</div>
</body>
</html>