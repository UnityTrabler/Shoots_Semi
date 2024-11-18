let option = 1; // 유지할 정렬 옵션

function getList(state) {
  console.log(state); 
  option = state;
  $.ajax({
    type: "get",
    url: "../comments/list",
    data: {
      "post_id": $("#post_id").val(), 
      state: state
    },
    dataType: "json",
    success: function(rdata) {
      $('#count').text(rdata.listcount).css('font-family', 'arial,sans-serif');
      let red1 = (state == 1) ? 'red' : 'gray';
      let red2 = (state == 2) ? 'red' : 'gray';
	
      let output =`
        <li class='comment-order-item ${red1}'>
          <a href='javascript:getList(1)' class='comment-order-button'>등록순</a>
        </li>
        <li class='comment-order-item ${red2}'>
          <a href='javascript:getList(2)' class='comment-order-button'>최신순</a>
        </li>`;
      $('.comment-order-list').html(output);

      output = ''; // 초기화
      if (rdata.commentlist.length) { 
        rdata.commentlist.forEach(comment => {
          let replyClass = (comment.comment_ref_id) ? 'comment-list-item--reply' : ''; // comment_ref_id가 있으면 답글로 처리
          let src = comment.user_file ? `../userupload/${comment.user_file}` : '../img/profile.png';
          
          // 답글 버튼은 원문 댓글에만 표시
          let replyButton = (!comment.comment_ref_id) ? `<a href='javascript:replyform(${comment.comment_id})' class='comment-info-button'>답글쓰기</a>` : '';
          
          // 로그인한 사람이 댓글 작성자일 경우 수정/삭제 버튼 표시
          let toolButtons = $("#loginid").val() == comment.id ? ` 
            <div class='comment-tool'>
              <div title='더보기' class='comment-tool-button'> 
                <div>&#46;&#46;&#46;</div>
              </div>
              <div id='comment-list-item-layer${comment.comment_id}' class='LayerMore'>
                <ul class='layer-list'>
                  <li class='layer-item'>
                    <a href='javascript:updateForm(${comment.comment_id})' class='layer-button'>수정</a>
                    <a href='javascript:del(${comment.comment_id})' class='layer-button'>삭제</a>
                  </li>
                </ul>
              </div>
            </div>` : '';
          
          output += ` 
          <li id='${comment.comment_id}' class='comment-list-item ${replyClass}'>
            <div class='comment-nick-area'>
              <img src='${src}' alt='profile picture' width='36' height='36'>
              <div class='comment-box'>
                <div class='comment-nick-box'>
                  <div class='comment-nick-info'>
                    <div class='comment-nickname'>${comment.id}</div>
                  </div>
                </div>
                <div class='comment-text-box'>
                  <p class='comment-text-view'>
                    <span class='text-comment'>${comment.content}</span>
                  </p>
                </div>
                <div class='comment-info-box'>
                  <span class='comment-info-date'>${comment.register_date}</span>
                  ${replyButton}
                </div>
                ${toolButtons}
              </div>
            </div>
          </li>`;
        });
      }
      $('.comment-list').html(output);

      if (!rdata.commentlist.length) {
        $('.comment-list, .comment-order-list').empty();
      }
    }
  });
}


// 더보기 - 수정 클릭한 경우에 수정 폼을 보여줍니다.
function updateForm(comment_id) {
  $(".comment-tool, .LayerMore").hide(); // 더보기 및 수정 삭제 영역 숨김
  let $num = $('#' + comment_id);
  const content = $num.find('.text-comment').text(); // 선택한 댓글 내용
  $num.find('.comment-nick-area').hide(); // 댓글 닉네임 영역 숨김
  $num.append($('.comment-list+.comment-write').clone()); // 기본 글쓰기 폼 복사하여 추가

  // 수정 폼의 <textarea>에 내용을 나타냅니다.
  $num.find('.comment-write textarea').val(content);
  // 수정 완료 버튼 및 취소 버튼 보이기
  //'.btn-register' 영역에 수정할 글 번호를 속성 'data-id'에 나타내고 클래스 'update'를 추가합니다.
  $num.find('.btn-register').attr('data-id', comment_id).addClass('update').text('수정완료');
  //폼에서 취소를 사용할 수 있도록 보이게 합니다.
  $num.find('.btn-cancel').show();
  // 글자 수 표시
  $num.find('.comment-write-area-count').text(`${content.length}/200`);
}


 //더보기 -> 삭제 클릭한 경우 실행하는 함수
function del(comment_id) {//num : 댓글 번호
  if (!confirm('정말 삭제하시겠습니까?')) {
    $('#comment-list-item-layer' + comment_id).hide(); // '수정 삭제' 영역 숨김
    return;
  }
  $.ajax({
    url: '../comments/delete',
    data: { num: comment_id },
    success: function(rdata) {
      if (rdata == 1) {
        getList(option); // 댓글 리스트 다시 불러오기
      }
    }
  });
}



//답글 달기 폼
function replyform(comment_id, comment_ref_id) {
  //수정 삭제 영역 선택 후 답글쓰기를 클릭한 경우
  $(".LayerMore").hide(); // 수정 삭제 영역 숨김
  let $num = $('#' + comment_id);
  //선택한 글 뒤에 답글 폼을 추가합니다.
  $num.after(`<li class="comment-list-item comment-list-item--reply"></li>`);
  
  // 글쓰기 영역 복사
  let replyForm = $('.comment-list+.comment-write').clone();
  
  //복사한 폼을 답글 영역에 추가
  let $num_next = $num.next().html(replyForm);
  
  // 답글 폼의 <textarea>에 '답글을 남겨보세요' placeholder 설정
  $num_next.find('textarea').attr('placeholder', '답글을 남겨보세요');
  
  //답글 폼의 'btn-cancel'을 보여주고 클래스 'reply-cancel'를 추가합니다.
  $num_next.find('.btn-cancel').show().addClass('reply-cancel');
  
  //답글 폼의 '.btn-register'에 클래스 'reply' 추가합니다.
  //속성 'data-ref'에 ref, 'data-lev'에 lev, 'data-seq'에 seq값을 설정합니다.
  //등록을 답글 완료로 변경합니다.
  $num_next.find('.btn-register')
           .addClass('reply')
           .attr({ 'data-ref': comment_ref_id }) // 부모 댓글의 comment_id를 'data-ref'로 설정
           .text('답글완료');
  //댓글 폼 보이지 않습니다.
  $("body > div > div.comment-area > div.comment-write").hide(); // 댓글 폼 숨기기
}





