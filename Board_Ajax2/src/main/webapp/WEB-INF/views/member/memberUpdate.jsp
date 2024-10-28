<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
<link rel="icon" href="${pageContext.request.contextPath}/image/orange.svg">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/join.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<style>
	h3 {
		text-align: center;
		color: #1a92b9;
	}
	
	input[type=file] {
		display: none;
	}
</style>
</head>
<body class="container">
	<jsp:include page="../board/header.jsp"></jsp:include>
	<form name="updateform" action="updateProcess" method="post" enctype="multipart/form-data">
		<h1>edit my info</h1>
		<hr>
		<b>id</b> <input type="text" name="id" placeholder="Enter id" maxlength="12" required value="${id}">
		<span id="id-message"></span>
			 
		<b>password</b>
		<input type="password" name="pass" placeholder="Enter password" required value="${member.password}">
			
		<b>name</b> <input type="text" name="name" placeholder="Enter name" maxlength="5" required value="${member.name}"> 
		
		<b>age</b> <input type="text" name="age" placeholder="Enter age" maxlength="2" required value="${member.age}"> 
			
		<b>gender</b>
		<div>
			<input type="radio" name="gender" value="남">male 
			<input type="radio" name="gender" value="여">female
		</div>

		<b>email</b>
		<input type="text" name="email" placeholder="Enter email" maxlength="30" required value="${member.email}"> 
		<span id="email_message"></span>
		
		<b>profile image</b>
		<label>
			<img src="${pageContext.request.contextPath}/image/attach.png" width="10px">
			<span id="filename">${member.memberfile}</span>
			<span id="showImage">
				<c:if test="${empty member.memberfile}">
					<c:set var='src' value='image/profile.png'/>
				</c:if>
				<c:if test="${!empty member.memberfile}">
					<c:set var='src' value='${"memberupload/"}${member.memberfile}'/>
					<input type="hidden" name="check" value="${member.memberfile}"> <%-- 파일이 있는데 --%>
				</c:if>
				<img src="${pageContext.request.contextPath}/${src}" width="20px" alt="profile">
			</span>
			<%-- accept : upload할 파일 타입 설정.
					(1) ex) .png .jpg .pdf .hwp 등등
					(2) audio/* : 모든 타입의 audio 파일
						image/* : 모든 타입의 image 파일
			 --%>
			<input type="file" name="memberfile" accept="image/*"> 
		</label>
		
		<div class="clearfix">
			<button type="submit" class="submitbtn">complete</button>
			<button type="reset" class="cancelbtn">rewrite</button>
		</div>
	</form>
	<script>
		$(function() {
			//gender check
			$("input[value='${member.gender}']").prop('checked', true);
			
			$(".cancelbtn").click(function() {
				location.href="../boards/list"
			});
			
			//처음 화면 로드시 보여줄 이메일은 이미 체크 완료된 것이므로 기본 checkemail=true입니다.
			let checkemail = true;
			$("input[name=email]").on('keyup', function() {
				$("#email_message").empty();
				//	\w = [A-Za-z0-9_]
				//	+ = {1, } = 1회 이상 반복
				//	\w+ = [A-Za-z0-9_]를 1회이상 반복
				const pattern = /^\w+@\w+[.]\w{3}$/;
				const email = $(this).val();
				if(!pattern.test(email)){
					$("#email_message").css('color', 'red').html("email 형식 틀림");
					checkemail=false;
				}
				else{
					$("#email_message").css('color', 'green').html("email 형식 맞음");
					checkemail=true;
				}
			});//email keyup
			
			$("input[name=updateform]").submit(function() {
				if(!$.isNumeric($("input[name='age']").val())){
					alert("age muse be number");
					$("input[name='age']").val('').focus();
					return false;
				}
				
				if(!checkemail){
					alert("email 형식 확인하세요.");
					$("input[name=email]").focus();
					return false;
				}
			});//updateform submit
		
			$('input[type=file]').change(function(event){
				const file = event.target.files[0]; //첫번째 파일
				const maxSizeInBytes = 5 * 1024 * 1024;
				if(file.size > maxSizeInBytes){
					alert("5MB 이하 크기로 업로드 하세요");
					$(this).val('');
					return;
				}
				
				const pattern = /(gif|jpg|jpeg|png)$/i; //i(ignore case) = 대소문자 무시.
				if(pattern.test(file.name)){
					$('#filename').text(file.name);
					
					//createObjectURL()를 통해 file을 server에 upload하지 않고도 browser에서 미리보기 가능.
					const fileURL = URL.createObjectURL(file);
					$('#showImage > img').attr('src', fileURL);
				}
				
				else{
					alert('image file(gif,jpg,jpeg,png)이 아닌 경우 무시됩니다.');
					$('#filename').text('');
					$('#showImage > img').attr('src', '../image/profile.png');
					$(this).val('');
					$('input[name=check]').val('');
				}
				
			});//file change event
			
		});
	</script>
</body>
</html>