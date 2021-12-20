<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="vo" items="${listVideo}">
	<div class='border-bottom mb-2'>
		<div class='row py-1'>
			<div class='col-6'><span class="bold">${vo.chapterNo}.${vo.chapterName}</span></div>
			<div class='col text-end'>
			</div>
		</div>

		<div class='row px-2 pb-2'>
			<div class='col'><iframe width="90%" height="100%"
						src="${vo.videoLink}"
						title="YouTube video player" frameborder="0"
						allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
						allowfullscreen></iframe></div>
		</div>
	</div>
</c:forEach>