<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
 <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
 <link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeAdmin.css" type = "text/css">
<jsp:include page="../user/top.jsp"></jsp:include>
<title>공지사항 관리(관리자 모드)</title>

<style>
	th:nth-child(2), th:nth-child(3), th:nth-child(4){
		text-align:center;
	}
	td:nth-child(2), td:nth-child(3), td:nth-child(4){
		text-align:center;
	}
	.noticeDetail {text-decoration: none; color : black}
	.noticeDetail:hover {text-decoration: none; font-weight : bold; color : #059669}
	
	.noticeUpdate {text-decoration: none; font-size : 15px; border-radius : 10px; border : none; width : 50px; height : 23px; text-align: center; color : white ; background : #1d4ed8; transition: background 0.3s, color 0.3s; }
	.noticeUpdate:hover {text-decoration: none; font-size : 15px; border : 1px solid #1d4ed8; border-radius : 10px; width : 50px; height : 23px; text-align: center; color : #1d4ed8 ; background : white}
	
	.noticeDelete {text-decoration: none; font-size : 15px; border-radius : 10px; border : none; width : 50px; height : 23px; text-align: center; color : white ; background : #be123c; transition: background 0.3s, color 0.3s; }
	.noticeDelete:hover {text-decoration: none; font-size : 15px; border : 1px solid #be123c; border-radius : 10px; width : 50px; height : 23px; text-align: center; color : #be123c ; background : white}
	 
</style>
 
<script>
	$(function(){
		$("tr > td:nth-child(5) > a").click(function(event){
			const answer = confirm("정말 삭제하시겠습니까?");
			console.log(answer);//취소를 클릭한 경우-false
			if (!answer){//취소를 클릭한 경우
				event.preventDefault(); //이동하지 않습니다.	
			}
		})//삭제 클릭 end
		
		$('.btnWrite').click(function(){
			location.href="write";
		})
		
		
	})
	
</script>

</head>
<body>
	<div class="container">
		<h1>공지사항 관리</h1>
		<c:if test="${listcount > 0 }">
			<table class="table">
				<thead>
					<tr>
						<th>제목</th>
						<th>조회수</th>
						<th>등록일</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="notice" items="${totallist}">
						<tr>
							<td>
								<a href="adminDetail?id=${notice.notice_id}" class="noticeDetail">${notice.title}</a>
							</td>
							<td>${notice.readcount }</td>
							<td>${notice.register_date}</td>
							<td><a href="update?id=${notice.notice_id}" type="button" class="noticeUpdate">수정</a></td>
							<td><a href="delete?id=${notice.notice_id}"  type="button" class="noticeDelete">삭제</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		<%-- 게시글이 없는 경우 --%>
		<c:if test="${listcount == 0 }">
			<h3 style="text-align:center">등록된 글이 없습니다.</h3>
		</c:if>
		
			<div class="btnD">
				<button type="button" class="btnWrite">글 쓰 기</button>
			</div>
	</div>
</body>
</html>