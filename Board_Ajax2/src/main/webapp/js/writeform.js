$(function() {
	$('button').click(function() {
		location.href = "write";
	});
	
	$("#upfile").change(function(){
		console.log($(this).val());
		const inputfile = $(this).val().split('\\');
		$('#filevalue').text(inputfile[inputfile.length-1]);
	});
	
	//submit event
	$("form[name=boardform]").submit(function() {
		const $boardPass = $("#board_pass");
		if ($boardPass.val().trim() == "") {
			alert("비밀번호 입력하세요");
			$boardPass.focus();
			return false;
		}//if
		
		const $boardSubject = $("#board_subject");
		if ($boardSubject.val().trim() == "") {
			alert("제목을 입력하세요");
			$boardSubject.focus();
			return false;
		}//if
		
		const $boardContent = $("#board_content");
		if ($boardContent.val().trim() == "") {
			alert("내용을 입력하세요");
			$boardContent.focus();
			return false;
		}//if
		
	})//submit 

})

