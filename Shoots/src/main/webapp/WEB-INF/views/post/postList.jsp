<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../user/top.jsp"></jsp:include>
    <meta charset="UTF-8">
    <title>게시판</title>
    <script src="${pageContext.request.contextPath}/js/list.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/list.css" type="text/css">
    
    
    
</head>
<body>
    <div class="container">
        <!-- 카테고리 선택 탭 -->
        <ul class="nav nav-tabs" id="categoryTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="tabA" data-toggle="tab" href="#A" role="tab" onclick="switchCategory('A')">자유 게시판</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tabB" data-toggle="tab" href="#B" role="tab" onclick="switchCategory('B')">중고 게시판</a>
            </li>
        </ul>

        <!-- 게시글 목록 -->
        <div class="tab-content mt-3">
            <div class="tab-pane fade active show" id="A" role="tabpanel">
                <!-- 게시글 목록 테이블 (자유게시판) -->
                <table class="table">
                    <thead>
                        <tr>
                            <th>글번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            <div class="tab-pane fade" id="B" role="tabpanel">
                <!-- 게시글 목록 테이블 (중고게시판) -->
                <table class="table">
                    <thead>
                        <tr>
                            <th>글번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                            <th>첨부파일</th> <!-- 파일 미리보기 칸 추가 -->
                            <th>가격</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
                
                
               
                
                
            </div>
        </div>

        <!-- 글 작성 버튼 -->
        <c:if test = "${idx == null}">
        	<button type="button" class="btn btn-info float-right btnw" onclick="postWriteN()">글 작성</button>
        </c:if>
        <c:if test = "${idx != null}">
        	<button type="button" class="btn btn-info float-right btnw" onclick="postWrite()">글 작성</button>
        </c:if>
    </div>
    
    
    <%--페이징 --%>
	<div class = "center-block">
				<ul class = "pagination justify-content-center">
					<li class = "page-item">
						<a href="javascript:go(${page - 1})"
							class = "page-link ${page <= 1 ? 'gray' : '' }">
							&lt;&lt;
						</a>
					</li>
					<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
						<li class = "page-item ${a == page ? 'active' : '' }">
							<a href="javascript:go(${a})"
								class = "page-link">${a}</a>
						</li>
					</c:forEach>
					<li class = "page-item">
						<a href="javascript:go(${page + 1})"
							class = "page-link ${page >= maxpage ? 'gray' : '' }">
							&gt;&gt;
						</a>
					</li>
				</ul>
			</div>
		<%--페이징 끝 --%>	
		
</body>
</html>
