<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.body-container {
	max-width: 800px;
}

.ck






.ck-editor__main
>
.ck-editor__editable






:not



 



(
.ck-focused



 



)
{
border






:



 



none






;
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
	function deleteCourse() {
	    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
		    var query = "pageNo=1&num=${dto.num}";
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

//강좌 찜 여부
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

$(function(){
	listPage(1);
});

// 챕터 리스트
function listPage(page) {
	var url = "${pageContext.request.contextPath}/course/listChapter";
	var query = "num=${dto.num}&pageNo="+page;
	var selector = "#listChapter";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}
//챕터 등록
$(function(){
	$(".btnSendChapter").click(function(){
		var num = "${dto.num}";
		var $tb = $(this).closest("table");
		var chapterNo = $tb.find("textarea[name=chapterNo]").val().trim();
		var chapterName = $tb.find("textarea[name=chapterName]").val().trim();
		if(! chapterNo) {
			$tb.find("textarea[name=chapterNo]").focus();
			return false;
		}
		if(! chapterName) {
			$tb.find("textarea[name=chapterName]").focus();
			return false;
		}
		chapterName = encodeURIComponent(chapterName);
		
		var url = "${pageContext.request.contextPath}/course/insertChapter";
		var query = "num=" + num + "&chapterNo=" + chapterNo + "&chapterName=" + chapterName + "&video=0";
		
		var fn = function(data){

			
			var state = data.state;
			if(state === "true") {
				listPage(1);
			} else if(state === "false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


// 챕터 별  영상 등록
$(function(){
	$("body").on("click", ".btnSendVideo", function(){
		var num = "${dto.num}";
		var chapNum = $(this).attr("data-chapNum");
		var $td = $(this).closest("td");
		
		var chapterNo = $td.find("textarea[name=chapterNo]").val().trim();
		var chapterName = $td.find("textarea[name=chapterName]").val().trim();
		var videoLink = $td.find("textarea[name=videoLink]").val().trim();
		
		if(! chapterNo) {
			$td.find("textarea[name=chapterNo]").focus();
			return false;
		}
		if(! chapterName) {
			$td.find("textarea[name=chapterName]").focus();
			return false;
		}
		if(! videoLink) {
			$td.find("textarea[name=videoLink]").focus();
			return false;
		}
		chapterName = encodeURIComponent(chapterName);
		
		var url = "${pageContext.request.contextPath}/course/insertVideo";
		var query = "num=" + num + "&chapterName=" + chapterName + "&video=" + chapNum + "&chapterNo=" + chapterNo + "&videoLink=" + videoLink;
		alert(query);
		var fn = function(data){
			$td.find("textarea[name=chapterNo]").val("");
			$td.find("textarea[name=chapterName]").val("");
			$td.find("textarea[name=videoLink]").val("");
			
			var state = data.state;
			if(state === "true") {
				listVideo(chapNum);
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 영상 목록
function listVideo(video) {
	var url = "${pageContext.request.contextPath}/course/listVideo";
	var query = "video=" + video;
	var selector = "#listVideo" + video;
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}


// 영상 목록 늘리기 버튼
$(function(){
	$("body").on("click", ".btnVideoListLayout", function(){
		var $trVideoList = $(this).closest("tr").next();

		
		var isVisible = $trVideoList.is(':visible');
		var chapNum = $(this).attr("data-chapNum");
			
		if(isVisible) {
			$trVideoList.hide();
		} else {
			$trVideoList.show();
            
			// 영상 리스트
			listVideo(chapNum);

		}
	});
	
});

$(function(){
	// 챕터 추가 대화상자
	$("body").on("click", ".btnChapterAdd", function(){
		$("form[name=categoryForm]").each(function(){
			this.reset();
		});
		
		$("#addChapterModal").modal("show");
	});
});

$(function(){
	// 영상 추가 대화상자
	$("body").on("click", ".btnVideoAdd", function(){
		$("form[name=videoForm]").each(function(){
			this.reset();
		});
		
		$(".btnSendVideo").attr("data-chapNum", $(this).attr("data-chapNum"));
		
		
		$("#addVideoModal").modal("show");
	});
});
</script>




<body>
	<section class="py-5">
		<div class="container px-5 my-5">
			<div class="col-lg-3 sticky-top float-start"
				style="padding-top: 100px; padding-right: 50px;">
				<figure class="mb-4">
					<img class="img-fluid rounded" style="width: 270px; height: 170px;"
						src="${pageContext.request.contextPath}/uploads/course/${dto.imageFile}"
						alt="..." />
				</figure>
				<div class="d-flex align-items-center mt-lg-5 mb-4">
					<img class="img-fluid rounded" style="width: 48px; height: 48px;"
						src="${pageContext.request.contextPath}/uploads/creatorInfo/${dto.imageFilename}"
						alt="..." />
					<div class="ms-3">
						<div class="fw-bold">${dto.creatorName}</div>
						<div class="text-muted">${dto.courseName}</div>

					</div>
				</div>
				<figure class="mb-4">
					<div>
						<button type="button"
							class="btn btn-outline-secondary btnSendCourseLike" title="좋아요">
							<i
								class="bi ${userCourseLiked ? 'bi-hand-thumbs-up-fill':'bi-hand-thumbs-up' }"></i>&nbsp;&nbsp;<span
								id="courseLikeCount">${dto.courseLikeCount}</span>
						</button>
					</div>
				</figure>
			</div>
			<div class="row gx-5">
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
										<td style="width: 1000px;">${dto.courseLevel}</td>
									</tr>
									<tr>
										<td>강사명</td>
										<td>${dto.creatorName}</td>
									</tr>
									<tr>
										<td>태그</td>
										<td>${dto.tag}</td>

									</tr>
									<tr>
										<td style="border-bottom: none;">추천대상</td>
										<td>${dto.recommended}</td>
									</tr>
								</tbody>
							</table>
						</figure>

						<!-- Preview image figure-->

						<!-- Post content-->
						<section class="mb-5">
							<div class="editor">${dto.content}</div>
						</section>
					</article>
					<div class="Chapter">
						<div class="col ps-1">
							<button class="btn btn-light btnChapterAdd" type="button">과목추가</button>
						</div>

						<div id="listChapter"></div>
					</div>

					<!-- Comments section-->




					<table class="table table-borderless mb-2">
						<tr>
							<td width="50%"><c:choose>
									<c:when test="${sessionScope.member.userId==dto.userId}">
										<button type="button" class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/course/update?pageNo=1&num=${dto.num}';">수정</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light"
											disabled="disabled">수정</button>
									</c:otherwise>
								</c:choose> <c:choose>
									<c:when
										test="${sessionScope.member.userId==dto.userId || sessionScope.member.membership>50}">
										<button type="button" class="btn btn-light"
											onclick="deleteCourse();">삭제</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light"
											disabled="disabled">삭제</button>
									</c:otherwise>
								</c:choose></td>
							<td class="text-end">
								<button type="button" class="btn btn-light"
									onclick="location.href='${pageContext.request.contextPath}/course/main';">리스트</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</section>
</body>
<div class="modal fade" id="addChapterModal" tabindex="-1"
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

				<form name="chapterForm" method="post">

					<table class="table table-borderless chapter-form">
						<tr>
							<td><textarea class='form-control' name="chapterNo"
									placeholder="챕터번호"></textarea></td>
							<td><textarea class='form-control' name="chapterName"
									placeholder="챕터명"></textarea></td>
						</tr>
						<tr>
							<td align='right'>
								<button type='button' class='btn btn-light btnSendChapter'>챕터
									등록</button>
							</td>
						</tr>
					</table>
				</form>

			</div>
		</div>
	</div>
</div>
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