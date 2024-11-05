<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
select.form-control {
	width: auto;
	margin-bottom: 2em;
	display: inline-block
}

.rows {
	text-align: right;
}

.gray {
	color: gray;
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(1) {
	width: 8%
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(2) {
	width: 50%
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(3) {
	width: 14%
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(4) {
	width: 17%
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(5) {
	width: 11%
}
</style>

<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/js/list.js"></script>

<%-- /*jsp ( 
			1) get 방식 전달(submit action, taglib c:if jsp:forward)  
			2) ajax (post or get) 로 servlet 전달
			3) click js button action(setParameter setSession)
			)  
			-> 1. request.setParameter("category"); 전달 */
	/* 2. session.setParameter("category"); 전달 -> HttpSession session = req.getSession()  session.getAttribute("category") */
--%>

<%-- 
		<script>
	$(function(){
		function switchBoard(var a){
			"${sessionScope.setAttribute('category',a)}"
		}
	});
	</script>
 --%>

<title>자유 게시판 / 중고 게시판</title>
<%-- 공통 스타일 --%>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

/* 공통 스타일 */
.tabs {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.tab {
	padding: 10px 20px;
	cursor: pointer;
	background-color: #f1f1f1;
	margin: 0 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.tab:hover {
	background-color: #ddd;
}

.active {
	background-color: #4CAF50;
	color: white;
}

.board-container {
	margin-top: 30px;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

/* 게시판 A 스타일 */
.board-container-a {
	background-color: #f9f9f9;
}

.post-a {
	margin-bottom: 20px;
	padding: 10px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.post-a h3 {
	color: #333;
}

.post-a p {
	font-size: 14px;
	line-height: 1.6;
}

.price {
	color: #ff5722;
	font-weight: bold;
}

/* 게시판 B 스타일 */
.board-container-b {
	background-color: #f1f1f1;
}

.B {
	margin-bottom: 20px;
	padding: 15px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
}

.B h3 {
	color: #1e88e5;
}

.B p {
	font-size: 14px;
	line-height: 1.6;
}

.file {
	color: #388e3c;
	font-weight: bold;
}

/* 페이지네이션 */
.pagination {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}

.page-item {
	margin: 0 5px;
	cursor: pointer;
}

.page-item.active {
	font-weight: bold;
}

.page-item:hover {
	color: #007bff;
}
</style>
</head>
<body>


	<!-- 게시판 선택 탭 -->
	<form action="post.jsp" method="get">
    <input type="hidden" name="category" value="A">
    <button type="submit">게시판 A</button>
</form>

<form action="post.jsp" method="get">
    <input type="hidden" name="category" value="B">
    <button type="submit">게시판 B</button>
</form>


	<!-- 게시판 내용 -->
	<div id="board-container"
		class="board-container <c:if test="${category == 'A'}">board-container-a</c:if><c:if test="${category == 'B'}">board-container-b</c:if>">
		<c:forEach var="post" items="${postlist}">
			<c:choose>
				<c:when test="${category == 'A'}">
					<!-- 게시판 A의 스타일 -->
					<%-- 게시글이 있는 경우 --%>
					<c:if test="${listcount > 0 }">
						<div class="post-a">
							<table class="table table-striped">

								<thead>
									<tr>
										<th colspan="5">자유게시판 <c:out
												value="${category == 'A' ? 'A' : 'B'}" /> 목록
										</th>
									</tr>

									<tr>
										<th><div>글번호</div></th>
										<th><div>제목</div></th>
										<th><div>작성자</div></th>
										<th><div>작성일</div></th>
										<th><div>조회수</div></th>
									</tr>
								</thead>

								<tbody>
									<c:set var="num" value="${listcount-(page-1)*limit}" />
									<c:forEach var="p" items="${postlist}">
										<tr>
											<td>
												<%-- 글번호 --%> <c:out value="${num}" /> <%-- num 출력 --%> <c:set
													var="num" value="${num-1}" /> <%-- num=num-1; 의미 --%>
											</td>
											<td>
												<%-- 제목 --%>
												<div>
													<a href="detail?num=${p.post_id}"> <c:if
															test="${p.title.length()>=20}">
															<c:out value="${p.title.substring(0,20)}..." />
														</c:if> <c:if test="${p.title.length()<20}">
															<c:out value="${p.title}" />
														</c:if>
													</a>
												</div>
											</td>
											<td><div>${p.writer}</div></td>
											<%-- 작성자 --%>
											<td><div>${p.register_date}</div></td>
											<%-- 작성일 --%>
											<td><div>${p.readcount}</div></td>
											<%-- 조회수 --%>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

					</c:if>
					<%-- <c:if test="${readcount > 0 }"> end --%>

				</c:when>



				<!-- 게시판 B의 스타일 -->
				<%-- 게시글이 있는 경우 --%>
				<c:when test="${category == 'B'}">
					<c:if test="${listcount > 0 }">
						<div class="post-b">
							<table class="table table-striped">

								<thead>
									<tr>
										<th colspan="5">중고게시판 <c:out
												value="${category == 'B' ? 'A' : 'B'}" /> 목록
										</th>
									</tr>

									<tr>
										<th><div>이미지</div></th>
										<th><div>글번호</div></th>
										<th><div>제목</div></th>
										<th><div>가격</div></th>
										<th><div>작성일</div></th>
										<th><div>조회수</div></th>
									</tr>
								</thead>

								<tbody>
									<c:set var="num" value="${listcount-(page-1)*limit}" />
									<c:forEach var="p" items="${postlist}">
										<tr>
											<%-- 이미지 --%>
											<c:if test="${post.post_File != null}">
												<img src="${post.post_File}" alt="첨부 이미지">
											</c:if>
											<td>
											
												<%-- 글번호 --%> <c:out value="${num}" /> <%-- num 출력 --%> <c:set
													var="num" value="${num-1}" /> <%-- num=num-1; 의미 --%>
											</td>
											<td>
												<%-- 제목 --%>
												<div>
													<a href="detail?num=${p.post_id}"> <c:if
															test="${p.title.length()>=20}">
															<c:out value="${p.title.substring(0,20)}..." />
														</c:if> <c:if test="${p.title.length()<20}">
															<c:out value="${p.title}" />
														</c:if>
													</a>
												</div>
											</td>
											<%-- 가격 --%>
											<c:if test="${post.price != null}">
												<p class="file">가격: ${post.price}원</p>
											</c:if>
											<%-- 작성일 --%>
											<td><div>${p.register_date}</div></td>
											<%-- 조회수 --%>
											<td><div>${p.readcount}</div></td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</c:if>
					<%-- <c:if test="${readcount > 0 }"> end --%>

				</c:when>
			</c:choose>
		</c:forEach>



		<%-- 게시글이 없는 경우 --%>
		<c:if test="${listcount  == 0 }">
			<h3 style="text-align: center">등록된 글이 없습니다.</h3>
		</c:if>
		<button type="button" class="btn btn-info float-right">글 작 성</button>



	</div>
	<%-- <div class="container"> end --%>


	<%--
 
     <!-- 페이지네이션 -->
    <div class="pagination">
        <c:if test="${page > 1}">
            <div class="page-item" onclick="changePage(${page - 1})">이전</div>
        </c:if>

        <c:forEach begin="${startpage}" end="${endpage}" var="i">
            <div class="page-item <c:if test="${i == page}">active</c:if>" onclick="changePage(${i})">${i}</div>
        </c:forEach>

        <c:if test="${page < maxpage}">
            <div class="page-item" onclick="changePage(${page + 1})">다음</div>
        </c:if>
    </div>
    
    
    <script>
        // 카테고리 변경
        function changeCategory(category) {
            window.location.href = "/postList.action?category=" + category;
        }

        // 페이지 변경
        function changePage(page) {
            const category = "${category}";
            window.location.href = "/postList.action?category=" + category + "&page=" + page;
        }

        // AJAX로 게시글을 가져오는 함수 (비동기 처리)
        function loadPosts(page, limit) {
            const category = "${category}";
            const url = "/postList.action?category=" + category + "&page=" + page + "&limit=" + limit + "&state=ajax";

            fetch(url)
                .then(response => response.json())
                .then(data => {
                    const postList = data.postlist;
                    const startpage = data.startpage;
                    const endpage = data.endpage;
                    const maxpage = data.maxpage;

                    // 게시글을 화면에 동적으로 업데이트
                    let postHTML = "";
                    postList.forEach(post => {
                        postHTML += `
                            <div class="post-b">
                                ${post.postFile ? `<img src="${post.postFile}" alt="첨부 이미지">` : ""}
                                <div>
                                    <h3>${post.title}</h3>
                                    <p>${post.content}</p>
                                    ${post.price ? `<p class="file">가격: ${post.price}원</p>` : ""}
                                </div>
                            </div>
                        `;
                    });

                    document.getElementById("board-container").innerHTML = postHTML;

                    // 페이지네이션 업데이트
                    let paginationHTML = "";
                    if (page > 1) {
                        paginationHTML += `<div class="page-item" onclick="changePage(${page - 1})">이전</div>`;
                    }

                    for (let i = startpage; i <= endpage; i++) {
                        paginationHTML += `<div class="page-item ${i === page ? 'active' : ''}" onclick="changePage(${i})">${i}</div>`;
                    }

                    if (page < maxpage) {
                        paginationHTML += `<div class="page-item" onclick="changePage(${page + 1})">다음</div>`;
                    }

                    document.querySelector(".pagination").innerHTML = paginationHTML;
                })
                .catch(error => console.error("Error loading posts:", error));
        }
    </script>
 
   --%>


</body>
</html>