<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/js/inquiryJs/inquirylist.js"></script>
<script src="${pageContext.request.contextPath}/css/inquiry.css"></script>
<jsp:include page = "/WEB-INF/views/user/top.jsp"/>

<title>문의 게시판</title>
</head>
<body>
	<div class="container">
		<%--게시글이 있는 경우 --%>
		<c:if test="${listcount > 0 }">
			<div class="rows">
				<span>줄보기</span> <select class="form-control" id="viewcount">
					<option value="1">1</option>
					<option value="3">3</option>
					<option value="5">5</option>
					<option value="7">7</option>
					<option value="10" selected>10</option>
				</select>
			</div>
			<table class="table table-striped">
				<thead>
					<tr>
						<th colspan="3">1:1 문의 게시판</th>
						<th colspan="2"><span>글 개수 : ${listcount}</span></th>
					</tr>
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
									<a href="detail?num=${i.inquiry_id}"> 
										<c:if test="${i.title.length()>=20 }">
											<c:out value="${i.title.substring(0,20 )}..." />
										</c:if> 
										
										<c:if test="${i.title.length()<20 }">
											<c:out value="${i.title}" />
										</c:if>
									</a> [${i.cnt}]
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

							<%--문의자의 ID. 초기 버전은 문의자의 식별번호였음. 
							(문의글 식별번호 & 문의글 쓴 사람의 idx 번호  2개를 조인 한 뒤 user_id를 뽑아옴) --%>
							<td><div>${i.user_id}</div></td>
							
							<%--문의 등록일--%>
							<td><div>${i.register_date}</div></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div class = "center-block">
            <ul class = "pagination justify-content-center">
               <li class = "page-item">
                  <a ${page > 1 ? 'href = list?page=' += (page - 1) : '' }
                     class = "page-link ${page <= 1 ? 'gray' : '' }">
                     &lt;&lt;
                  </a>
               </li>
               <c:forEach var = "a" begin = "${startpage}" end = "${endpage}">
                  <li class = "page-item ${a == page ? 'active' : '' }">
                     <a ${a == page ? '' : 'href = list?page=' += a }
                        class = "page-link">${a}</a>
                  </li>
               </c:forEach>
               <li class = "page-item">
                  <a ${page < maxpage ? 'href = list?page=' += (page + 1) : '' }
                     class = "page-link" ${page >= maxpage ? 'gray' : '' }">
                     &gt;&gt;
                  </a>
               </li>
            </ul>
         </div>
		</c:if>
		<%--<c:if test"${listcounbt > 0}"> end --%>
		<%--게시글이 없는 경우 --%>
		<c:if test="${listcount == 0 }">
			<h3 style="text-align: center">등록된 글이 없습니다.</h3>
		</c:if>

		<button type="button" class="btn btn-info float-right">문의하기</button>
	</div>
	<%--<div class="container"> end --%>
</body>
</html>