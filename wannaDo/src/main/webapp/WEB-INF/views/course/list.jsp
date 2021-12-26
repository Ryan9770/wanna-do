<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<section class="py-5">
	<div class="container px-5 my-5 ">

		<c:if test="${list.size() > 0}">
		
			<div class="row gx-5">
				<c:forEach var="dto" items="${list}">
				<c:if test="${dto.enabled==1}">
					<div class="col-lg-3 course-list">
						<div class="position-relative mb-5" data-num="${dto.num}">
							<a href="article?pageNo=1&num=${dto.num}">
							<img class="img-fluid rounded-3 mb-3"
								style="width: 270px; height: 210px; border:1px solid #eee;"
								src="${pageContext.request.contextPath}/uploads/course/${dto.imageFile}"
								alt="..." /> 
								<span style=" display:block; text-align:center; padding:1.5rem; width:90%; background:rgba(255,255,255,0.95); border-radius:1rem; box-shadow: 0 4px 8px rgba(0,0,0,0.14); position:absolute; top:180px; left:50%; transform:translateX(-50%);">
									<span class="h5 fw-bolder text-decoration-none link-dark stretched-link d-block text-truncate">${dto.courseName}</span>
									<span class="text-decoration-none link-dark text-truncate">${dto.creatorName}</span>
								</span>
								<span class="position-absolute btn btn-danger btn-sm level-badge">${dto.courseLevel}</span>
							</a>
						</div>
					</div>
				</c:if>
				</c:forEach>
			</div>
		
		</c:if>
		<div class="page-box">${dataCount == 0 ? "등록된 강좌가 없습니다." : ""}</div>


	</div>
</section>



