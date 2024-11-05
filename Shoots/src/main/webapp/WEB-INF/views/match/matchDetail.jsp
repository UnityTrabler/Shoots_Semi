<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<div class = "imgD">
		<img class = "Mimg" src = "${pageContext.request.contextPath}/img/matchD.jpg">
	</div>
	<div class = "container">
		<div class = "container1">
			<p class = "mP"> 매치포인트 </p>
			<div class = "mpDiv">
				<c:forEach var="i" begin="0" end="${match.player_min - 1}">
					<img class = "picon" src="${pageContext.request.contextPath}/img/player_icon1.png" />
				</c:forEach>
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
			<pre class = "preP"> </pre>
		</div>
		<div class = "container2">
			<p class = "datetime"> ${match.match_date.substring(0,4)}년 ${match.match_date.substring(5,7)}월 ${match.match_date.substring(8,10)}일 ${match.match_time} </p>
		 	<p class = "name"> ${match.business_name} </p>
		 	<p class  = "address"> ${match.address} </p>
		 	<hr class = "hr1">
		 	<p class = "price"> ${match.price}원 <span class = "time">  / 2시간 </span></p>
		 	<div class = "btndiv">
		 		<input type = "button" class = "btn1" id = "paymentBtn" value = "신청하기">
		 	</div>
		</div>
	</div>
	<div class = "btnC">
		<input type = "button" class = "listBtn" value = "목록보기">
		<input type = "button" class = "updateBtn" value = "수정하기">
		<input type = "button" class = "deleteBtn" value = "삭제하기">
	</div>
	<script>
		 $(function() {
		        $('#paymentBtn').click(function() {
		            // 결제 요청
		            var IMP = window.IMP;
		            IMP.init('imp35523152'); // 가맹점 식별코드

		            IMP.request_pay({
		                pg: 'html5_inicis',
		                pay_method: 'card', 
		                merchant_uid: 'merchant_' + new Date().getTime(),
		                name: ${match.match_id} + ' 번 매치 플레이어 신청',
		                amount: ${match.price}, 
		                buyer_email: 'example@gmail.com',
		                buyer_name: '구매자 이름',
		                buyer_tel: '연락처',
		                buyer_addr: '주소',
		                buyer_postcode: '우편번호',
		            }, function(rsp) {
		                if (rsp.success) {
		                    var msg = '결제가 완료되었습니다.';
		                    msg += '고유ID : ' + rsp.imp_uid;
		                    msg += '결제 금액 : ' + rsp.paid_amount;
		                    msg += '카드 승인번호 : ' + rsp.apply_num;

		                    pay_info(rsp);

		                } else {
		                    var msg = '결제에 실패하였습니다.';
		                    msg += '에러내용 : ' + rsp.error_msg;
		                    
		                    alert(msg);
		         
		                }
		            });
		        });
			
			$('.listBtn').click(function(){
				location.href = location.href = "../matchs/list";
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
		});
	</script>
</body>
</html>