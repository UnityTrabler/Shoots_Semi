$(function(){
	function go(page){
		const limit = $('#viewcount').val();
		// const data = `limit=${limit}&state=ajax&page=${page}`;
		const data = {limit:limit, state:"ajax", page:page}
		ajax(data);
	}
	
	function setPaging(href, digit, isActive = false){
		const gray = (href == "" && isNaN(digit)) ? "gray" : "";
		const active = isActive ? "active" : "";
		const anchor = `<a class = "page-link ${gray}" ${href}> ${digit}</a>`;
	}
	
	function ajax(sdata){
		console.log(sdata);
		$.ajax({
			data : sdata,
			url : "list",
			dataType : "json",
			cache : false,
			
			success : function(data){
				$("#viewcount").val(data.limit);
				$("thead").find("span").text("글 개수 : " + data.listcount);
				
				if(data.listcount > 0){
					$("tbody").remove();
					updateBoardList(data); //게시판 내용 update
					generatePagination(data); // pagination 생성
				}	
			}, //success
			error:function(){
				console.log('error');
			}
		});
	}//function ajax
	
	function updateBoardList(data){
		let num = data.listcount - (data.page - 1) * data.limit;
		let output = "<tbody>";
		
		$(data.boardlist).each(function(index, item){
			const blank = '&nbsp;&nbsp;'.repeat(item.board_re_lev * 2);
			const img = item.board_re_lev > 0 ? "<img src='../image/line.gif'>" : "";
			const subject = item.board_subject.length >= 20
						  ? item.board_subject.substr(0,20) + "..." : item.board_subject;
			const changeSubject = subject.replace(/</g, '&lt;').replace(/>/g, '&gt;'); 
			
			output +=
				`<tr>
					<td>${num--}</td>
					<td><div>${blank}${img}<a href = 'detail?num=${item.board_num}'>${changeSubject}</a>[${item.cnt}]</div></td>
					<td><div>${item.board_name}</div></td>
					<td><div>${item.board_date}</div></td>
					<td><div>${item.board_readcount}</div></td>
				</tr>`;
		});
		output += "</tbody>";
		$('table').append(output);
	}
	
	$('button').click(function(){
		location.href = "write";
	});//button click
	
	$("#viewcount").change(function(){
		go(1);//보여줄 페이지 1로 설정
	});//change
});