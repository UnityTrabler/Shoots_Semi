$(function(){
	function show(){
	//file name 있는/없는 경우 remove 보이게/안보이게
	$('.remove').css('display' , $('#filevalue').text() ? 'inline-block' : 'none')
	.css({'position' : 'relative', 'top' : '-5px'});
	}
	
	show();
	
	$('.remove').click(function(){
		$('#filevalue').text('');
		$(this).css('display', 'none');// or $('.remove').toggle();
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
			alert("내용을 입력해 주세요..");
			$content.focus();
			return false;
		}
		
		
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