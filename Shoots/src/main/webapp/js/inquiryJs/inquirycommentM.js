$(function() {
    const loginid = $("#loginid").val();  // 로그인한 유저의 id

    $(".ic").each(function() { //문의댓글을 c:foreach 반복문으로 뽑아내서 여러개가 나오기 때문에 각 댓글들마다 코드 실행시키기 위해 each 함수 사용
        const commentwriter = $(this).find(".iqcomment-writer").val();  // 각 댓글의 작성자 id

        if (loginid === commentwriter) {
            $(this).find(".ic-modify").css('display', 'inline-block');  // 수정 버튼 보이기
            $(this).find(".ic-delete").css('display', 'inline-block');  // 삭제 버튼 보이기
        }
    }); //each 함수 끝
    
    
    $(".ic-delete").click(function(){ //삭제 버튼 누르면 해당 i_commoent_id 값에 해당하는 문의댓글 삭제
		const deletenum = $(this).val();
		const inquiryid = $("#inquiryid").val();  //삭제 후 다시 문의글로 돌아갈때 글의 번호값을 저장
		console.log(inquiryid);
		
		location.href= `${contextPath}/iqcomments/delete?i_comment_id=${deletenum}&inquiryid=${inquiryid}`;
	}) //문의댓글 삭제 click() 끝
    
    
    $(".ic-modify").click(function(){ //수정 버튼 누르면 해당 수정,삭제 버튼 사라지고 수정완료 , 취소 버튼이 생기게
		
		const $modifybutton = $(this);
		const $deletebutton = $(this).closest(".ic").find(".ic-delete")
		
		 const modifyCompleteButton = $('<button>', {
            type: "button",
            class: "btn btn-success ic-modifyComplete",
            text: "수정완료"
        });
        
        //수정취소 버튼 생성
        const modifyCancelButton = $('<button>', {
            type: "button",
            class: "btn btn-danger ic-modifyCancel",
            text: "취소"
        });
		
		
		//수정, 삭제 버튼 숨기기
		$modifybutton.hide();
		$deletebutton.hide();
		
		//기존 댓글의 내용을 originalContent 라고 선언. 후에 숨김 (수정 버튼 누르면 기존 내용 숨기고 텍스트 박스 나오게)
		const originalContent = $(this).closest(".ic").find(".iqcomment-content")
		originalContent.hide();
		
		//새 댓글 내용창을 textarea로 만들고 기존 댓글내용 뒤에 갖다 붙임 (기존 내용은 숨겨서 기존 자리에 대체된거로 보임)
		const newContent = $('<textarea>', {
			placeholder: $(originalContent).text()
		})
		
		originalContent.after(newContent);
		
		//수정, 삭제버튼 숨긴 뒤 만들어둔 수정완료, 수정취소 버튼을 div(buttonfront) 부분 뒤에 갖다 붙임.
		$(".buttonfront").append(modifyCompleteButton, modifyCancelButton);
		
		
		$(".ic-modifyCancel").click(function(){ //수정취소 버튼 누르면 숨겼던 수정, 삭제 버튼 다시 나오게 하고 수정완료, 수정취소버튼 삭제함
			const $modifyComplete = $(this).closest(".ic").find(".ic-modifyComplete")
			const $modifyCancel = $(this);
			$modifyComplete.remove();
			$modifyCancel.remove();
			
			$modifybutton.show();
			$deletebutton.show();
			
			newContent.remove();
			originalContent.show();
			
		})
		
		
		
	}) //'수정' 버튼 누르면 작동하는 메서드 끝
    
    
}); //ready() 끝