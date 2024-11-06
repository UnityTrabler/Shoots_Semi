<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script> <!-- 모달창 쓰려면 필요한 스크립트 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/report.css">

<title>신고창</title>

<style>
.modal-content {
    width: 700px;
    height: 400px;
}

.modal-content {
    border-radius: 40px;
    border: 3px solid #1FAF82;
}

</style>
</head>
<body>
<button class ="push" data-toggle="modal" data-target=".report-modal">여기 누르면 모달 창이 뜸</button>

	<!-- 모달창 시작-->		
<div class="modal report-modal fade" style="display:none">
	 <div class="modal-dialog" role="document">
        <div class="modal-content"> <!-- 모달 내용으로 포함시킬 부분 -->
        	<h1 style="text-align:center;">플레이어 신고</h1>
        	<!-- 플레이어1 구간 -->
			<div class="player" id="p1">
			<span>
			<img src="${pageContext.request.contextPath}/img/reportHuman.png" width="80px"/>
			<label><input type="radio" class="personchoice">
			<h4>1번 플레이어</h4> </label>
			</span>
			
			<select>
				<option disabled selected hidden>신고 사유를 선택해 주세요</option>
				<option>욕설, 모욕 등의 언어적 폭력행위</option>
				<option>난폭한 플레이</option>
				<option>약속시간 미준수</option>
				<option>헥토파스칼킥 태클</option>
			</select>
			<input type="text" maxlength="100">
			</div> <!-- 플레이어1 끝 -->
			
			<!-- 플레이어2 구간 -->
			<div class="player" id="p1">
			<span>
			<img src="${pageContext.request.contextPath}/img/reportHuman.png" width="80px"/>
			<label><input type="radio" class="personchoice">
			<h4>2번 플레이어</h4> </label>
			</span>
			
			<select>
				<option disabled selected hidden>신고 사유를 선택해 주세요</option>
				<option>폭언 욕설 등의 언어적 폭력행위</option>
				<option>난폭한 플레이</option>
				<option>약속시간 미준수</option>
				<option>헥토파스칼킥 태클</option>
			</select>
			<input type="text" maxlength="100">
			</div> <!-- 플레이어2 끝 -->
			
			
			<button class="btn btn-danger" style="width:60px;  font-size:10px">신고하기</button>
		</div> <!-- modal-content -->
	</div> <!-- modal-dialog -->
</div> <!-- 모달창 끝 -->



<!--  모달창에 플레이어 목록을 테이블 형태로 만들기 위한 테스트 부분. 차후 위의 모달창과 합침 -->
<table class="table table-striped">
	<caption>신고할 플레이어 목록</caption>
	<thead>
	
	</thead>

</table>



</body>
</html>