<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	
	<style>
		input[type="text"], input[type="email"], input[type="password"]{width: 300px; border-radius: 30px; padding: 5px; padding-left: 10px; padding-right: 10px; margin-bottom: 10px; }
		input{display: block; align-items: center;}
	</style>
	
	<script>
		function init() {
 			$('#verify-block').css('display', 'none');
			$("#verify-toggle-text").hide();
			$("#preview").hide(); 
			$('button#btnBusiness').addClass('btn-success');
		}
		
		function btnRegularClick() {
			location.href = '${pageContext.request.contextPath}/user/signup';
		}
	
		$(function() {
			init();
			
			$('#send-email').click(function() {
				 $.post("${pageContext.request.contextPath}/user/signupProcess", {email: $('#email').val()},
					function(response) {
			            alert("이메일이 전송되었습니다.");
						$('#verify-block').css('display', 'block');
			            console.log(response);
			        }, "json").fail(function(response) {
			            alert("이메일 전송에 실패했습니다.");
			            console.log(response);
			            console.log(response.message);
			        }); //$.post
				 
			});//$('#send-email').click
			
			$('#check-email-verify').click(function() {
				$.ajax({
					url : "${pageContext.request.contextPath}/user/signupProcess",
					type : "POST",
					data : { key : $('#email-verify-text').val().trim() 
							},
					success : function(response){
						$('#verify-toggle-text').show().text("일치합니다!").css('color', 'green');
						$('#check-email-verify').prop('disabled', true);
						$('#email-verify-text').prop('readonly', true);
						${session.removeAttribute()}
						emailCheck = true;
					},
					error : function() {
						$('#verify-toggle-text').show().text("불일치 합니다.").css('color', 'red');
					},
					dataType : "json"
				}); //$.ajax
				 
			});//$('#check-email-verify').click
			
			var emailCheck = false;
			function checkInvalidate() {
				//유효성검증--- start
				var patternIdPwd = /^[a-zA-Z]{1}\w+$/; // 첫글자 알파벳 + 최대 19글자 한글없이 입력하여야 됩니다.
				var patternBusinessName = /^[\w가-힣]{1,99}$/; // 최대 100글자 가능합니다. 			
				var patternBusinessNumber = /^\d{13}$/; // 13자리 숫자
				var patternTel = /^(01[016789]|02|0[3-9][0-9])-?\d{3,4}-?\d{4}$/; //010, 011, 016, 017, 018, 019 or 02 or 031.. + 하이픈 선택 + 숫자 3개 or 4개 + 숫자 4개 
				var patternEmail = /^[a-zA-Z]{1}\w+@\w+[.]\w+$/; //첫글자 알파벳, a@a.a 의 형태로 입력 
				
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
				else if(!patternBusinessName.test($('#business-name').val())){
					alert('올바른 기업명 형식이 아닙니다.\n 특수문자 없이 최대 100글자 가능합니다.');
					$('#business-name').focus();
					return false;
				}
				else if(!patternBusinessNumber.test($('#business-number').val())){
					alert('올바른 사업자 번호 형식이 아닙니다.\n 13자리, 숫자만 가능합니다.');
					$('#business-number').focus();
					return false;
				}
				else if(!patternTel.test($('#tel').val())){
					alert('올바른 전화번호 형식이 아닙니다.\n 010, 011, 016, 017, 018, 019 or 02 or 031.. + 숫자 3개 or 4개 + 숫자 4개 만 가능합니다.');
					$('#tel').focus();
					return false;
				}
				else if(!patternEmail.test($('#email').val())){
					alert('올바른 이메일 형식이 아닙니다.\n //첫글자 알파벳, ab@a.a 의 형태만 가능합니다. ');
					$('#email').focus();
					return false;
				}
				/* else if(emailCheck == false){
					alert('이메일 인증을 해주세요!');
					$('#email').focus();
					return false;
				} */
				
				return true;
				//유효성검증--- end
			}//checkInvalidate()
			
		 	$('form[name="signupform"]').submit(function(e) {
				e.preventDefault();
				var invali = checkInvalidate(); //유효성검증
				if(invali == false) return;
				
				const data = $(this).serialize();
				let state;
				if ($('#btnGroupRB').find('.btn-success').first().attr('id') != null)
					state = $('#btnGroupRB').find('.btn-success').first().attr('id') == 'btnRegular' ? {'state' : 'regular'} : {'state' : 'business'};
					
				ajax(`\${data + "&" + $.param(state)}`, $(this).attr('action'));
			}); 
			
			function ajax(sdata, surl) {
				$.ajax({
					url : surl,
					data : sdata,
					type : 'POST',
					dataType : "json",
					success : function(data){
						console.log('ajax success');
						alert(data.message);
						window.location.href = "${pageContext.request.contextPath}/user/login";
					},
					error:function(xhr, textStatus, errorThrown){
						console.log('ajax error');
						var response = JSON.parse(xhr.responseText);
						alert(response.message);
					}
				});
			}//ajax()
			
		});//ready 
	</script>
