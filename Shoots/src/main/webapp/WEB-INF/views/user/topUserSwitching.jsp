<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script>
	$(function() {
		$('#btnRegular').click(function() {
			$(this).addClass('successBtn');
			$(this).siblings().removeClass('successBtn');
		});
		$('#btnBusiness').click(function() {
			$(this).addClass('successBtn');
			$(this).siblings().removeClass('successBtn');
		});
	});
</script>
<div id="btnGroupRB" class="d-flex justify-content-center align-items-center" style = "margin :30px 0 30px 0">
	<button type="button" id="btnRegular" class="regularBtn" onClick="btnRegularClick()">개인</button>
	<button type="button" id="btnBusiness" class="businessBtn" onClick="btnBusinessClick()">기업</button>
</div>