$(document).ready(function(){
	
	//첨부파일이 있을(없을)경우 remove 이미지가 보이도록(안보이도록) 하는 함수
	function show(){ 
	$('.remove').css('display' , $('#filevalue').text() ? 'inline-block' : 'none')
	.css({'position' : 'relative', 'top' : '-5px'});
	}
	
	
	//미리 show 함수를 실행해서 remove 이미지를 세팅해놓음
	show();
	
	//첨부파일 옆 x 표시 아이콘 누르면 첨부했던 첨부파일 다시 없애기
	$('.remove').click(function(){
		$('#filevalue').text('');
		$(this).css('display', 'none');// or $('.remove').toggle();
	});
	
	
	//사용자가 첨부파일을 업로드하면 업로드 한 첨부파일의 이름이 나타나게 하는 함수
	$("#upfile").change(function(){
		console.log($(this).val());
		const inputfile = $(this).val().split('\\');
		$('#filevalue').text(inputfile[inputfile.length-1]);
		show();
	});
	
	})
 // $(document).ready(function(){ end
	
	
	
	$("form[name=modifyform]").submit(function(event){
		event.preventDefault();  // 기본 폼 제출을 막음
		
		const $title = $('#title');
		if($title.val().trim() == ""){
			alert("제목을 입력하세요.");
			$title.focus();
			return false;
		}
		
		const $content = $('#content');
		if($content.val().trim() == ""){
			alert("내용을 입력하세요.");
			$content.focus();
			return false;
		}
		
		
		
		// 중고게시판(B) 선택 시 가격 확인
        if ($("#B").is(":checked")) {
            const $price = $("#priceInput");
            if ($price.val().trim() == "") {
                alert("가격을 입력하세요");
                $price.focus();
                return false;
            }
            // 가격이 숫자인지 확인
            if (isNaN($price.val().trim())) {
                alert("가격은 숫자만 입력 가능합니다.");
                $price.focus();
                return false;
            }
        }
        
		
	
		
		
			
			// 모든 입력이 정상이라면 폼을 전송
        const formData = new FormData(this);  // this는 현재 폼을 가리킴
        // submit 버튼 비활성화 (중복 제출 방지)
        $('button[type="submit"]').prop('disabled', true);

        // AJAX를 통해 폼 데이터 전송
        $.ajax({
            url: 'modifyProcess',  // 서버에 데이터 전송할 URL
            type: 'POST',
            data: formData,
            contentType: false, // 파일 전송시 반드시 false로 설정
            processData: false, // jQuery에서 자동으로 데이터를 처리하지 않도록 설정
            success: function(response) {
                if (response.success) {
                    // 성공적으로 게시글이 등록되었으면 리스트 페이지로 리다이렉트
                    alert("게시글이 수정되었습니다.");
                } else {
                    alert("게시글 수정에 실패했습니다. 다시 시도해 주세요.");
                    location.href = "list";
                }
            },
            error: function(xhr, status, error) {
                alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
                console.error(error);
                //location.href = "modify?num=" + response.post_id;
            },
            complete: function() {
                // 버튼을 다시 활성화 시켜주기
                $('button[type="submit"]').prop('disabled', false);
            }
        });
        
		
	});//submit click event
	
	
	
	
	
	
	





