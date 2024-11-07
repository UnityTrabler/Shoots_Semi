<%--
	0. 공지사항을 확인, 수정, 삭제, 추가 할 수 있는 관리자 페이지 입니다.
	1. 삭제 버튼을 클릭할 경우 confirm을 확인 하면 삭제 됩니다.
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
 <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
 <link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeAdmin.css" type = "text/css">
  <link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/pagination.css" type = "text/css">
<jsp:include page="../user/top.jsp"></jsp:include>
<title>공지사항 관리(관리자 모드)</title>

<script>
	$(function(){
		$("tr > td:nth-child(5) > a").click(function(event){
			const answer = confirm("정말 삭제하시겠습니까?");
			console.log(answer);//취소를 클릭한 경우-false
			if (!answer){//취소를 클릭한 경우
				event.preventDefault(); //이동하지 않습니다.	
			}
		})//삭제 클릭 end
	})
	
</script>
</head>
<body>
	<div class="container">
		
		<c:if test="${listcount > 0 }">
			<table class="table">
				<caption>공지사항 관리</caption>
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
					<tr>
						<td colspan="5" style="text-align:center;">
							<a href="write" type="button" class="btnWrite">글 쓰 기</a>
						</td>
					</tr>
				</tbody>
			</table>
		</c:if>
		<%-- 게시글이 없는 경우 --%>
		<c:if test="${listcount == 0 }">
			<h3 style="text-align:center">등록된 글이 없습니다.</h3>
			<a href="write" type="button" class="btnWrite">글 쓰 기</a>
		</c:if>
		
		<%--페이징 --%>
		<div class = "center-block">
				<ul class = "pagination justify-content-center">
					<li class = "page-item">
						<a ${page > 1 ? 'href = noticeAdmin?page=' += (page - 1) : '' }
							class = "page-link ${page <= 1 ? 'gray' : '' }">
							&lt;&lt;
						</a>
					</li>
					<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
						<li class = "page-item ${a == page ? 'active' : '' }">
							<a ${a == page ? '' : 'href = noticeAdmin?page=' += a }
								class = "page-link">${a}</a>
						</li>
					</c:forEach>
					<li class = "page-item">
						<a ${page < maxpage ? 'href = noticeAdmin?page=' += (page + 1) : '' }
							class = "page-link ${page >= maxpage ? 'gray' : '' }">
							&gt;&gt;
						</a>
					</li>
				</ul>
			</div>
			<%--페이징 끝 --%>
	</div>
</body>
</html>