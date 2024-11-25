function loadfaq(pageName, elmnt){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '../faq/faqList', true);
  // Hide all elements with class="tabcontent" by default */
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Remove the background color of all tablinks/buttons
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.backgroundColor = "";
  }

  // Show the specific tab content
  document.getElementById(pageName).style.display = "block";

  // Add the specific color to the button used to open the tab content
  elmnt.style.backgroundColor = "white";
  
  // 요청을 보내고 응답을 처리합니다.
  xhr.onreadystatechange = function() {
  	if (xhr.readyState === 4 && xhr.status === 200) {
            // 요청이 성공적으로 완료되면 탭에 데이터를 삽입합니다.
    	document.getElementById(pageName).innerHTML = xhr.responseText; // 서버 응답을 탭 내용으로 넣습니다.
    	
    	$(document).ready(function(){
  			$(".accordion").on("click", function() {
    			$(this).toggleClass("active");
    			var panel = $(this).next(".panel");
    
    			if (panel.css("max-height") !== "0px") {
     				panel.css("max-height", "0");
    			} else {
     				 panel.css("max-height", panel.prop("scrollHeight") + "px");
    			}
  			});
		});
	}
  };	
  xhr.send();
  
}

function loadnotice(pageName, elmnt){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '../customer/notice', true);
  // Hide all elements with class="tabcontent" by default */
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Remove the background color of all tablinks/buttons
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.backgroundColor = "";
  }

  // Show the specific tab content
  document.getElementById(pageName).style.display = "block";

  // Add the specific color to the button used to open the tab content
  elmnt.style.backgroundColor = "white";
  
  // 요청을 보내고 응답을 처리합니다.
  xhr.onreadystatechange = function() {
  	if (xhr.readyState === 4 && xhr.status === 200) {
            // 요청이 성공적으로 완료되면 탭에 데이터를 삽입합니다.
    	document.getElementById(pageName).innerHTML = xhr.responseText; // 서버 응답을 탭 내용으로 넣습니다.
    	
    	$(function(){
			//검색 버튼 클릭한 경우
			$(".filterButton").click(function(){
				//검색어 공백 유효성 검사합니다.
				const word = $(".search").val();
				if (word == ""){
					alert("검색어를 입력하세요");
					$(".search").focus();
					return false;
				}
			})
			
		})
	}
  };	
  xhr.send();
  
}


function loadinquiry(pageName, elmnt){
  
  var idx = document.getElementById('idx');
  var xhr = new XMLHttpRequest();
  
  if (idx == null || idx.value.trim() === "") {

        alert("로그인 후 이용가능합니다.");
        location.href = "../user/login";
        return;
    }
  xhr.open('GET', '../inquiry/list', true);
  // Hide all elements with class="tabcontent" by default */
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Remove the background color of all tablinks/buttons
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.backgroundColor = "";
  }

  // Show the specific tab content
  document.getElementById(pageName).style.display = "block";

  // Add the specific color to the button used to open the tab content
  elmnt.style.backgroundColor = "white";
  
  // 요청을 보내고 응답을 처리합니다.
  xhr.onreadystatechange = function() {
  	if (xhr.readyState === 4 && xhr.status === 200) {
            // 요청이 성공적으로 완료되면 탭에 데이터를 삽입합니다.
    	document.getElementById(pageName).innerHTML = xhr.responseText; // 서버 응답을 탭 내용으로 넣습니다.
	}
  };	
  xhr.send();
  
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();


//notice pagination
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

function updateNoticeList_notice(data) {
	let output = "<tbody>";
	
	$(data.totallist).each(function(index, item){
		var shortenedTitle = item.title.length >= 20 ? item.title.substring(0, 20) + "..." : item.title;
				output += `
                	<tr>
						<td>${item.name}</td>
						<td>
						<a href="notice/detail?id=${item.notice_id}" class="noticeDetail">${shortenedTitle}</a>
						</td>
						<td>${item.register_date }</td>
						<td>${item.readcount }</td>
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
		url : "/Shoots/customer/notice",
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
						<a class ="inquiryDetail" href="../inquiry/detail?inquiryid=${item.inquiry_id}">
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
		url : "/Shoots/inquiry/list",
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
}
