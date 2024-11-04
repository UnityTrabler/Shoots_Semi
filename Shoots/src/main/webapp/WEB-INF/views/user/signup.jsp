<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	<script>
		function init() {
			$('#verify-block').css('display', 'none');
		}
	
		$(function() {
			init();
			
			$('#send-email').click(function() {
				$('#verify-block').css('display', 'block');
				
				 $.post("${pageContext.request.contextPath}/user/signupProcess", {receiver: $('#receiver').val()},
					function(response) {
			            alert("이메일이 전송되었습니 다.");
			            console.log(response);
			        }, "json").fail(function(response) {
			            alert("이메일 전송에 실패했습니다.");
			            console.log(response);
			            console.log(response.message);
			        });
				 
			});
			$('#check-email-verify').click(function() {
				console.log("Input Value:", $('#email-verify-text').val().trim());
				console.log("Session Value:", '<%= session.getAttribute("verifyNum") != null ? session.getAttribute("verifyNum").toString().trim() : "" %>');
				console.log('<%= session.getAttribute("verifyNum") != null ? session.getAttribute("verifyNum").toString().trim() : "" %>' === $('#email-verify-text').val().trim());
				
				$.ajax({
					url : "${pageContext.request.contextPath}/user/signupProcess",
					type : "POST",
					data : key : $('#receiver').val(),
					success : function(response){
						
					},
					error : function() {
						
					},
					dataType : "json"
				});
				
			});
		});
	</script>
</head>
<body class="container">
	<jsp:include page="top.jsp"></jsp:include>
	<%-- action="/JSP/mailSend" --%>
	<form class="form-horizontal" method="post" action="#" onsubmit="return false;">			

		Enter Email for Verification<font color='red'>*</font>
		<input type="email" name="receiver" id="receiver" class="form-control" placeholder="받는 주소" value = "<%="kdhmm0325"%>@naver.com" required>
		<input type="button" class="btn btn-primary" id="send-email" value="send">
		
		<div id="verify-block">
			Enter Verification code<font color='red'>*</font>
			<input type="text" class="form-control" id="email-verify-text">
			<input type="submit" class="btn btn-primary" id="check-email-verify" value="send">
		</div>
	</form>
</body>
</html>