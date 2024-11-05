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
	<jsp:include page="../user/top.jsp"></jsp:include>
<title>FAQ</title>
<style>
.accordion {
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 50%;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
  margin: 0 auto;
}

.panel {
  padding: 0 18px;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
  margin: 0 auto;
  width: 50%; 
}

.active{
	border: 1.5px dashed #059669;
}

.accordion:after {
  content: '\25BC'; /* Unicode character for right arrow (→) */
  font-size: 20px;
  color: #059669;
  position: absolute; /* 절대 위치로 설정 */
  right: 10px;  /* 오른쪽 끝에 배치 */
  top: 50%;  /* 수직 가운데 정렬 */
  transform: translateY(-50%); /* 정확한 수직 중앙 정렬 */
}

.accordion.active:after {
  content: '\25B2'; /* Unicode character for downwards arrow (↓) */
}

h1{
	text-align:center;
	
}

#downImg{
	width : 10px
}
</style>
<script>

	$(document).ready(function(){
  		$(".accordion").on("click", function() {
    		$(this).toggleClass("active");
    		var panel = $(this).next(".panel");
    
    		if (panel.css("max-height") !== "0px") {
     			panel.css("max-height", "0");
    		} else {
     			 panel.css("max-height", panel.prop("scrollHeight") + "px");
    		}
  		});
	});

</script>

</head>
<div class = "imgb">
		<div class = "imgL">
			<img  class = "Limg" src = "${pageContext.request.contextPath}/img/matchL.jpg">
			<div class="overlay">
				<p class = "p1"> 언제, 어디서나 빠르고 간편한 매칭을 원한다면? </p>
				<p class = "imgP2 p1"> SHOOT MATCHING ! </p>
				<p> 지금 가입해서 즐겨보세요 </p>
			</div>
		</div>
	</div>
<body>
	<h1>FAQ</h1>
	 <c:forEach var="f" items="${totallist}">
		<div class="faqlist">
			<button class="accordion">${f.title}</button>
				<div class="panel">
				<br>
  					<p>${f.content}</p>
  					<%--파일을 첨부한 경우 --%>
					<c:if test="${!empty f.faq_file}">
						<p><img src="${pageContext.request.contextPath}/img/down.png" id="downImg">
							<a href="down?filename=${f.faq_file}">${f.faq_file}</a></p>
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