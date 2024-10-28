<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE net>
<html>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/css/join.css"
	rel="stylesheet">
<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
<style>
h3 {
	text-align: center;
	color: #1a92b9;
}

input[type=file] {
	display: none;
}
</style>
<body>
	<jsp:include page="../board/header.jsp" />
	<form name="updateform" method="post" action="updateProcess"
		enctype="multipart/form-data">
		<h1>회원 정보 수정</h1>
		<hr>
		<b>아이디</b> <input type="text" name="id" placeholder="Enter id"
			maxLength="12" readOnly value="${memberinfo.id}"> <span
			id="id-message"></span> <b>비밀번호</b> <input type="password"
			name="password" placeholder="Enter password"
			value="${memberinfo.password}" readOnly> <b>이름</b> <input
			type="text" name="name" placeholder="Enter name" maxLength="5"
			value="${memberinfo.name}" required> <b>나이</b> <input
			type="text" name="age" placeholder="Enter age" maxLength="2"
			value="${memberinfo.age}" required> <b>성별</b>
		<div>
			<input type="radio" name="gender" value="남"><span>남자</span>
			<input type="radio" name="gender" value="여"><span>여자</span>
		</div>

		<b>이메일 주소</b> <input type="text" name="email"
			value="${memberinfo.email}" placeholder="Enter email" required><span
			id="email_message"></span> 
			
			<b>프로필 사진</b> <label> <img
			src="${pageContext.request.contextPath}/image/attach.png"
			width="10px"> <span id="filename">${memberinfo.memberfile}</span> 
			<span id="showImage"> 
				<c:if test='${empty memberinfo.memberfile}'>
					<c:set var='src' value='image/profile.png' />
				</c:if> 
				
				<c:if test='${!empty memberinfo.memberfile}'>
					<c:set var='src'
						value='${"memberupload/"}${memberinfo.memberfile }' />
					<input type="hidden" name="check" value="${memberinfo.memberfile}">
				</c:if> <img src="${pageContext.request.contextPath}/${src}" width="20px"
				alt="profile">
		</span> <%--accept: 업로드할 파일 타입을 설정함.
			<input type="file" accept ="파일확장자|audio/*video/*|image/*">
			(1) 파일 확장자는 .png, .jpg, .pdf, .hwp 처럼 (.)으로 시작되는 파일 확장자를 뜻함.
				예) accept=".png, .jpg, .pdf, .hwp"
			(2) audio/* : 모든 타입의 오디오 파일
			(2) image/* : 모든 타입의 이미지 파일
			 --%> 
			 
			 <input type="file" name="memberfile" accept="image/*">
		</label>
		<div class="clearfix">
			<button type="submit" class="submitbtn">수정</button>
			<button type="reset" class="cancelbtn">취소</button>
		</div>
	</form>

	<script>
//성별 체크 부분
$(document).ready(function(){
$("input[value='${memberinfo.gender}']").prop('checked', true);
$(".cancelbtn").click(function(){
	location.href="../boards/list"
});

//처음 화면 로드시 보여줄 이메일은 이미 체크 완료된것이므로 기본 checkemail = true임.
let checkemail = true;
$('input[name=email]').on('keyup', function(){
	$("#email_message").empty();
	//[A-Za-z0-9_]와 동일한것이 \w
	//+는 1회 이상 반복을 뜻함. {1,} 과 동일함.
	// \w+ 는 [A-Za-z0-9_]를 1개 이상 사용하란 뜻.
	const pattern = /^\w+@\w+[.]\w{3}$/;
	const email = $(this).val();
	if (!pattern.test(email)){
		$("#email_message").css('color', 'red').html("이메일 형식이 맞지 않다.");
		checkemail=false;
	} else{
		$("#email_message").css('color', 'green').html("이메일 형식에 맞다.");
		checkemail=true;
	}
}); //email keyup 이벤트 처리 끝


$('form[name=updateform]').submit(function(){
	if(!$.isNumberic($("input[name='age']").val())){
		alert("나이는 숫자를 입력하세요");
		$("input[name='age']").val('').focus();
		return false;
	}
	
	if(!checkemail){
		alert("email 형식을 확인해라")
		$("input[name=email]").focus();
		return false;
	}
}) //submit()끝

$('input[type=file]').change(function(event){
	//event.target.files[0] : 파일리스트에서 첫번째 객체를 가져옴
	const file=event.target.files[0];
	
	const maxSizeInBytes = 5 * 1024 *1024;
	if(file.size > maxSizeInBytes){
		alert("5MB 이하 크기로 업로드 해라.");
		$(this).val('');
		return;
	}
	
	const pattern = /(gif|jpg|jpeg|png)$/i; //i(ignor case)는 대소문자 무시를 의미
	if (pattern.test(file.name)) {
		$('#filename').text(file.name);
		
		//createOjbectURL()를 통해 파일을 서버에 업로드하지 않고도 브라우저에서 미리보기를 할 수 있다.
		const fileURL = URL.createObjectURL(file);
		$('#showImage > img').attr('src', fileURL);
	} else{
		alert('이미지 파일(gif,jpg,jpeg,png)이 아닌 경우는 무시됨.')
		$('#filename').text('');
		$('#showImage > img').attr('src', '../image/proifile.png');
		$(this).val('');
		$('input[name=check]').val('');
	}
	
 }) //change () 끝

});
</script>

</body>
</html>