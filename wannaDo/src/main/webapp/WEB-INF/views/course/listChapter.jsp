<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
.accordion-item>h2>button, .accordion-item>h2>button:focus {
	box-shadow: inset 0 -1px 0 rgb(0 0 0/ 13%);
}

.accordion-button:after {
	background-image:
		url("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='%23212529'><path fill-rule='evenodd' d='M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z'/></svg>")
		!important;
}
/* .accordion-item + .accordion-item{
	border-top:1px solid #ccc;
} */
</style>

<div class="accordion" id="accordionFlush">
	<c:forEach var="vo" items="${listChapter}" varStatus="status">
		<div class="accordion-item">
			<h2 class="accordion-header ms-2" id="flush-heading-${status.index}">
				<button class="accordion-button btnVideoListLayout bg-white" 
					style="color: #212529;" data-chapNum='${vo.chapNum}' type="button" ${userCourseBought ? '':'disabled="disabled'}
					data-bs-toggle="collapse"
					data-bs-target="#flush-collapse-${status.index}"
					aria-expanded="false"
					aria-controls="flush-collapse-${status.index}">${vo.orderNo}.${vo.subject }
				</button>
			</h2>
			<div id="flush-collapse-${status.index}"
				class="accordion-collapse collapse"
				aria-labelledby="flush-heading-${status.index}">
				<div class="accordion-body bg-light">
					<table class='table table-borderless mb-4' id='listVideo${vo.chapNum}'>
					</table>

					<div class="row">
						<div class="col">
							<c:choose>
								<c:when test="${sessionScope.member.userId==vo.userId}">
									<button class="btn btn-outline-dark btnVideoAdd"  
										data-chapNum="${vo.chapNum}" type="button">영상 <i class="bi bi-plus"></i></button>
								</c:when>
								<c:otherwise>

								</c:otherwise>
							</c:choose>
						</div>
						<div class="col text-end">
							<c:choose>
								<c:when test="${sessionScope.member.userId==vo.userId}">
									<button class='btn btn-outline-danger deleteChapter'
										data-chapNum='${vo.chapNum}'>챕터 삭제</button>
								</c:when>
								<c:otherwise>

								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
<div class="modal fade" id="addVideoModal" tabindex="-1"
	data-bs-backdrop="static" data-bs-keyboard="false"
	aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">영상 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">

				<form name="videoForm" method="post">

					<table class='table table-borderless'>
						<tr>
							<td colspan='2' class="px-3">
								<div class="p-2 border">

									<div class="row px-2">
										<div class='col'>
											<input class='form-control' name="orderNo"
												placeholder="영상번호"></input>
											<input class='form-control' name="subject"
												placeholder="영상제목"></input>
											<input class='form-control' name="videoLink"
												placeholder="영상링크"></input>
										</div>
									</div>
									<div class='row p-2'>
										<div class="col text-end">
											<button type='button' class='btn btn-outline-secondary btnSendVideo'
												data-chapNum='${vo.chapNum}'>영상 등록</button>
										</div>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</form>

			</div>
		</div>
	</div>
</div>



