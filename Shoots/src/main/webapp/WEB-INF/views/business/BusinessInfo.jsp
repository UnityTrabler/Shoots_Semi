<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
			<th> 구장정보 </th> <td> ${businessUser.description} </td>
		</tr>
		<tr>
			<th> 파일 </th> <td> ${businessUser.business_file} </td>
		</tr>
		<tr>
			<th> 가입일 </th> <td> ${businessUser.register_date.substring(0,4)}년 ${businessUser.register_date.substring(5,7)}월 ${businessUser.register_date.substring(8,10)}일 </td>
		</tr>
	</table>
	<div class = "container2">
		<input type = "button" class = "updateBtn" value = "구장 정보 수정">
	</div>
</body>
</html>