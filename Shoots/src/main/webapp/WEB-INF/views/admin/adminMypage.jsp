<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자페이지</title>
<jsp:include page="../user/top.jsp"></jsp:include>
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/css/adminMypage.css" type = "text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/adminJS/AdminMypage.js"></script>
<script src="${pageContext.request.contextPath}js/jquery-3.7.1.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
	$(function() {
		
	}); //ready
	
	function AdminbusinessUserApprovalAction() {
		e.preventDefault();
		
		const data = $(this).serialize();
		let state;
		if ($('#btnGroupRB').find('.btn-success').first().attr('id') != null)
			state = $('#btnGroupRB').find('.btn-success').first().attr('id') == 'btnRegular' ? {'state' : 'regular'} : {'state' : 'business'};
			
		alert(`\${data + "&" + $.param(state)}`);
		ajax(`\${data + "&" + $.param(state)}`, $(this).attr('action'));
	}//function AdminbusinessUserApprovalAction() 
	
	function ajax(sdata, surl) {
		$.ajax({
			url : surl,
			data : sdata,
			type : 'POST',
			dataType : "json",
			success : function(data){
				console.log('ajax success');
				alert(data.message);
				window.location.href = "${pageContext.request.contextPath}/user/login";
			},
			error:function(xhr, textStatus, errorThrown){
				console.log('ajax error');
				var response = JSON.parse(xhr.responseText);
				alert(response.message);
			}
		});
	}//ajax()
</script>

</head>
<body>
	<div class = "container0">
	
		<div class = "container0-1">
			<p class = "cP0-1"><a type="button" class = "cA0" id="tab-info" onclick="loadfaq()" > FAQ관리 </a></p>
			<p class = "cP0-2"><a type="button" class = "cA0" id= "tab" onclick="loadnotice()"> 공지사항 관리 </a></p>
			<p class = "cP0-3"><a type="button" class = "cA0" id= "tab" onclick="loadinquiry()"> 1:1 문의글 관리 </a></p>
			<p class = "cP0-4"><a type="button" class = "cA0" id= "tab" onclick="loaduser()"> 회원관리 </a></p>
			<p class = "cP0-5"><a type="button" class = "cA0" id= "tab" onclick="loadbusiness()"> 기업목록 </a></p>
			<p class = "cP0-6"><a type="button" class = "cA0" id= "tab" onclick="AdminbusinessUserApprovalAction()"> 기업 유저 승인 관리 </a></p>
		</div>
		
		<div class = "container" id = "content-container"></div>
	</div>
</body>
</html>