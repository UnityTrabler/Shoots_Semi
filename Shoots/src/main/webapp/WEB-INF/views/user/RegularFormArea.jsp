<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div id="regularContext">
			<form class="form-horizontal" method="post" action="signupProcess" id="signupform" >
				<h2 style="text-align: center; color: #059669; margin-bottom: 50px">개인 회원가입</h2>

				<font color='red'>*</font>표시는 필수 입력 사항입니다.
				<hr style="border: 1px solid #059669; width: 100%; opacity: 1;">

				<!-- name : id, pwd, name, RRN, gender, tel, email, nickname, profile? -->
				<div class="divBlock1">
					<div  style="text-align: left;">아이디<font color='red'>*</font></div>
					<input type="text" name="id" id="id"  placeholder="id...">
				</div>
	
				
				<div class="divBlock1">
				    <div style="text-align: left;">비밀번호<font color='red'>*</font></div>
				    <input type="password" name="pwd" id="pwd" class="form-control" placeholder="pwd...">
				</div>
				
				<div class="divBlock1">
				    <div style="text-align: left;">성함<font color='red'>*</font></div>
				    <input type="text" name="name" id="name" class="form-control" placeholder="name...">
				</div>
				
				<div class="divBlock1" style="margin-left: 110px">
				    <div style="text-align: left; margin-right: 10px;">주민등록번호<font color='red'>*</font></div>
				    <div class="row mb-3">
				        <div class="col">
				            <input type="text" id="RRN" name="RRN" class="form-control" placeholder="990101" maxlength="6">
				        </div>
				        <div class="col">
				            <span>-</span>
				        </div>
				        <div class="col d-flex align-items-center" style="padding: auto 0px;">
				            <input type="text" id="gender" name="gender" class="form-control" placeholder="" maxlength="1" style="width: 40px;"> ****** 
				        </div>
				    </div>
				</div>
				
				<div class="divBlock1">
				    <div style="text-align: left;">전화번호<font color='red'>*</font></div>
				    <input type="text" name="tel" id="tel" class="form-control" placeholder="tel...">
				</div>
				
				<div class="divBlock1">
					<div class="row" style="margin-left: 180px;">
					    <div style="text-align: left;">이메일<font color='red'>*</font></div>
					    <input type="email" name="email" id="email" class="form-control col" placeholder="받는 주소" value="<%="kdhmm0325"%>@naver.com" required>
					    <input type="button" class="btn btn-primary col" style="margin-left: 20px; padding: 0px; flex: 0.6;" id="send-email" value="확인메일 전송">
				    </div>
				</div>
				
				<div id="verify-block" class="p-3" style="background-color: #d4edda;">
				    <div class="divBlock1">
				        <div style="text-align: left;">Enter Verification code<font color='red'>*</font></div>
				        <input type="text" class="form-control" id="email-verify-text">
				        <input type="button" class="btn btn-primary" id="check-email-verify" value="check">
				        <b id="verify-toggle-text"></b>
				    </div>
				</div>
				
				<div class="divBlock1" style="margin-top: 50px">
					아래는 선택 사항입니다.<br>
				</div>
				<hr style="border: 1px solid #059669; width: 100%; opacity: 1;">
				
				<div class="divBlock1">
				    <div style="text-align: left;">닉네임</div>
				    <input type="text" name="nickname" id="nickname" class="form-control" placeholder="name...">
				</div>
				<div class="divBlock1">
					<div style="text-align: left;">프로필 사진</div>
					<label>
						<div class="divBlock2">
							<img src="" id="preview" style="width:200px; height: 200px; border: 1px solid #059669; margin-bottom: 10px;">
							<input type="file" name="userFile" accept="image/*">
						</div>	
						<span id="filename" class="btn btn-primary" style="width: 100px;">파일첨부</span>
						<span id="fileReset" class="btn btn-danger" style="width: 100px;">파일리셋</span>
					</label>
				</div>
				
				<hr style="border: 1px solid #059669; width: 100%; opacity: 1;">
				<div class="divBlock1">
				    <input type="submit" class="submit btn btn-info" value="완료">
				</div>
			</form>

		</div><!--  	<div id="regularContext">   -->