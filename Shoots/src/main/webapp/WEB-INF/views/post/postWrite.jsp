<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../user/top.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/js/writeform.js"></script>
 <style>
  h1{font-size:1.5em; text-align:center; color:#1a92b9}
  .container{width:60%}
  label{font-weight:bold}
 </style>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
</head>
<body>
<div class="container">
  <form action="add" method="post" enctype="multipart/form-data" name="writeform">
  	<h1>게시판 글쓰기</h1>
  
  	<div class="form-group">
  		<label for="category"></label>
  		<input type="radio" name="category" id ="A" value="A" checked><span>자유게시판</span>
		<input type="radio" name="category" id ="B" value="B"><span>중고게시판</span>
  	</div>
  	
  	<!-- 작성자 -->
  	<input name="writer" id ="writer" value="${writer}" 
				type="hidden" class="form-control" readOnly>
  
  	<div class="form-group">
  		<label for="title">제목</label>
  		<input name="title" id="title" type="text" maxlength="100" class="form-control" placeholder="제목을 입력해주세요" >
  	</div>
  
  	<div class="form-group">
  		<label for="content">내용</label>
  		<textarea name="content" id="content" rows="20" class="form-control" placeholder="내용을 입력하세요." ></textarea>
  	</div>
  	
  	<!-- 가격 입력 (중고게시판일 경우에만 보이게 설정) -->
  	<div class="form-group" id="price" style="display: none;">
  		<label for="price">가격</label>
  		<input name="price" type="text" class="form-control" placeholder="가격을 입력해주세요"></input >
  	</div>
  
  	<div class="form-group">
  		<label>
  		파일첨부
  		 <img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부">
  		 <input type="file" id="upfile" name="post_file">
  		</label>
  		<span id="filevalue"></span>
  	</div>
  
  	<div class="form-group">
  		<button type=reset class="btn btn-danger">취소</button>
  		<button type=submit class="btn btn-primary">등록</button>
  	</div>
  	
  </form>
 </div>
 
 
  <!-- 자바스크립트로 라디오 버튼 선택 시 가격 입력란 보이기/숨기기 처리 -->
    <script>
        // DOM 로딩 후 실행
        document.addEventListener("DOMContentLoaded", function() {
            // 라디오 버튼 이벤트 리스너 등록
            document.querySelectorAll("input[name='category']").forEach(function(radio) {
                radio.addEventListener("change", function() {
                    togglePriceField();
                });
            });

            // 페이지 로드 시 카테고리 값에 따라 가격 입력란 상태 설정
            togglePriceField();
        });

        function togglePriceField() {
            const isUsedBoard = document.getElementById("B").checked;
            const priceField = document.getElementById("price");
            
            // 중고게시판 선택 시 가격 입력란 보이기, 아니면 숨기기
            if (isUsedBoard) {
                priceField.style.display = "block";
            } else {
                priceField.style.display = "none";
            }
        }
    </script>
 
 
</body>
</html>
