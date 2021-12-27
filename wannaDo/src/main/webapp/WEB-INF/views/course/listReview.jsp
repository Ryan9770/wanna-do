<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<table class='table table-borderless'>
	<c:forEach var="vo" items="${listReview}">
		<tr class='border bg-light'>
			<td width='50%'><span class='bold'>${vo.userName}</span></td>
			<td width='50%' align='right'><span class="text-muted">${vo.reg_date}</span>
				| <c:choose>
					<c:when
						test="${sessionScope.member.userId==vo.userId || sessionScope.member.membership > 50 }">
						<span class='deleteReview' data-reviewNum='${vo.reviewNum}'
							data-pageNo='${pageNo}'>삭제</span>

					</c:when>
					<c:otherwise>

					</c:otherwise>
				</c:choose></td>
		</tr>
		<tr>
			<td colspan='2' valign='top'>${vo.content}</td>
		</tr>
		<tr>
			<td colspan='2'>
				<ul class="star star-none">
					<c:forEach var="n" begin="1" end="${vo.rate}">
				    	<li class="on"><span>★</span></li>
					</c:forEach>
					<c:forEach var="n" begin="${vo.rate+1}" end="5">
				    	<li><span>★</span></li>
					</c:forEach>
				    <a>${vo.rate}</a>
				</ul>
			</td>
		</tr>

	</c:forEach>
</table>

<div class="page-box">${paging}</div>
