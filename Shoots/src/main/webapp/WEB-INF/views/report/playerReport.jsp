<%@ page language="java" contentType="text/html; charset=UTF-8;"
    pageEncoding="UTF-8"%> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/js/report.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script> <!-- 모달창 쓰려면 필요한 스크립트 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/report.css">

<title>신고창</title>

</head>
<body>
<button class ="push" data-toggle="modal" data-target=".report-modal">여기 누르면 모달 창이 뜸</button>

	<!-- 모달창 시작-->		
<div id = "p-reportModal" class="modal p-report-modal fade" style="display:none">
	 <div class="modal-dialog" role="document">
        <div class="modal-content"> <!-- 모달 내용으로 포함시킬 부분 -->
        
        <form action ="${pageContext.request.contextPath}/report/add2" method="post" name="reportform">
        
        	<h1 style="text-align:center;">플레이어 신고</h1>
        	
        	<br>
        	<input type="text" name="report_type" class="report_type" value="C"> <!-- 신고유형 분류, 댓글은 B, 숨겨둠. -->
        	<input type="text" name="reporter" class="reporter" value="${idx}"> <!-- 신고자, 로그인 한 아이디로 가져옴 -->
        	<input type="text" name="target" class="target" value="${player.idx}"> <!-- 신고당하는 사람, detail?num에서 뽑아와야함-->
        	<input type="text" name="report_ref_id" class="report_ref_id" value="102"> <!-- 참조할 번호. A면 postid, B면 commentid, C면 matchid-->
        	
        	<!-- 플레이어1 구간 -->
			<div class="player" id="p1">
			<span>
			<img src="${pageContext.request.contextPath}/img/reportHuman.png" width="80px"/>
			<label><input type="radio" class="personchoice">
			<h4>1번 플레이어</h4> </label>
			</span>
			
			<select name="title" required>
				<option disabled selected hidden value="">신고 사유를 선택해 주세요</option>
				<option value="욕설, 모욕 등의 언어적 폭력행위">욕설, 모욕 등의 언어적 폭력행위</option>
				<option value="난폭한 플레이">난폭한 플레이</option>
				<option value="약속시간 미준수">약속시간 미준수</option>
				<option value="경기와 관계 없는 행위">경기와 관계 없는 행위</option>
				<option value="직접 입력">직접 입력</option>
			</select>
			<textarea placeholder ="&nbsp;&nbsp;내용을 작성해 주세요." maxlength="300" class="content" name="content" required></textarea>
			</div> <!-- 플레이어1 끝 -->
			
			
			<div id="reportbutton">
				<button class="btn btn-danger">신고하기</button>
			</div>
			
			</form>
			
		</div> <!-- modal-content -->
	</div> <!-- modal-dialog -->
</div> <!-- 모달창 끝 -->


</body>
</html>