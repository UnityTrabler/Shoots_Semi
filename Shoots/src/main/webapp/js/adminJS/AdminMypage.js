window.onload = function() {
    var firstTab = document.querySelector('#tab-info'); 
    if (firstTab) {
        firstTab.click();
    }
};

//사용자 로드
function loaduser(){
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../admin/userlist', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText; // 내용 뽑아오기 끝
			
		}
		
		
        // 관리자 페이지에서 좌측 탭 누르면 메뉴들 활성화 / 비활성화 시키는 부분 
		var tab = document.querySelector('.cP0-1 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a, .cP0-4 a, .cP0-5 a, .cP0-6 a, .cP0-7 a, .cP0-8 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            	});
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}//loaduser() end

//기업 로드
function loadbusiness(){
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../admin/businesslist', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText; // 내용 뽑아오기 끝
			
		}
		
        // 관리자 페이지에서 좌측 탭 누르면 메뉴들 활성화 / 비활성화 시키는 부분 
		var tab = document.querySelector('.cP0-2 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a, .cP0-4 a, .cP0-5 a, .cP0-6 a, .cP0-7 a, .cP0-8 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            	});
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}//loaduser() end

//기업승인 로드
function loadbusinessApproval(){
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../admin/businessapprove', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText; // 내용 뽑아오기 끝
			
		}
		
        // 관리자 페이지에서 좌측 탭 누르면 메뉴들 활성화 / 비활성화 시키는 부분 
		var tab = document.querySelector('.cP0-3 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a, .cP0-4 a, .cP0-5 a, .cP0-6 a, .cP0-7 a, .cP0-8 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            	});
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}//loaduser() end


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
        var tab = document.querySelector('.cP0-4 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a, .cP0-4 a, .cP0-5 a, .cP0-6 a, .cP0-7 a, .cP0-8 a');
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
		var tab = document.querySelector('.cP0-5 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-2 a, .cP0-1 a, .cP0-3 a, .cP0-4 a, .cP0-5 a, .cP0-6 a, .cP0-7 a, .cP0-8 a');
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
		var tab = document.querySelector('.cP0-6 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a, .cP0-4 a, .cP0-5 a, .cP0-6 a, .cP0-7 a, .cP0-8 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            	});
            tab.classList.add('active');
        }
    };
    xhr.send(); 
} //loadinquiry() 끝


//loadpost()
function loadpost(){
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../admin/postlist', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText; // 내용 뽑아오기 끝
			
			$(function(){
				//관리자 페이지 -  1:1 문의글 리스트 떴을때 삭제버튼 누르면 삭제 할지 말지 뜨는 팝업창
				$("td:nth-child(6) > a").click(function(event){
				const answer = confirm("정말 삭제하시겠습니까?");
				console.log(answer);//취소를 클릭한 경우-false
				if (!answer){//취소를 클릭한 경우
					event.preventDefault(); //이동하지 않습니다.	
					}
				})//삭제 클릭 end
		
			})
		}
		
		
        // 관리자 페이지에서 좌측 탭 누르면 메뉴들 활성화 / 비활성화 시키는 부분 
		var tab = document.querySelector('.cP0-7 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a, .cP0-4 a, .cP0-5 a, .cP0-6 a, .cP0-7 a, .cP0-8 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            	});
            tab.classList.add('active');
        }
    };
    xhr.send();
}//loadpost() end

//report load
function loadreport(){
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../admin/reportList', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText; // 내용 뽑아오기 끝

			
		$(function(){
			$("td:nth-child(6) > input").click(function(event){
				var button = $(this);
				if(button.val() === "처리중"){
					button.val("완료");
				}else{
					button.val("처리중");
				}
			})
		})

		}
		
        // 관리자 페이지에서 좌측 탭 누르면 메뉴들 활성화 / 비활성화 시키는 부분 
		var tab = document.querySelector('.cP0-8 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a, .cP0-3 a, .cP0-4 a, .cP0-5 a, .cP0-6 a, .cP0-7 a, .cP0-8 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            	});
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}//loadreport() end



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
	output += `<tr>
					<td colspan="5" style="text-align:center;">
						<a href="../notice/write" type="button" class="btnWrite">글 쓰 기</a>
					</td>
				</tr>`
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

