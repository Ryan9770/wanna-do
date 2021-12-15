<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<style type="text/css">
.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}
</style>

<div class="container px-2 mt-2">	
	<div class="body-container">
		<div class="body-title mb-3">	
			<h3>구매 내역</h3>
		</div>
		<div class="body-main">
			<table class="table">
				<tr>
					<td align="left" width="50%">
						${dataCount}개(${page}/${total_page} 페이지)
					</td>
				</tr>
			</table>	
			<table class="table table-hover table-list">
				<thead class="table-light">
					<tr>
						<th class="col-1">번호</th>
						<th class="col-3">구매 수량</th>
						<th class="col-3">가격</th>
						<th class="col-3">구매일</th>
					</tr>
				</thead>
						
				<tbody>
					<c:forEach var="dto" items="${list}">
						<tr class="hover-tr">
							<td>${dto.listNum}</td>
							<td>${dto.amount}</td>
							<td>${dto.price} 원</td>
							<td>${dto.buy_date}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="page-box" style="text-align: center">
				${dataCount == 0 ? "구매 내역이 없습니다." : paging}
			</div>
		</div>
	</div>
</div>
<div class="col text-end">
	&nbsp;
</div>

<script type="text/javascript">
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR) {
			if (jqXHR.status == 403) {
				location.href="${pageContext.request.contextPath}/member/login";
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}
</script>