$(function() {
	$('button').click(function() {
		location.href = "write";

		});
	});
	
	
	
$(document).ready(function(){
	
	$("#upfile").change(function() {
		console.log($(this).val()) //c.\fakepath\upload.png
		const inputfile = $(this).val().split('\\');
		$('#filevalue').text(inputfile[inputfile.length - 1]);
	});
	
	
	// submit 버튼 클릭할 때 이벤트 부분
	$("form[name=postform]").submit(function() {
		
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
		
	}); //submit end
}) // ready() end