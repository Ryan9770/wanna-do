<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="vo" items="${listVideo}">
	<tr>
		<td>
			<div class='row py-2 border-bottom align-items-center'>
				<div class='col-9'>
					<span class="bold">${vo.orderNo}.${vo.subject}</span>
				</div>
				<div class="col text-end p-0">
					<c:choose>
						<c:when
							test="${sessionScope.member.userId==vo.userId || sessionScope.member.membership>50}">
							<span class='deleteVideo' data-chapNum='${vo.chapNum}'
								data-video='${vo.video}' style="cursor: pointer;"><i class='bi bi-trash'></i></span>
						</c:when>
						<c:otherwise>

						</c:otherwise>
					</c:choose>
					<button class="btn btn-secondary btnWatchVideo ms-3" type="button"
						data-chapNum="${vo.chapNum}" data-url="${vo.videoLink}"><i class="bi bi-play-btn"></i>  영상 보기</button>
				</div>
			</div>
		</td>
	</tr>

</c:forEach>



