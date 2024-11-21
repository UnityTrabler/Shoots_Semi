<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserMatchs.css" type="text/css">
</head>
<body>
	<p class = "cP1"> 참여한 매칭 </p>
	<c:if test = "${empty list}">
		<div class = "nm">
			<p> ※ 참여한 매칭이 존재하지 않습니다 ※ </p>
		</div>
	</c:if>
	<c:if test = "${!empty list}">
		<div class = "sc">
			<table class = "table tablehd">
		 		<thead>
					<tr>
						<th> 날짜 </th>
						<th> 시간 </th>
						<th> 장소 </th>
						<th> 인원 </th>
						<th> 현황 </th>
						<th> 플레이어 </th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var = "match" items= "${list}">
						<tr>
							<input type = "hidden" value = "match.match_id" name = "match_id">
							<td> ${match.match_date.substring(0, 10)} </td>
							<td> ${match.match_time} </td>
							<td> ${match.business_name} </td>
							<td> ${match.playerCount} / ${match.player_max} </td>
							<td>
								<c:choose>
									<c:when test="${match.isMatchPast() && match.playerCount >= match.player_min}">
							            <input type="button" class="status5" value="매칭확정" disabled>
							        </c:when>
									 <c:when test="${match.isMatchPast()}">
								        <input type="button" class="status4" value="마감" disabled>
								    </c:when>
								    <c:when test="${match.playerCount == match.player_max}">
						                <input type="button" class="status2" value="마감" disabled>
						            </c:when>
								    <c:when test="${match.playerCount >= match.player_min && match.playerCount < match.player_max}">
							        	<input type="button" class="status3" data-match-id="${match.match_id}" value="마감임박">
							        </c:when>
									<c:when test="${match.playerCount >= 0 && match.playerCount <= player_min}">
						                <input type="button" class="status" data-match-id="${match.match_id}" value="신청가능">
						            </c:when>
						 			<c:otherwise>
						 				<input type = "button" class = "status" data-match-id="${match.match_id}" value = "신청가능">
						 			</c:otherwise>
								</c:choose> 
							</td>
							<td> <input type = "button" value = "보기" class = "check" data-match-id="${match.match_id}" onclick="openModal(${match.match_id})">
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:if>
	
	<div id="myModal" class="modal">
        <div class="modal-content">
            <div class = "modalBD"><input type = "button" value = "X" onclick="closeModal()" class = "modalX"></div>
            <div id="modalContent">
				<p class = "cP2"> 함께한 플레이어 </p>
				<div id="playersList">
				</div>
            </div>
        </div>
    </div>
</body>
</html>