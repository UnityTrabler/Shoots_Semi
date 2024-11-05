<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

	body > div > table > thead > tr:nth-child(2) > th:nth-child(1){width:8%}
	body > div > table > thead > tr:nth-child(2) > th:nth-child(2){width:50%}
	body > div > table > thead > tr:nth-child(2) > th:nth-child(3){width:14%}
	body > div > table > thead > tr:nth-child(2) > th:nth-child(4){width:17%}
	body > div > table > thead > tr:nth-child(2) > th:nth-child(5){width:11%}
 </style>
 
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/js/list.js"></script>
<title>게시판</title>
</head>
<body>

 <div class="container" id="postListContainer">
 



<c:if test="${param.category == 'A'}">
    <!-- 게시판 A에 대한 내용을 보여주는 부분 -->
    <%-- 게시글이 있는 경우 --%>
  <c:if test="${listcount > 0 }">
  
   <table class="table table-striped">
    <thead>
     <tr>
      <th colspan="3">자유게시판</th>
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
    <c:set var="num" value="${listcount-(page-1)*limit}"/>
    <c:forEach var="p" items="${postlist}">
     <tr>
      <td><%-- 글번호 --%>
       <c:out value="${num}"/><%-- num 출력 --%>
       <c:set  var="num" value="${num-1}"/>		<%-- num=num-1; 의미 --%>
      </td>
      <td><%-- 제목 --%>
      <div>
      <a href="detail?num=${p.post_id}">
		<c:if test="${p.title.length()>=20}">
			<c:out value="${p.title.substring(0,20)}..."/>
		</c:if>
		<c:if test="${p.title.length()<20}">
			<c:out value="${p.title}"/>
		</c:if>
	</a>
      </div>
      </td>
	<td><div>${p.writer}</div></td><%-- 작성자 --%>
	<td><div>${p.register_date}</div></td><%-- 작성일 --%>
	<td><div>${p.readcount}</div></td><%-- 조회수 --%>
      </tr>
      </c:forEach>
    </tbody>
   </table>
   </c:if> <%-- <c:if test="${readcount > 0 }"> end --%>
</c:if>



<c:if test="${param.category == 'B'}">
    <!-- 게시판 B에 대한 내용을 보여주는 부분 -->
    <%-- 게시글이 있는 경우 --%>
  <c:if test="${listcount > 0 }">
  
   <table class="table table-striped">
    <thead>
     <tr>
      <th colspan="3">자유게시판</th>
     </tr>
     
     <tr>
     	<th><div>글번호</div></th>
     	<th><div>제목</div></th>
     	<th><div>가격</div></th>
     	<th><div>작성일</div></th>
     	<th><div>조회수</div></th>
     </tr>
    </thead>
    <tbody>
    <c:set var="num" value="${listcount-(page-1)*limit}"/>
    <c:forEach var="p" items="${postlist}">
     <tr>
      <td><%-- 글번호 --%>
       <c:out value="${num}"/><%-- num 출력 --%>
       <c:set  var="num" value="${num-1}"/>		<%-- num=num-1; 의미 --%>
      </td>
      <td><%-- 제목 --%>
      <div>
      <a href="detail?num=${p.post_id}">
		<c:if test="${p.title.length()>=20}">
			<c:out value="${p.title.substring(0,20)}..."/>
		</c:if>
		<c:if test="${p.title.length()<20}">
			<c:out value="${p.title}"/>
		</c:if>
	</a>
      </div>
      </td>
      
	<%-- 가격 --%>
	<c:if test="${post.price != null}">
	<p class="file">가격: ${post.price}원</p>
	</c:if>
	
	<td><div>${p.register_date}</div></td><%-- 작성일 --%>
	<td><div>${p.readcount}</div></td><%-- 조회수 --%>
      </tr>
      </c:forEach>
    </tbody>
   </table>
   </c:if> <%-- <c:if test="${readcount > 0 }"> end --%>
</c:if>



   
   <%-- 게시글이 없는 경우 --%>
  <c:if test="${listcount  == 0 }">
  	<h3 style="text-align:center">등록된 글이 없습니다.</h3>
  </c:if>
   <button type="button" class="btn btn-info float-right"> 글 작 성</button>
   
 </div> <%-- <div class="container"> end --%>
 
 
 <script>
    // 카테고리 변경을 처리하는 함수
    function switchCategory(category) {
        // 카테고리를 변경한 후 AJAX 요청으로 게시글 목록을 새로 고침
        $.ajax({
            url: 'postList',  // 서블릿 URL
            type: 'GET',  // GET 방식
            data: { category: category },  // 카테고리 값 전달
            success: function(response) {
                // 게시글 목록을 받아와서 #postListContainer에 삽입
                $('#postListContainer').html(response);
                
                // 카테고리 탭 활성화 상태 업데이트
                $('#tabA').toggleClass('active', category === 'A');
                $('#tabB').toggleClass('active', category === 'B');
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 실패: " + error);
            }
        });
    }
    
    // 페이지 로드 시 기본적으로 A 카테고리 게시글 목록을 불러옵니다.
    $(document).ready(function() {
        switchCategory('A');
    });
</script>
 
 
</body>
</html>