//inquiry pagination
isRequestInProgress = false
function go_inquiry(page) {
	if(isRequestInProgress) return;
	
	const limit = 10;
	const data = {limit : limit, state : "ajax", page : page};
	ajax_inquiry(data);
}


function generatePagination_inquiry(data) {
	let output = "";
	
	let prevHref = data.page > 1 ? `href=javascript:go_inquiry(${data.page - 1})` : "";
	output += setPaging(prevHref, '&lt;&lt;');
	
	for (let i = data.startpage; i <= data.endpage; i++) {
		const isActive = (i === data.page);
		let pageHref = !isActive ? `href=javascript:go_inquiry(${i})` : "";
		  
		output += setPaging(pageHref, i, isActive); 
	}
	
	let nextHref = (data.page < data.maxpage) ? `href=javascript:go_inquiry(${data.page + 1})` : "";
	output += setPaging(nextHref, '&gt;&gt;' );
	
	$(".pagination").empty().append(output);
}

//문의 tobody
function updateNoticeList_inquiry(data) {
	let output = "<tbody>";
	var num = data.listcount - (data.page - 1) * data.limit + 1;
	$(data.inquirylist).each(function(index, item){
		num-=1;
    	var shortenedTitle = item.title.length >= 20 ? item.title.substring(0, 20) + "..." : item.title;
    	var userId = item.inquiry_type == 'A' ? item.user_id : item.business_id;
    	var inquiryType = item.inquiry_type == 'A' ? "개인회원 문의" : "기업회원 문의";
    	var hasReply = (item.hasReply === true || item.hasReply === 'true') ? "[답변완료]" : "";
		output += `			
			<tr>
				<td>
				${num}
				</td>
				<td>
					
					<div>
						<a class ="inquiryDetail" href="inquirydetail?inquiryid=${item.inquiry_id}">
							${shortenedTitle}
						</a> 
						${hasReply}
					</div>
				</td>
				
				<%--문의자 유형 : A면 개인, B면 기업 --%>
				 <td>
				    <div> ${inquiryType} </div>
				</td>
				
				<%--문의자의 ID. 로그인해서 받아온 회원 유형이 A면  --%>
				<td><div>${userId}</div></td>
							
				<%--문의 등록일--%>
				<td><div>${item.register_date}</div></td>
				
				<%--관리자 페이지에서의 수정/삭제 버튼 --%>
				<td><a href="../inquiry/delete?num=${item.inquiry_id}"  type="button" class="inquiryDelete">삭제</a></td>
			</tr>
            	`;
	});
	output += "</tbody>";
	
	$('table').append(output);
	
	 generatePagination_inquiry(data);
}

function ajax_inquiry(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/admin/inquirylist",
		dataType : "json",
		cache : false, 
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
				$("thead").show();
				$("tbody").remove();
				updateNoticeList_inquiry(data);
			} else {
				$("thead").hide();
				$("tbody").remove();
				$(".pagination").empty();
				$("table").append("<tbody><tr><td colspan='5' style='text-align: center;'>아직 문의주신 사항이 없습니다.</td></tr></tbody>");
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
} //inquiry pagenation 끝


//useradmin pagination
isRequestInProgress = false
function go_user(page) {
	if(isRequestInProgress) return;
	
	const limit = 10;
	const data = {limit : limit, state : "ajax", page : page};
	ajax_user(data);
}


function generatePagination_user(data) {
	let output = "";
	
	let prevHref = data.page > 1 ? `href=javascript:go_user(${data.page - 1})` : "";
	output += setPaging(prevHref, '&lt;&lt;');
	
	for (let i = data.startpage; i <= data.endpage; i++) {
		const isActive = (i === data.page);
		let pageHref = !isActive ? `href=javascript:go_user(${i})` : "";
		  
		output += setPaging(pageHref, i, isActive); 
	}
	
	let nextHref = (data.page < data.maxpage) ? `href=javascript:go_user(${data.page + 1})` : "";
	output += setPaging(nextHref, '&gt;&gt;' );
	
	$(".pagination").empty().append(output);
}

