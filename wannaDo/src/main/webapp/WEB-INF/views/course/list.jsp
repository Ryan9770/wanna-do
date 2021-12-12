<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.course-list div>div.over {
	cursor: pointer;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot-board.css"
	type="text/css">

<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}


</script>
<body>
	<section class="py-5">
		<div class="container px-5 my-5 ">

			<c:if test="${list.size() > 0}">
				<div class="row gx-5 course-list">
					<c:forEach var="dto" items="${list}">
						<div class="col-lg-3 course-list">
							<div class="position-relative mb-5" data-num="${dto.num}">
								<img class="img-fluid rounded-3 mb-3"
									style="width: 270px; height: 210px;"
									src="${pageContext.request.contextPath}/uploads/course/${dto.imageFilename}"
									alt="..." /> <a 
									class="h4 fw-bolder text-decoration-none link-dark stretched-link"
									href="#!">${dto.courseName}</a> <a
									class="h5 fw-bolder text-decoration-none link-dark stretched-link"
									href="#!">${dto.price}</a> <a
									class="h5 fw-bolder text-decoration-none link-dark stretched-link"
									href="#!">${dto.groupCategory}</a>

							</div>
						</div>

					</c:forEach>
				</div>
			</c:if>
			<div class="page-box">${dataCount == 0 ? "등록된 강좌가 없습니다." : ""}</div>

			<div class="col text-end">
				<button type="button" class="btn btn-light"
					onclick="location.href='${pageContext.request.contextPath}/course/write';">강좌 등록</button>
			</div>
		</div>
	</section>
	<section class="py-1 bg-light">
		<div class="container px-3 my-3">
			<h2 class="display-3 fw-bolder mb-3">쿠키가 부족하면?</h2>
			<a class="btn btn-lg btn-primary"
				href="${pageContext.request.contextPath}/credit/buy">여기눌러</a>
		</div>
	</section>
</body>

