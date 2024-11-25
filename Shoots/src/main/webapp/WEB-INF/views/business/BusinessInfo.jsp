<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<p class = "cP1"> 구장정보 </p>
	<input type = "hidden" id = "idx" name =  "idx" value = "${idx}">
	<table class = "table">
		<tr>
			<th> 기업명 </th> <td> ${businessUser.business_name} </td>
		</tr>
		<tr>
			<th> 사업자 번호 </th> <td> ${businessUser.business_number} </td>
		</tr>
		<tr>
			<th> 위치 </th> <td> ${businessUser.address} </td>
		</tr>
		<tr>
			<th> 대표 번호 </th> <td> ${businessUser.tel} </td>
		</tr>
		<tr>
			<th> 기업 이메일 </th> <td> ${businessUser.email} </td>
		</tr>
		<tr>
			<th> 주소 </th> <td> (${businessUser.post})  ${businessUser.address} </td>
		</tr>
		<tr>
			<th> 구장설명 </th> <td> ${businessUser.description} </td>
		</tr>
		<tr>
			<th> 파일 </th> <td> ${businessUser.business_file} </td>
		</tr>
		<tr>
			<th> 가입일 </th> <td> ${businessUser.register_date.substring(0,4)}년 ${businessUser.register_date.substring(5,7)}월 ${businessUser.register_date.substring(8,10)}일 </td>
		</tr>
	</table>
	<div class = "container2">
		<input type = "button" class = "updateBtn" value = "구장 정보 수정" onclick = "redirectToUpdatePage()">
		<input type = "button" class = "descriptionBtn" value = "구장 설명 추가" data-match-id="${businessUser.business_idx}" onclick="openModal(${businessUser.business_idx})">
	
	<div id="myModal" class="modal">
        <div class="modal-content">
            <div class = "modalBD"><input type = "button" value = "X" onclick="closeModal()" class = "modalX"></div>
            <div id="modalContent">
				<p class = "cP2"> 구장설명 추가 </p>
				<div>
					<form action = 'updateDescription' method = "post">
						<input type = "hidden" value = "${idx}">
						<textarea class = "descriptionT" placeholder = "구장에 관련한 설명을 자세하게 적어주세요 (위치, 주차정보, 편의시설, 대여여부 등등)"></textarea> 
					</form>
				</div>
            </div>
        </div>
    </div>
</body>
</html>