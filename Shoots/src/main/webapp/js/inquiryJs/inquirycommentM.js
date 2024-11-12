$(function() {
    const loginid = $("#loginid").val();  // 로그인한 유저의 id





    $(".ic").each(function() { //문의댓글을 c:foreach 반복문으로 뽑아내서 여러개가 나오기 때문에 각 댓글들마다 코드 실행시키기 위해 each 함수 사용
        const commentwriter = $(this).find(".iqcomment-writer").val();  // 각 댓글의 작성자 id

        if (loginid === commentwriter) {
            $(this).find(".ic-modify").css('display', 'inline-block');  // 수정 버튼 보이기
            $(this).find(".ic-delete").css('display', 'inline-block');  // 삭제 버튼 보이기
        }
    }); //each 함수 끝
    
    $(".ic-num").click(function(){ //삭제 버튼 누르면 해당 i_commoent_id 값에 해당하는 문의댓글 삭제
		
		location.href("/delete")
	}) //문의댓글 삭제 click() 끝
    
    
}); //ready() 끝