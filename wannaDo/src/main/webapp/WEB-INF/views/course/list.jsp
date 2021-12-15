<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<section class="py-5">
	<div class="container px-5 my-5 ">

		<c:if test="${list.size() > 0}">
			<div class="row gx-5">
				<c:forEach var="dto" items="${list}">
					<div class="col-lg-3 course-list">
						<div class="position-relative mb-5" data-num="${dto.num}">
							<img class="img-fluid rounded-3 mb-3"
								style="width: 270px; height: 210px;"
								src="${pageContext.request.contextPath}/uploads/course/${dto.imageFile}"
								alt="..." /> <a 
								class="h4 fw-bolder text-decoration-none link-dark stretched-link"
								href="article?pageNo=1&num=${dto.num}">${dto.creatorName}</a>

						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
		<div class="page-box">${dataCount == 0 ? "등록된 강좌가 없습니다." : ""}</div>


	</div>
</section>



