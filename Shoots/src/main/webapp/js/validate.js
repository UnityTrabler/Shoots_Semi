$(document).ready(function() {
	let idCheckValue = ''; // id 중복 검사 때 사용한 값으로 정규식 통과한 값을 저장
	$('form#myform').submit(function() {
		const id = $('#id');
		if (id.val().trim() === '') {
			alert('ID를 입력하세요.');
			id.focus();
			return false;
		}

		const path = location.pathname;
		console.log(path) //=> /JSP_Template_JSTL/join.net
		//sign up form & 정보 수정 form 에서 동시에 사용할 js
		//아래 문장들은 sign up form에서만 사용할 문장들.
		//정보 수정 form에서는 id를 수정하지 않기 때문에 필요없는 부분임.
		if (path.endsWith("join.net")) {
			//submit 당시 id값과 id 중복검사에 사용된 id를 비교함.
			if (id.val().trim() != idCheckValue) {
				alert("ID 중복검사를 하세요");
				$("#opener_message").text('');
				return false;
			}
			const result = $("#result").val();
			//id 중복 검사를 했지만 사용중인 아이디인 경우에는 submit시 경고창 나타납니다.
			if (result == '-1') {
				alert("사용 가능한 아이디로 다시 입력 하세요");
				id.val('').focus();
			}
		}//if (path.endsWith("join.net"))



		if (id.val().trim() !== idCheckValue) {
			alert('ID 중복체크를 하세요.');
			$('#idcheck').focus();
			return false;
		}

		const $pass = $('#pass');
		if ($pass.val().trim() === '') {
			alert('비밀번호를 입력하세요.');
			$pass.focus();
			return false;
		}

		const $jumin1 = $('#jumin1');
		if ($jumin1.val().trim().length !== 6) {
			alert('주민번호 앞자리 6자리를 입력하세요.');
			$jumin1.val('').focus();
			return false;
		}
		if (!$.isNumeric($jumin1.val().trim())) {
			alert('주민번호 앞자리 6자리는 숫자만 입력 가능합니다.');
			$jumin1.val('').focus();
			return false;
		}

		const $jumin2 = $('#jumin2');
		if ($jumin2.val().trim() === '') {
			alert('주민번호 뒷자리를 입력하세요.');
			$jumin2.focus();
			return false;
		}
		if ($jumin2.val().trim().length !== 7) {
			alert('주민번호 뒷자리 7자리를 입력하세요.');
			$jumin2.val('').focus();
			return false;
		}
		if (!$.isNumeric($jumin2.val().trim())) {
			alert('주민번호 뒷자리 7자리는 숫자만 입력 가능합니다.');
			$jumin2.val('').focus();
			return false;
		}

		const $email = $('#email');
		if ($email.val().trim() === '') {
			alert('E-mail 아이디를 입력하세요.');
			$email.focus();
			return false;
		}

		const $domain = $('#domain');
		if ($domain.val().trim() === '') {
			alert('E-mail 도메인를 입력하세요.');
			$domain.focus();
			return false;
		}

		const $gender = $('input:radio:checked');
		if ($gender.length === 0) {
			alert('남, 여 중에서 1개를 선택하세요.');
			return false;
		}

		const $hobbys = $('input:checkbox:checked');
		if ($hobbys.length < 2) {
			alert('2개 이상의 취미를 선택하세요.')
			return false;
		}

		const $post1 = $('#post1');
		if ($post1.val().trim() === '') {
			alert('우편번호를 입력하세요.');
			$post1.focus();
			return false;
		}
		if (!$.isNumeric($post1.val().trim())) {
			alert('우편번호는 숫자만 입력 가능합니다.');
			$post1.val('').focus();
			return false;
		}

		const $address = $('#address');
		if ($address.val().trim() === '') {
			alert('주소를 입력하세요.');
			$address.focus();
			return false;
		}

		const $intro = $('#intro');
		if ($intro.val().trim() === '') {
			alert('자기소개를 입력하세요.');
			$intro.focus();
			return false;
		}
	})

	$('#idcheck').click(function() {
		const $id = $('#id');
		const idVal = $id.val().trim();

		if (idVal === '') {
			alert('ID를 입력하세요.');
			$id.focus();
			return false;

		} else {
			const pattern = /^[A-Z][A-Za-z0-9_]{3,19}$/;
			if (pattern.test(idVal)) {
				idCheckValue = idVal;
				const ref = `idcheck.net?id=${idVal}`;

				window.open(ref, 'idcheck', 'width=350, height=200');
			} else {
				alert('첫글자는 대문자이고 두번째부터는 대소문자, 숫자, _로 총 4개 이상이어야 합니다.');
				$id.val('').focus();

			}
		}
	})

	$('input[name=gender]').click(function() {
		return false;
	})

	$('#jumin1').keyup(function() {
		const jumin1Value = $(this).val().trim();
		if (jumin1Value.length === 6) {
			const jumin1Pattern = /^[0-9]{2}(0[1-9]|1[012])(0[1-9]|1[0-9]|2[0-9]|3[01])$/;
			if (jumin1Pattern.test(jumin1Value)) {
				$('#jumin2').focus();
			} else {
				alert('숫자 또는 형식에 맞게 입력하세요[yymmdd]');
				$(this).val('').focus();
			}
		}
	})

	$('#jumin2').keyup(function() {
		const jumin2Value = $(this).val().trim();
		if (jumin2Value.length === 7) {
			const jumin2Pattern = /^[1234][0-9]{6}$/;
			if (jumin2Pattern.test(jumin2Value)) {
				let genderNum = Number(jumin2Value.substring(0, 1));
				let index = (genderNum - 1) % 2;

				$('input[name=gender]').eq(index).prop('checked', true);
			} else {
				alert('형식에 맞게 입력하세요[1234][0-9]{6}');
				$(this).val('').focus();
			}
		} else {
			$('#gender1, #gender2').prop('checked', false)
		}
	});

	$('select#sel').change(function() {
		const $domain = $('#domain');
		if ($(this).val()) {
			$domain
				.attr('readonly', true)
				.val($(this).val());
		} else {
			$domain
				.attr('readonly', false)
				.val('')
				.focus();
		}
	})

	$('input#postcode').click(function() {
		new daum.Postcode({
			oncomplete: function(data) {
				console.log(data.zonecode)
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				let fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				let extraRoadAddr = ''; // 도로명 조합형 주소 변수

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
				$('#post1').val(data.zonecode);
				$('#address').val(fullRoadAddr);
			}
		}).open();
	})
})
