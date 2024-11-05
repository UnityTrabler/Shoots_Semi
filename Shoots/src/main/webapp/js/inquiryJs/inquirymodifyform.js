$(function(){
	
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
	});
	
	let check = 0;
	
	
	// '수정'버튼 눌렀을때 유효성 검사
	$("form[name=modifyform]").submit(function(){
		const $title = $('#title');
		if($title.val().trim() == ""){
			alert("제목을 입력해 주세요.");
			$title.focus();
			return false;
		}
		
		const $content = $('#content');
		if($content.val().trim() == ""){
			alert("내용을 입력해 주세요.");
			$content.focus();
			return false;
		}
		
		//파일명을 숨긴 뒤에 폼 전송시에 서버로 전송해주는 코드
		if(check == 0){
			const value = $('#filevalue').text();
			const html = `<input type='hidden' value='${value}' name='check'>`;
			console.log(html);
			$(this).append(html);
		}
		
	});//submit click event
	
	$("#upfile").change(function(){
		check++;
		const maxSizeInBytes = 5 * 1024 * 1024;
		const file = this.files[0];
		if(file.size > maxSizeInBytes){
			alert("첨부할 파일의 용량은 5MB 이하여야 합니다.");
			$(this).val('');
		}else
			$('#filevalue').text(file.name);
		
		show();
	});
	
});