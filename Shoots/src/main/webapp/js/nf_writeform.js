$(document).ready(function(){
	$("#upfile").change(function(){
		console.log($(this).val())	//c:\fakepath\upload.png
		const inputfile = $(this).val().split('\\');
		$('#filevalue').text(inputfile[inputfile.length - 1]);
	});
	
})//ready end