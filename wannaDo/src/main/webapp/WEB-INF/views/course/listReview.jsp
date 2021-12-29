<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>

.page-item.active .page-link {
	background-color: #DC1A45;
    border-color: #DC1A45;
}
.page-link {
	color: #000000;
}
.page-link:hover {
    z-index: 2;
    color: #eee;
    background-color: #DC1A45;
    border-color: #C82334;
}
</style>


<c:forEach var="vo" items="${listReview}">
	<div class="py-4 px-5 mb-2">
		<!-- head:s -->
		<div class="row">
			<div class="col">
				<span style="display:inline-block; background:#799CD7; border-radius:50%; width:25px; height:25px; margin-right:0.4rem; text-align:center; overflow:hidden; vertical-align:middle;">
					<i class="bi bi-person-fill" style="color:#fff; font-size:23px;"></i>
				</span>
				<span class='bold' style="line-height:25px;">${vo.userName}</span>
			</div>
			<div class="col text-end">
				<ul class="star star-none mb-0">
					<c:forEach var="n" begin="1" end="${vo.rate}">
				    	<li class="on"><span>★</span></li>
					</c:forEach>
					<c:forEach var="n" begin="${vo.rate+1}" end="5">
				    	<li><span>★</span></li>
					</c:forEach>
				</ul>	
			</div>
		</div>
		<!-- head:e -->
		
		<!-- body:s -->
		<div class="py-2 text-break">${vo.content}</div>
		<!-- body:e -->
		
		<!-- footer:s -->
		<div class="text-end">
			<span class="text-muted"><small>${vo.reg_date}</small></span>
			<c:choose>
				<c:when
					test="${sessionScope.member.userId==vo.userId || sessionScope.member.membership > 50 }">
			
					<span class='deleteReview border-start ps-2' data-reviewNum='${vo.reviewNum}' data-pageNo='${pageNo}' style="cursor:pointer;">
						<i class="bi bi-trash"></i>
					</span>
					
				</c:when>
				<c:otherwise>
	
				</c:otherwise>
			</c:choose>
		</div>
		<!-- footer:e -->
	</div>
</c:forEach>

<div class="pagination pagination-sm justify-content-center border-0 mt-4">${paging}</div>
