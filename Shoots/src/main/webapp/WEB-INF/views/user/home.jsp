<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/home.css" type = "text/css">
</head>
<body>
	<div class = "homeb">
		<div class = "homeL">
			<img  class = "Limg" src = "${pageContext.request.contextPath}/img/home_thumbnail.png">
			<div class="overlay">
				<p class = "p1"> 만남은 짧고, 이야기는 긴 </p>
				<p class = "p2"> SHOOTS </p>
				<p class = "p3"> 국내 최초, 초대형 축구 플랫폼 </p>
				<p class = "p3"> 언제든, 누구나 함께 </p>
			</div>
		</div>
	</div>
	
	<div class="btnD">
    <button type="button" class="btnI btn1_1">
        <div class="image-container">
            <img src="${pageContext.request.contextPath}/img/main1.png" class="button-image1 normal">
            <img src="${pageContext.request.contextPath}/img/main1_1.png" class="button-image1 hover">
        </div>
        <p class="btnP1"> 우리지역 풋살장 </p>
    </button>
    <button type="button" class="btnI btn2_1">
        <div class="image-container">
            <img src="${pageContext.request.contextPath}/img/main2.png" class="button-image2 normal">
            <img src="${pageContext.request.contextPath}/img/main2_1.png" class="button-image2 hover">
        </div>
        <p class="btnP1"> 슛매칭 </p>
    </button>
    <button type="button" class="btnI btn3_1">
        <div class="image-container">
            <img src="${pageContext.request.contextPath}/img/main3.png" class="button-image1 normal">
            <img src="${pageContext.request.contextPath}/img/main3_1.png" class="button-image1 hover">
        </div>
        <p class="btnP1"> 커뮤니티 </p>
    </button>
    <button type="button" class="btnI btn4_1">
        <div class="image-container">
            <img src="${pageContext.request.contextPath}/img/main4.png" class="button-image1 normal">
            <img src="${pageContext.request.contextPath}/img/main4_1.png" class="button-image1 hover">
        </div>
        <p class="btnP1"> 고객센터 </p>
    </button>
    
    <script>
	    $(function(){
			$('.btn2_1').click(function(){
				location.href = "matchs/list";
			});
	    });
	    
	    $(function(){
			$('.btn3_1').click(function(){
				location.href = "post/list";
			});
	    });
	    
	    $(function(){
			$('.btn4_1').click(function(){
				location.href = "inquiry/list";
			});
	    });
    </script>
</div>
</body>
</html>