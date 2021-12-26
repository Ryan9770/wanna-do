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
		var orderNo = $tb.find("textarea[name=orderNo]").val().trim();
		var subject = $tb.find("textarea[name=subject]").val().trim();
		if(! orderNo) {
			$tb.find("textarea[name=orderNo]").focus();
			return false;
		}
		if(! subject) {
			$tb.find("textarea[name=subject]").focus();
			return false;
		}
		subject = encodeURIComponent(subject);
		
		var url = "${pageContext.request.contextPath}/course/insertChapter";
		var query = "num=" + num + "&orderNo=" + orderNo + "&subject=" + subject + "&video=0";
		
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
		
		var orderNo = $td.find("textarea[name=orderNo]").val().trim();
		var subject = $td.find("textarea[name=subject]").val().trim();
		var videoLink = $td.find("textarea[name=videoLink]").val().trim();
		
		if(! orderNo) {
			$td.find("textarea[name=orderNo]").focus();
			return false;
		}
		if(! subject) {
			$td.find("textarea[name=subject]").focus();
			return false;
		}
		if(! videoLink) {
			$td.find("textarea[name=videoLink]").focus();
			return false;
		}
		subject = encodeURIComponent(subject);
		
		var url = "${pageContext.request.contextPath}/course/insertVideo";
		var query = "num=" + num + "&subject=" + subject + "&video=" + chapNum + "&orderNo=" + orderNo + "&videoLink=" + videoLink;
		
		var fn = function(data){
			$td.find("textarea[name=orderNo]").val("");
			$td.find("textarea[name=subject]").val("");
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

// 챕터 삭제
$(function(){
	$("body").on("click", ".deleteChapter", function(){
		if(! confirm("챕터를 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var chapNum = $(this).attr("data-chapNum");
		
		
		var url = "${pageContext.request.contextPath}/course/deleteChapter";
		var query = "chapNum="+chapNum;
		
		var fn = function(data){
			// var state = data.state;
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
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

// 영상 삭제
$(function(){
	$("body").on("click", ".deleteVideo", function(){
		if(! confirm("영상을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var chapNum = $(this).attr("data-chapNum");
		var video = $(this).attr("data-video");
		
		var url = "${pageContext.request.contextPath}/course/deleteVideo";
		var query = "chapNum=" + chapNum;
		
		var fn = function(data){
			listVideo(video);
	
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


// 리뷰 페이징 처리
$(function(){
	listPage1(1);
});

function listPage1(page) {
	var url = "${pageContext.request.contextPath}/course/listReview";
	var query = "num=${dto.num}&pageNo="+page;
	var selector = "#listReview";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 리뷰 등록
$(function(){
	$(".btnSendReview").click(function(){
		var num = "${dto.num}";
		
		var $tb = $(this).closest("table");
		var content = $tb.find("textarea").val().trim();
		var rate = $tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "${pageContext.request.contextPath}/course/insertReview";
		var query = "num="+num+"&content="+content+"&rate="+rate;
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state === "true") {
				listPage(1);
			} else if(state === "false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 리뷰 삭제
$(function(){
	$("body").on("click", ".deleteReview", function(){
		if(! confirm("리뷰를 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var reviewNum = $(this).attr("data-reviewNum");
		var page = $(this).attr("data-pageNo");
		
		var url = "${pageContext.request.contextPath}/course/deleteReview";
		var query = "reviewNum="+reviewNum;
		
		var fn = function(data){
			// var state=data.state;
			listPage1(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});
</script>


<body>
	<section class="pb-5 bg-light">
	<div class="sub-banner position-relative" style="height:160px; background:#212529;">
		<h1 class="fw-bolder mb-1 position-absolute top-50 start-50 translate-middle" style="color:#fff; min-width:fit-content;">${dto.courseName}</h1>		
	</div>
		<div class="container my-5">
			<div class="col-lg-3 sticky-top float-start bg-white border border-light shadow rounded" style="top:40px;">
				<div style="overflow: hidden; height: 190px;">
					<img class="img-fluid rounded" style="width: 100%; height: auto;"
						src="${pageContext.request.contextPath}/uploads/course/${dto.imageFile}"
						alt="..." />
				</div>
				<div class="p-3">
					<div class="fs-2 py-3">
						<img width="35" height="35" style="vertical-align:sub; margin-right:0.7rem;" src="https://user-images.githubusercontent.com/93500782/145944393-e33135d9-16c1-495c-9d34-5f5fd1d79f32.png"/>
					${dto.price}개</div>
					<div class="d-flex align-items-center my-4 border border-end-0 border-start-0 border-secondary py-3">
						<img class="img-fluid rounded" style="width: 60px; height: auto;"
							src="${pageContext.request.contextPath}/uploads/creatorInfo/${dto.imageFilename}"
							alt="..." />
						<div class="ms-3">
							<div class="fw-bold">${dto.creatorName}</div>
							<div class="text-muted">${dto.intro}</div>
	
						</div>
					</div>
					<div class="d-flex justify-content-between mb-3">
						<div class="border border-secondary rounded col-7  d-flex align-items-center justify-content-center">★★★★★ <span>5.0</span></div>
						<button type="button"
							class="btn btn-outline-secondary btnSendCourseLike col-4" title="좋아요">
							<i
								class="bi ${userCourseLiked ? 'bi-hand-thumbs-up-fill':'bi-hand-thumbs-up' }"></i>&nbsp;&nbsp;<span
								id="courseLikeCount">${dto.courseLikeCount}</span>
						</button>
					</div>
					<div class="d-grid">
						<button type="button" class="btn btn-danger"
							onclick="${pageContext.request.contextPath}/course/pay">구매하기</button>
					</div>
				</div>
			</div>
			
			<div class="d-inline-flex col-7">
				<div class="bg-white border border-light shadow rounded mx-3 p-3">
					<!-- Post content-->
					<article>
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
							<c:choose>
								<c:when test="${sessionScope.member.userId==dto.userId}">
									<button class="btn btn-light btnChapterAdd" type="button">챕터추가</button>
								</c:when>
								<c:otherwise>

								</c:otherwise>
							</c:choose>

						</div>

						<div id="listChapter"></div>
					</div>

					<!-- Comments section-->
					<div class="review">
						<form name="reviewForm" method="post">
							<div class='form-header'>
								<span class="bold">리뷰</span><span> - 후기 작성 부탁드립니다.</span>
							</div>

							<table class="table table-borderless review-form">
								<tr>
									<td><textarea class='form-control' name="content" placeholder="평가내용"></textarea>
									</td>
								</tr>
								<tr>
									<td><textarea class='form-control' name="rate" placeholder="별점"></textarea>
									</td>
								</tr>
								<tr>
									<td align='right'>
										<button type='button' class='btn btn-light btnSendReview'>리뷰
											등록</button>
									</td>
								</tr>
							</table>
						</form>

						<div id="listReview"></div>
					</div>



					<table class="table table-borderless mb-2">
						<tr>
							<td width="50%"><c:choose>
									<c:when
										test="${sessionScope.member.userId==dto.userId || sessionScope.member.membership>50}">
										<button type="button" class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/course/update?pageNo=1&num=${dto.num}';">수정</button>
									</c:when>
									<c:otherwise>

									</c:otherwise>
								</c:choose> <c:choose>
									<c:when
										test="${sessionScope.member.userId==dto.userId || sessionScope.member.membership>50}">
										<button type="button" class="btn btn-light"
											onclick="deleteCourse();">삭제</button>
									</c:when>
									<c:otherwise>

									</c:otherwise>
								</c:choose></td>
							<td class="text-end">
								<button type="button" class="btn btn-light"
									onclick="location.href='${pageContext.request.contextPath}/course/main';">강좌목록</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
		
			<div class="col-2 sticky-top float-end bg-white border border-light shadow rounded" style="top:40px;">
				광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고광고
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
							<td><textarea class='form-control' name="orderNo"
									placeholder="챕터번호"></textarea></td>
							<td><textarea class='form-control' name="subject"
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

<div class="modal fade" id="watchVideoModal" tabindex="-1"
	data-bs-backdrop="static" data-bs-keyboard="false"
	aria-labelledby="myDialogModalLabel2" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 550px; height: 400px">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel2">영상</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">

				<div class='col'>
					<iframe id="sampleMovie" width="500" height="300"
						style="border: none;" allowfullscreen></iframe>
				</div>
			</div>
		</div>
	</div>
</div>

<script>               

var $videoId = "";
var player = null;
$(function(){
	// 영상 시청 대화상자
	$("body").on("click", ".btnWatchVideo", function(){
		var url = $(this).attr("data-url");
		url = url.substring(url.lastIndexOf('/') +1); 
		if(url.indexOf("=") > 0) {
			$url = url.substring(url.indexOf("=") + 1);
		}
		var movSrc = 'https://www.youtube.com/embed/'+url+'?autoplay=1';
		// var movSrc = 'https://www.youtube.com/embed/'+url;
		document.getElementById("sampleMovie").setAttribute("allow", "accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture");
		document.getElementById("sampleMovie").setAttribute("src", movSrc);
		
		
		$("#watchVideoModal").modal("show");
		


		

	});
});


</script>


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