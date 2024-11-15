$(function() {
    const loginid = $("#loginid").val();  // 로그인한 유저의 id
    const postid = $("#postid").val(); // 게시글 번호.
    
    $('#register-comment').click(function(e) {
        e.preventDefault();  // 기본 폼 제출 막기

        var content = $('textarea[name="content"]').val();
        var postId = $('input[name="postid"]').val();
        var loginId = $('input[name="loginid"]').val();

        // 유효성 검사
        if (content.trim() === "") {
            alert("댓글 내용을 입력해주세요.");
            return;
        }

        // AJAX 요청
        $.ajax({
            type: "POST",
            url: "../comments/add",  // 댓글 추가를 처리할 URL
            data: {
                content: content,
                postid: postId,
                loginid: loginId
            },
            
            success: function(response) {
                if (response.status === "success") {
                    // 댓글이 성공적으로 추가되면 댓글 목록을 갱신
                    var newComment = response.newComment;  // 서버에서 새 댓글 데이터를 받아옴
                    var commentHTML = `
                        <div class="co">
                            <input type="hidden" value="${newComment.comment_id}" class="co-num">
                            <img src="${pageContext.request.contextPath}/img/profile.png" alt="프로필" width="60" height="48">
                            <div class="buttonfront">
                                <p><strong>작성자:</strong> ${newComment.user_id} <strong>등록일:</strong> ${newComment.register_date}</p>
                                <button type="button" class="btn btn-primary co-modify" style="display:none" value="${newComment.comment_id}">수정</button>
                                <button type="button" class="btn btn-danger co-delete" style="display:none" value="${newComment.comment_id}">삭제</button>
                            </div>
                            <span class="comment-content">${newComment.content}</span>
                        </div>
                        <hr>
                    `;
                    // 댓글 목록에 새로운 댓글 추가
                    $('.comments-section').append(commentHTML);
                    
                    // 폼 초기화
                    $('textarea[name="content"]').val('');
                } else {
                    alert("댓글 작성 실패. 다시 시도해주세요.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
    });

    // 취소 버튼 클릭 시 폼 초기화
    $('#cancel-comment').click(function() {
        $('#commentform')[0].reset();
        $('#cancel-comment').hide();
        $('#register-comment').show();
    });
    
    
    
    

    $(".co").each(function() { //댓글을 c:foreach 반복문으로 뽑아내서 여러개가 나오기 때문에 각 댓글들마다 코드 실행시키기 위해 each 함수 사용
        const commentwriter = $(this).find(".comment-writer").val();  // 각 댓글의 작성자 id

        if (loginid === commentwriter) {
            $(this).find(".co-modify").css('display', 'inline-block');  // 수정 버튼 보이기
            $(this).find(".co-delete").css('display', 'inline-block');  // 삭제 버튼 보이기
        }
    }); //each 함수 끝
    
    
    
    
    //댓글 등록
	    $(function() {
	    $('#register-comment').click(function(e) {
	        e.preventDefault();  // 기본 폼 제출을 막음
	        if ($("#commentform")[0].checkValidity()) {
	            $("#commentform").submit();  // 폼을 전송
	        }
	    });
	
	    $('#cancel-comment').click(function() {
	        $('#commentform')[0].reset();  // 댓글 폼 초기화
	        $('#cancel-comment').hide();
	        $('#register-comment').show();
	    });
	});
    
    
    
    
    
    $(".co-delete").click(function(){ //삭제 버튼 누르면 해당 comment_id 값에 해당하는 댓글 삭제
		const deletenum = $(this).val();
		const postid = $("#postid").val();  //삭제 후 다시 글로 돌아갈때 글의 번호값을 저장
		console.log(postid);
		
		
		location.href= `${contextPath}/comments/delete?comment_id=${deletenum}&postid=${postid}`;
	}) //문의댓글 삭제 click() 끝
    
    
    $(".co-modify").click(function(){ //수정 버튼 누르면 해당 수정,삭제 버튼 사라지고 수정완료 , 취소 버튼이 생기게
		
		const $modifybutton = $(this);
		const $deletebutton = $(this).closest(".co").find(".co-delete")
		
		 const modifyCompleteButton = $('<button>', {
            type: "button",
            class: "btn btn-success co-modifyComplete",
            text: "수정완료"
        });
        
        //수정취소 버튼 생성
        const modifyCancelButton = $('<button>', {
            type: "button",
            class: "btn btn-danger co-modifyCancel",
            text: "취소"
        });
		
		
		//수정, 삭제 버튼 숨기기
		$modifybutton.hide();
		$deletebutton.hide();
		
		//기존 댓글의 내용을 originalContent 라고 선언. 후에 숨김 (수정 버튼 누르면 기존 내용 숨기고 텍스트 박스 나오게)
		const originalContent = $(this).closest(".co").find(".comment-content")
		originalContent.hide();
		
		//새 댓글 내용창을 textarea로 만들고 기존 댓글내용 뒤에 갖다 붙임 (기존 내용은 숨겨서 기존 자리에 대체된거로 보임)
		const newContent = $('<textarea>', {
			text: $(originalContent).text(),
			class : "new-comment-content",
			name : "new-comment-content"
		})
		
		originalContent.after(newContent);
		
		//수정, 삭제버튼 숨긴 뒤 만들어둔 수정완료, 수정취소 버튼을 div(buttonfront) 부분 뒤에 갖다 붙임.
		//선택자가 긴 이유는, 그냥 buttonfront.append 로 붙이면 모든 댓글에 다 수정완료 버튼이 생겨버림.
		$modifybutton.closest(".co").find(".buttonfront").append(modifyCompleteButton, modifyCancelButton);
		
		
		$(".co-modifyCancel").click(function(){ //수정취소 버튼 누르면 숨겼던 수정, 삭제 버튼 다시 나오게 하고 수정완료, 수정취소버튼 삭제함
			const $modifyComplete = $(this).closest(".co").find(".co-modifyComplete")
			const $modifyCancel = $(this);
			$modifyComplete.remove();
			$modifyCancel.remove();
			
			$modifybutton.show();
			$deletebutton.show();
			
			newContent.remove();
			originalContent.show();
			
		})
		
		$(".co-modifyComplete").click(function() {  //수정완료 버튼을 누를시 실행하는 ajax.
		    const modifyButton = $(this);
		    const commentId = modifyButton.closest(".co").find(".co-num").val(); // 댓글 ID
		    const newContent = modifyButton.closest(".co").find(".new-comment-content").val(); // 새 댓글 내용
		    //const postId = $("#postid").val(); // 글 ID
		
		    $.ajax({
		        url: `${contextPath}/comments/modify`,
		        type: "POST",
		        data: {
		            "comment_id": commentId,
		            "new-comment-content": newContent,
		            "postid": postid
		        },
		        success: function(response) {
		            // 서버로부터 성공적인 응답을 받은 경우 처리
		            alert("댓글을 성공적으로 수정했습니다.");
		            location.href = `${contextPath}/post/detail?postid=${postid}`;
		        },
		        error: function(xhr, status, error) {
		            // 오류 처리
		            console.log("수정 실패:", error);
		            alert("문의댓글을 수정하지 못했습니다.");
		        }
		    }); //ajax 끝
		    
		    
		}); //수정완료 메서드 끝

		
	}) //'수정' 버튼 누르면 작동하는 메서드 끝
    
    
}); //ready() 끝