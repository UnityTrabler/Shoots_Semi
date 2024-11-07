	// 페이지가 로드될 때 자유게시판(A)의 게시글을 불러오는 부분을 추가합니다.
	$(document).ready(function() {
	    // 페이지가 로드되면 자동으로 자유게시판(A)로 게시글 목록을 불러오기
	    switchCategory('A');
	});


        // 카테고리 변경 시 게시글 목록을 비동기적으로 불러오는 함수
        function switchCategory(category) {
		            $.ajax({
		                url: 'list',  // 서블릿 URL
		                type: 'GET',
		                data: {
		                    category: category,  // 카테고리 정보 전송
		                    state: 'ajax',  // AJAX 요청임을 알려주는 파라미터
		                    page: 1,  // 기본적으로 첫 페이지
		                    limit: 10  // 한 페이지당 10개씩 게시글을 표시
		                },
		                dataType : 'json',
		                success: function(response) {
							// 응답 데이터 확인
							console.log(response);
							
		                    // 서버로부터 받은 JSON 응답 처리
		                    updatePostList(response);
		                    
		                    
		                },
		                error: function(xhr, status, error) {
		                    console.error("AJAX 요청 실패: " + error);
		                }
		            });
        }

        // 서버에서 받은 응답 데이터를 바탕으로 게시글 목록을 갱신하는 함수
        function updatePostList(data) {
            var category = data.category;
            var postList = data.postlist;
            var page = data.page;
            var maxPage = data.maxpage;
            var startPage = data.startpage;
            var endPage = data.endpage;
            var listCount = data.listcount;

            // 게시글 목록 테이블 갱신
            var tableBody = $('table tbody');
            tableBody.empty();  // 기존 내용 비우기


            // 새로 받은 게시글 목록을 테이블에 추가
            postList.forEach(function(post) {
                var row = $('<tr>');
                row.append('<td>' + post.post_id + '</td>');
                row.append('<td><a href="detail?num=' + post.post_id + '">' + (post.title.length > 20 ? post.title.substring(0, 20) + '...' : post.title) + '</a></td>');
                row.append('<td>' + post.writer + '</td>');
                row.append('<td>' + post.register_date + '</td>');
                row.append('<td>' + post.readcount + '</td>');
                
                if (category === 'B') {
                    // 카테고리 B일 경우 추가로 가격 표시
                    row.append('<td>' + post.price + '</td>');
                }
                row.append('</tr>');
                tableBody.append(row);
            });
            

            // 페이지 네비게이션 갱신 (예시: 페이지 번호 표시)
            var pagination = $('#pagination');
            pagination.empty();  // 기존 페이지네이션 비우기

            // 페이지 번호 추가 (예시: 페이지 1, 2, 3, ...)
            for (var i = startPage; i <= endPage && i <= maxPage; i++) {
                var pageLink = $('<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="switchPage(' + i + ')">' + i + '</a></li>');
                pagination.append(pageLink);
            }
        }

        // 게시판 클릭 시 게시판 이동하는 함수 (페이지 이동)
        function switchPage(pageNumber) {
            var category = $('input[name="category"]:checked').val();  // 선택된 카테고리
            switchCategory(category, pageNumber); 
        }

        // 글쓰기 버튼 클릭 시 카테고리와 함께 '글쓰기' 페이지로 이동
        function postWrite() {
            location.href = "write";  // 카테고리 파라미터를 함께 전달
        }
        
        /* // 글쓰기 버튼 클릭 시 카테고리와 함께 '글쓰기' 페이지로 이동
        function postWrite() {
            var category = $('input[name="category"]:checked').val();  // 선택된 카테고리
            location.href = "write?category=" + category;  // 카테고리 파라미터를 함께 전달
        }*/