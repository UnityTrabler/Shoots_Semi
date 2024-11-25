<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
	
	<style>
		input[type="text"], input[type="email"], input[type="password"]{width: 300px; border-radius: 30px; padding: 5px; padding-left: 10px; padding-right: 10px; margin-bottom: 10px; border: 1px solid #059669;}
		input{display: block; align-items: center;}
		form{border: 1px solid #059669; padding: 60px; border-radius: 30px; text-align: center; align-items: center; justify-content: center; justify-items:center;	}
		.row>.col{padding: 0px 6px;}
		.regularBtn {font-size :  12px; border-radius : 20px; border : 1px solid orange; width : 80px; height : 25px; color : orange ; background : white; margin-left : 10px; transition: background 0.3s, color 0.3s}
		.businessBtn {font-size :  12px; border-radius : 20px; border : 1px solid orange; width : 80px; height : 25px; color : orange ; background : white; margin-left : 10px; transition: background 0.3s, color 0.3s}
	</style>
	
	
	<script>
		function init() {
 			$('#verify-block').css('display', 'none');
			$("#verify-toggle-text").hide();
			$('button#btnRegular').addClass('btn-success');
			$('input[type=file]').hide();
			$('#preview').attr('src', '${pageContext.request.contextPath}/img/profile.png');
		}
		
		function btnBusinessClick() {
			location.href = '${pageContext.request.contextPath}/user/signupBusiness';
		}
		
		var emailCheck = false;
		function checkInvalidate() {
			var patternIdPwd = /^[a-zA-Z]{1}\w+$/; // 첫글자 알파벳 + 최대 19글자 한글없이 입력하여야 됩니다.
			var patternName = /^[\w가-힣]{1,99}$/; // 최대 100글자 가능합니다. 			
			var patternRRN = /^\d{6}$/; // 6자리 숫자
			var patternGender = /^\d{1}$/; // 1자리 숫자
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
			else if(!patternName.test($('#name').val())){
				alert('올바른 이름 형식이 아닙니다.\n 특수문자 없이 최대 100글자 가능합니다.');
				$('#name').focus();
				return false;
			}
			else if(!patternRRN.test($('#RRN').val())){
				alert('올바른 주민번호 앞자리 형식이 아닙니다.\n 6자리 숫자만 가능합니다.');
				$('#RRN').focus();
				return false;
			}
			else if(!patternGender.test($('#gender').val())){
				alert('올바른 주민번호 뒷자리 형식이 아닙니다.\n 숫자만 가능합니다.');
				$('#gender').focus();
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
		}//checkInvalidate()
	
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
					$('#preview').show();
					$('#preview').attr('src', URL.createObjectURL(event.target.files[0]));
					$('#filename').text('파일변경');
				}
				
				else{
					alert('image file(gif,jpg,jpeg,png) 파일만 올려주세요.');
					$('#showImage > img').attr('src', '../image/profile.png');
					$(this).val('');
					$('input[name=check]').val('');
					return;
				}
				
			});//file change event
			
			$('#fileReset').click(function(e) {
				e.preventDefault();
				$('input[type=file]').val('');
				$('#preview').val('');
				$('#filename').text('파일첨부');
				$('#preview').attr('src', '${pageContext.request.contextPath}/img/profile.png');
			});
			
			$('#signupform').on('submit',function(e) {
				e.preventDefault();
				
				var invali = checkInvalidate(); //유효성검증
				if(invali == false) return;
				
				const data = $(this).serialize();
				let state;
				if ($('#btnGroupRB').find('.btn-success').first().attr('id') != null)
					state = $('#btnGroupRB').find('.btn-success').first().attr('id') == 'btnRegular' ? {'state' : 'regular'} : {'state' : 'business'};
				
				$.ajax({
					url: $(this).attr('action'),
					method:$(this).attr('method'),
					data:`\${data + "&" + $.param(state)}`,
					success: function(resp) {
						alert(resp.message);
						window.location.href = "${pageContext.request.contextPath}/user/login";
					},
					error: function(xhr, textStatus, errorThrown) {
						console.log('ajax error');
						var response = JSON.parse(xhr.responseText);
						alert(response.message);
					}
				});//$.ajax
			});//$('#signupform').submit
			
		});//ready 
	</script>
</head>

<body>
	<jsp:include page="top.jsp"></jsp:include>
    <jsp:include page="topUserSwitching.jsp"></jsp:include>
	<div id="switchingContext"  class="container">
		<jsp:include page="RegularFormArea.jsp"></jsp:include>
	</div>
</body>
</html>
