$(function() {
	
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
	
	//문의글쓰기에서 '등록' 눌렀을때 제목/내용이 공백일 경우 창 띄움 
	$("form[name=inquiryform]").submit(function() {
		
		const $title = $("#title");
		if ($title.val().trim() == "") {
			alert("제목을 입력해 주세요");
			$title.focus();
			return false;
		}//if
		
		const $content = $("#content");
		if ($content.val().trim() == "") {
			alert("내용을 입력해 주세요");
			$content.focus();
			return false;
		}//if
	})//submit 
	
	
	//글쓰기 중 취소 누르면 confirm 창 뜨고 확인 시 뒤로가기, 취소시 현상유지
	$("div:nth-child(6) > button.btn.btn-danger").click(function(){
		const $title = $("#title");
		const $content = $("#content");
		
		if (!($title.val().trim() == "") || !($content.val().trim() == "") ) {
			if(confirm("정말 글 작성을 취소하시겠습니까?")) {
			history.back();
			}
		} else (history.back())
	}) //click 끝
	
	
})