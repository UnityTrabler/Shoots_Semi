function toggleTab(tabId, element) {
	var content = document.getElementById(tabId);

	if (content.style.display === "none") {
		content.style.display = "block";
		element.classList.add("active"); 
	} else {
		content.style.display = "none";
		element.classList.remove("active"); 
	}
        
}

// tap 이동
function loadBusinessStatistics() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../business/statistics', true); 
    xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
				document.getElementById('content-container').innerHTML = xhr.responseText;
            }
        };
    xhr.send(); 
}

function loadBusinessSales() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../business/sales', true); 
    xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
				document.getElementById('content-container').innerHTML = xhr.responseText;
            }
        };
    xhr.send(); 
}

function loadBusinessMyposts() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../business/myposts', true); 
    xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
				document.getElementById('content-container').innerHTML = xhr.responseText;
            }
        };
    xhr.send(); 
}

function loadBusinessCustomer() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../business/customers', true); 
    xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
				document.getElementById('content-container').innerHTML = xhr.responseText;
            }
        };
    xhr.send(); 
}


// pagination
let isRequestInProgress = false;

function go(page) {
	if (isRequestInProgress) return;
	 
	const limit = 7;
	const year = document.getElementById('year').value;  // 선택된 연도
    const month = document.getElementById('month').value;
	const data = {limit : limit, state : "ajax", page : page,  year: year, month: month};
	ajax(data);
}

function setPaging (href, digit, isActive = false) {
	const gray = (href === "" && isNaN(digit)) ? "gray" : "";
	const active = isActive ? "active" : "";
	const anchor = `<a class = "page-link ${gray}" ${href}>${digit}</a>`;
	return `<li class = "page-item ${active}">${anchor}</li>`;
}

function generatePagination(data) {
	let output = "";
	
	let prevHref = data.page > 1 ? `href=javascript:go(${data.page - 1})` : "";
	output += setPaging(prevHref, '&lt;&lt;');
	
	for (let i = data.startpage; i <= data.endpage; i++) {
		const isActive = (i === data.page);
		let pageHref = !isActive ? `href=javascript:go(${i})` : "";
		  
		output += setPaging(pageHref, i, isActive); 
	}
	
	let nextHref = (data.page < data.maxpage) ? `href=javascript:go(${data.page + 1})` : "";
	output += setPaging(nextHref, '&gt;&gt;' );
	
	$(".pagination").empty().append(output);
}

function updateMatchList(data) {
	let num = data.listcount - (data.page - 1) * data.limit;
	let output = "<tbody>";
	
	$(data.list).each(function(index, item){
		
		output += `
			<tr>
				<td> ${item.match_date.substring(0,10)} </td>
				<td> ${item.match_time} </td>
				<td> <a href = "detail?match_id=${item.match_id}" class = "locatinA"> ${item.business_name} </a> </td>
				<td> ${item.player_max} </td>
				<td> <input type = "button" class = "status" data-match-id="${item.match_id}" value = "신청가능"> </td>
			</tr>
		`;
	});
	output += "</tbody>";
	$('table').append(output);
	
	 generatePagination(data);
}

function ajax(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/business/myposts",
		dataType : "json",
		cache : false,
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
				$("tbody").remove();
				updateMatchList(data);
				generatePagination(data);
			}
		},
		error : function() {
			console.log("에러");
		}
	});
}