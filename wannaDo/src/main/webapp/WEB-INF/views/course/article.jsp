<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.body-container {
	max-width: 800px;
}

.ck.ck-editor__main>.ck-editor__editable:not (.ck-focused ) {
	border: none;
}

.table .ellipsis {
	position: relative;
	min-width: 200px;
}

.table .ellipsis span {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	position: absolute;
	left: 9px;
	right: 9px;
	cursor: pointer;
}

.table .ellipsis:before {
	content: '';
	display: inline-block;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot-board.css"
	type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/ckeditor.js"></script>

<script type="text/javascript">
<c:if test="${sessionScope.member.userId==dto.userId||sessionScope.member.membership>50}">
	function deleteBoard() {
	    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
		    var query = "num=${dto.num}&${query}";
		    var url = "${pageContext.request.contextPath}/course/delete?" + query;
	    	location.href = url;
	    }
	}
</c:if>
</script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

//게시글 공감 여부
$(function(){
	$(".btnSendCourseLike").click(function(){
		var $i = $(this).find("i");
		var userLiked = $i.hasClass("bi-hand-thumbs-up-fill");
		var msg = userLiked ? "강좌 찜을 취소하시겠습니까 ? " : "강좌 찜을하십니까 ? ";
		
		if(! confirm( msg )) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/course/insertCourseLike";
		var num="${dto.num}";
		var query="num="+num+"&userLiked="+userLiked;
		
		var fn = function(data){
			var state = data.state;
			if(state==="true") {
				if( userLiked ) {
					$i.removeClass("bi-hand-thumbs-up-fill").addClass("bi-hand-thumbs-up");
				} else {
					$i.removeClass("bi-hand-thumbs-up").addClass("bi-hand-thumbs-up-fill");
				}
				
				var count = data.courseLikeCount;
				$("#courseLikeCount").text(count);
			} else if(state==="liked") {
				alert("강좌 찜은 한번만 가능합니다. !!!");
			} else if(state==="false") {
				alert("강좌 찜 여부 처리가 실패했습니다. !!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


</script>


<body>
	<section class="py-5">
		<div class="container px-5 my-5">
			<div class="row gx-5">
				<div class="col-lg-3">
					<figure class="mb-4">
						<img class="img-fluid rounded"
							src="${pageContext.request.contextPath}/uploads/course/${dto.imageFilename}"
							alt="..." />
					</figure>
					<div class="d-flex align-items-center mt-lg-5 mb-4">
						<img class="img-fluid rounded"
							src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." />
						<div class="ms-3">
							<div class="fw-bold">${dto.userId}</div>
							<div class="text-muted">${dto.courseName}</div>

						</div>

					</div>
				</div>
				<div class="col-lg-9">
					<!-- Post content-->
					<article>
						<!-- Post header-->
						<header class="mb-4">
							<!-- Post title-->
							<h1 class="fw-bolder mb-1">${dto.courseName}</h1>
							<!-- Post meta content-->
							<div class="text-muted fst-italic mb-2">${dto.reg_date}</div>
							<!-- Post categories-->

						</header>

						<figure>
							<table class="table">
								<tbody>
									<tr>
										<td style="width: 200px;">난이도</td>
										<td style="width: 1000px;">${dto.groupCategory}</td>
									</tr>
									<tr>
										<td>강사명</td>
										<td>${dto.userId}</td>
									</tr>
									<tr>
										<td>태그</td>
										<td  class="badge bg-secondary text-decoration-none link-light">${dto.tag}</td>

									</tr>
									<tr>
										<td style="border-bottom: none;">추천대상</td>
										<td>${dto.recommended}</td>
									</tr>
								</tbody>
							</table>
						</figure>

						<!-- Preview image figure-->
						<figure class="mb-4">
							<div>
							<button type="button" class="btn btn-outline-secondary btnSendCourseLike" title="좋아요"><i class="bi ${userCourseLiked ? 'bi-hand-thumbs-up-fill':'bi-hand-thumbs-up' }"></i>&nbsp;&nbsp;<span id="courseLikeCount">${dto.courseLikeCount}</span></button>
							</div>
						</figure>
						<!-- Post content-->
						<section class="mb-5">
							<div class="editor">${dto.content}</div>
						</section>
					</article>
					<div class="accordion accordion-flush" id="accordionFlushExample">
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingOne">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#flush-collapseOne"
									aria-expanded="false" aria-controls="flush-collapseOne">
									챕터 1</button>
							</h2>
							<div id="flush-collapseOne" class="accordion-collapse collapse"
								aria-labelledby="flush-headingOne"
								data-bs-parent="#accordionFlushExample">
								<div class="accordion-body">1-1 abcdefg</div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingTwo">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo"
									aria-expanded="false" aria-controls="flush-collapseTwo">
									챕터 2</button>
							</h2>
							<div id="flush-collapseTwo" class="accordion-collapse collapse"
								aria-labelledby="flush-headingTwo"
								data-bs-parent="#accordionFlushExample">
								<div class="accordion-body">2-1 hijk</div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingThree">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#flush-collapseThree"
									aria-expanded="false" aria-controls="flush-collapseThree">
									챕터 3</button>
							</h2>
							<div id="flush-collapseThree" class="accordion-collapse collapse"
								aria-labelledby="flush-headingThree"
								data-bs-parent="#accordionFlushExample">
								<div class="accordion-body">
									<a href="#">3-1 lmnop</a>
								</div>
							</div>
							<div id="flush-collapseThree" class="accordion-collapse collapse"
								aria-labelledby="flush-headingThree"
								data-bs-parent="#accordionFlushExample">
								<div class="accordion-body">
									<a href="#">3-2 qrstuv</a>
								</div>
							</div>
						</div>
					</div>



					<!-- Comments section-->
					<div
						class="height-100 container d-flex justify-content-center align-items-center">
						<div class="card p-3">
							<div class="d-flex justify-content-between align-items-center">
								<div class="ratings">
									<i class="fa fa-star rating-color"></i> <i
										class="fa fa-star rating-color"></i> <i
										class="fa fa-star rating-color"></i> <i
										class="fa fa-star rating-color"></i> <i class="fa fa-star"></i>
								</div>
								<h5 class="review-count">12 Reviews</h5>
							</div>
						</div>
					</div>



					<section>
						<div class="card bg-light">
							<div class="card-body">
								<!-- Comment form-->
								<form class="mb-4">
									<textarea class="form-control" rows="3"
										placeholder="Join the discussion and leave a comment!"></textarea>
								</form>
								<!-- Comment with nested comments-->
								<div class="d-flex mb-4">
									<!-- Parent comment-->
									<div class="flex-shrink-0">
										<img class="rounded-circle"
											src="https://dummyimage.com/50x50/ced4da/6c757d.jpg"
											alt="..." />
									</div>
									<div class="ms-3">
										<div class="row">
											<div class="fw-bold col">Commenter Name</div>

										</div>
										If you're going to lead a space frontier, it has to be
										government; it'll never be private enterprise. Because the
										space frontier is dangerous, and it's expensive, and it has
										unquantified risks.
									</div>
								</div>
								<!-- Single comment-->
								<div class="d-flex">
									<div class="flex-shrink-0">
										<img class="rounded-circle"
											src="https://dummyimage.com/50x50/ced4da/6c757d.jpg"
											alt="..." />
									</div>
									<div class="ms-3">
										<div class="fw-bold">Commenter Name</div>
										When I look at the universe and all the ways the universe
										wants to kill us, I find it hard to reconcile that with
										statements of beneficence.
									</div>
								</div>
							</div>
						</div>
					</section>
					<table class="table table-borderless mb-2">
						<tr>
							<td width="50%"><c:choose>
									<c:when test="${sessionScope.member.userId==dto.userId}">
										<button type="button" class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/course/update?num=${dto.num}&group=${group}&page=${page}';">수정</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light"
											disabled="disabled">수정</button>
									</c:otherwise>
								</c:choose> <c:choose>
									<c:when
										test="${sessionScope.member.userId==dto.userId || sessionScope.member.membership>50}">
										<button type="button" class="btn btn-light"
											onclick="deleteBoard();">삭제</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light"
											disabled="disabled">삭제</button>
									</c:otherwise>
								</c:choose></td>
							<td class="text-end">
								<button type="button" class="btn btn-light"
									onclick="location.href='${pageContext.request.contextPath}/course/list?${query}';">리스트</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</section>
</body>
<script type="text/javascript">
ClassicEditor
.create( document.querySelector( '.editor' ), {
})
.then( editor => {
	window.editor = editor;
	editor.isReadOnly = true;
	editor.ui.view.top.remove( editor.ui.view.stickyPanel );
} );
</script>
</html>