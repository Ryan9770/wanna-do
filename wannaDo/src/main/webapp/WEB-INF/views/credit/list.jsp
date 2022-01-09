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
		<div class="body-main">
			<table class="table">
				<tr>
					<td align="left" width="50%">
						${dataCount}개(${page}/${total_page} 페이지)
					</td>
				</tr>
			</table>	
			<table class="table table-hover table-list">
				<thead class="table-light" style="text-align: center">
					<tr>
						<th class="col-1">번호</th>
						<th class="col-3">구매 수량</th>
						<th class="col-3">가격</th>
						<th class="col-3">구매일</th>
						<th class="col-3">환불 요청</th>
					</tr>
				</thead>
						
				<tbody style="text-align: center">
					<c:forEach var="dto" items="${list}">
						<tr class="hover-tr">
							<td>${dto.listNum}<input type="hidden" name="num" value="${dto.num}"></td>
							<td>${dto.amount}</td>
							<td><fmt:formatNumber value="${dto.price}" pattern="#,###" /> 원</td>
							<td>${dto.buy_date}</td>
							<c:if test="${dto.gap < 168}">
								<td>
									<button type="button" data-num="${dto.num}" data-amount="${dto.amount}" data-price="${dto.price}" id="refund" class="btn btn-light refund">환불 요청</button>
								</td>
							</c:if>
							<c:if test="${dto.gap >= 168}">
								<td>
									<button type="button" class="btn btn-light" disabled>기한 만료</button>
								</td>
							</c:if>
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
$(function(){
		$("body").on("click", "#refund", function(){
			if(! confirm("환불 요청을 진행하시겠습니까?")) {
			    return false;
			}
			var num = $(this).attr("data-num");
			var amount = $(this).attr("data-amount");
			var price = $(this).attr("data-price");
			var query = "num="+num+"&amount="+amount+"&price="+price;
			var url = "${pageContext.request.contextPath}/credit/refund?" + query;
			location.href = url;
		});
	});
</script>