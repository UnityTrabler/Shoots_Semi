<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="net.match.db.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/matchDetail.css" type = "text/css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>
<body>
	<input type = "hidden" id = "match_id" name = "match_id" value = ${match.match_id}>
	<input type = "hidden" id = "writer" name = "writer" value = ${match.writer}>
	<div class = "imgD">
		<img class = "Mimg" src = "${pageContext.request.contextPath}/img/matchD.jpg">
	</div>
	<div class = "container">
		<div class = "container1">
			<p class = "mP"> 매치포인트 </p>
			<div class = "mpDiv">
				<c:if test = "${playerCount > 0 }">
					<c:if test = "${playerCount < match.player_min}">
						<c:forEach var = "i" begin = "0" end = "${playerCount - 1}">
							<img class = "picon" src = "${pageContext.request.contextPath}/img/player_icon2.png" />
						</c:forEach>
					</c:if>
					
					<c:if test = "${playerCount >= match.player_min}">
				    	<c:forEach var = "i" begin = "0" end = "${playerCount - 1}">
							<img class = "picon" src = "${pageContext.request.contextPath}/img/player_icon3.png" />
						</c:forEach>
					</c:if>
					<c:forEach var = "i" begin = "${playerCount}" end = "${match.player_max - 1}">
				        <img class = "picon" src = "${pageContext.request.contextPath}/img/player_icon1.png" />
				    </c:forEach>
			    </c:if>
			    <c:if test = "${playerCount == 0}">
			    	<c:forEach var = "i" begin = "0" end = "${match.player_max - 1}">
				        <img class = "picon" src = "${pageContext.request.contextPath}/img/player_icon1.png" />
				    </c:forEach>
			    </c:if>
			    <p class = "mpP"> 최소 ${match.player_min}명 &nbsp; 최대 ${match.player_max}명 </p>
				<c:choose>
				<c:when test="${match.player_gender == 'm'}">
					<p class = "mpP"> 남자만 참여할 수 있어요 </p>
				</c:when>
				<c:when test="${match.player_gender == 'f'}">
					<p class = "mpP"> 여자만 참여만 참여할 수 있어요 </p> 
				</c:when>
				<c:when test="${match.player_gender == 'a'}">
					<p class = "mpP"> 남녀 모두 참여할 수 있어요 </p>
				</c:when>
				</c:choose>
			</div>
			<hr class = "hr2">
			<p class = "mP"> 구장설명 </p>
			<pre class = "preP">
				${match.description}
			</pre>
		</div>
		<div class = "container2">
			<p class = "datetime"> ${match.match_date.substring(0,4)}년 ${match.match_date.substring(5,7)}월 ${match.match_date.substring(8,10)}일 ${match.match_time} </p>
		 	<p class = "name"> ${match.business_name} </p>
		 	<p class  = "address"> ${match.address} </p>
		 	<hr class = "hr1">
		 	<p class = "price"> ${match.price}원 <span class = "time">  / 2시간 </span></p>
		 	<c:if test="${empty sessionScope.id or userClassification == 'regular'}"> 
			 	<div class = "btndiv">		 	
			 		<c:choose>
			 			<c:when test = "${!empty idx and isPaid and !isMatchClosed}">
					        <input type="button" class="btn1" id="refundBtn" value="신청취소">
					    </c:when>
					    <c:when test="${!empty idx and isPaid and isMatchClosed}">
					        <input type="button" class="PdeadlineBtn2" value="매칭확정">
					        <p class = "deadlineP3"> ※ 신청이 확정되었습니다. 이후 <span class = "deadlinePS">취소는 <b>불가능</b></span>합니다. ※ </p>
					    </c:when>
					    <c:when test="${playerCount == match.player_max}">
					        <input type="button" class="IdeadlineBtn" value="마감">
					        <p class = "deadlineP"> ※ 인원이 가득 찼습니다. 더 이상 신청할 수 없습니다. ※ </p>
					    </c:when>
			 			<c:when test = "${isMatchClosed}">
			 				<input type = "button" class = "IdeadlineBtn" value = "마감">
			 				<p class = "deadlineP2"> ※ 신청기간이 지난 매치입니다. ※ </p>
			 			</c:when>
			 			<c:when test = "${empty idx}" >
			 				<input type = "button" class = "btn1" id = "paymentBtnN" value = "신청하기">
			 				<p class = "deadlineP3"> ※ 현재 <b class = "deadlineP3p">${match.player_max * 1 - playerCount * 1}</b> 자리 남았습니다. ※ </p>
			 			</c:when>
			 			<c:otherwise>
			 				<input type = "button" class = "btn1" id = "paymentBtn" value = "신청하기">
			 				<p class = "deadlineP3"> ※ 현재 <b class = "deadlineP3p">${match.player_max * 1 - playerCount * 1}</b> 자리 남았습니다. ※ </p>
			 			</c:otherwise>
			 		</c:choose>
			 	</div>
			 </c:if>
			 <c:if test="${not empty sessionScope.id and userClassification == 'business'}">
				<div class = "btndiv">		 	
				 	<input type = "button" class = "IdeadlineBtn" value = "신청불가">
				 	<p class = "deadlineP2"> ※ 신청 가능한 대상이 아닙니다. ※ </p>
			 	</div>
			 </c:if>
		</div>
	</div>
	
	<c:if test="${empty sessionScope.id or userClassification == 'regular' or idx != match.writer}">
		<div class = "btnC">
			<input type = "button" class = "listBtn" value = "목록보기">
		</div>
	</c:if>
	<c:if test="${not empty sessionScope.id and userClassification == 'business' and idx == match.writer}">
		<div class = "btnC">
			<input type = "button" class = "listBtn" value = "목록보기">
			<input type = "button" class = "updateBtn" value = "수정하기">
			<input type = "button" class = "deleteBtn" value = "삭제하기">
		</div>
	</c:if>
	<jsp:include page="../user/bottom.jsp"></jsp:include>
	<script>
		 $(function() {
			 
			 var idx = '${idx}';
			 console.log("로그인된 사용자 ID: " + idx);
			 console.log(${isPaid});
			 
			$('#paymentBtn').click(function(){
				var matchId = $('#match_id').val();
				var price = '${match.price}';
				var buyer = '${idx}';
				var seller = '${match.writer}';
				
				location.href = "../payments/pay?match_id=" + matchId + "&price=" + price + "&buyer=" + buyer + "&seller=" + seller;
			});
			
			$('#paymentBtnN').click(function() {
				alert("로그인 후 이용 가능합니다.")
                location.href = "../user/login";
            });
			
			$('.listBtn').click(function(){
				history.back();
			});
			
			$('.updateBtn').click(function(){
				location.href = "update?match_id=${match.match_id}";
			})
			
			$('.deleteBtn').click(function(){
				if (confirm("매칭글을 삭제하시겠습니까?")) {
					$.ajax({
						type: "POST", 
						url: "delete?match_id=${match.match_id}", 
						success: function(response) {
							alert("삭제되었습니다."); 
							location.href = "../matchs/list"; 
						},
						error: function() {
							alert("삭제 실패. 다시 시도해주세요.");
						}
					});
				}
			});
			
			$('#refundBtn').click(function() {
			    if (confirm("신청을 취소하시겠습니까?")) {
			        var matchId = $('#match_id').val();
			        var paymentId = '${payment.payment_id}';
			        var buyerId = '${idx}';

			        $.ajax({
			            type: "POST",
			            url: "../payments/refund",
			            data: {
			                paymentId: paymentId,
			                buyerId: buyerId,
			                matchId: matchId
			            },
			            success: function(response) {
			                if (response.status === "SUCCESS") {
			                    alert("환불이 완료되었습니다.");
			                    location.reload();
			                } else {
			                    alert("환불 실패: " + response.message);
			                }
			            },
			            error: function(xhr, status, error) {
			                alert("환불 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
			            }
			        });
			    }
			});
		});
	</script>
</body>
</html>