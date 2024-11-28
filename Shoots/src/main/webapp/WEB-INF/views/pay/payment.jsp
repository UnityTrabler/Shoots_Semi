<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>
<body>
	<script>
		 $(document).ready(function() {
	         var IMP = window.IMP;
	         IMP.init(' '); 
	
	         var merchant_uid = 'merchant_' + new Date().getTime();
	         
	         IMP.request_pay({
	             pg: 'html5_inicis',
	             pay_method: 'card', 
	             merchant_uid: merchant_uid,
	             name: '${matchId}' + ' 번 매치 플레이어 신청', 
	             amount: '${price}', 
	             buyer_email: '${userEmail}',  
	             buyer_name: '${userName}',  
	             buyer_tel: '${userTel}' 
	         }, function(rsp) {
	             if (rsp.success) {
	                 var msg = '결제가 완료되었습니다.';
	                 msg += '고유ID : ' + rsp.imp_uid;
	                 msg += '결제 금액 : ' + rsp.paid_amount;
	                 msg += '카드 승인번호 : ' + rsp.apply_num;

	                 $.ajax({
	                	type : "post",
	                	url : "../payments/addPayment",
	                	data : {
	                		matchId : '${matchId}',
	                		buyer : '${idx}',
	                		seller : '${seller}',
	                		paymentMethod : 'card',
	                		amount : rsp.paid_amount,
	                		status : 'SUCCESS',
	                		applyNum : rsp.apply_num,
	                		impUid : rsp.imp_uid,
	                		merchantUid : merchant_uid
	                	},
	                	success : function(response) {
	                		alert("결제가 완료되었습니다.");
	                		location.href = '${pageContext.request.contextPath}/matchs/detail?match_id=' + ${matchId};
	                	},
	                	error : function (xhr, status, error) {
	                		alert("결제 정보 저장에 실패하였습니다.");
	                		location.href = '${pageContext.request.contextPath}/matchs/detail?match_id=' + ${matchId};
	                	}
	                	
	                 });
	                 
	             } else {
	                 var msg = '결제에 실패하였습니다.';
	                 msg += '에러내용 : ' + rsp.error_msg;
	                 alert(msg);
	                 location.href = "${pageContext.request.contextPath}/matchs/detail?match_id=" + ${matchId};	                 
	             }
	         });
	     });
	</script>
</body>
</html>
