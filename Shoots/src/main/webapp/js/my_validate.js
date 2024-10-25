    $(function () {

      $('form#myform').submit(function (event) {
        let $input = $('input');
        let flat = true;
        $input.each(function (event) {
          if ($(this).val().trim() === "") {
            alert($(this).attr('ID') + " is space");
            $(this).focus();
            flat = false;
            return false;
          }
        });
        if (!flat) return flat;

        if ($('input[name=hobby]:checked').length < 2) {
          alert('more hobby');
          return false;
        } //hobby-check

        return flat;
      });//all-check

      $('input[type = button]').click(function () {
        const id = $('#id');
        const idValue = id.val().trim();
        if(idValue == ""){
			alert("id 입력하셈");
			id.focus();
			return false;
		} else{
			
		}
        
        var reg = new RegExp("^[A-Z]([a-z]|[A-Z]|[0-9]|_){3,}$");
        const pattern = /^[A-Z]([a-z]|[A-Z]|[0-9]|_){3,19}$/;
        if (reg.test(id.val().trim()) === false) {
          alert('첫번째 대문자, 2번째 부터는 대소문자 숫자 _ 로 총 4개 이상');
          return false;
        }

        if (id.val().trim() !== "") {
          var child = window.open(`idcheck.net?id=${idValue}`);
          var width = screen.width;
          var height = screen.height;

          child.moveTo(0, 0);
          child.resizeTo(width, height);
        }
      })//id-check

      $('#jumin1, #jumin2').keyup(function () {
        if ($(this).val().length === 6)
          $('#jumin2').focus();

        if (isNaN($(this).val())) {
          $(this).val(jumin1.value.slice(0, -1));
          $(this).focus();
          alert("first part is NaN");
        }

        //var reg = new RegExp("^[1-4]{1}[0-9]{0,}$");

        $('#gender1').prop('checked', ($('#jumin2').val()[0] === '1' || $('#jumin2').val()[0] === '3'));
        $('#gender2').prop('checked', !($('#gender1').is(':checked')));

      }); //RRN-check

      $('#postcode').click(function () {
        new daum.Postcode({
          oncomplete: function (data) {
            console.log(data.zonecode)
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
            $('#post1').val(data.zonecode);
            $('#address').val(fullRoadAddr);
          }
        }).open();
      });
    });


    function domain1() {
      $('#domain').val($('#sel').val());
    }

    function post() {
      var child = window.open('post.html', '_blank', 'width=300', 'height=200');
      var width = 400;
      var height = 500;

      child.moveTo(0, 0);
      child.resizeTo(width, height);
    }