//userlist tobody
function updateUserlist(data) {
	let output = "<tbody>";
	
	$(data.totallist).each(function(index, item){
		var gender = (item.gender == 1 || item.gender == 3) ? "남자" : "여자"
		
		output += (item.role == "common") ? 
    	`			
        	<tr>
            	<td>${item.idx}</td>
            	<td>${item.id}</td>
            	<td>${item.name}</td>
            	<td>${item.RRN}</td>
            	<td>${gender}</td>
            	<td>${String(item.tel).substring(0,3)}-${String(item.tel).substring(3,7)}-${String(item.tel).substring(7)}</td>
            	<td>${item.email}</td>
            	<td>${item.register_date.substring(0, 10)}</td>
            	<td><a href="../admin/grant?id=${item.id}" type="button" class="grantadmin">일반</a></td>
        	</tr>
    	` : 
    	`			
        	<tr>
            	<td>${item.idx}</td>
            	<td>${item.id}</td>
            	<td>${item.name}</td>
            	<td>${item.RRN}</td>
            	<td>${gender}</td>
            	<td>${String(item.tel).substring(0,3)}-${String(item.tel).substring(3,7)}-${String(item.tel).substring(7)}</td>
            	<td>${item.email}</td>
            	<td>${item.register_date.substring(0, 10)}</td>
            	<td><a href="../admin/revoke?id=${item.id}" type="button" class="revokeadmin">관리자</a></td>
        	</tr>
    	`;
    	
	});
	
	output += "</tbody>";
	
	$('table').append(output);
	
	 generatePagination_user(data);
}

function ajax_user(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/admin/userlist",
		dataType : "json",
		cache : false, 
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
				$("thead").show();
				$("tbody").remove();
				updateUserlist(data);
			} else {
				$("thead").hide();
				$("tbody").remove();
				$(".pagination").empty();
				$("table").append("<tbody><tr><td colspan='5' style='text-align: center;'>회원이 존재하지 않습니다</td></tr></tbody>");
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
} //useradmin pagination 끝

//businessadmin pagination
isRequestInProgress = false
function go_business(page) {
	if(isRequestInProgress) return;
	
	const limit = 10;
	const data = {limit : limit, state : "ajax", page : page};
	ajax_business(data);
}


function generatePagination_business(data) {
	let output = "";
	
	let prevHref = data.page > 1 ? `href=javascript:go_business(${data.page - 1})` : "";
	output += setPaging(prevHref, '&lt;&lt;');
	
	for (let i = data.startpage; i <= data.endpage; i++) {
		const isActive = (i === data.page);
		let pageHref = !isActive ? `href=javascript:go_business(${i})` : "";
		  
		output += setPaging(pageHref, i, isActive); 
	}
	
	let nextHref = (data.page < data.maxpage) ? `href=javascript:go_business(${data.page + 1})` : "";
	output += setPaging(nextHref, '&gt;&gt;' );
	
	$(".pagination").empty().append(output);
}

//businesslist tobody
function updateBusiness(data) {
	let output = "<tbody>";
	
	$(data.totallist).each(function(index, item){
		
		output += `			
			<tr>
				<td>${item.business_idx }</td>
				<td>${item.business_id }</td>
				<td>${item.business_name }</td>
				<td>${item.business_number }</td>
				<td>${item.email }</td>
				<td>${item.address} </td>
				<td>${item.register_date.substring(0, 10)}</td>
			</tr>
          `;
	});
	output += "</tbody>";
	
	$('table').append(output);
	
	 generatePagination_business(data);
}

function ajax_business(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/admin/businesslist",
		dataType : "json",
		cache : false, 
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
				$("thead").show();
				$("tbody").remove();
				updateBusiness(data);
			} else {
				$("thead").hide();
				$("tbody").remove();
				$(".pagination").empty();
				$("table").append("<tbody><tr><td colspan='5' style='text-align: center;'>회원이 존재하지 않습니다</td></tr></tbody>");
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
} //businessadmin pagination 끝

//businessapprove pagination
isRequestInProgress = false
function go_approve(page) {
	if(isRequestInProgress) return;
	
	const limit = 10;
	const data = {limit : limit, state : "ajax", page : page};
	ajax_approve(data);
}


