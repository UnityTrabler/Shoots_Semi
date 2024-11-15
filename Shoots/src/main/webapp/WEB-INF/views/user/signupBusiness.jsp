<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
	
</script>
<form class="form-horizontal" method="post" action="signupProcess" id="signupform" >
	<h2 style="text-align: center;">회원가입(sign up)</h2>
	
	<font color='red'>*</font>표시는 필수 입력 사항입니다.<hr>
	
	<!-- name : id, pwd, name, RRN1, RRN2, gender, tel, email, nickname, profile? -->
	B아이디(id)<font color='red'>*</font>
	<input type="text" name="id" id="id" class="form-control" placeholder="id..." >
	
	비밀번호(password)<font color='red'>*</font>
	<input type="text" name="pwd" id="pwd" class="form-control" placeholder="pwd..." >
	
	성함(name)<font color='red'>*</font>
	<input type="text" name="name" id="name" class="form-control" placeholder="name..." >
	
	주민등록번호(RRN)<font color='red'>*</font>
       <div class="row mb-3">
           <div class="col">
               <input type="text" name="RRN" class="form-control" placeholder="앞자리(frontpart)" maxlength="6">
           </div>
           <div class="col-auto">
               <span>-</span>
           </div>
           <div class="col d-flex align-items-center">
               <input type="text" name="gender"  class="form-control" placeholder="" maxlength="1" style="width: 40px;">
               	******
           </div>
       </div>
	
	전화번호(tel)<font color='red'>*</font>
	<input type="text" name="tel" id="tel" class="form-control" placeholder="tel..." >

	이메일(Email)<font color='red'>*</font>
	<input type="email" name="email" id="email" class="form-control" placeholder="받는 주소" value = "<%="kdhmm0325"%>@naver.com" required>
	<input type="button" class="btn btn-primary" id="send-email" value="확인메일 전송(send verifycode)">
	
	<div id="verify-block" class="p-3"  style="background-color: #d4edda;">
		Enter Verification code<font color='red'>*</font>
		<input type="text" class="form-control" id="email-verify-text">
		<input type="button" class="btn btn-primary" id="check-email-verify" value="check">
		<b id="verify-toggle-text"></b>
	</div><br><br>
	<hr>선택 사항입니다.<hr>
	닉네임(nickname)
	<input type="text" name="nickname" id="name" class="form-control" placeholder="name..." >
	
	<input type="submit" class="submit btn btn-submit">
</form>
