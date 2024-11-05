<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%--
0. FAQ 관리자 모드는 관리자로 로그인 했을 때 마이페이지를 통해 들어올 수 있습니다
경로 지정은 마이페이지가 있는 jsp에서 해주세요
경로명 :  ${pageContext.request.contextPath}/faq/faqAdmin
1. faq 테이블에 저장되어 있는 faq 내용을 모두 가져옵니다.
2. 해당 페이지에서 수정, 삭제, 추가 관리를 할 수 있습니다.
3. 보기 쉽게 일단 memberList.css를 가져왔습니다.
 --%>
 <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/faqAdmin.css" type = "text/css">
	<jsp:include page="../user/top.jsp"></jsp:include>
<title>FAQ 관리(관리자모드)</title>

<style>
	th:nth-child(2), th:nth-child(3), th:nth-child(4){
		text-align:center;
	}
	td:nth-child(2), td:nth-child(3), td:nth-child(4){
		text-align:center;
	}
</style>

<script>
	$(function(){
		$("tr > td:nth-child(4) > a").click(function(event){
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
	<h1>FAQ 관리</h1>
	<table class="table">
		
		<thead>
			<tr>
				<th>제목</th>
				<th>등록일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="f" items="${totallist}">
				<tr>
					
					<td>
					<a href="detail?id=${f.faq_id}" class="faqDetail">${f.title}</a>
					</td>
					
					<td>${f.register_date}</td>
					<td><a href="update?id=${f.faq_id}" type="button" class="faqUpdate">수정</a></td>
					<td><a href="delete?id=${f.faq_id}"  type="button" class="faqDelete">삭제</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		<div class="btnD">
			<button type="button" class="btnWrite">글 쓰 기</button>
		</div>
</div>
</body>
</html>