<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../user/top.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/js/modifyform.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/modifyform.css" type="text/css">
    <title>수정</title>


 <style>
  .container{width:60%}
  label{font-weight:bold}
  #upfile{display:none}
 </style>
</head>
<body>

 <div class="container">
  <form action="modifyProcess" method="post" name="modifyform"
  		enctype="multipart/form-data">
  		<input type="hidden" name="post_id" value="${postdata.post_id}">
  		 <input type="hidden" name="existing_file" value="${postdata.post_file}"> <!-- 기존 첨부파일명 전달 -->
  		<input type="hidden" name="remove_file" value="false"> <!-- 파일 삭제 여부 플래그 추가 -->
  		
  	<h1>게시판 - 수정</h1>
  	
  	
  	
  	<%--
  	
  	<div class="form-group">
  		<label for="category"></label>
  		<input type="radio" name="category" id ="A" value="A" checked><span>자유게시판</span>
		<input type="radio" name="category" id ="B" value="B"><span>중고게시판</span>
  	</div>
  	
  	
  	 --%>
  	<div class="form-group">
  		<label for="writer">작성자</label>
  		<input type="text" class="form-control" name="writer" id ="writer"
  				value="${postdata.writer}" readOnly>
  				<%-- postdata.writer --%>
  	</div>
  	
  	<div class="form-group">
  		<label for="title">제목</label>
  		<textarea name="title" id="title" rows="1"
  				class="form-control" maxlength="100" required>${postdata.title}</textarea>
  	</div>
  	
  	
  	<div class="form-group">
  		<label for="content">내용</label>
  		<textarea name="content" id="content"
  				class="form-control" rows="10" required>${postdata.content}</textarea>
  	</div>
  	
  	
  	<%--
  	
  	<!-- 가격 입력 (중고게시판일 경우에만 보이게 설정) -->
  	<div class="form-group fade active show" id="price">
  		<label for="price">가격</label>
  		<input name="price" id="priceInput" type="text" class="form-control" placeholder="가격을 입력해주세요"></input >
  	</div>
  	
  	<!-- 중고게시판일 경우 가격 입력란 보이기 -->
            <div class="form-group" id="price" style="${postdata.category == 'B' ? '' : 'display: none;'}">
                <label for="price">가격</label>
                <input name="price" id="priceInput" type="text" class="form-control" value="${postdata.price}" placeholder="가격을 입력해주세요">
            </div>
  	
  	 --%>
  	
  	
  	<!-- 중고게시판일 경우 가격 입력란 보이기 -->
            <div class="form-group" id="price" style="${postdata.category == 'B' ? '' : 'display: none;'}">
                <label for="priceInput">가격</label>
                <input name="price" id="priceInput" type="text" class="form-control" value="${postdata.price}" placeholder="가격을 입력해주세요">
            </div>
  	
  
  
  
	<%-- 원문글인 경우에만 파일 첨부 수정 가능합니다. --%>
  	<div class="form-group">
  		<label>파일첨부
  		 <img src="${pageContext.request.contextPath}/img/attach.png" alt="파일첨부"> 
  		 <input type="file" id="upfile" name="post_file">
  		</label>
  		<span id="filevalue">${postdata.post_file}</span> <!-- 기존 파일명 출력 -->
  		<img src="${pageContext.request.contextPath}/img/remove.png"
  			 alt="파일삭제" width="10px" class="remove">
  	</div>


  	
  	
  	<div class="form-group">
  		<button type=submit class="btn btnr">수정</button>
  		<button type=reset class="btn btnc" onClick="history.go(-1)">취소</button>
  	</div>
  	</form>
 </div> <%-- class="container" end --%>
 
 
 
 <script>
document.addEventListener("DOMContentLoaded", function () {
    document.querySelector("form[name='modifyform']").addEventListener("submit", function (event) {
        if (!validateForm()) {
            event.preventDefault(); // 유효성 검사 실패 시 폼 제출 중단
        }
    });
});

function validateForm() {
    const category = document.querySelector("input[name='category']").value; // 숨겨진 카테고리 값
    const priceInput = document.getElementById("priceInput");
    const upfile = document.getElementById("upfile");
    const existingFile = document.querySelector("input[name='existing_file']").value; // 기존 첨부파일

    // 중고게시판(B)인 경우 추가 유효성 검사
    if (category === "B") {
        // 가격 필수 확인
        if (priceInput && priceInput.value.trim() === "") {
            alert("중고게시판에서는 가격을 입력해야 합니다.");
            priceInput.focus();
            return false;
        }

        // 가격이 숫자인지 확인
        if (priceInput && isNaN(priceInput.value.trim())) {
            alert("가격은 숫자만 입력 가능합니다.");
            priceInput.focus();
            return false;
        }

        // 가격이 0인지 확인
        if (priceInput && parseFloat(priceInput.value.trim()) <= 0) {
            alert("가격은 0보다 큰 값을 입력해야 합니다.");
            priceInput.focus();
            return false;
        }

        // 첨부파일 필수 확인 (기존 파일이 없고 새 파일도 첨부되지 않은 경우)
        if (!existingFile && !upfile.value) {
            alert("중고게시판에서는 첨부파일을 반드시 첨부해야 합니다.");
            upfile.focus();
            return false;
        }
    }

    return true; // 유효성 검사 통과
}
</script>
 
 
 
</body>
</html>