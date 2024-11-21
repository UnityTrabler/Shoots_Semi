<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserMatchPlayer.css" type="text/css">
</head>
<body>
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
					<p> <b> ${player.name.substring(0,1)} * ${player.name.substring(2,3)} </b> (${player.id} / 
						<c:choose>
							<c:when test = "${player.gender == 1 or player.gender == 3}">
								(남)
							</c:when>
							<c:when test = "${player.gender == 2 or player.gender == 4}">
								(여)
							</c:when>
						</c:choose>
						&nbsp;
						<c:if test = "${player.idx != idx}">
							<input type = "button" class = "reportBtn" name = "report" value = "신고">
						</c:if>
					</p>
					<p><img class = "ip" src = "${pageContext.request.contextPath}/img/tel.png"> ${player.tel.substring(0, 3)}-****-${player.tel.substring(7)} &nbsp; | &nbsp; 
					   <img class = "ip" src = "${pageContext.request.contextPath}/img/mail.png"> ${player.email}
					</p>
					<hr>	
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>