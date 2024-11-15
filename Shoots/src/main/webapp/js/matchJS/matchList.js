let isRequestInProgress = false;

function go(page, year, month) {
	if (isRequestInProgress) return;
	 
	const limit = 10;
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
	let output = "<tbody id = 'searchResults'>";
	let previousDate = "";
    let rowspan = 1;
    
	$(data.list).each(function(index, item){
		
		const matchDate = item.match_date.substring(0, 10);
		const formattedDate = matchDate.replace(/-/g, '/');
		
		if (matchDate === previousDate) {
            rowspan++;
            output += `
                <tr>
                    <td class="empty-td"></td>
                    <td> ${item.match_time} </td>
                    <td> <a href="detail?match_id=${item.match_id}" class="locatinA"> ${item.business_name} </a> </td>
                    <td>
					    <span style="color: ${item.playerCount >= 1 ? '#1d4ed8' : 'black'}">
					        ${item.playerCount}
					    </span> / ${item.player_max}
					</td>
                    <td> <input type="button" class="status" data-match-id="${item.match_id}" value="신청가능"> </td>
                </tr>
            `;
            
        } else {
			output += `
				<tr>
					<td rowspan="${rowspan}"> ${formattedDate} </td>
					<td> ${item.match_time} </td>
					<td> <a href = "detail?match_id=${item.match_id}" class = "locatinA"> ${item.business_name} </a> </td>
					<td>
					    <span style="color: ${item.playerCount >= 1 ? '#1d4ed8' : 'black'}">
					        ${item.playerCount}
					    </span> / ${item.player_max}
					</td>
					<td> <input type = "button" class = "status" data-match-id="${item.match_id}" value = "신청가능"> </td>
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

function ajax(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/matchs/list",
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
				$("table").append("<tbody id='myTable' ><tr><td colspan='5' style='text-align: center;'>등록된 매칭이 없습니다</td></tr></tbody>");
			}
		},
		error : function() {
			console.log("에러");
			$("thead").hide();
			$("tbody").remove();
    		$(".pagination").empty();
    		$("table").append("<tbody id='myTable' ><tr><td colspan='5' style='text-align: center;'>데이터를 불러오는 중 오류가 발생했습니다. 다시 시도해주세요.</td></tr></tbody>");
		}
	});
}

function applyFilter() {
    const year = document.getElementById('year').value;
    const month = document.getElementById('month').value;
    go(1, year, month); 
}

$(document).ready(function(){
  $("#searchTable").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#searchResults tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});