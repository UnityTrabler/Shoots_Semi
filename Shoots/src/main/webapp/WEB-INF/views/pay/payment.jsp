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
	         IMP.init('imp35523152'); 
	
	         IMP.request_pay({
	             pg: 'html5_inicis',
	             pay_method: 'card', 
	             merchant_uid: 'merchant_' + new Date().getTime(),
	             name: ${matchId} + ' 번 매치 플레이어 신청', 
	             amount: ${price}, 
	             buyer_email: 'example@gmail.com',  
	             buyer_name: '구매자 이름',  
	             buyer_tel: '연락처', 
	             buyer_addr: '주소',  
	             buyer_postcode: '우편번호'  
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
	                 location.href = "../matchs/detail?match_id=" + ${matchId};
	                 
	                 alert(msg);
	             }
	         });
	     });
	</script>
</body>
</html>