<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>함께한 플레이어들</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserMatchPlayer.css" type="text/css">

</head>
<body>
<input type="hidden" name="report_ref_id" id="report_ref_id" value="${match.match_id }">
	<div class = "sc">
		<div class = "df">
			<c:forEach var="player" items="${players}">
				<input type = "hidden" name = "reporter"  value = "${player.idx}">
		    	<div class = "fileD">
					<c:if test="${empty player.userfile}">
						<img src="${pageContext.request.contextPath}/img/info.png" class="infoI">
					</c:if>
	
					<c:if test="${not empty player.userfile}">
						<img src="${pageContext.request.contextPath}/userupload/${player.userfile}" class="infoIs">
					</c:if>
				</div>
				<div class = "infoD">
					<p> <b>
							<c:choose>
								<c:when test = "${player.idx != idx}">
									${player.name.substring(0,1)} * ${player.name.substring(2,3)} 
								</c:when>
								<c:when test = "${player.idx == idx}">
									${player.name}
								</c:when>
							</c:choose>
					 	</b> (${player.id} / 
						<c:choose>
							<c:when test = "${player.gender == 1 or player.gender == 3}">
								남)
							</c:when>
							<c:when test = "${player.gender == 2 or player.gender == 4}">
								여)
							</c:when>
						</c:choose>
						&nbsp;
						<c:if test = "${player.idx != idx}">
							<c:choose>
								<c:when test = "${isReport}">
									<input type = "button" class = "reportBtn" name = "report" value = "신고" 
									data-match-id="${match.match_id}" data-player-idx="${player.idx}" data-player-name="${player.name}"
									onclick="openReportModal('${player.idx}',$('#report_ref_id').val(), '${player.name}')">
								</c:when>
								<c:when test = "${! isReport}">
									<input type = "button" class = "NreportBtn" name = "report" value = "신고" disabled>
									<span class = "NreportP"> 신고기간이 아닙니다 </span>
								</c:when>
							</c:choose>
						</c:if>
					</p>
					<p>
						<c:choose>
							<c:when test = "${player.idx != idx}">
								<img class = "ip" src = "${pageContext.request.contextPath}/img/tel.png"> ${player.tel.substring(0, 3)}-****-${player.tel.substring(7)} 
							</c:when>
							<c:when test = "${player.idx == idx}">
								<img class = "ip" src = "${pageContext.request.contextPath}/img/tel.png"> ${player.tel.substring(0, 3)}-${player.tel.substring(3,7)}-${player.tel.substring(7)} 
							</c:when>
						</c:choose>
						&nbsp; | &nbsp; 
					   <img class = "ip" src = "${pageContext.request.contextPath}/img/mail.png"> ${player.email}
					</p>
					<hr>	
				</div>
			</c:forEach>
		</div>
	</div> <!-- div class sc 끝 -->
	
		<!-- 플레이어 신고모달창 시작-->		
	<div id = "p-reportModal" class="modal p-report-modal fade" style="display:none">
		 <div class="modal-dialog" role="document">
	        <div class="modal-content"> <!-- 모달 내용으로 포함시킬 부분 -->
	         <div class = "modalBD"><input type = "button" value = "X" onclick="closeReportModal()" class = "modalX"></div>
	        
	        <form action ="${pageContext.request.contextPath}/report/add2" method="post" name="reportform">
	        
	        	<p class = "reportT">플레이어 신고</p>
	        	
	        	<br>
	        	<input type="hidden" name="report_type" class ="report_type" value="C"> <!-- 신고유형 분류, 댓글은 B, 숨겨둠. -->
	        	<input type="hidden" name="reporter" class="reporter" value="${idx}"> <!-- 신고자, 로그인 한 아이디로 가져옴 -->
	        	<input type="hidden" name="target" class="target" value=""> <!-- 신고당하는 사람, detail?num에서 뽑아와야함-->
	        	<input type="hidden" name="report_ref_id" class="report_ref_id" value=""> <!-- 참조할 번호. A면 postid, B면 commentid, C면 matchid-->
	        	
	        	<!-- 플레이어1 구간 -->
				<div class="player" id="p1" style="padding-left: 80px;">
				<div>
				<p class = "targetT"><input type="text" name="targetName" class="targetName" value="" style="border:none; font-size : 14px; font-weight : bold" readOnly> 플레이어 신고하기 </p>
				</div>
				
				<select name="title" style="margin-bottom: 10px;" required>
					<option disabled selected hidden value="">신고 사유를 선택해 주세요</option>
					<option value="욕설, 모욕 등의 언어적 폭력행위">욕설, 모욕 등의 언어적 폭력행위</option>
					<option value="난폭한 플레이">난폭한 플레이</option>
					<option value="약속시간 미준수">약속시간 미준수</option>
					<option value="경기와 관계 없는 행위">경기와 관계 없는 행위</option>
					<option value="직접 입력">직접 입력</option>
				</select>
				
				<br>
				<textarea placeholder ="내용을 작성해 주세요." maxlength="300" class="content" name="content" 
				 style="height:150px; width:500px; resize:none; margin-bottom: 10px;" required></textarea>
				</div> <!-- 플레이어1 끝 -->
				
				
				<div id="reportbutton">
					<button class="reportBtnr">신고하기</button>
				</div>
				
				</form>
				
			</div> <!-- modal-content -->
		</div> <!-- modal-dialog -->
	</div> <!-- 플레이어 신고모달창 끝 -->
	
	
	
</body>
</html>