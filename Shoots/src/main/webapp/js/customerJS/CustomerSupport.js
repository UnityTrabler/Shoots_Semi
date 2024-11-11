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
  xhr.open('GET', '../notice/noticeList', true);
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
			$(".Sbtn").click(function(){
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