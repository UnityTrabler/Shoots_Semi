<%--
	0. faq 첫 페이지이자 결제 및 환불 탭을 눌렀을 때 나오는 페이지
	1. 이동지정 경로명은 /faq/* 입니다.
	2. class="accordion"은 foreach문으로 faq 테이블에 있는 모든 title, content를 받아 title을 클릭하면 content가 보이도록 합니다.
	3. 관리자모드(user_id = 'admin')일 때에만 '수정', '삭제', '글쓰기' 버튼이 보입니다.(삭제)
	4. '삭제'버튼을 클릭할 경우 삭제를 확인하는 comfirm문이 나오고 확인을 누르면 삭제되고 취소를 누르면 삭제되지 않습니다.(삭제)
	
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/faqList.css" type = "text/css">

	<title>FAQ</title>
</head>

<body>
	<p class="faq">FAQ</p>
	 <c:forEach var="f" items="${totallist}">
		<div class="faqlist">
			<button class="accordion">${f.title}</button>
				<div class="panel">
				<br>
  					<p>${f.content}</p>
  					<%--파일을 첨부한 경우 --%>
					<c:if test="${!empty f.faq_file}">
						<p><img src="${pageContext.request.contextPath}/img/down.png" id="downImg">
							<a href="faq/down?filename=${f.faq_file}">${f.faq_file}</a></p>
					</c:if>
					
					<%--파일을 첨부하지 않은 경우 --%>
					<c:if test="${empty f.faq_file}">
						<p></p>
					</c:if>
				</div>
		</div>
		<br>
		<br>
	</c:forEach>
</body>
</html>