<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




	<div class="accordion" id="accordionPanelsStayOpenExample">
		<c:forEach var="vo" items="${listChapter}">
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingOne">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
						aria-controls="panelsStayOpen-collapseOne">${vo.chapterNo}.${vo.chapterName }</button>
				</h2>
				<div id="panelsStayOpen-collapseOne"
					class="accordion-collapse collapse show"
					aria-labelledby="panelsStayOpen-headingOne">
					<div class="accordion-body"><iframe width="560" height="315" src="https://www.youtube.com/embed/mEZlClPvYRI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
				</div>
			</div>
		</c:forEach>
	</div>



