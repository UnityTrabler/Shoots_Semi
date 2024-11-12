<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../user/top.jsp"></jsp:include>
    <meta charset="UTF-8">
    <title>게시판</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/list.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
    
    
    
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
                <table class="table table-striped">
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
                <table class="table table-striped">
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

        <!-- 페이지 네비게이션 -->
        <ul id="pagination" class="pagination justify-content-center">
            <!-- 페이지 번호가 여기에 추가됩니다. -->
        </ul>

        <!-- 글 작성 버튼 -->
        <button type="button" class="btn btn-info float-right" onclick="postWrite()">글 작성</button>
    </div>
</body>
</html>
