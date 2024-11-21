window.onload = function() {
    var firstTab = document.querySelector('#tab-info');
    if (firstTab) {
        loadUserInfo();
    }
};

function loadUserInfo() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../user/info', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText;
        }
        
        var tab = document.querySelector('.cP0-1 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });

            tab.classList.add('active');
        }
    };
    xhr.send(); 
}

function loadUserMatchs() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../user/matchs', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText;
        }
        
        var tab = document.querySelector('.cP0-1 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}

function loadUserPosts() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../user/posts', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText;
        }
        
        var tab = document.querySelector('.cP0-1 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}

function loadUserComments() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../user/comments', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText;
        }
        
        var tab = document.querySelector('.cP0-1 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}

function loadUserInquiry() {
	var xhr = new XMLHttpRequest();
    xhr.open('GET', '../user/inquiry', true); 
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById('content-container').innerHTML = xhr.responseText;
        }
        
        var tab = document.querySelector('.cP0-1 a');
        if (tab) {
            var activeTabs = document.querySelectorAll('.cP0-1 a');
            activeTabs.forEach(function(item) {
                item.classList.remove('active');
            });
            tab.classList.add('active');
        }
    };
    xhr.send(); 
}

// button
function redirectToUpdatePage() {
	location.href = "update";
	}
	
function redirectToUpdatePost(postId) {
	location.href = "../post/modify?num=" + postId;
	}

function redirectToDeletePost(postId) {
	location.href = "../post/delete?num=" + postId;
	}	
	
// pagination
let isRequestInProgress = false;

// UserPosts
function go(page) {
	if (isRequestInProgress) return;
	 
	const limit = 10;
	const data = {limit : limit, state : "ajax", page : page};
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
	let output = "<tbody id = 'result'>";
	$(data.list).each(function(index, item){
	
		output += `
                <tr>
                    <td> ${item.category === 'A' ? '<span class = "a"> [자유] </span>' : item.category === 'B' ? '<span class = "b"> [중고] </span>' : item.category} </td>
                    <td> <a href = "../post/detail?num=${item.post_id}"> ${item.title.length > 12 ? item.title.substring(0, 12) + '...' : item.title} </a> </td>
                    <td> ${item.user_id} </td>
                    <td> ${item.register_date.substring(0,10)} </td>
                    <td> ${item.readcount} </td>
					<td> <input type = "button" value = "수정" class= "updateBtn" onclick = "redirectToUpdatePost(${item.post_id})"> </td>
					<td> <input type = "button" value = "삭제" class= "deleteBtn" onclick = "redirectToDeletePost(${item.post_id})"> </td>
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
		url : "/Shoots/user/posts",
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

// UserComments
function cgo(page) {
	if (isRequestInProgress) return;
	 
	const limit = 12;
	const data = {limit : limit, state : "ajax", page : page};
	cajax(data);
}

function cgeneratePagination(data) {
	let output = "";
	
	let prevHref = data.page > 1 ? `href=javascript:cgo(${data.page - 1})` : "";
	output += setPaging(prevHref, '&lt;&lt;');
	
	for (let i = data.startpage; i <= data.endpage; i++) {
		const isActive = (i === data.page);
		let pageHref = !isActive ? `href=javascript:cgo(${i})` : "";
		  
		output += setPaging(pageHref, i, isActive); 
	}
	
	let nextHref = (data.page < data.maxpage) ? `href=javascript:cgo(${data.page + 1})` : "";
	output += setPaging(nextHref, '&gt;&gt;' );
	
	$(".pagination").empty().append(output);
}

let prevPostId = null;

function cupdateMatchList(data) {
    let output = "<div class='Cc'>";
    
    $(data.list).each(function(index, item) {
         if (item.post_id !== prevPostId) {
			
            output += `
                <p> <a href="../post/detail?num=${item.post_id}">
                    <img src="/Shoots/img/post.png" class="commentI">
                    ${item.category == 'A' ? '<span class = "categoryA">[자유]</span>' : '<span class = "categoryB">[중고]</span>'} &nbsp; ${item.post_title} </a>
                </p>
            `;
        }

        output += `
            <p>&nbsp;&nbsp;&nbsp;
                <img src="/Shoots/img/comment.png" class="commentI">
                <b>${item.content}</b>
                <span class="cg">${item.register_date}</span>
            </p>
        `;

        prevPostId = item.post_id;
        
		if (index === data.list.length - 1 || data.list[index + 1].post_id !== item.post_id) {
			output += "<hr>";
		}
     
    });

    output += "</div>";
    console.log(output);
    
    $('#comment-list').empty().append(output);

    cgeneratePagination(data);
}
	
function cajax(sdata) {
	console.log(sdata);
	
	$.ajax({
		data : sdata,
		url : "/Shoots/user/comments",
		dataType : "json",
		cache : false, 
		success : function(data){
			console.log(data);
			if (data.listcount > 0) {
 				$('#comment-list').empty();
 				cupdateMatchList(data);
				cgeneratePagination(data);
			} else {
				$(".pagination").empty();
                $("#comment-list").append("<p>등록된 댓글이 없습니다</p>");
			}
		},
		error : function() {
			console.log("에러");
    		$(".pagination").empty();
			$("#comment-list").append("<p>데이터를 불러오는 중 오류가 발생했습니다. 다시 시도해주세요.</p>");		}
	});
}

// UserMatchs - modal

function openModal(matchId) {
    // AJAX 요청을 보내서 플레이어 목록을 가져오기
    fetch(`../user/userMatchPlayer?match_id=${matchId}`)
        .then(response => response.text())  // 텍스트 형태로 응답받기
        .then(data => {
            // 받은 데이터를 모달에 표시
            document.getElementById('playersList').innerHTML = data;
            document.getElementById('myModal').style.display = "block"; 
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

function closeModal() {
    document.getElementById('myModal').style.display = "none";
}

window.onclick = function(event) {
    if (event.target == document.getElementById('myModal')) {
        closeModal();
    }
}
