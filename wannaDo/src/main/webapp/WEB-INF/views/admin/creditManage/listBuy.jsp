<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css" type="text/css">

<style type="text/css">
.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}
</style>

<script type="text/javascript">
$(function(){
	$("#tab-0").addClass("active");

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="${pageContext.request.contextPath}/admin/creditManage/listRefund";	
		location.href=url;
	});
});

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

<main>
	<div class="body-container">
	    <div class="body-title">
			<h2><i class="icofont-coins"></i> 매출 관리 </h2>
	    </div>
	    
	    <div class="body-main shadow">
			<div>
				<ul class="tabs">
					<li id="tab-0" data-tab="0"><i class="icofont-waiter-alt"></i> 매출 리스트</li>
					<li id="tab-1" data-tab="1"><i class="icofont-spreadsheet"></i> 환불 리스트</li>
				</ul>
			</div>
			<div id="tab-content" style="clear:both; padding: 20px 10px 0;">
			
				<table class="table">
					<tr>
						<td align="left" width="50%">
							${dataCount}개(${page}/${total_page} 페이지)
						</td>
					</tr>
				</table>
					
				<table class="table table-border table-list">
					<thead>
						<tr> 
							<th class="col-1">번호</th>
							<th class="col-2">아이디</th>
							<th class="col-2">구매 수량</th>
							<th class="col-2">구매 가격</th>
							<th class="col-2">구매일</th>
							<th class="col-1">상태</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}">
						<tr> 
							<td>${dto.listNum}</td>
							<td>${dto.userId}</td>
							<td>${dto.amount}</td>
							<td>${dto.price}</td>
							<td>${dto.buy_date}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
						 
				<div class="page-box">
					${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
				</div>
						
				<table class="table">
					<tr>
						<td align="left" width="100">
							<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/creditManage/listBuy';">새로고침</button>
						</td>
						<td align="right" width="100">&nbsp;</td>
					</tr>
				</table>
			
			</div>
			
	    </div>
	</div>
</main>
