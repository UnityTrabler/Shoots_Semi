<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자 전용 문의 게시판</title>
<jsp:include page = "/WEB-INF/views/user/top.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiryDetail.css" type="text/css">

<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/js/inquiryJs/inquiryview.js"></script>

</head>
<body>

<input type="hidden" value="${id}" id="loginid">  <!-- 수정 삭제 버튼 보이게 하려고 현재 로그인 한 유저의 id값을 받아놓음 -->
<input type="hidden" value="${inquirydata.inquiry_id}" id="inquiryid">  <!-- 댓글 삭제한 뒤 다시 문의글로 돌아오게 하기 위해 문의글 번호값을 받아둠 -->
	<%--view.js에서 사용하기 위해 추가 --%>
	<div class="container">
		<table class="table">
				<tr>
					<th colspan="3" style="text-align:center">1:1 문의 게시판</th>
				</tr>
				
					<%--문의글 제목 --%>
				<tr>
					<th colspan="3">&nbsp<c:out value = "${inquirydata.title}"/></th>
				</tr>
				<tr>
					<td><div>문의자: 
					
					<c:choose>
			            <c:when test="${inquirydata.inquiry_type eq 'A'}">
			                ${inquirydata.user_id}</div></td>
			            </c:when>
			            <c:when test="${inquirydata.inquiry_type eq 'B'}">
			                ${inquirydata.business_id}</div></td>
			            </c:when>
			        </c:choose>
					
					<td>문의 날짜: ${inquirydata.register_date.substring(0,16)}</td>
				</tr>
				<tr>
					<td colspan="2" style ="padding-right:0px">
						<textarea class="form-control" rows="5"
						 readOnly>${inquirydata.content}</textarea></td>
				</tr>
				
				<tr>
					<td><div>첨부파일</div></td>
					
					<%--파일 첨부한 경우 --%>
					<c:if test="${!empty inquirydata.inquiry_file}">
						<td><img src="${pageContext.request.contextPath}/img/down.png" id="downImg" width="10px">
							<a href="down?filename=${inquirydata.inquiry_file}">${inquirydata.inquiry_file}</a></td>
					</c:if>
					
					
					<%--파일 첨부 안한경우 --%>
					<c:if test="${empty inquirydata.inquiry_file}">
						<td></td>
					</c:if>
				</tr>
			
			<tr>
				<td colspan="2" class="center">
					<%--관리자 페이지는 수정삭제 버튼 다 보임 --%>
						<a href="../inquiry/modify?inquiryid=${inquirydata.inquiry_id}">
							<button class="btn btn-info updateBtn">수정</button>
						</a>
						
						<a href ="../inquiry/delete?num=${inquirydata.inquiry_id}">
							<button class="btn btn-danger" data-toggle="modal"
								data-target="../#myModal" id="inquiryDelete">삭제</button>
						</a>
					
						<%--관리자가 목록 버튼 누르면 관리자 전용 리스트로, 일반회원은 개인 문의글 리스트 경로로 이동 --%>
							<c:choose>
							    <c:when test="${role == 'admin'}">
							        <a href="../admin/mypage">
							            <button class="btn btn-warning listBtn">목록</button>
							        </a>
							    </c:when>
							    <c:otherwise>
							        <a href="list">
							            <button class="btn btn-warning listBtn">목록</button>
							        </a>
							    </c:otherwise>
							</c:choose>
							
					</td>
				</tr>
			</table>
		</div>
	<%--<div class="container"> end --%>
	
	
	 <!-- 댓글 리스트 출력 -->
    <div class="comments-section">
        
        <c:if test="${!empty iqlist}">
            <c:forEach var="ic" items="${iqlist}">
                <div class="ic">
                
                	<input type="hidden" value="${ic.i_comment_id}" name = "i_comment_id" class="ic-num">  <!-- 문의댓글의 고유번호값 받아두기 -->
                	
                	<!-- 프로필 사진 -->
                	<img src ="${pageContext.request.contextPath}/img/profile.png" alt="프로필" width="60" height="48">
                	
                	<input type="hidden" value="${ic.user_id}" class="iqcomment-writer"> <!-- 각 문의댓글을 남긴 댓글 작성자 값 -->
                	<div class="buttonfront">
                    <p><strong>작성자:</strong> ${ic.user_id} <strong>등록일:</strong> ${ic.register_date.substring(0,16)}
                    </div>
                    <button type="button" class="btn btn-primary ic-modify" style="display:none" value="${ic.i_comment_id}">수정</button>
                    <button type="button" class="btn btn-danger ic-delete" style="display:none" value="${ic.i_comment_id}">삭제</button>
                    </p>
                    <span class="iqcomment-content">${ic.content}</span>
                </div>
                <hr>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty iqlist}">
            <p>아직 관리자의 답변이 없습니다.</p>
        </c:if>
    </div>
	
<!-- 댓글 폼 시작. 댓글 작성은 관리자만 가능 (role == admin) -->
<c:if test="${role == 'admin'}">
<form action="../iqcomments/add" method ="post" name = "iqcommentform" id="iqcommentform">
	<div class="comment-head">
	</div>
	
	<!-- 댓글 내용 부분 -->
	<div class="comment-body">
		<input type="hidden" name="inquiry_id" value="${inquirydata.inquiry_id}">
		<img src ="${pageContext.request.contextPath}/img/profile.png" alt="프로필" width="60" height="48">
		
		<div class="nickname">
		<input type="hidden" class ="nickname" name="writer" value="${idx}"> <!-- 댓글 작성자의 로그인id :int형, idx 가져옴. -->
		<span class="nickname">${id}</span>  <!-- 댓글 작성자의 닉네임 : 로그인 한 유저 닉네임 -->
		</div>
		
		
		<textarea placeholder = "문의글에 대한 답변을 남겨보세요" width="1200" class="iqcomment-content" name="content" maxlength="300" required></textarea>		
		
		<div class="register-box">
			<button class="btn-primary" id="register-comment">등록</button>
			<button class="btn-danger" id="cancel-comment" style="display:none">취소</button>
		</div>
		
	</div>
</form>
</c:if>
	
<script>

<%--js에서 contextPath를 직접 선언할 수 없기에 jsp에서 선언하기 위해 있는 부분 --%>
const contextPath = "${pageContext.request.contextPath}";
</script>
</body>
</html>