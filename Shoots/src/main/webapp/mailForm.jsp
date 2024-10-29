<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>	
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5 text-center">
		<%-- action="/JSP/mailSend" --%>
		<form class="form-horizontal" method="post" action="<%=request.getContextPath()%>/mailSend">			
			my email <font color='red'>*</font>
			<input type="text" name="sender" id="sender" class="form-control" placeholder="보내는 분의 email 주소 입력." value = "<%="kdhmm0325"%>@naver.com" required>
		
			받는 주소 <font color='red'>*</font>
			<input type="email" name="receiver" id="receiver" class="form-control" placeholder="받는 주소" value = "<%="kdhmm0325"%>@naver.com" required>
		
			메일 제목<font color='red'>*</font>
			<input type="text" name="subject" id="subject" class="form-control" placeholder="email title 입력" value="title" required>
		
			내용 입력 <font color='red'>*</font>
			<textarea name="content" id = "content" class="form-control" rows="5" required>content</textarea>
		
			<input type="submit" class="btn btn-primary" value="send">
			<input type="reset" class="btn btn-danger" value="reset">
		</form>
</body>
</html>