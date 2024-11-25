<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


		<div id="regularContext">
			<form class="form-horizontal" method="post" action="updateProcessBusiness" id="signupform" name="signupform">
				<h2 style="text-align: center; color: #059669; margin-bottom: 50px">기업 회원가입</h2>

				<font color='red'>*</font>표시는 필수 입력 사항입니다.
				<hr style="border: 1px solid #059669; width: 100%; opacity: 1;">
				<!-- id pwd business-name business-number tel email postcode address+adressDetail description business_file -->
				<div class="divBlock1">
				    <div style="text-align: left;">아이디<font color='red'>*</font></div>
				    <input type="text" name="id" id="id" class="form-control" placeholder="id..." value="${id}" required readonly>
				</div>
				
				<div class="divBlock1">
				    <div style="text-align: left;">비밀번호<font color='red'>*</font></div>
				    <input type="text" name="pwd" id="pwd" class="form-control" placeholder="pwd..." required value="${BusinessBean.password}" readonly>
				</div>
				
				<div class="divBlock1">
				    <div style="text-align: left;">기업명<font color='red'>*</font></div>
				    <input type="text" name="business-name" id="business-name" class="form-control" placeholder="name..." required value="${BusinessBean.business_name}">
				</div>
				
				<div class="divBlock1">
				    <div style="text-align: left;">사업자 번호<font color='red'>*</font></div>
				    <input type="text" name="business-number" id="business-number" class="form-control" placeholder="name..." maxlength="13" required value="${BusinessBean.business_number}">
				</div>
				
				<div class="divBlock1">
				    <div style="text-align: left;">대표 전화번호<font color='red'>*</font></div>
				    <input type="text" name="tel" id="tel" class="form-control" placeholder="tel..." required value="${BusinessBean.tel}">
				</div>
				
				<div class="row" style="margin-left: 180px;">
				    <div style="text-align: left;">이메일<font color='red'>*</font></div>
				    <input type="email" name="email" id="email" class="form-control col" placeholder="받는 주소" value="${BusinessBean.email}" required>
				    <input type="button" class="btn btn-primary col" style="margin-left: 20px; padding: 0px; flex: 0.6;" id="send-email" value="확인메일 전송">
			    </div>
				
				<div id="verify-block" class="p-3" style="background-color: #d4edda;">
				    <div class="divBlock1">
				        <div style="text-align: left;">Enter Verification code<font color='red'>*</font></div>
				        <input type="text" class="form-control" id="email-verify-text">
				        <input type="button" class="btn btn-primary" id="check-email-verify" value="check">
				        <b id="verify-toggle-text"></b>
				    </div>
				</div>
				
				<!-- 우편번호 block  -->
				<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
				<script>
				    $(function() {
				        $('#postcode').click(function () {
				            new daum.Postcode({
				                oncomplete: function (data) {
				                    console.log('postcode : ' + data.zonecode)
				                    var fullRoadAddr = data.roadAddress;
				                    var extraRoadAddr = '';
				
				                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
				                        extraRoadAddr += data.bname;
				                    }
				
				                    if (data.buildingName !== '' && data.apartment === 'Y') {
				                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				                    }
				
				                    if (extraRoadAddr !== '') {
				                        extraRoadAddr = ' (' + extraRoadAddr + ')';
				                    }
				
				                    if (fullRoadAddr !== '') {
				                        fullRoadAddr += extraRoadAddr;
				                    }
				
				                    $('#postcode').val(data.zonecode);
				                    $('#address').val(fullRoadAddr);
				                }
				            }).open();
				        });
				    });
				
				    function post() {
				        var child = window.open('post.html', '_blank', 'width=300', 'height=200');
				        var width = 400;
				        var height = 500;
				
				        child.moveTo(0, 0);
				        child.resizeTo(width, height);
				    }
				</script>
				
				<div class="divBlock1">
				    <div style="text-align: left;">우편번호, 주소<font color='red'>*</font></div>
				    <label for='postcodeBtn'>
				        <input type="button" value="우편번호 검색하기(Postcode search)" id="postcodeBtn" style="visibility: hidden; display: none;">
				        <input type="text" name="postcode" id="postcode" class="form-control" placeholder="search..." readonly required value="${BusinessBean.post}">
				        <input type="text" name="address" id="address" class="form-control" readonly required value="${BusinessBean.address}">
				    </label>
				</div>
				
				<div class="divBlock1">
				    <div style="text-align: left;">상세주소<font color='red'>*</font></div>
				    <input type="text" name="addressDetail" id="addressDetail" class="form-control" placeholder="name..." required  value="${BusinessBean.address}">
				    <!-- 상세주소와 주소 구분하는 스크립트 -->
				    <script>
						var address = $('#address').val();
						var lastSpaceIndex = address.lastIndexOf(' ');
						if (lastSpaceIndex !== -1) 
							$('#address').val(address.substring(0, lastSpaceIndex));
						
						address = $('#addressDetail').val();
						lastSpaceIndex = address.lastIndexOf(' ');
						if (lastSpaceIndex !== -1) 
							$('#addressDetail').val(address.substring(lastSpaceIndex + 1)); 
					</script>
				</div>
				
				<hr style="border: 1px solid #059669; width: 100%; opacity: 1;">
				
				<div class="divBlock1">
				    <input type="submit" class="submit btn btn-primary">
				</div>

			</form>

		</div><!--  	<div id="regularContext">   -->

