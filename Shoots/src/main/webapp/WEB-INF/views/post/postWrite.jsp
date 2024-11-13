<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../user/top.jsp"></jsp:include>

 <style>
  h1{font-size:1.5em; text-align:center; color:#1a92b9}
  .container{width:60%}
  label{font-weight:bold}
 </style>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<script src="${pageContext.request.contextPath}/js/writeform.js"></script>
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
  	<input name="writer" id ="writer" value="${idx}" 
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
  	<div class="form-group fade active show" id="price">
  		<label for="priceInput">가격</label>
  		<input name="price" id="priceInput" type="text" class="form-control" placeholder="가격을 입력해주세요"></input >
  	</div>
  	
  
  	<div class="form-group">
  		<label>
  		파일첨부
  		 <img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부">
  		 <input type="file" id="upfile" name="post_file" onchange="previewImage()">
  		</label>
  		<span id="filevalue"></span>
  	</div>
  
  	<div class="form-group">
  		<button type=reset class="btn btn-danger">취소</button>
  		<button type=submit class="btn btn-primary">등록</button>
  	</div>
  	
  </form>
 </div>
 
 
 
 <%--
 
 
 
    
 
 
  --%>
 
 
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
            const B = document.getElementById("B").checked;
            const priceField = document.getElementById("price");
            
            // 중고게시판(B) 선택 시 가격 입력란 보이기, 아니면 숨기기
            if (B) {
                priceField.style.display = "block";
            } else {
                priceField.style.display = "none";
            }
        }
        
     // 이미지 미리보기 함수
        function previewImage() {
            const fileInput = document.getElementById("upfile");
            const file = fileInput.files[0];
            
            // 이미지 파일이 아니면 처리하지 않음
            if (file && file.type.startsWith("image")) {
                const reader = new FileReader();

                // 파일을 읽어서 이미지로 표시
                reader.onload = function(e) {
                    const img = document.createElement("img");
                    img.src = e.target.result;
                    img.id = "file-preview";  // 미리보기 이미지의 ID
                    img.style.maxWidth = "100px"; // 이미지 크기 제한

                    // 기존의 미리보기 이미지를 제거하고 새로 추가
                    const previewContainer = document.getElementById("file-preview-container");
                    previewContainer.innerHTML = ''; // 기존 내용을 지움
                    previewContainer.appendChild(img);
                };

                reader.readAsDataURL(file); // 파일을 읽음
            } else {
                // 이미지가 아닐 경우, 파일명을 표시
                const previewContainer = document.getElementById("file-preview-container");
                previewContainer.innerHTML = "<span>" + file.name + "</span>";
            }
        }
        
        
    </script>
    
  
 
</body>
</html>
