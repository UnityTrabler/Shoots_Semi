<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
    <link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/login.css" type = "text/css">
    <script>
    	function init() {
			$('#id').focus();
			$('button#btnRegular').addClass('successBtn');
		}
    	
    	function btnRegularClick() {}
    	function btnBusinessClick() {}
    	
    	function checkInvalidate() {
			var patternIdPwd = /^[a-zA-Z]{1}\w+$/; // 첫글자 알파벳 + 최대 19글자 한글없이 입력하여야 됩니다.
			
			if(!patternIdPwd.test($('#id').val())){
				alert('올바른 아이디 형식이 아닙니다.\n 첫글자 알파벳, 최소 2글자 ~ 최대 20글자, 한글 없이, 특수문자 없이 가능합니다.');
				$('#id').focus();
				return false;
			}
			else if(!patternIdPwd.test($('#pwd').val())){
				alert('올바른 비밀번호 형식이 아닙니다.\n 첫글자 알파벳, 최소 2글자 ~ 최대 20글자, 한글 없이, 특수문자 없이 가능합니다.');
				$('#pwd').focus();
				return false;
			}
			
			return true;
		}//checkInvalidate()
    	
    	$(function() {
    		init();
    		
			$('#signup').click(function() {
				location.href = "${pageContext.request.contextPath}/user/signup";
			});
			
			const id = '${cookieId}';
			if(id) {
				$("#id").val(id);
				$("#remember").prop('checked', true);
			}
			
			$('#btnRegular').click(function() {
				$(this).addClass('successBtn');
				$(this).siblings().removeClass('successBtn');
			});
			$('#btnBusiness').click(function() {
				$(this).addClass('successBtn');
				$(this).siblings().removeClass('successBtn');
			});
			
		 	$('form[name="loginform"]').submit(function(e) {
				e.preventDefault();
				
				var invali = checkInvalidate(); //유효성검증
				if(invali == false) return;
				
				const data = $(this).serialize();
				let state;
				if ($('#btnGroupRB').find('.successBtn').first().attr('id') == 'btnRegular')
					state = {'state' : 'regular'};
				
				else if ($('#btnGroupRB').find('.successBtn').first().attr('id') == 'btnBusiness')
					state = {'state' : 'business'}; 
				
				ajax(`\${data + "&" + $.param(state)}`, `\${$(this).attr('action')}`);
			}); 
			
		});//ready
		
		function ajax(sdata, surl) {
			$.ajax({
				url : surl,
				data : sdata,
				type : 'POST',
				dataType : "json",
				success : function(data){
					console.log('ajax success');
					alert(data.message);
					window.location.href = "${pageContext.request.contextPath}/index.jsp";
				},
				error:function(xhr, textStatus, errorThrown){
					console.log('ajax error');
					var response = JSON.parse(xhr.responseText);
					alert(response.message);
				}
			});
		}
		
    </script>
</head>
<body>
	<jsp:include page="top.jsp"></jsp:include>
	<div class = "loginAD container">
		<div class = "loginBD">
			<div class = "loginImgD">
				<img src = "${pageContext.request.contextPath}/img/info.png" class = "loginImg">
			</div>
		    <jsp:include page="topUserSwitching.jsp"></jsp:include>
		    <form action="${pageContext.request.contextPath}/user/loginProcess" method="post" name="loginform">
				<div class = "loginD">
			        <div class = "loginI">
			            <p class = "idP"> ID </p>
			            <input type="text" name="id" id="id" class="idI" placeholder="Enter ID" required>
			        </div>
			        <div class = "loginP">
			            <p class = "pwP"> PASSWORD </p>
			            <input type="password" name="pwd" id="pwd" class="pwI" placeholder="Enter password" required>
			        </div>
			        <div class = "RD">
			            <input type="checkbox" id="remember" name="remember" value="store" class="form-check-input">
			            <label for="remember" class="form-check-label">Remember me</label>
			        </div>
		        </div>
		        <div class = "btnD">
		            <button type="submit" class="loginBtn">Login</button>
		            <button type="button" class="signupBtn" id="signup">Sign Up</button>
		        </div>
		    </form>
	    </div>
    </div>
</body>
</html>