function generatePagination_approve(data) {
	let output = "";
	
	let prevHref = data.page > 1 ? `href=javascript:go_approve(${data.page - 1})` : "";
	output += setPaging(prevHref, '&lt;&lt;');
	
	for (let i = data.startpage; i <= data.endpage; i++) {
		const isActive = (i === data.page);
		let pageHref = !isActive ? `href=javascript:go_approve(${i})` : "";
		  
		output += setPaging(pageHref, i, isActive); 
	}
	
	let nextHref = (data.page < data.maxpage) ? `href=javascript:go_approve(${data.page + 1})` : "";
	output += setPaging(nextHref, '&gt;&gt;' );
	
	$(".pagination").empty().append(output);
}

//businesslist tobody
function updateBusinessApprove(data) {
	let output = "<tbody>";
	
	$(data.totallist).each(function(index, item){
		
		output += (item.login_status == "pending") ? 
			`			
			<tr>
				
				<td>${item.business_name }</td>
				<td>${item.business_number }</td>
				<td>${item.email }</td>
				<td>${business.tel.substring(0,3)}-${business.tel.substring(3,7)}-${business.tel.substring(7) }</td>
				<td>${item.register_date.substring(0, 10)}</td>
				<td><b class="pending">대기중</b></td>
				<td>
        			<a href="../admin/approve?id=${item.business_id}" type="button" class="approve">승인</a>
        			<a href="../admin/refuse?id=${item.business_id}" type="button" class="refuse">거절</a>
        		</td>
				
			</tr>
          `: ( (item.login_status == "approved") ?
          `
          <tr>
				
				<td>${item.business_name }</td>
				<td>${item.business_number }</td>
				<td>${item.email }</td>
				<td>${String(business.tel).substring(0,3)}-${String(business.tel).substring(3,7)}-${String(business.tel).substring(7)}</td>
				<td>${item.register_date.substring(0, 10)}</td>
				<td><a href="../admin/refuse?id=${item.business_id}" type="button" class="approved"><b>승인됨</b></a></td>
				<td></td>
				
			</tr>
			`
			:
			`
			 <tr>
				
				<td>${item.business_name }</td>
				<td>${item.business_number }</td>
				<td>${item.email }</td>
				<td>${String(business.tel).substring(0,3)}-${String(business.tel).substring(3,7)}-${String(business.tel).substring(7)}</td>
				<td>${item.register_date.substring(0, 10)}</td>
				<td><a href="../admin/approve?id=${item.business_id}" type="button" class="refused"><b>거절됨</b></a></td>
				<td></td>
				
			</tr>
			`
			);
	});
	output += "</tbody>";
	
	$('table').append(output);
	
	 generatePagination_approve(data);
}

function ajax_approve(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/admin/businessapprove",
		dataType : "json",
		cache : false, 
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
				$("thead").show();
				$("tbody").remove();
				updateBusinessApprove(data);
			} else {
				$("thead").hide();
				$("tbody").remove();
				$(".pagination").empty();
				$("table").append("<tbody><tr><td colspan='5' style='text-align: center;'>기업이 존재하지 않습니다</td></tr></tbody>");
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
} //businessadmin pagination 끝

//postlist pagination
isRequestInProgress = false
function go_post(page) {
	if(isRequestInProgress) return;
	
	const limit = 10;
	const data = {limit : limit, state : "ajax", page : page};
	ajax_post(data);
}


function generatePagination_post(data) {
	let output = "";
	
	let prevHref = data.page > 1 ? `href=javascript:go_post(${data.page - 1})` : "";
	output += setPaging(prevHref, '&lt;&lt;');
	
	for (let i = data.startpage; i <= data.endpage; i++) {
		const isActive = (i === data.page);
		let pageHref = !isActive ? `href=javascript:go_post(${i})` : "";
		  
		output += setPaging(pageHref, i, isActive); 
	}
	
	let nextHref = (data.page < data.maxpage) ? `href=javascript:go_post(${data.page + 1})` : "";
	output += setPaging(nextHref, '&gt;&gt;' );
	
	$(".pagination").empty().append(output);
}