$(function() {
  getList(option); // 처음 로드될 때는 등록순 정렬

 $('.comment-area').on('keyup','.comment-write-area-text', function() {
	 const length=$(this).val().length;
	 $(this).prev().text(length+'/200');
 }); // keyup','.comment-write-area-text', function() 

  //댓글 등록을 클릭하면 데이터베이스에 저장 -> 저장 성공 후에 리스트 불러옵니다.
  $('ul + .comment-write .btn-register').click(function() {
    const content = $('.comment-write-area-text').val();
    if (!content) {
      alert("댓글을 입력하세요");
      return;
    }
    
    $.ajax({
      url: '../comments/add',
      data: {
        id: $("#loginid").val(),
        content: content,
        post_id: $("#post_id").val(),  
        comment_ref_id: null // 원본 댓글은 comment_ref_id가 null
      },
      type: 'post',
      success: function(rdata) {
        if (rdata == 1) {
          getList(option); // 댓글 리스트 갱신
        }
      }
    });

    $('.comment-write-area-text').val(''); // textarea 초기화
    $('.comment-write-area-count').text('0/200'); // 입력한 글 카운트 초기화
  }); // $('ul + .comment-write .btn-register').click(function() {


  // 더보기를 클릭한 경우
	$(".comment-list").on('click', '.comment-tool-button', function() {
		//더보기를 클릭하면 수정과 삭제 영역이 나타나고 다시 클릭하면 사라져요
		$(this).next().toggle();
		
		//클릭 한 곳만 수정 삭제 영역이 나타나도록 합니다.
		$(".comment-tool-button").not(this).next().hide();
	})
    
    
    // 수정 후 수정완료를 클릭한 경우
	$('.comment-area').on('click','.update',function(){
		const content = $(this).parent().parent().find('textarea').val();
		if(!content){ //내용없이 등록 클릭한 경우
			alert("수정할 글을 입력하세요");
			return;
		}
		const num = $(this).attr('data-id');
		$.ajax({
			url:'../comments/update',
			data:{num:comment_id, content:content},
			success:function(rdata){
				if(rdata==1){
					getList(option);
				}// if
			} // success
		}); //ajax
	}) // 수정 후 수정완료를 클릭한 경우
    
    
    // 수정 후 취소 버튼을 클릭한 경우
	$('.comment-area').on('click','.btn-cancel',function(){
		// 댓글 번호를 구합니다.
		const num = $(this).next().attr('data-id');
		const selector = '#' + num;
		
		//.comment-write 영역 삭제 합니다.
		$(selector + ' .comment-write').remove();
		
		//숨겨두었던 .comment-nick-area 영역 보여줍니다.
		$(selector + '>.comment-nick-area').css('display','block');
		
		// 수정 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겼는데 취소를 선택하면 보여주도록 합니다.
		$(".comment-tool").show();
		
	}) // 수정 후 취소 버튼을 클릭한 경우
	
	
	//답글완료 클릭한 경우
	$('.comment-area').on('click', '.reply', function(){
		
		const content= $(this).parent().parent().find('.comment-write-area-text').val();
		if(!content){ //내용없이 답글완료 클릭한 경우
			alert("답글을 입력하세요");
			return;
		}
		
		

    $.ajax({
      type: 'post',
      url: '../comments/reply',
      data: {
        id: $('#loginid').val(),
        content: content,
        post_id: $("#post_id").val(),  
        comment_ref_id: $(this).attr('data-ref') // 부모 댓글의 comment_id를 comment_ref_id로 설정
      },
      success: function(rdata) {
        if (rdata == 1) {
          getList(option); // 댓글 리스트 갱신
        }
      }
    });// ajax
    
	//답글 폼 보여줍니다.
    $("body > div > div.comment-area > div.comment-write").show(); // 댓글 폼 보이기
  }); //답글완료 클릭한 경우

  // 답글쓰기 후 취소 버튼을 클릭한 경우
	$('.comment-area').on('click','.reply-cancel', function(){
		$(this).parent().parent().parent().remove();
		$(".comment-tool").show(); // 더 보기 영역 보이도록 합니다.
	
		//댓글 폼 보여줍니다.
		$("body> div > div.comment-area > div.comment-write").show();
	})//답글쓰기 후 취소 버튼을 클릭한 경우
	
	//답글쓰기 클릭 후 계속 누르는 것을 방지하기 위한 작업
	$('.comment-area').on('click','.comment-info-button', function(event) {
		//답변쓰기 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겨요
		$(".comment-tool").hide();
	
		//답글쓰기 폼의 갯수를 구합니다.
		const length=$(".comment-area .btn-register.reply").length;
		if(length==1){ //답글쓰기 폼이 한 개가 존재하면 anchor 태그(<a>)의 기본 이벤트를 막아
					   //또 다른 답글쓰기 폼이 나타나지 않도록 합니다.
		event.preventDefault();
		}
	})//답글쓰기 클릭 후 계속 누르는 것을 방지하기 위한 작업
  
  
});
