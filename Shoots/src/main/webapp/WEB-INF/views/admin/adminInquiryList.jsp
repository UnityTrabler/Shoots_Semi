<%@ page language="java" contentType="text/html; charset=UTF-8;"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/js/inquiryJs/inquirylist.js"></script>

<title>관리자 전용 문의 게시판</title>
</head>
<body>
		<%--게시글이 있는 경우 --%>
		<c:if test="${listcount > 0 }">
			<table class="table table-striped">
				<thead>
					<tr>
						<th colspan="4">관리자 전용 1:1 문의 게시판</th>
						<th colspan="3"><span>문의글 개수 : ${listcount}</span></th>
					</tr>
					<tr>
						<th><div>번호</div></th>
						<th><div>문의 제목</div></th>
						<th><div>문의자 유형</div></th>
						<th><div>문의자</div></th>
						<th><div>날짜</div></th>
						<th>수정</th>
						<th>삭제</th>
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
									<a href="inquirydetail?inquiryid=${i.inquiry_id}"> 
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

							<%--문의자의 ID. 초기 버전은 문의자의 식별번호였음. 
							(문의글 식별번호 & 문의글 쓴 사람의 idx 번호  2개를 조인 한 뒤 user_id를 뽑아옴) --%>
							<c:choose>
					            <c:when test="${i.inquiry_type eq 'A'}">
					               <td><div>${i.user_id}</div></td>
					            </c:when>
					            <c:when test="${i.inquiry_type eq 'B'}">
					                <td><div>${i.business_id}</div></td>
					            </c:when>
					        </c:choose>
							
							<%--문의 등록일--%>
							<td><div>${i.register_date}</div></td>
							
							<%--관리자 페이지에서의 수정/삭제 버튼 --%>
							<td><a href="../inquiry/modify?inquiryid=${i.inquiry_id}" type="button" class="inquiryUpdate">수정</a></td>
							<td><a href="../inquiry/delete?num=${i.inquiry_id}"  type="button" class="inquiryDelete">삭제</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

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
			<h3 style="text-align: center">등록된 문의가 없습니다.</h3>
		</c:if>

	<%--<div class="container"> end --%>
</body>
</html>