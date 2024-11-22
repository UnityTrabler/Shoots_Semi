<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<jsp:include page="top.jsp"></jsp:include>
    <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
    <link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/login.css" type = "text/css">
    <script>
    	function init() {
			$('#id').focus();
			$('button#btnRegular').addClass('successBtn');
		}
    	
    	function btnRegularClick() {}
    	function btnBusinessClick() {}
    	
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
				const data = $(this).serialize();
				let state;
				if ($('#btnGroupRB').find('successBtn').first().attr('id') == 'btnRegular')
					state = {'state' : 'regular'};
				
				else if ($('#btnGroupRB').find('successBtn').first().attr('id') == 'btnBusiness')
					state = {'state' : 'business'};
				
				alert(`\${data + "&" + $.param(state)}`);
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
	<div class = "loginAD">
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
