<%--
	0. faq 첫 페이지이자 결제 및 환불 탭을 눌렀을 때 나오는 페이지
	1. 이동지정 경로명은 /faq/* 입니다.
	2. class="accordion"은 foreach문으로 faq 테이블에 있는 모든 title, content를 받아 title을 클릭하면 content가 보이도록 합니다.
	3. 관리자모드(user_id = 'admin')일 때에만 '수정', '삭제', '글쓰기' 버튼이 보입니다.
	4. '삭제'버튼을 클릭할 경우 삭제를 확인하는 comfirm문이 나오고 확인을 누르면 삭제되고 취소를 누르면 삭제되지 않습니다.
	
	=============================================================================================
	
	5. 로그인 기능이 없어 admin이 아니어도 해당 내용을 확인할 수 있도록 설정했으며 admin일 경우는 주석처리 했습니다.
	6. <ul>안에 있는 다른 페이지로 이동과 검색 항목은 스토리보드에는 있었으나 구현 여부는 확실치 않아 경로 지정을 하지는 않았습니다.
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<title>FAQ</title>
<style>
.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}

.active, .accordion:hover {
  background-color: #ccc;
}

.panel {
  padding: 0 18px;
  background-color: white;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
}

h1{
	text-align:center;
	
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
  		
  		
  		$("div > a:nth-of-type(2)").click(function(event){
			const answer = confirm("정말 삭제하시겠습니까?");
			console.log(answer);//취소를 클릭한 경우-false
			if (!answer){//취소를 클릭한 경우
				event.preventDefault(); //이동하지 않습니다.	
			}
		})//삭제 클릭 end
		
	});

</script>

</head>
<body>
	<h1>FAQ</h1>
	<ul class="navbar-nav">
		<li class="nav-item">
			<%--(FAQ)결제 및 환풀 탭으로 이동 --%>
			<a class="nav-link"
				href="${pageContext.request.contextPath}/faq/결제 및 환불">결제 및 환불</a>
		</li>
			
		<li class="nav-item">
			<%--(FAQ)경기 진행 탭으로 이동 --%>
			<a class="nav-link"
				href="${pageContext.request.contextPath}/faq/경기 진행">경기 진행</a>
		</li>
			
		<li class="nav-item">
			<%--(FAQ)구장 및 구장서비스 탭으로 이동 --%>
			<a class="nav-link"
				href="${pageContext.request.contextPath}/faq/구장 및 구장서비스">구장 및 구장서비스</a>
		</li>
		
		<li class="nav-item">
			<%--(FAQ)매치 신청 탭으로 이동 --%>
			<a class="nav-link"
				href="${pageContext.request.contextPath}/faq/매치 신청">매치 신청</a>
		</li>
		<li class="nav-item">
			<input name="search_word" type="text" class="form-control"
					placeholder="글 제목, 내용 검색" value="${search_word}">
			<button class="btn btn-primary" type="submit">search</button>
		</li>
	</ul>
	
	
	
	<%-- 관리자만 볼 수 있는 수정, 삭제 버튼
	<c:forEach var="f" items="${totallist}">
		<div class="faqlist">
			<button class="accordion">${f.title}</button>
				<div class="panel">
  					<p>${f.content}</p>
				</div>
			<c:if test="${user_id=='admin'}">
				<a href="delete?id=${f.faq_id}">삭제</a>
				<a href="update?id=${f.faq_id}">수정</a>
			</c:if>
		</div>
	</c:forEach>
	 --%>
	 
	 <c:forEach var="f" items="${totallist}">
		<div class="faqlist">
			<button class="accordion">${f.title}</button>
				<div class="panel">
  					<p>${f.content}</p>
				</div>
				<a href="update?id=${f.faq_id}">수정</a>
				<a href="delete?id=${f.faq_id}">삭제</a>
				
		</div>
	</c:forEach>
	
	<button class="accordion">매치신청 취소를 하고 싶어요</button>
		<div class="panel">
  			<p>jhl</p>
		</div>
		
	<button class="accordion">환불하고 싶어요</button>
		<div class="panel">
  			<p>환불신청</p>
		</div>
		
	<a href="write">
		<button type="button" class="btn btn-info float-right">글 쓰 기</button>
	</a>
	
	<%--
	관리자만 볼 수 있는 글쓰기 버튼
	<c:if test="${id=='admin'}">
		<button type="button" class="btn btn-info float-right">글 쓰 기</button>
	</c:if>
	
	 --%>
	
</body>
</html>