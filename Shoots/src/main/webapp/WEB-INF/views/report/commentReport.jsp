<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/js/report.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/report.css">


<title>신고창</title>
</head>
<body>
<button class ="push" data-toggle="modal" data-target=".report-modal">여기 누르면 모달 창이 뜸</button>

	<!-- 모달창 시작-->		
<div class="modal report-modal fade" style="display:none">
	 <div class="modal-dialog" role="document">
        <div class="modal-content"> <!-- 모달 내용으로 포함시킬 부분 -->
        	<h1 style="text-align:center;">댓글 신고</h1>
        	<br>
        	
        	<p>
        	<span>★</span>신고사유</p>
        	
        	<!-- 신고사유 선택 = report: title 부분 -->
        	<div id="title"> <!-- select는 중앙으로 정렬이 안돼서 부모요소로 div 써둠 -->
			<select>
				<option disabled selected hidden>신고 사유를 선택해 주세요</option>
				<option value="욕설, 혐오 표현 등이 포함된 댓글">욕설, 혐오 표현 등이 포함된 댓글</option>
				<option value="갈등 조장댓글">갈등 조장댓글</option>
				<option value="게시글과 관계 없는 내용">게시글과 관계 없는 내용</option>
				<option value="도배 목적 댓글">도배 목적 댓글</option>
				<option value="성적 컨텐츠가 포함된 댓글">성적 컨텐츠가 포함된 댓글</option>
			</select>
			</div>
			
			<br>
			<div id="content"> <!-- textarea는 속성으로 중앙에 위치시킬 수 없어서 부모요소로 쓴 div -->
				<textarea placeholder ="&nbsp;&nbsp;내용을 작성해 주세요." maxlength="300"></textarea>
			</div>
			
			<%--
			<br>
			
			<!-- 차단 여부 묻는 부분 -->
			<div style="display:flex;  align-items: center; margin-left:150px">
				<input type="checkbox" style="margin-right:10px">
				<p style="text-align:center; margin:0;">해당 댓글의 작성자를 <span>차단</span>할까요?<p>
			</div>
			--%>
			
			<br>
			
			<div id="reportbutton">
				<button class="btn btn-danger">신고하기</button>
			</div>
			
			
		</div> <!-- modal-content -->
	</div> <!-- modal-dialog -->
</div> <!-- 모달창 끝 -->


</body>
</html>