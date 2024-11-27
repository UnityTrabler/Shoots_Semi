<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>문의 게시판</title>
<jsp:include page = "/WEB-INF/views/user/top.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/inquiry.css" type="text/css">
<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/js/inquiryJs/inquiryview.js"></script>
<style>
/* Flex 컨테이너 설정 */
.buttonfront {
    display: flex;
    justify-content: space-between; /* 양 끝 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
    padding: 10px 0; /* 상하 여백 */
    border-bottom: 1px solid #ddd; /* 구분선 추가 (옵션) */
}

/* 텍스트 스타일 */
.info-text {
    font-size: 12px;
    margin: 0; /* p 태그의 기본 여백 제거 */
    color: #333; /* 텍스트 색상 */
}

/* 버튼 그룹 */
.action-buttons {
    display: flex;
    gap: 10px; /* 버튼 간격 */
}

.ic-modify, .ic-delete {
    font-size: 12px;
    border-radius: 5px;
    padding: 5px 10px;
    border: none;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.ic-modify {
    background-color: #1d4ed8; /* 수정 버튼 색상 */
}

.ic-modify:hover {
    background-color: #2563eb; /* 수정 버튼 hover 색상 */
}

.ic-delete {
    background-color: #be123c; /* 삭제 버튼 색상 */
}

.ic-delete:hover {
    background-color: #dc2626; /* 삭제 버튼 hover 색상 */
}

</style>
</head>
<body>
<input type="hidden" value="${id}" id="loginid">  <!-- 수정 삭제 버튼 보이게 하려고 현재 로그인 한 유저의 id값을 받아놓음 -->
<input type="hidden" value="${inquirydata.inquiry_id}" id="inquiryid">  <!-- 댓글 삭제한 뒤 다시 문의글로 돌아오게 하기 위해 문의글 번호값을 받아둠 -->
	<%--view.js에서 사용하기 위해 추가 --%>
	<div class="containerI">
		<table class="table tableV">
				
				<%--문의글 제목 --%>
				<tr>
					<th colspan="3" style="font-size:20px; text-align : left"><c:out value = "${inquirydata.title}"/></th>
				</tr>
				
				<tr>
					<td style = "text-align : left"><div>문의자 : ${inquirydata.user_id}</div></td>
					<td>문의 날짜 : ${inquirydata.register_date.substring(0,16)}</td>
				</tr>
				
				<tr>
					<td colspan="2" style ="padding-right:0px">
					<div class = "contentT" style="display:fixed">
						<pre>${inquirydata.content}</pre>
					</div>
					</td>
				</tr>
				
				<tr>
					<td colspan = "2" style = "text-align : left"> 첨부파일 &nbsp;
					
					<%--파일 첨부한 경우 --%>
					<c:if test="${!empty inquirydata.inquiry_file}">
							<a href="down?filename=${inquirydata.inquiry_file}">
							<img src="${pageContext.request.contextPath}/img/down.png" class="downImg">
							${inquirydata.inquiry_file}</a>
					</c:if>
					
					
					<%--파일 첨부 안한경우 --%>
					<c:if test="${empty inquirydata.inquiry_file}">
					</c:if>
					</td>
				</tr>
			</table>
			<hr>
	 <!-- 댓글 리스트 출력 -->
    <div class="comments-section">
        <c:if test="${!empty iqlist}">
            <c:forEach var="ic" items="${iqlist}">
                <div class="ic">
                
                	<input type="hidden" value="${ic.i_comment_id}" name = "i_comment_id" class="ic-num">  <!-- 문의댓글의 고유번호값 받아두기 -->
                	
                	<!-- 프로필 사진 -->
                	<img src ="${pageContext.request.contextPath}/img/info.png" alt="프로필" style = "width :35px; height : 35px">
                	
                	<input type="hidden" value="${ic.user_id}" class="iqcomment-writer"> <!-- 각 문의댓글을 남긴 댓글 작성자 값 -->
                	<div class="buttonfront">
					    <p class="info-text">
					        <strong>작성자:</strong> ${ic.user_id} 
					        <strong>등록일:</strong> ${ic.register_date.substring(0,16)}
					    </p>
					    <div class="action-buttons">
					        <button type="button" class="btn btn-primary ic-modify" style="display:none" value="${ic.i_comment_id}">수정</button>
					        <button type="button" class="btn btn-danger ic-delete" style="display:none" value="${ic.i_comment_id}">삭제</button>
					    </div>
					</div>

                    <span class="iqcomment-content" style = "font-size : 13px">${ic.content}</span>
                </div>
                <hr>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty iqlist}">
        	<div class = "comD">
            	<p class = "comP">아직 관리자의 답변이 없습니다.</p>
            </div>
            <br>
        </c:if>
    </div>
		
	<!-- 댓글 폼 시작. 댓글 작성은 관리자만 가능 (role == admin) -->
	 <c:if test="${role == 'admin'}">
	  <form action="../iqcomments/add" method ="post" name = "iqcommentform" id="iqcommentform"
  		style="margin-top: 0; padding: 10px; background-color: #f9f9f9;
 		border: 1px solid #ddd; border-radius: 5px;">
		<div class="comment-head">
		</div>
		
		<!-- 댓글 내용 부분 -->
		<div class="comment-body">
			<input type="hidden" name="inquiry_id" value="${inquirydata.inquiry_id}">
			<img src ="${pageContext.request.contextPath}/img/info.png" alt="프로필" width="60" height="48">
			
			<div class="nickname">
			<input type="hidden" class ="nickname" name="writer" value="${idx}"> <!-- 댓글 작성자의 로그인id :int형, idx 가져옴. -->
			<span class="nickname">${id}</span>  <!-- 댓글 작성자의 닉네임 : 로그인 한 유저 닉네임 -->
			</div>
			
			
			<textarea placeholder = "문의글에 대한 답변을 남겨보세요" class="iqcomment-content" name="content" maxlength="300" required></textarea>		
			
			<div class="register-box">
				<button class="btn-primary" id="register-comment">등록</button>
				<button class="btn-danger" id="cancel-comment" style="display:none">취소</button>
			</div>
			
		</div>
	  </form>
	 </c:if>
	 
			<%--수정, 삭제 버튼은 로그인 한 유저만 보이게 함. 관리자도 안보임 --%>
			<div class = "btnD">
				<c:if test="${inquirydata.inquiry_ref_idx == idx}">
					<c:choose>
					<c:when test="${!inquirydata.hasReply}">
						<a href="modify?inquiryid=${inquirydata.inquiry_id}">
							<button class="btn btn-info updateBtn">수정</button>
						</a>
					</c:when>
						<c:otherwise>
							<button class="btn btn-info updateBtn" style="display:none">수정</button>
						</c:otherwise>
					</c:choose>
					<%--href의 주소를 #으로 설정함. --%>
					<a href ="#">
						<button class="btn deleteBtn" data-toggle="modal"
							data-target="#myModal" id="inquiryDelete">삭제</button>
					</a>
				</c:if>
				
					<%--관리자가 목록 버튼 누르면 관리자 전용 리스트로, 일반회원은 개인 문의글 리스트 경로로 이동 --%>
				<c:choose>
				    <c:when test="${role == 'admin'}">
				        <a href="../admin/mypage">
				            <button class="btn listB listBtn">목록</button>
				        </a>
				    </c:when>
				    <c:otherwise>
				        <a href="../customer/support">
				            <button class="btn listB">목록</button>
				        </a>
				    </c:otherwise>
				</c:choose>
			</div>

	
	
</div>
<script>
const inquiryid = $('#inquiryid').val(); 

$('#inquiryDelete').click(function(){ //문의글 삭제 버튼 누르면 삭제하는 메서드
	if (confirm("문의글을 삭제하시겠습니까?")) {
		$.ajax({
			type: "POST", 
			url: "delete?num=" + inquiryid, 
			success: function(response) {
				alert("삭제되었습니다."); 
				location.href = "../customer/support"; 
			},
			error: function() {
				alert("삭제 실패. 다시 시도해주세요.");
			}
		});
	}
}); 
<%--js에서 contextPath를 직접 선언할 수 없기에 jsp에서 선언하기 위해 있는 부분 --%>
const contextPath = "${pageContext.request.contextPath}";
</script>
</body>
</html>