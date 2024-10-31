<%--
	0. faq 첫 페이지이자 결제 및 환불 탭을 눌렀을 때 나오는 페이지
	1. href에 들어갈 경로명을 지정해야 합니다.
		-frontcontroller에서 해당 경로 명을 받으면 서블렛으로 이동하고 서블렛에서 해당jsp로 연결되도록 합니다.
	2. class="accordion"은 foreach문으로 faq 테이블에 있는 모든 title, content르 받아 title을 클릭하면 content
		가 보이도록 합니다.
	3. 관리자 모드일 때만 글쓰기 버튼이 보이도록 버튼을 추가하려면 하고 그러면 글쓰기 폼을 만들어야 하고
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src = "${pageContext.request.contextPath}/js/list.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
</style>
<script>
	//search 버튼을 눌렀을 때 글 제목, 내용을 가진 게시글이 나올 수 있도록

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
  		
  		/*
  		$("div > a").click(function(event){
			const answer = confirm("정말 삭제하시겠습니까?");
			console.log(answer);//취소를 클릭한 경우-false
			if (!answer){//취소를 클릭한 경우
				event.preventDefault(); //이동하지 않습니다.	
			}
		})//삭제 클릭 end
		*/
	});

</script>

</head>
<body>
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
			<c:if test="${id=='admin'}">
				<a href="delete?id=${f.faq_id}">삭제</a>
				<a href="update?id=${f.faq_id}">수정</a>
			</c:if>
		</div>
	</c:forEach>
	 --%>
	<button class="accordion">매치신청 취소를 하고 싶어요</button>
		<div class="panel">
  			<p>jhl</p>
		</div>
		
		
	<button class="accordion">비나 눈이 와도 매치가 진행되나요?</button>
		<div class="panel">
  			<p>비나 눈이 와도</p>
		</div>

	<button class="accordion">인원이 채워지지 않으면 경기가 취소 되나요?</button>
		<div class="panel">
  			<p>부족한 인원</p>
		</div>
	
	<button class="accordion">날짜를 잘못 신청해서 취소하고 싶어요</button>
		<div class="panel">
  			<p>잘못된 날짜</p>
		</div>
		
	<button class="accordion">환불하고 싶어요</button>
		<div class="panel">
  			<p>환불신청</p>
		</div>
		
	
	<%--
	관리자만 볼 수 있는 글쓰기 버튼
	<c:if test="${id=='admin'}">
		<button type="button" class="btn btn-info float-right">글 쓰 기</button>
	</c:if>
	
	
	js/list.js에서 
		$(function(){
			$("button").click(function(){
				location.href="write";
			})
		})로 하고 FaqFrontController에 /write case추가해서 글쓰기 기능 추가 가능
	 --%>
	
</body>
</html>