//postlist tobody
function updatePost(data) {
	let output = "<tbody>";
	
	$(data.totallist).each(function(index, item){
		var category = item.category=='A' ? "<span class = 'a'>[자유]</span>" : "<span class = 'b'>[중고]</span>"
		output += `			
			<tr>
				<td>${category}</td>
				<td><a href="../post/detail?num=${item.post_id}"  type="button" class="postDetail">${item.title }</a></td>
				<td>${item.user_id}</td>
				<td>${item.register_date}</td>
				<td>${item.readcount }</td>
				<td><a href="postDelete?id=${item.post_id}"  type="button" class="postDelete">삭제</a></td>
			</tr>
          `;
	});
	output += "</tbody>";
	
	$('table').append(output);
	
	 generatePagination_post(data);
}

function ajax_post(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/admin/postlist",
		dataType : "json",
		cache : false, 
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
				$("thead").show();
				$("tbody").remove();
				updatePost(data);
			} else {
				$("thead").hide();
				$("tbody").remove();
				$(".pagination").empty();
				$("table").append("<tbody><tr><td colspan='5' style='text-align: center;'>게시물이 존재하지 않습니다</td></tr></tbody>");
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
} //postlist pagination 끝


//reportadmin pagination
isRequestInProgress = false
function go_report(page) {
	if(isRequestInProgress) return;
	
	const limit = 10;
	const data = {limit : limit, state : "ajax", page : page};
	ajax_report(data);
}


function generatePagination_report(data) {
	let output = "";
	
	let prevHref = data.page > 1 ? `href=javascript:go_report(${data.page - 1})` : "";
	output += setPaging(prevHref, '&lt;&lt;');
	
	for (let i = data.startpage; i <= data.endpage; i++) {
		const isActive = (i === data.page);
		let pageHref = !isActive ? `href=javascript:go_report(${i})` : "";
		  
		output += setPaging(pageHref, i, isActive); 
	}
	
	let nextHref = (data.page < data.maxpage) ? `href=javascript:go_report(${data.page + 1})` : "";
	output += setPaging(nextHref, '&gt;&gt;' );
	
	$(".pagination").empty().append(output);
}

//reportlist tbody
function updateReportlist(data) {
	let output = "<tbody>";
	
	$(data.totallist).each(function(index, item){
		output += (item.report_type == "A") ?
		`			
			<tr>
				<td>게시글</td>
				<td>${item.reporter_name}</td>
				<td>${item.target_name}</td>
				<td>${item.title} </td>
				<td>${item.register_date.substring(0, 10) }</td>
				<td>
					<button class="status">처리중</button>
				</td>
				<td><a href="../admin/report?id=${item.report_id}" type="button" class="report">자세히 보기</a></td>
			</tr>
          `:((item.report_type=="B") ? 
          `			
			<tr>
				<td>댓글</td>
				<td>${item.reporter_name}</td>
				<td>${item.target_name}</td>
				<td>${item.title} </td>
				<td>${item.register_date.substring(0, 10) }</td>
				<td>
					<button class="status">처리중</button>
				</td>
				<td><a href="../admin/report?id=${item.report_id}" type="button" class="report">자세히 보기</a></td>
			</tr>
          ` :
          `			
			<tr>
				<td>매칭선수</td>
				<td>${item.reporter_name}</td>
				<td>${item.target_name}</td>
				<td>${item.title} </td>
				<td>${item.register_date.substring(0, 10) }</td>
				<td>
					<button class="status">처리중</button>
				</td>
				<td><a href="../admin/report?id=${item.report_id}" type="button" class="report">자세히 보기</a></td>
			</tr>
          `
          )
          ;
	});
	
	output += "</tbody>";
	
	$('table').append(output);
	
	 generatePagination_report(data);
}

function ajax_report(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/admin/reportList",
		dataType : "json",
		cache : false, 
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
				$("thead").show();
				$("tbody").remove();
				updateReportlist(data);
			} else {
				$("thead").hide();
				$("tbody").remove();
				$(".pagination").empty();
				$("table").append("<tbody><tr><td colspan='5' style='text-align: center;'>신고내역이 존재하지 않습니다</td></tr></tbody>");
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
} //reportadmin pagination 끝



