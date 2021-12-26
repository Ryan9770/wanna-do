<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="vo" items="${listVideo}">
	<div class='border-bottom mb-2'>
		<div class='row py-1'>
			<div class='col-6'>
				<span class="bold">${vo.orderNo}.${vo.subject}</span>
			</div>
			<div class='col text-end'></div>
			<div class="col ps-1">
				<c:choose>
					<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.membership>50}">
						<span class='deleteVideo' data-chapNum='${vo.chapNum}' data-video='${vo.video}'>삭제</span>
					</c:when>
					<c:otherwise>
						
					</c:otherwise>
				</c:choose>
				<button class="btn btn-light btnWatchVideo" type="button"
					data-chapNum="${vo.chapNum}" data-url="${vo.videoLink}">영상
					보기</button>
			</div>
		</div>

	</div>

</c:forEach>