</head>
<body class="container">
	<jsp:include page="top.jsp"></jsp:include>
    <jsp:include page="topUserSwitching.jsp"></jsp:include>
	<div id="switchingContext">
		<div id="regularContext">
			<form class="form-horizontal" method="post" action="signupProcess" id="signupform" name="signupform">
				<h2 style="text-align: center; color:blue;">기업 회원가입(sign up)</h2>

				<font color='red'>*</font>표시는 필수 입력 사항입니다.
				<hr>
				<!-- id pwd business-name business-number tel email postcode address+adressDetail description business_file -->
				아이디<font color='red'>*</font><br>
				<input type="text" name="id" id="id" class="form-control" placeholder="id..." required>

				비밀번호<font color='red'>*</font> <br>
				<input type="text" name="pwd" id="pwd" class="form-control" placeholder="pwd..." required>

				기업명<font color='red'>*</font> <br>
				<input type="text" name="business-name" id="business-name" class="form-control" placeholder="name..." required>
				
				사업자 번호<font color='red'>*</font> <br>
				<input type="text" name="business-number" id="business-number" class="form-control" placeholder="name..." required>

				대표 전화번호<font color='red'>*</font> <br>
				<input type="text" name="tel" id="tel" class="form-control" placeholder="tel..." required>

				이메일<font color='red'>*</font> <br>
				<input type="email" name="email" id="email" class="form-control" placeholder="받는 주소" value="<%=" kdhmm0325"%>@naver.com" required>
				 
				<input type="button" class="btn btn-primary" id="send-email" value="확인메일 전송(send verifycode)"><br>
				
		        <div id="verify-block" class="p-3" style="background-color: #d4edda;">
		          Enter Verification code<font color='red'>*</font> <br>
		          <input type="text" class="form-control" id="email-verify-text"> <input type="button" class="btn btn-primary" id="check-email-verify" value="check">
		          <b id="verify-toggle-text"></b>
		        </div><br>
				
				<!-- 우편번호 block  -->
				<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
				<script>
				$(function() {
					$('#postcode').click(function () {
				        new daum.Postcode({
				          oncomplete: function (data) {
				            console.log('postcode : ' + data.zonecode)
				            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

				            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
				            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
				              extraRoadAddr += data.bname;
				            }
				            // 건물명이 있고, 공동주택일 경우 추가한다.
				            if (data.buildingName !== '' && data.apartment === 'Y') {
				              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				            }
				            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				            if (extraRoadAddr !== '') {
				              extraRoadAddr = ' (' + extraRoadAddr + ')';
				            }
				            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				            if (fullRoadAddr !== '') {
				              fullRoadAddr += extraRoadAddr;
				            }

				            // 우편번호와 주소 정보를 해당 필드에 넣는다.
				            $('#postcode').val(data.zonecode);
				            $('#address').val(fullRoadAddr);
				          }
				        }).open();
				      });//postcode click function
				      
				});//ready
				function post() {
					var child = window.open('post.html', '_blank', 'width=300', 'height=200');
					var width = 400;
					var height = 500;
	
					child.moveTo(0, 0);
					child.resizeTo(width, height);
			      }
				</script>
				
				우편번호, 주소<font color='red'>*</font><br>
				<label for='postcodeBtn'> 
		        <input type="button" value="우편번호 검색하기(Postcode search)" id="postcodeBtn" style="visibility: hidden; display: none;">
				<input type="text" name="postcode" id="postcode" class="form-control" placeholder="search..." readonly required>
				<input type="text" name="address" id="address" class="form-control" placeholder="search..." readonly required>
				</label><br>
				
				상세주소<font color='red'>*</font> <br>
				<input type="text" name="addressDetail" id="addressDetail" class="form-control" placeholder="name..." required>
				<!-- 우편번호 block end -->
				
				<br><br><hr>
					선택 사항입니다.
				<hr>
					설명 <br>
					<input type="text" name="description" id="description" class="form-control" placeholder="name..."> 
					
					프로필 사진 <br>
					<input type="text" name="business_file" id="business_file" class="form-control" placeholder="name..."> 
					<input type="submit" class="submit btn btn-primary">
			</form>

		</div><!--  	<div id="regularContext">   -->
	</div>
</body>
</html>
