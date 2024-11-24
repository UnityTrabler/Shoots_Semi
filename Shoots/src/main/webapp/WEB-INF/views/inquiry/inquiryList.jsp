<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css">


<title>문의 게시판</title>
</head>
<body>
		<%--게시글이 있는 경우 --%>
		<c:if test="${listcount > 0 }">
			<div class = "inquiryD">
				<table class="table">
					<caption> &nbsp; 1:1 문의 게시판 </caption>
					<input type ="hidden" id="user-data" data-idx="${idx}">
					<thead>
						<tr>
							<th><div>번호</div></th>
							<th><div>문의 제목</div></th>
							<th><div>문의자 유형</div></th>
							<th><div>문의자</div></th>
							<th><div>날짜</div></th>
						</tr>
					</thead>
					<tbody>
						<c:set var="num" value="${listcount-(page-1)*limit}" />
						<c:forEach var="i" items="${inquirylist}">
							<tr>
								<td>
									<%--번호 --%> <c:out value=" ${num }" />
									<%--num 출력 --%> <c:set var="num" value="${num-1}" /> <%--num=num-1; 의미 --%>
								</td>
								<td>
									<%--제목 --%>
									<div>
										<a class="inquiryDetail" href="../inquiry/detail?inquiryid=${i.inquiry_id}"> 
											<c:if test="${i.title.length()>=20 }">
												<c:out value="${i.title.substring(0,20 )}..." />
											</c:if> 
											
											<c:if test="${i.title.length()<20 }">
												<c:out value="${i.title}" />
											</c:if>
										</a>
										<!-- 답변 여부 표시 -->
						                <span>
						                    <c:if test="${i.hasReply}">
						                        [답변완료]
						                    </c:if>
						                </span>
									</div>
								</td>
								<%--문의자 유형 : A면 개인, B면 기업 --%>
								 <td>
								    <div>
								        <c:choose>
								            <c:when test="${i.inquiry_type == 'A'}">
								                개인회원 문의
								            </c:when>
								            <c:when test="${i.inquiry_type == 'B'}">
								                기업회원 문의
								            </c:when>
								        </c:choose>
								    </div>
								</td>
	
								<%--문의자의 ID. 로그인해서 받아온 회원 유형이 A면  --%>
								   <c:choose>
							            <c:when test="${userClassification == 'regular'}">
							               <td><div>${i.user_id}</div></td>
							            </c:when>
							            <c:when test="${userClassification == 'business'}">
							                <td><div>${i.business_id}</div></td>
							            </c:when>
							        </c:choose>
								
								<%--문의 등록일--%>
								<td><div>${i.register_date}</div></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<%--페이징 --%>
		<div class = "center-block">
				<ul class = "pagination justify-content-center">
					<li class = "page-item">
						<a href="javascript:go_inquiry(${page - 1})"
							class = "page-link ${page <= 1 ? 'gray' : '' }">
							&lt;&lt;
						</a>
					</li>
					<c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
						<li class = "page-item ${a == page ? 'active' : '' }">
							<a href="javascript:go_inquiry(${a})"
								class = "page-link">${a}</a>
						</li>
					</c:forEach>
					<li class = "page-item">
						<a href="javascript:go_inquiry(${page + 1})"
							class = "page-link ${page >= maxpage ? 'gray' : '' }">
							&gt;&gt;
						</a>
					</li>
				</ul>
			</div>
			<%--페이징 끝 --%>
		</c:if>
		<%--<c:if test"${listcount > 0}"> end --%>
		<%--게시글이 없는 경우 --%>
		<c:if test="${listcount == 0 }">
			<p class = "ni">아직 문의주신 사항이 없습니다.</p>
		</c:if>
			
		<%--문의하기 버튼 누르면 글쓰기 페이지로 이동 --%>
		<a href="../inquiry/write"><button type="button" class="btn btn-success float-right inquiryBtn">문의하기</button></a>

</body>

</html>