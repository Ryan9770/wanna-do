<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	table{
		text-align: center;
		margin-top: 0
	}
	
	textarea {
		resize: none;
		height:300px;
	}
	
	.modal-body{
		max-height:500px;
	}
	
	#receivers{
		background: transparent;
		border: none;
	}
</style>
<main>
	<div class="body-container">
	    <div class="body-title">
			<h2> 환전 목록 </h2>
	    </div>
	    
	    <div class="body-main">
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
						<th class="col-2">환전 날짜</th>
						<th class="col-1">환전 쿠키</th>
						<th class="col-2">환전 금액</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="dto" items="${list}" varStatus="status">
					<tr> 
						<td>${status.count}</td>
						<td>${dto.buy_date}</td>
						<td>${dto.amount}개</td>
						<td>${dto.price}원</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
					 
			<div class="page-box">
				${dataCount == 0 ? "환전 기록이 없습니다." : paging}
			</div>
					
			<table class="table">
				<tr>
					<td align="left" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/creator/withdraw/list';">새로고침</button>
					</td>
					<td align="right" width="100">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
</main>