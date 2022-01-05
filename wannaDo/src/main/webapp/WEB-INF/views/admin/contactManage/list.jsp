<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">

tbody button{
	border: none;
	background-color: transparent;
}
</style>
<main>
<div class="body-container">
	<div class="body-title">
		<h2><i class="icofont-contacts"></i> 문의사항 관리 </h2>
	</div>
	
	<div class="body-main  shadow">
		<table class="table">
			<tr>
				<td align="left" width="50%">
					${dataCount}개(${page}/${total_page} 페이지)
				</td>
			</tr>
		</table>
		
		<table class="table table-border table-list text-center">
			<thead>
				<tr>
					<th class="col-1">문의 번호</th>
					<th class="col-1">문의자 성함</th>
					<th class="col-3">내용</th>
					<th class="col-2">이메일</th>
					<th class="col-2">연락처</th>
					<th class="col-2">문의일</th>
					<th class="col-1">문의 상태</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="dto" items="${list}">
					<tr>
						<td>${dto.listNum}</td>
						<td>${dto.fullName}</td>
						<td>${dto.message}</td>
						<td>${dto.email}</td>
						<td>${dto.tel}</td>
						<td>${dto.reg_date}</td>
						<c:choose>
							<c:when test="${dto.state != 1}">
								<td><button type="button" onclick="updateState('${dto.contactIdx}');">미확인</button><td>
							</c:when>
							<c:otherwise>
								<td><button disabled="disabled">확인</button></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
			
		</table>
		<div class="page-box">
					${dataCount == 0 ? "등록된 문의가 없습니다." : paging}
		</div>
	</div>
</div>
</main>
<script type="text/javascript">
function updateState(contactIdx) {
	var url = "${pageContext.request.contextPath}/admin/contactManage/updateState";
	var query = "?page="+${page}+"&contactIdx="+contactIdx;
	
	url = url+query;
	
	location.href=url;
}
</script>