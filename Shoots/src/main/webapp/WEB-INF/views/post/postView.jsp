<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../user/top.jsp"></jsp:include>
<meta charset="UTF-8">
<title>post - view</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/view.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/view.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src = "https://code.jquery.com/jquery-3.7.1.js"></script>
	
</head>
<body>
<input type="hidden" id="loginid" value="${id}" name="loginid"> <!-- 수정 삭제 버튼 보이게 하려고 현재 로그인 한 유저의 id값을 받아놓음 -->


<input type="hidden" value="${postdata.post_id}" id="post_id" name="post_id">  <!-- 댓글 삭제한 뒤 다시 글로 돌아오게 하기 위해 글 번호값을 받아둠 -->
	<%-- view.js에서 사용하기 위해 추가 --%>
	<div class="container">
		<!-- 게시글 정보 -->
		<table class="table">
			<!-- 게시글 정보 표시 -->
			<tr>
				<!-- 글제목, 아래줄에 작성자, 글작성시간, 조회수 -->
				<td colspan="2"><div class="title"><c:out value="${postdata.title}" />
				
				</div>
				<span class= "user_id">${postdata.user_id}</span>
				<span class= "register_date" style="margin-left: 30px;">${postdata.register_date}</span>
				<span class= "readcount" style="margin-left: 30px;">조회수&nbsp; ${postdata.readcount}</span>
				
				<div style="float:right"><jsp:include page="/WEB-INF/views/report/postReport.jsp" /></div>
				</td>
			</tr>
			
			
			<%-- 파일첨부 --%>
				<%-- 원문글인 경우에만 첨부파일을 추가 할 수 있습니다. --%> 
			<%-- 파일을 첨부하지 않은경우엔 아예 태그가 사라져 파일이 보일 칸이 사라짐 --%>
				<%-- 파일을 첨부한 경우 --%>
			<c:if test="${!empty postdata.post_file}">
			<tr>
				<td><img src="${pageContext.request.contextPath}/postupload/${postdata.post_file}" style= "width : 300px">
				<br><a href="down?filename=${postdata.post_file}">${postdata.post_file}</a>
			</tr>
			</c:if>
			
			<%-- 파일을 첨부하지 않은 경우 
			<c:if test="${empty postdata.post_file}">
				<td></td>
			</c:if>  </c:if> --%>
			
			
			<%-- 내용 --%>
			<tr>
				<td style="padding-right: 0px">
						<%-- <c:out value="${postdata.content}" /> --%>
						<pre>${postdata.content}</pre>
				</td>
			</tr>
			
			
			<!-- 중고게시판은 가격 -->
			<c:if test="${postdata.category=='B'}">
			<tr>
				<td>가격: &nbsp; <c:out value="${postdata.price}" />원</td>
				
			</tr>
			</c:if>
			
			
			
			<tr>
				<td colspan="2" class="center">
				<%--수정, 삭제 버튼은 로그인 한 유저의 아이디 = 글 작성자 일때 혹은 id가 관리자 일때만 보이게 함 --%>
					 <c:if test="${postdata.writer == idx || id == 'admin' }"> 
						<a href="modify?num=${postdata.post_id}">
							<button class="modifyBtn">수정</button>
						</a>
						<%-- href의 주소를 #으로 설정합니다.<a href="#">--%>
							<button class="deleteBtn" id="delete-post-btn">삭제</button>
						<%--</a>--%>
					 </c:if> 
					<a href="list">
						<button class="listBtn">목록</button>
					</a>
				</td>
			</tr>
		</table>
		
		
		
		
		<%-- 댓글창 --%>
		<div class="comment-area">
			<div class="comment-head">
				<h3 class="comment-count">
					댓글 <sup id="count"></sup><%--superscript(윗첨자) --%>
				</h3>
				<div class="comment-order">
					<ul class="comment-order-list">
					</ul>
				</div>
			</div><%-- comment-head end --%>
			
			<ul class="comment-list">
			</ul>
			<div class="comment-write">
				<div class="comment-write-area">
					<b class="comment-write-area-name" >${id}</b>
						<span class="comment-write-area-count">0/200</span>
					<textarea placeholder="댓글을 남겨보세요" rows="1"
				class="comment-write-area-text" maxLength="200"></textarea>
				
				</div>
				<div class="register-box">
					<div class="button btn-cancel">취소</div> <%-- 댓글의 취소는 display:none, 등록만 보이도록 --%>
					<div class="button btn-register">등록</div>
				</div>
			</div> <%-- comment-write end --%>
	</div>	<%-- comment-area end --%>
		
		
		
		</div>
		<%-- <div class="container"> 게시판 view end --%>
		
		<!-- 모달창 시작-->		
	<div class="modal c-report-modal fade" style="display:none">
		 <div class="modal-dialog" role="document">
	        <div class="modal-content"> <!-- 모달 내용으로 포함시킬 부분 -->
	        
	        <form action ="${pageContext.request.contextPath}/report/add" method="post" name="reportform" id="reportform">
	        	<h1 style="text-align:center;">댓글 신고</h1>
	        	<br>
	        	<input type="hidden" name="report_type" class="report_type" value="B"> <!-- 신고유형 분류, 게시글은 A, 숨겨둠. -->
	        	<input type="hidden" name="reporter" class="reporter" value="${idx}"> <!-- 신고자, 로그인 한 아이디로 가져옴. 회원 번호(idx)로 저장 -->
	        	<input type="hidden" name="target" class="target" value=""> <!-- 신고당하는 사람, view에서 데이터 가져왔을때 그 객체에서 .idx 뽑아와야함-->
	        	<input type="hidden" name="report_ref_id" class="report_ref_id" value=""> <!-- 참조할 번호. A면 postid, B면 commentid, C면 matchid-->
	        	<input type="hidden" name="post_id" class="post_id" value="${postdata.post_id}"> <!--신고할때 게시글 번호 가져가려고 값 저장해두는 postid -->
	        	
	        	
	        	<p>
	        	<span class="redColor">★</span>신고사유</p>
	        	
	        	<!-- 신고사유 선택 = report: title 부분 -->
	        	<div id="title"> <!-- select는 중앙으로 정렬이 안돼서 부모요소로 div 써둠 -->
				<select name="title" required>
					<option disabled selected hidden value="">신고 사유를 선택해 주세요</option>
					<option value="욕설, 혐오 표현 등이 포함된 댓글">욕설, 혐오 표현 등이 포함된 댓글</option>
					<option value="갈등 조장하는 댓글">갈등 조장하는 댓글</option>
					<option value="게시글과 관계 없는 내용">게시글과 관계 없는 내용</option>
					<option value="도배 목적의 댓글">도배 목적의 댓글</option>
					<option value="성적 컨텐츠가 포함된 댓글">성적 컨텐츠가 포함된 댓글</option>
					<option value="직접 입력">직접 입력</option>
				</select>
				</div>
				
				<br>
				<div id="content"> <!-- textarea는 속성으로 중앙에 위치시킬 수 없어서 부모요소로 쓴 div -->
					<textarea placeholder ="&nbsp;&nbsp;내용을 작성해 주세요." maxlength="300" name="content" required></textarea>
				</div>
				
				<br>
				
				<div id="reportbutton">
					<button class="btn btn-danger">신고하기</button>
				</div>
				
				</form>
				
			</div> <!-- modal-content -->
		</div> <!-- modal-dialog -->
	</div> <!-- 모달창 끝 -->
	
	<script>
		$(function(){
			$('#delete-post-btn').click(function(){
				if (confirm("게시글을 삭제하시겠습니까?")) {
					$.ajax({
						type: "POST", 
						url: "delete?num=${postdata.post_id}", 
						success: function(response) {
							alert("삭제되었습니다."); 
							location.href = "../post/list"; 
						},
						error: function() {
							alert("삭제 실패. 다시 시도해주세요.");
						}
					});
				}
			});
		})
		
	<%--js에서 contextPath를 직접 선언할 수 없기에 jsp에서 선언하기 위해 있는 부분 --%>
	const contextPath = "${pageContext.request.contextPath}";
		
	</script>
</body>


</html>