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
  var xhr = new XMLHttpRequest();
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
						<td>${item.name}</td>
						<td>
						<a href="notice/detail?id=${item.notice_id}" class="noticeDetail">${item.title}</a>
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

