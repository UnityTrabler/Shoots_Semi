	//선택한 등록순과 최신순을 수정, 삭제, 추가 후에도 유지되도록 하기위한 변수로 사용됩니다.
	let option=1; // 선택한 정렬 순서를 저장하는 변수 (기본값 1)
	
	
	
	
	
	
	// 댓글 등록
	$('ul + .comment-write .btn-register').click(function() {
	    const content = $('.comment-write-area-text').val();
	    const postId = $("#post_id").val();  // 게시글 번호를 가져옵니다.
	
	    if (!content) {
	        alert("댓글을 입력하세요");
	        return;
	    }
	
	    $.ajax({
	        url: '../comments/add',
	        data: {
	            user_id: $("#loginid").val(),
	            content: content,
	            post_id: postId,  // 게시글 번호 추가
	        },
	        type: 'post',
	        success: function(rdata) {
	            if (rdata == 1) {
	                getList(postId); // 댓글 목록 갱신
	            }
	        }
	    });
	});
	
	
	
	
	
	
	
	function getList(postId) {
    $.ajax({
        type: "get",
        url: "../comments/list",
        data: {
            post_id: postId  // 게시글 번호를 사용하여 댓글 조회
        },
        dataType: "json",
        success: function(rdata) {
            let output = '';
            if (rdata.commentlist.length) {
                rdata.commentlist.forEach(post_comment => {
                    let src = post_comment.user_file ? `../postupload/${post_comment.user_file}` : '../img/profile.png';
                    let replyButton = `<a href='javascript:replyform(${post_comment.comment_id})' class='comment-info-button'>답글쓰기</a>`;

                    let toolButtons = $("#loginid").val() == post_comment.user_id ? `
                        <div class='comment-tool'>
                            <div title='더보기' class='comment-tool-button'>
                                <div>&#46;&#46;&#46;</div>
                            </div>
                            <div id='comment-list-item-layer${post_comment.comment_id}' class='LayerMore'>
                                <ul class='layer-list'>
                                    <li class='layer-item'>
                                        <a href='javascript:updateForm(${post_comment.comment_id})' class='layer-button'>수정</a>
                                        <a href='javascript:del(${post_comment.comment_id})' class='layer-button'>삭제</a>
                                    </li>
                                </ul>
                            </div>
                        </div>` : '';

                    output += `
                        <li id='${post_comment.comment_id}' class='comment-list-item'>
                            <div class='comment-nick-area'>
                                <img src='${src}' alt='profile picture' width='36' height='36'>
                                <div class='comment-box'>
                                    <div class='comment-nick-box'>
                                        <div class='comment-nick-info'>
                                            <div class='comment-nickname'>${post_comment.user_id}</div>
                                        </div>
                                    </div>
                                    <div class='comment-text-box'>
                                        <p class='comment-text-view'>
                                            <span class='text-comment'>${post_comment.content}</span>
                                        </p>
                                    </div>
                                    <div class='comment-info-box'>
                                        <span class='comment-info-date'>${post_comment.register_date}</span>
                                        ${replyButton}
                                    </div>
                                    ${toolButtons}
                                </div>
                            </div>
                        </li>`;
                });
            } else {
                output = '<li>댓글이 없습니다.</li>';
            }

            $('.comment-list').html(output);
        }
        
    });
}