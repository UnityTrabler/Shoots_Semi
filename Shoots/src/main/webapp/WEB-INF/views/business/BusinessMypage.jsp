<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../user/top.jsp"></jsp:include>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
</head>
<body>
	<form action="/business/mypage" method="GET">
		<input type = "hidden" id = "business_idx" name = "business_idx" value = "5">
		<table>
			<tr>
				<th> 기업명 </th> <td> ${businessUser.business_name} </td>
			</tr>
		</table>
	</form>
</body>
</html>