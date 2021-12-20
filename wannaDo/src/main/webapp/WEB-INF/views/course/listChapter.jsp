<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<div class="accordion" id="accordionFlush">
	<div class="accordion-item">
		<c:forEach var="vo" items="${listChapter}" varStatus="status">
			<h2 class="accordion-header" id="flush-heading-${status.index}">

				<button class="accordion-button btnVideoListLayout"
					data-chapNum='${vo.chapNum}' type="button"
					data-bs-toggle="collapse"
					data-bs-target="#flush-collapse-${status.index}"
					aria-expanded="false"
					aria-controls="flush-collapse-${status.index}">${vo.chapterNo}.${vo.chapterName }</button>

			</h2>
			<div id="flush-collapse-${status.index}"
				class="accordion-collapse collapse"
				aria-labelledby="flush-heading-${status.index}">
				<div class="accordion-body">
					<table class='table table-borderless'>
						<tr>
							<td colspan='2' class="px-3">
								<div class="p-2 border">
									<div id='listVideo${vo.chapNum}' class='p-2'></div>

									<div class='row p-2'>
										<div class="col ps-1">
											<button class="btn btn-light btnVideoAdd" data-chapNum="${vo.chapNum}" type="button">과목추가</button>
										</div>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<div class="modal fade" id="addVideoModal" tabindex="-1"
	data-bs-backdrop="static" data-bs-keyboard="false"
	aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">챕터 추가</h5>
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
											<textarea class='form-control' name="chapterNo"
												placeholder="영상번호"></textarea>
											<textarea class='form-control' name="chapterName"
												placeholder="영상제목"></textarea>
											<textarea class='form-control' name="videoLink"
												placeholder="영상링크"></textarea>
										</div>
									</div>
									<div class='row p-2'>
										<div class="col text-end">
											<button type='button' class='btn btn-light btnSendVideo'
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



