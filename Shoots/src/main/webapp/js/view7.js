let option=1;  //선택한 등록순과 최신순을 수정, 삭제, 추가 후에도 유지되도록 하기위한 변수로 사용됩니다.

function getList(state) {
    
}//function getList()

//더보기-수정 클릭한 경우에 수정 폼을 보여줍니다.
function updateForm(num) {
   
}
	
//더보기 -> 삭제 클릭한 경우 실행하는 함수
function del(num){//num : 댓글 번호
  	
}//function(del) end


//답글 달기 폼
function replyform(num, lev, seq, ref) {
	             
}


$(function() {
	
	getList(option);  //처음 로드 될때는 등록순 정렬
	
	$('form[name="deleteForm"]').submit(function() {
		if ($("#board_pass").val() == '') {
			alert("비밀번호를 입력하세요");
			$("#board_pass").focus();
			return false;
		}
    })// form
	
})//ready