$(document).ready(function(){
	let check = 0;
	$("#upfile").change(function(){
		check++;
		const maxSizeInBytes = 20 * 1024 * 1024;
		const file = this.files[0]; //선택된 파일
		if(file.size > maxSizeInBytes) {
			alert("파일용량 <= 20MB 이어야함.");
			$(this).val('');
		} else{
			$('#filevalue').text(file.name); //파일 이름
		}
		show();
	});
	
	function show(){
		//파일 이름이 있는 경우 remove 이미지를 보이게 하고
		//파일 이름이 없는 경우 remove이미지를 보이지 않게 합니다.
		$('.remove').css('display', $('#filevalue').text() ? 'inline-block' : 'none')
					.css({'position': 'relative', 'top': '-5px'});
	}
	show();
	
	//remove 이미지를 클릭하면 파일명을 ''로 변경하고 remove이미지를 보이지 않게 합니다.
	$(".remove").click(function(){
		$("#filevalue").text('');
		$(this).css('display', 'none');
	})
	
})//ready end