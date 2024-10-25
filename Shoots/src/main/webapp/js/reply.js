$(function() {
	//submit event
	$("form[name=replyform]").submit(function() {
		
		const $board_subject = $("#board_subject");
		if ($boardPass.val().trim() == "") {
			alert("subject 입력하세요.");
			$board_subject.focus();
			return false;
		}//if
		
		const $board_content = $("#board_content");
		if ($board_content.val().trim() == "") {
			alert("내용을 입력하세요");
			$board_content.focus();
			return false;
		}//if
		
		const $board_pass = $("input:password");
		if ($board_pass.val().trim() == "") {
			alert("비밀번호를 입력하세요");
			$board_pass.focus();
			return false;
		}//if
		
	})//submit 
})

