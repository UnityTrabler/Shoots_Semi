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
<title>FAQ 관리(관리자모드)</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
	table{
		text-align: center;
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
	})
	
</script>

</head>
<body>
<div class="container">
	<h1>FAQ 관리</h1>
	<table class="table table-striped">
		
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
					<a href="detail?id=${f.faq_id}">${f.title}</a>
					</td>
					
					<td>${f.register_date}</td>
					<td><a href="update?id=${f.faq_id}">수정</a></td>
					<td><a href="delete?id=${f.faq_id}">삭제</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="write">
		<button type="button" class="btn btn-info float-right">글 쓰 기</button>
	</a>
</div>
</body>
</html>