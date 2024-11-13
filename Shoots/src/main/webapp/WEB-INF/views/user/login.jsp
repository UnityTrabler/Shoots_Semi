<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        .container { margin: 3em auto; box-shadow: 3px 3px 30px gray; width: 500px;  border: 6px solid lightgreen;}
    </style>
    <script>
    	function init() {
			$('#id').focus();
		}
    
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
				$(this).addClass('btn-success');
				$(this).siblings().removeClass('btn-success');
			});
			$('#btnBusiness').click(function() {
				$(this).addClass('btn-success');
				$(this).siblings().removeClass('btn-success');
			});
			
		 	$('form[name="loginform"]').submit(function(e) {
				e.preventDefault();
				const data = $(this).serialize();
				let state;
				if ($('#btnGroupRB').find('.btn-success').first().attr('id') == 'btnRegular')
					state = {'state' : 'regular'};
				
				else if ($('#btnGroupRB').find('.btn-success').first().attr('id') == 'btnBusiness')
					state = {'state' : 'business'};
				
				alert(`\${data + "&" + $.param(state)}`);
				ajax(`\${data + "&" + $.param(state)}`, `loginProcess`);
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
					window.location.href = "${pageContext.request.contextPath}/index.jsp";
				},
				error:function(){
					console.log('ajax error');
				}
			});
		}
		
    </script>
</head>
<body class="container">
    <jsp:include page="top.jsp"></jsp:include>
    <jsp:include page="topUserSwitching.jsp"></jsp:include>
    <form action="${pageContext.request.contextPath}/user/loginProcess" method="post" name="loginform">
        <h1 class="text-center">Login</h1>      

        <div class="form-group mb-3">
            <label for="id">ID</label>
            <input type="text" name="id" id="id" class="form-control" placeholder="Enter ID" required>
        </div>

        <div class="form-group mb-3">
            <label for="pwd">Password</label>
            <input type="password" name="pwd" id="pwd" class="form-control" placeholder="Enter password" required>
        </div>

        <div class="form-check mb-3">
            <input type="checkbox" id="remember" name="remember" value="store" class="form-check-input">
            <label for="remember" class="form-check-label">Remember me</label>
        </div>

        <div class="d-flex justify-content-center">
            <button type="submit" class="btn btn-primary">Login</button>
            <button type="button" class="btn btn-secondary" id="signup">Sign Up</button>
        </div>
    </form>
</body>
</html>
