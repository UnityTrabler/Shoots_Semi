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

