<%--
	0. 공지사항 리스트를 확인할 수 있는 관리자가 아닌 일반 사용자용 페이지 입니다.
	1. 공지사항을 작성한 관리자 이름, 제목, 작성일, 조회수를 확인할 수 있습니다.
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항</title>
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/noticeList.css" type = "text/css">
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
				<caption>공지사항</caption>
				<thead>
					<tr>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="notice" items="${totallist}">
						<tr>
							<td>${notice.name}</td>
							<td>
							<a href="notice/detail?id=${notice.notice_id}" class="noticeDetail">
								<c:if test="${notice.title.length()>=20 }">
									<c:out value="${notice.title.substring(0,20 )}..." />
									</c:if> 
										
								<c:if test="${notice.title.length()<20 }">
									<c:out value="${notice.title}" />
								</c:if>
							</a>
							</td>
							<td>${notice.register_date }</td>
							<td>${notice.readcount }</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</c:if>
		
		<%-- 게시글이 없는 경우 --%>
		<c:if test="${listcount == 0 }">
			<h3 style="text-align:center">등록된 글이 없습니다.</h3>
		</c:if>
		
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
</body>
</html>