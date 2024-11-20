window.onload = function() {
    var firstTab = document.querySelector('#tab-info');
    if (firstTab) {
        loadBusinessInfo();
    }
};

function toggleTab(tabId, element) {
	var content = document.getElementById(tabId);
	var activeTabs = document.querySelectorAll('.sub-tabs a, .cP0-1 a, .cP0-2 a');
	activeTabs.forEach(function(item) {
		item.classList.remove('active');
	});
	if (content.style.display === "none") {
		content.style.display = "block";
		element.classList.add("active"); 
	} else {
		content.style.display = "none";
		element.classList.remove("active"); 
	}
        
}

// tap 이동
function loadBusinessInfo() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../business/info', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText;
        }
        
        var tab = document.querySelector('.cP0-1 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.sub-tabs a, .cP0-1 a, .cP0-2 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });

            tab.classList.add('active');
        }
    };
    xhr.send(); 
}

function loadBusinessStatistics() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../business/statistics', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText;
        }
        var tab = document.querySelector('.cP0-t1 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a, .cP0-2 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });

            tab.classList.add('active');
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
         var tab = document.querySelector('.cP0-t2 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-t1 a, .cP0-1 a, .cP0-2 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });

            tab.classList.add('active');
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
         var tab = document.querySelector('.cP0-t3 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-t1 a, .cP0-t2 a, .cP0-1 a, .cP0-2 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });

            tab.classList.add('active');
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
        
        var tab = document.querySelector('.cP0-2 a'); 
        if (tab) {
            var activeTabs = document.querySelectorAll('.sub-tabs a, .cP0-2 a, .cP0-1 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });

            tab.classList.add('active');
        }
    };
    xhr.send(); 
}


// pagination
let isRequestInProgress = false;

function go(page, year, month) {
	if (isRequestInProgress) return;
	 
	const limit = 10;
	const data = {limit : limit, state : "ajax", page : page,  year: year, month: month};
	ajax(data);
}

function sgo(year, month) {
	if (isRequestInProgress) return;
	
	const sdata = {state : "ajax", year: year, month: month};
	sajax(sdata);
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
	let output = "<tbody id = 'searchResults'>";
	let previousDate = "";
    let rowspan = 1;
    
    const currentDate = new Date();
    const currentDateTime = currentDate.getFullYear() + '-' +
							(currentDate.getMonth() + 1).toString().padStart(2,'0') + '-' +
							 currentDate.getDate().toString().padStart(2, '0') + ' ' +
							 currentDate.getHours().toString().padStart(2, '0') + ':' +
                             currentDate.getMinutes().toString().padStart(2, '0');
    
    console.log(currentDateTime);
    
	$(data.list).each(function(index, item){
		
		const matchDate = item.match_date.substring(0, 10);
		const formattedDate = matchDate.replace(/-/g, '/');
		
		const matchTime = item.match_time;
		const matchDateTime = matchDate + ' ' + matchTime;
		
		const twoHoursInMilliseconds = 2 * 60 * 60 * 1000;
		
		const a = new Date(matchDateTime);
		const b = new Date(a.getTime() - twoHoursInMilliseconds);
			
		const isMatchPast = b < new Date(currentDateTime);
		
		if (matchDate === previousDate) {
            rowspan++;
            output += `
                <tr>
                    <td class="empty-td"></td>
                    <td> ${item.match_time} </td>
                    <td> <a href="../matchs/detail?match_id=${item.match_id}" class="locatinA"> ${item.business_name} </a> </td>
                    <td> ${item.player_max} </td>
                    <td>
                    	${isMatchPast && item.playerCount >= item.player_min
                    	? `<input type="button" class="status5" value="매칭확정">` 
                    	: (isMatchPast
                    		? `<input type="button" class="status4" value="마감">`
              				:(item.playerCount == item.player_max 
	                    		? `<input type="button" class="status2" value="마감">`
							    : (item.playerCount >= item.player_min && item.playerCount < item.player_max
							        ? `<input type="button" class="status3" data-match-id="${item.match_id}" value="마감임박">`
							        : (item.playerCount >= 0 && item.playerCount <= item.player_min
							            ? `<input type="button" class="status" data-match-id="${item.match_id}" value="신청가능">`
							            : '')
							        )
							    )
							)
						}
					</td>
                </tr>
            `;
            
        } else {
			output += `
				<tr>
					<td rowspan="${rowspan}"> ${formattedDate} </td>
					<td> ${item.match_time} </td>
                    <td> <a href="../matchs/detail?match_id=${item.match_id}" class="locatinA"> ${item.business_name} </a> </td>
					<td> ${item.player_max} </td>
					<td>
                    	${isMatchPast && item.playerCount >= item.player_min
                    	? `<input type="button" class="status5" value="매칭확정">` 
                    	: (isMatchPast
                    		? `<input type="button" class="status4" value="마감">`
              				:(item.playerCount == item.player_max 
	                    		? `<input type="button" class="status2" value="마감">`
							    : (item.playerCount >= item.player_min && item.playerCount < item.player_max
							        ? `<input type="button" class="status3" data-match-id="${item.match_id}" value="마감임박">`
							        : (item.playerCount >= 0 && item.playerCount <= item.player_min
							            ? `<input type="button" class="status" data-match-id="${item.match_id}" value="신청가능">`
							            : '')
							        )
							    )
							)
						}
					</td>
				</tr>
			`;
		 }
		 rowspan = 1;
		 previousDate = matchDate;
	});
	
	output += "</tbody>";
	$('table').append(output);
	
	 generatePagination(data);
}

function supdateMatchList(data) {
	
	let output = "<tbody id = 'searchResults'>";
	let previousDate = "";
    let rowspan = 1;
    let dailyTotal = 0;
    let totalPlayerCount = 0;
    let totalSales = 0;
    
    const currentDate = new Date();
    const currentDateTime = currentDate.getFullYear() + '-' +
							(currentDate.getMonth() + 1).toString().padStart(2,'0') + '-' +
							 currentDate.getDate().toString().padStart(2, '0') + ' ' +
							 currentDate.getHours().toString().padStart(2, '0') + ':' +
                             currentDate.getMinutes().toString().padStart(2, '0');
    
    console.log(currentDateTime);
    
	$(data.list).each(function(index, item){
		
		const matchDate = item.match_date.substring(0, 10);
		const formattedDate = matchDate.replace(/-/g, '/');
		
		totalPlayerCount += item.playerCount;
        totalSales += item.price * item.playerCount; 
        
		if (matchDate === previousDate) {
            rowspan++;
            dailyTotal += item.price * item.playerCount;
            output += `
                <tr>
                    <td class="empty-td"></td>
                    <td> ${item.match_time} </td>
                    <td> ${item.price} </td>
                    <td> ${item.playerCount} </td>
                    <td> ${item.total} </td>
                </tr>
            `;
            
        } else {
			
			if (previousDate !== "") {
                output += `
                    <tr>
                        <td colspan="3"></td>
                        <td style="font-weight: bold;">날짜 별 총 매출</td>
                        <td>${dailyTotal}</td>
                    </tr>
                `;
            }
            
			output += `
				<tr>
					<td rowspan="${rowspan}"> ${formattedDate} </td>
                    <td> ${item.match_time} </td>
                    <td> ${item.price} </td>
                    <td> ${item.playerCount} </td>
                    <td> ${item.total} </td>
				</tr>
			`;
			
			dailyTotal = item.price * item.playerCount;
		 }
		 rowspan = 1;
		 previousDate = matchDate;
	});
	
	 if (previousDate !== "") {
        output += `
            <tr>
                <td colspan="3"></td>
                <td style="font-weight: bold;">날짜 별 총 매출</td>
                <td>${dailyTotal}</td>
            </tr>
        `;
    }
	output += "</tbody>";
	$('.tabletd').append(output);
	
	 $(".totalD").html(`
        <strong> 이번달 총 참여인원 &nbsp; ${totalPlayerCount}명 </strong> &nbsp;&nbsp;&nbsp; 
        <strong> 이번달 총 매출 &nbsp; ${totalSales}원 </strong>
    `);
	
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
				$("thead").show();
				$("tbody").remove();
				updateMatchList(data);
				generatePagination(data);
			} else {
				$("thead").hide();
				$("tbody").remove();
				$(".pagination").empty();
				$("table").append("<tbody><tr><td colspan='5' style='text-align: center;'>등록된 매칭이 없습니다</td></tr></tbody>");
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

function sajax(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/business/sales",
		dataType : "json",
		cache : false, 
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
				$("tbody").remove();
				supdateMatchList(data);
			} else {
				$("tbody").remove();
				$(".tabletd").append("<tbody><tr><td colspan='5' style='text-align: center;'>등록된 매칭이 없습니다</td></tr></tbody>");
			}
		},
		error : function() {
			console.log("에러");
			$("thead").hide();
			$("tbody").remove();
    		$(".tabletd").append("<tbody><tr><td colspan='5' style='text-align: center;'>데이터를 불러오는 중 오류가 발생했습니다. 다시 시도해주세요.</td></tr></tbody>");
		}
	});
}

function applyFilter() {
    const year = document.getElementById('year').value;
    const month = document.getElementById('month').value;
    go(1, year, month); 
}

function sapplyFilter() {
    const year = document.getElementById('year').value;
    const month = document.getElementById('month').value;
    sgo(year, month); 
}

$(document).on('click', '.uploadBtn', function(){
    location.href = "../matchs/write";
});

$(document).on('click', '.excelB', function(){
    location.href = "../business/downloadExcel";
});
