

/*
 $(function() {
	$('button').click(function() {
		location.href = "list";

		});
	});
*/




	/*
	
	
    $(document).ready(function(){
	// 카테고리 선택 시 가격 입력란 처리
    $("input[name='category']").change(function () {
        if ($("#B").is(":checked")) {
            $("#price").show(); // 중고게시판 선택 시 가격 입력란 보이기
        } else {
            $("#price").hide(); // 자유게시판 선택 시 가격 입력란 숨기기
        }
    });
    
	 */
	
	
	
    
	
	$("#upfile").change(function() {
		console.log($(this).val()) //c.\fakepath\upload.png
		const inputfile = $(this).val().split('\\');
		$('#filevalue').text(inputfile[inputfile.length - 1]);
	});
	
	
	
	
	
	// submit 버튼 클릭 시 유효성 검사 및 AJAX 처리
    $("form[name=writeform]").submit(function(event) {
        event.preventDefault(); // 기본 폼 제출 동작을 막음

        const $title = $("#title");
        if ($title.val().trim() == "") {
            alert("제목을 입력하세요");
            $title.focus();
            return false;
        }
        
        const $content = $("#content");
        if ($content.val().trim() == "") {
            alert("내용을 입력하세요");
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
            url: 'postInsert',  // 서버에 데이터 전송할 URL
            type: 'POST',
            data: formData,
            contentType: false, // 파일 전송시 반드시 false로 설정
            processData: false, // jQuery에서 자동으로 데이터를 처리하지 않도록 설정
            success: function(response) {
                if (response.success) {
                    // 성공적으로 게시글이 등록되었으면 리스트 페이지로 리다이렉트
                    alert("게시글이 등록되었습니다.");
                    location.href = "list"; //리스트 페이지로 이동
                } else {
                    alert("게시글 등록에 실패했습니다. 다시 시도해 주세요.");
                   
                }
            },
            error: function(xhr, status, error) {
                alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
                console.error(error);
               
            },
            complete: function() {
                // 버튼을 다시 활성화 시켜주기
                $('button[type="submit"]').prop('disabled', false);
            }
        });
        
        
        
        /*
        
        
        
        // 모든 입력이 정상이라면 폼을 전송
        const formData = new FormData(this);  // this는 현재 폼을 가리킴

        // submit 버튼 비활성화 (중복 제출 방지)
        $('button[type="submit"]').prop('disabled', true);

        // AJAX를 통해 폼 데이터 전송
        $.ajax({
            url: 'postInsert',  // 서버에 데이터 전송할 URL
            type: 'POST',
            data: formData,
            contentType: false, // 파일 전송시 반드시 false로 설정
            processData: false, // jQuery에서 자동으로 데이터를 처리하지 않도록 설정
            success: function(response) {
                if (response.success) {
                    // 성공적으로 게시글이 등록되었으면 리스트 페이지로 리다이렉트
                    alert("게시글이 등록되었습니다.");
                    location.href = "list"; //리스트 페이지로 이동
                } else {
                    alert("게시글 등록에 실패했습니다. 다시 시도해 주세요.");
                   
                }
            },
            error: function(xhr, status, error) {
                alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
                console.error(error);
               
            },
            complete: function() {
                // 버튼을 다시 활성화 시켜주기
                $('button[type="submit"]').prop('disabled', false);
            }
        });
        
        
        
         */
        
        
         
        
        
        
       
        
	
	
}) // ready() end



	
	