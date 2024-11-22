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
 <link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeList.css" type = "text/css">

<title>공지사항 관리(관리자 모드)</title>


</head>
<body>
	<c:if test="${listcount > 0 }">
		<form id="filterForm" method="post">
			<div class="input-group">
				<input type="button" class = "filterButton" id = "filterButton" onclick = "applyFilter()" value="SERACH" >&nbsp;
				<input name="search_word" type="text" class="search"
					placeholder="  Search..." value="${search_word}">
			</div>
		</form>
		
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
							<a href="../notice/adminDetail?id=${notice.notice_id}" class="noticeDetail">
								<c:if test="${notice.title.length()>=20 }">
									<c:out value="${notice.title.substring(0,20 )}..." />
								</c:if> 
										
								<c:if test="${notice.title.length()<20 }">
									<c:out value="${notice.title}" />
								</c:if>
							</a>
						</td>
						<td>${notice.readcount }</td>
						<td>${notice.register_date}</td>
						<td><a href="../notice/update?id=${notice.notice_id}" type="button" class="noticeUpdate">수정</a></td>
						<td><a href="../notice/delete?id=${notice.notice_id}"  type="button" class="noticeDelete">삭제</a></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5" style="text-align:center;">
						<a href="../notice/write" type="button" class="btnWrite">글 쓰 기</a>
					</td>
				</tr>
			</tbody>
		</table>
		<%--페이징 --%>
		<div class = "center-block">
			<ul class = "pagination justify-content-center">
				<li class = "page-item">
					<a href="javascript:go_notice(${page - 1})"
						class = "page-link ${page <= 1 ? 'gray' : '' }">
						&lt;&lt;
					</a>
				</li>
				<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
					<li class = "page-item ${a == page ? 'active' : '' }">
						<a href="javascript:go_notice(${a})"
							class = "page-link">${a}</a>
					</li>
				</c:forEach>
				<li class = "page-item">
					<a href="javascript:go_notice(${page + 1})"
						class = "page-link ${page >= maxpage ? 'gray' : '' }">
						&gt;&gt;
					</a>
				</li>
			</ul>
		</div>
		<%--페이징 끝 --%>	
	</c:if>
	
	<%-- 게시글이 없는 경우 --%>
	<c:if test="${listcount == 0 }">
		<h3 style="text-align:center">등록된 글이 없습니다.</h3>
		<a href="../notice/write" type="button" class="btnWrite">글 쓰 기</a>
	</c:if>
</body>
</html>