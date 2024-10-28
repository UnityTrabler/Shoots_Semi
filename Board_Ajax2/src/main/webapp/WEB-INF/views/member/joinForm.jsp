<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<title>join.jsp</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/image/orange.svg">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/join.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script>
	$(function() {
		let checkid = false;
		let checkemail = false;

		$("input[name=id]").on(
				'keyup',
				function() {
					// \w = [A-Za-z0-9_]
					const pattern = /^\w{5,12}$/;
					const id = $(this).val();

					if (!pattern.test(id)) {
						$("#id-message").css('color', 'red').html(
								"( 영문자 or 숫자 or _ )로 5~12자 가능함.");
						checkid = false;
						return;
					}//if(!pattern)

					$.ajax({
						url : "idcheck",
						data : {
							"id" : id
						},
						success : function(resp) {
							if (resp == '-1') {//db에 해당 id가 없는 경우
								$("#id-message").css('color', 'green').html(
										"possible ID")
								checkid = true;
							} else { // db에 해당 id가 있는 경우('0')
								$("#id-message").css('color', 'blue').html(
										"This ID is in use");
								checkid = false;
							}
						},//success
					});//ajax
				}); //keyup

		$("input[name=email]").on('keyup', function() {
			// \w = [A-Za-z0-9_]
			const pattern = /^\w@\w+[.][A-Za-z0-9]{3}$/;
			const email_value = $(this).val();

			if (!pattern.test(email_value)) {
				$("#email-message").css('color', 'red').html("email 형식 틀림");
				checkemail = false;
			}//if(!pattern)
			else {
				$("#email-message").css('color', 'green').html("email 형식 맞음");
				checkemail = true;
			}
		}); //keyup
		
		$("form[action=joinProcess]").submit(function() {
			if(!$.isNumeric($("input[name='age']").val())){
				alert("age는 number 입력.");
				$("input[name='age']").val('').focus();
				return false;
			}
			
			if(!checkid){
				alert("사용가능한 id로 입력하세요.")
				$("input[name=id]").val('').focus();
				$("#id-message").text('');
				return false;
			}
			
			if(!checkemail){
				alert("email 형식 확인하세요.")
				$("input[name=email]").focus();
				return false;
			}
		}); //submit

	}); //$(function())
</script>
</head>
<body class="container">
	<form name="joinform" action="joinProcess" method="post">
		<h1>sign up</h1>
		<hr>
		<b>id</b> <input type="text" name="id" placeholder="Enter id"
			maxlength="12" required> <span id="id-message"></span> <b>password</b>
		<input type="password" name="pass" placeholder="Enter password"
			required> <b>name</b> <input type="text" name="name"
			placeholder="Enter name" maxlength="5" required> <b>age</b> <input
			type="text" name="age" placeholder="Enter age" maxlength="2"
			required> <b>gender</b>
		<div>
			<input type="radio" name="gender" value="남" checked>male <input
				type="radio" name="gender" value="여">female
		</div>

		<b>email</b> <input type="text" name="email" placeholder="Enter email"
			maxlength="30" required> <span id="email-message"></span>
		<div class="clearfix">
			<button type="submit" class="submitbtn">sign up</button>
			<button type="reset" class="cancelbtn">rewrite</button>
		</div>
	</form>
</body>
</html>