$(function() {
	
	$("#upfile").change(function(){
		console.log($(this).val());
		const inputfile = $(this).val().split('\\');
		$('#filevalue').text(inputfile[inputfile.length-1]);
	});
	
	//submit event
	$("form[name=inquiryform]").submit(function() {
		
		const $title = $("#title");
		if ($title.val().trim() == "") {
			alert("제목을 입력하세요");
			$title.focus();
			return false;
		}//if
		
		const $content = $("#content");
		if ($content.val().trim() == "") {
			alert("비밀번호 입력하세요");
			$content.focus();
			return false;
		}//if
		
		
		
	})//submit 

})