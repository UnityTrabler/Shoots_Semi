window.onload = function() {
    var firstTab = document.querySelector('#tab-info'); 
    if (firstTab) {
        firstTab.click();
    }
};


// tap 이동 - FAQ관리
function loadfaq() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../faq/faqAdmin', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText;
			$(function(){
				$("tr > td:nth-child(4) > a").click(function(event){
					const answer = confirm("정말 삭제하시겠습니까?");
					console.log(answer);//취소를 클릭한 경우-false
					if (!answer){//취소를 클릭한 경우
						event.preventDefault(); //이동하지 않습니다.	
					}
				})//삭제 클릭 end
			})
        }
        
        // 관리자 페이지에서 좌측 탭 누르면 메뉴들 활성화 / 비활성화 시키는 부분 
        var tab = document.querySelector('.cP0-1 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });

            tab.classList.add('active');
        }
    };
    xhr.send(); 
}

// tab 이동 - 공지사항
function loadnotice() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../notice/noticeAdmin', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText;
			
			$(function(){
				$("tr > td:nth-child(5) > a").click(function(event){
				const answer = confirm("정말 삭제하시겠습니까?");
				console.log(answer);//취소를 클릭한 경우-false
				if (!answer){//취소를 클릭한 경우
					event.preventDefault(); //이동하지 않습니다.	
					}
				})//삭제 클릭 end
		
				//검색 버튼 클릭한 경우
				$(".filterButton").click(function(){
					//검색어 공백 유효성 검사합니다.
					const word = $(".search").val();
					if (word == ""){
						alert("검색어를 입력하세요");
						$(".search").focus();
						return false;
					}
				})//검색 클릭 end
			})
		}
		
		
        // 관리자 페이지에서 좌측 탭 누르면 메뉴들 활성화 / 비활성화 시키는 부분 
		var tab = document.querySelector('.cP0-2 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-2 a, .cP0-1 a, .cP0-3 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            	});
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}

	//tab 이동 - 1:1 문의글
function loadinquiry() { //ajax로  관리자전용 1:1 문의글 리스트 뽑아오는곳
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../admin/inquirylist', true); 
    xhr.onreadystatechange = function () {
		// xhr.readyState === 4 : 4는 요청이 완료됐다는 뜻의 서버코드
		// xhr.status === 200 : 2은 서버가 요청을 성공적으로 완료했을때 쓰는 서버코드
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText; // 내용 뽑아오기 끝
			
			
			$(function(){
				//관리자 페이지 -  1:1 문의글 리스트 떴을때 삭제버튼 누르면 삭제 할지 말지 뜨는 팝업창
				$("td:nth-child(7) > a").click(function(event){
				const answer = confirm("정말 삭제하시겠습니까?");
				console.log(answer);//취소를 클릭한 경우-false
				if (!answer){//취소를 클릭한 경우
					event.preventDefault(); //이동하지 않습니다.	
					}
				})//삭제 클릭 end
		
			})
		}
		
		
        // 관리자 페이지에서 좌측 탭 누르면 메뉴들 활성화 / 비활성화 시키는 부분 
		var tab = document.querySelector('.cP0-3 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            	});
            tab.classList.add('active');
        }
    };
    xhr.send(); 
} //loadinquiry() 끝


//사용자 로드
function loaduser(){
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../admin/userlist', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText; // 내용 뽑아오기 끝
			
		}
		
		
        // 관리자 페이지에서 좌측 탭 누르면 메뉴들 활성화 / 비활성화 시키는 부분 
		var tab = document.querySelector('.cP0-4 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a, .cP0-4 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            	});
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}//loaduser() end

//pagination
let isRequestInProgress = false;


function go_notice(page, searchWord='') {
	if(isRequestInProgress) return;
	
	const limit = 10;
	const data = {limit : limit, state : "ajax", page : page, search_word: searchWord};
	ajax_notice(data);
}

function setPaging (href, digit, isActive = false) {
	const gray = (href === "" && isNaN(digit)) ? "gray" : "";
	const active = isActive ? "active" : "";
	const anchor = `<a class = "page-link ${gray}" ${href}>${digit}</a>`;
	return `<li class = "page-item ${active}">${anchor}</li>`;
}

function generatePagination_notice(data) {
	let output = "";
	
	let prevHref = data.page > 1 ? `href=javascript:go_notice(${data.page - 1})` : "";
	output += setPaging(prevHref, '&lt;&lt;');
	
	for (let i = data.startpage; i <= data.endpage; i++) {
		const isActive = (i === data.page);
		let pageHref = !isActive ? `href=javascript:go_notice(${i})` : "";
		  
		output += setPaging(pageHref, i, isActive); 
	}
	
	let nextHref = (data.page < data.maxpage) ? `href=javascript:go_notice(${data.page + 1})` : "";
	output += setPaging(nextHref, '&gt;&gt;' );
	
	$(".pagination").empty().append(output);
}

//검색했을 때 나타나는 정보 추가해야 함
function updateNoticeList_notice(data) {
	let output = "<tbody>";
	
	$(data.totallist).each(function(index, item){
				output += `
                	<tr>
                		<td>
							<a href="../notice/adminDetail?id=${item.notice_id}" class="noticeDetail">${item.title}</a>
						</td>
						<td>${item.readcount }</td>
						<td>${item.register_date}</td>
						<td><a href="../notice/update?id=${item.notice_id}" type="button" class="noticeUpdate">수정</a></td>
						<td><a href="../notice/delete?id=${item.notice_id}"  type="button" class="noticeDelete">삭제</a></td>
						
					</tr>
            	`;
	});
	output += "</tbody>";
	
	$('table').append(output);
	
	 generatePagination_notice(data);
}

function ajax_notice(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/admin/notice",
		dataType : "json",
		cache : false, 
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
				$("thead").show();
				$("tbody").remove();
				updateNoticeList_notice(data);
			} else {
				$("thead").hide();
				$("tbody").remove();
				$(".pagination").empty();
				$("table").append("<tbody><tr><td colspan='5' style='text-align: center;'>등록된 공지가 없습니다</td></tr></tbody>");
			}
		},
		error : function() {
			console.log("에러");
			$("thead").hide();
			$("tbody").remove();
    		$(".pagination").empty();
    		$("table").append("<tbody><tr><td colspan='5' style='text-align: center;'>데이터를 불러오는 중 오류가 발생했습니다. 다시 시도해주세요.</td></tr></tbody>");
		}
	});
}

function applyFilter() {
    const searchWord = $("input[name='search_word']").val();
    go_notice(1, searchWord);  // Start from page 1 when a new search is applied
}

function backBtn(){
	var tab1 = document.querySelector('#tab-info'); 
	var tab2 = document.querySelector('#tab');
	
	 
	
	
   window.location.href = 'http://localhost:8088/Shoots/admin/mypage'; // 원하는 페이지로 이동
 
}


