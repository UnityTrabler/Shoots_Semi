<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script>
	$(function() {
		$('button#btnRegular').addClass('btn-success');
		$('#btnRegular').click(function() {
			$(this).addClass('btn-success');
			$(this).siblings().removeClass('btn-success');
		});
		$('#btnBusiness').click(function() {
			$(this).addClass('btn-success');
			$(this).siblings().removeClass('btn-success');
			$('#switchingContext').html(`<jsp:include page="signupBusiness.jsp"></jsp:include>`);
			//init
			$('#verify-block').css('display', 'none');
			$("#verify-toggle-text").hide();
			$("#preview").hide();
		});
	});
</script>
<div id="btnGroupRB" class="d-flex justify-content-center align-items-center">
	<button type="button" id="btnRegular" class="btn btn-secondary mb-5 mr-5" style="width:100px; height:60px; border-radius: 40px">개인</button>
	<button type="button" id="btnBusiness" class="btn btn-secondary mb-5" style="width:100px; height:60px; border-radius: 40px">기업</button>
</div>