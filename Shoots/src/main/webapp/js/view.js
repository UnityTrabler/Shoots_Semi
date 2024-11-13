	//선택한 등록순과 최신순을 수정, 삭제, 추가 후에도 유지되도록 하기위한 변수로 사용됩니다.
	let option=1; // 선택한 정렬 순서를 저장하는 변수 (기본값 1)
	
	function getList(state) {
    
    console.log(state); 
    //사용자가 선택한 정렬 순서를 option 변수에 저장
	  option = state; // state 1이면 등록순, 2면 최신순
    
    $.ajax({
		type: "get",
    url: "../comments/list",
    data: {
        "post_id": $("#post_id").val(),
        state: state
    },
		dataType: "json",
    success: function(rdata) {
		//서버에서 받은 댓글 목록의 개수 표시
		$('#count').text(rdata.listcount).css('font-family', 'arial,sans-serif');
		
		// 등록순과 최신순 버튼의 색상 설정
		let red1 = (state == 1) ? 'red': 'gray';
		let red2 = (state == 2) ? 'red': 'gray';
		
		//정렬 순서를 선택할 수 있는 버튼을 출력합니다.
		//사용자가 클릭하면 getList 함수가 호출되어 댓글 목록이 재정렬됩니다.
		let output = `
	    <li class='comment-order-item ${red1}'>
	        <a href='javascript:getList(1)' class='comment-order-button'>등록순</a>
	    </li>
	    <li class='comment-order-item ${red2}'>
	        <a href='javascript:getList(2)' class='comment-order-button'>최신순</a>
	    </li>`;
	$('.comment-order-list').html(output)
	
	//댓글 목록을 생성하여 화면에 출력합니다. 
	//rdata.commentlist 배열에 있는 각 댓글을 처리하고, 
	//이를 HTML 형식으로 변환하여 output 변수에 저장
	output = ''; 
	if (rdata.commentlist.length) { 
	    rdata.commentlist.forEach(comment => {
	        //댓글의 내용, 작성자, 날짜 등 다양한 정보가 comment-list 요소 내에 동적으로 추가됩니다.
	        
	        
	        
	    });
	}
	$('.comment-list').html(output);
	
	
		
	}
		
	})
}//function getList()