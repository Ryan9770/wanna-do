<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<div class="accordion" id="accordionPanelsStayOpenExample">
	<div class="accordion-item">
		<c:forEach var="vo" items="${listChapter}">
			<h2 class="accordion-header" id="panelsStayOpen-headingOne">
				<button class="accordion-button" type="button"
					data-bs-toggle="collapse"
					data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
					aria-controls="panelsStayOpen-collapseOne">${vo.chapterNo}.${vo.chapterName }</button>
			</h2>
			<div id="panelsStayOpen-collapseOne"
				class="accordion-collapse collapse show"
				aria-labelledby="panelsStayOpen-headingOne">
				<div class="accordion-body">
					<div class="p-2 border">
		            <div id='listVideo${vo.chapNum}' class='p-2'></div>
		            <div class="row px-2">
		                <div class='col'><textarea class='form-control' placeholder="영상순서 입력" name="lessonNum"></textarea></div>
		                <div class='col'><textarea class='form-control' placeholder="영상명 입력" name="lessonName"></textarea></div>
		                <div class='col'><textarea class='form-control' placeholder="영상링크 입력" name="saveFilename"></textarea></div>
		                <div class='col'><textarea class='form-control' placeholder="영상상태 입력" name="state"></textarea></div>
		            </div>
		             <div class='row p-2'>
		             	<div class="col text-end">
		                	<button type='button' class='btn btn-light btnSendVideo' data-chapNum='${vo.chapNum}'>영상 등록</button>
		                </div>
		            </div>
				</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>



