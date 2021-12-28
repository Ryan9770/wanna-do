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

.star {font-size:0; letter-spacing:-4px;}
.star li {
    font-size:22px;
    letter-spacing:0;
    display:inline-block;
    margin-left:3px;
    color:#cccccc;
    text-decoration:none;
    cursor:pointer;
}
.star li:first-child {margin-left:0;}
.star li.on {color:#F2CB61;}
.star-none  {
	cursor: default;
	pointer-events: none;
	
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
		var userLiked = $i.hasClass("bi-heart-fill");
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
					$i.removeClass("bi-heart-fill").addClass("bi-heart");
				} else {
					$i.removeClass("bi-heart").addClass("bi-heart-fill");
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
		var rate = $tb.find("input[name=rate]").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "${pageContext.request.contextPath}/course/insertReview";
		var query = "num="+num+"&content="+content+"&rate="+rate;
		
		var fn = function(data){
			$tb.find("textarea").val("");
			$tb.find("input[name=rate]").val("0");
			
			var state=data.state;
			if(state === "true") {
				listPage1(1);
			} else if(state === "false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 별점 추가
$(function(){
	$( ".star-input li" ).click(function() {
		var b=$(this).hasClass("on");
	    $(this).parent().children("li").removeClass("on");
	    $(this).addClass("on").prevAll("li").addClass("on");
	    if(b) {
	    	$(this).removeClass("on");
	    }
	    
	    var s=$(".star-input .on").length;
	    $("#rate").val(s);
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

// 쪽지
$(function(){
	$("body").on("click", ".btnQnaMessage", function(){
		$("form[name=qnaForm]").each(function(){
			this.reset();
		});
		
		$(".btnQnaMessage").attr("data-receiveId", $(this).attr("data-receiveId"));
		$("#qnaMessageModal").modal("show");
	});
});

function sendOk() {
	var f = document.noteForm;
	var str;


	str = f.content.value.trim();
	if(!str) {
		alert("내용을 입력하세요.");
		f.content.focus();
		return;
	}

	f.action="${pageContext.request.contextPath}/note/write";

	f.submit();
}

$(function(){
	$(".btnReceiverDialog").click(function(){
		$("#condition").val("userName");
		$("#keyword").val("");
		$(".dialog-receiver-list ul").empty();
		
		$("#myDialogModal").modal("show");
	});
	
	// 대화상자 - 받는사람 검색 버튼
	$(".btnReceiverFind").click(function(){
		var condition = $("#condition").val();
		var keyword = $("#keyword").val();
		if(! keyword) {
			$("#keyword").focus();
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/note/listFriend"; 
		var query = "condition="+condition+"&keyword="+encodeURIComponent(keyword);
		
		var fn = function(data){
			$(".dialog-receiver-list ul").empty();
			searchListFriend(data);
		};
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function searchListFriend(data) {
		var s;
		for(var i=0; i<data.listFriend.length; i++) {
			var userId = data.listFriend[i].userId;
			var userName = data.listFriend[i].userName;
			
			s = "<li><input type='checkbox' class='form-check-input' data-userId='"+userId+"' title='"+userId+"'> <span>"+userName+"</span></li>";
			$(".dialog-receiver-list ul").append(s);
		}
	}
	
	// 대화상자-받는 사람 추가 버튼
	$(".btnAdd").click(function(){
		var len1 = $(".dialog-receiver-list ul input[type=checkbox]:checked").length;
		var len2 = $("#forms-receiver-list input[name=receivers]").length;
		
		if(len1 == 0) {
			alert("추가할 사람을 먼저 선택하세요.");
			return false;			
		}
		
		if(len1 + len2 >= 5) {
			alert("받는사람은 최대 5명까지만 가능합니다.");
			return false;
		}
		
		var b, userId, userName, s;

		b = false;
		$(".dialog-receiver-list ul input[type=checkbox]:checked").each(function(){
			userId = $(this).attr("data-userId");
			userName = $(this).next("span").text();
			
			$("#forms-receiver-list input[name=receivers]").each(function(){
				if($(this).val() == userId) {
					b = true;
					return false;
				}
			});
			
			if(! b) {
				s = "<span class='receiver-user btn border px-1'>"+userName+" <i class='bi bi-trash' data-userId='"+userId+"'></i></span>";
				$(".forms-receiver-name").append(s);
				
				s = "<input type='hidden' name='receivers' value='"+userId+"'>";
				$("#forms-receiver-list").append(s);
			}
		});
		
		$("#myDialogModal").modal("hide");
	});
	
	$(".btnClose").click(function(){
		$("#myDialogModal").modal("hide");
	});
	
	$("body").on("click", ".bi-trash", function(){
		var userId = $(this).attr("data-userId");
		
		$(this).parent().remove();
		$("#forms-receiver-list input[name=receivers]").each(function(){
			var receiver = $(this).val();
			if(userId == receiver) {
				$(this).remove();
				return false;
			}
		});
		
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
						<div class="border border-secondary rounded col-7  d-flex align-items-center justify-content-center"><div>
							<ul class="star star-none">
								<c:forEach var="n" begin="1" end="${dto.rateAvg}">
							    	<li class="on"><span>★</span></li>
							   
								</c:forEach>
								<c:forEach var="n" begin="${dto.rateAvg+1}" end="5">
							    	<li><span>★</span></li>
								</c:forEach>
							</ul>
			 	 		</div>
		 	 		</div>
						<button type="button"
							class="btn btn-outline-secondary btnSendCourseLike col-4" title="좋아요">
							<i
								class="bi ${userCourseLiked ? 'bi-heart-fill':'bi-heart' }"></i>&nbsp;&nbsp;<span
								id="courseLikeCount">${dto.courseLikeCount}</span>
						</button>
					</div>
					<div class="d-grid">
						<button type="button" class="btn btn-danger"
							onclick="location.href='${pageContext.request.contextPath}/course/pay?num=${dto.num}&price=${dto.price}&courseName=${dto.courseName}';">구매하기</button>
					</div>
					<div>
						<button type='button' class='btn btn-light btnQnaMessage' data-receiveId="${dto.userId}">쪽지 보내기</button>
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
					<div class="review pt-5" >
						<div class="bg-light border border-light px-5 py-5">
							<form name="reviewForm" method="post">
								<div class='form-header'>
									<span class="bold">리뷰</span><span> - 후기 작성 부탁드립니다.</span>
								</div>
		
								<table class="table table-borderless review-form">
									<tr>
										<td><textarea class='form-control' name="content" placeholder="평가내용"></textarea>
										</td>
										<td>
											<div>
												<ul class="star star-input">
											    	<li><span>★</span></li>
												    <li><span>★</span></li>
												    <li><span>★</span></li>
												    <li><span>★</span></li>
												    <li><span>★</span></li>
												</ul>
												<input type="text" name="rate" id="rate" value="0" readonly="readonly" hidden="hidden">
										 	 </div>
										 
										<td align='right'>
											<button type='button' class='btn btn-danger btnSendReview'>리뷰 등록</button>
										</td>
									</tr>
			
					
								</table>
							</form>
		
							<div id="listReview"></div>
						</div>
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
				
				<a href="${pageContext.request.contextPath}/credit/main">쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키쿠키</a>
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
						style="border: none;"></iframe>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="qnaMessageModal" tabindex="-1"
	data-bs-backdrop="static" data-bs-keyboard="false"
	aria-labelledby="myDialogModalLabel2" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 550px; height: 800px">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel2">쪽지 보내기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form name="noteForm" method="post">
					<table class="table write-form mt-5">
						<tr>
							<td class="table-light col-sm-2" scope="row">받는사람</td>
							<td>
								<div class="row">
									<div class="col-auto pe-0">
										<button type="button" class="btn btn-light btnReceiverDialog">추가</button>
									</div>
									<div class="col">
										<div class="forms-receiver-name"><span class='receiver-user btn border px-1'>${dto.userId}<i class='bi bi-trash' data-userId='${dto.userId}'></i></span></div>
									</div>
								</div>	
							</td>
						</tr>
						
						<tr>
							<td class="table-light col-sm-2" scope="row">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control" value="">
							</td>
						</tr>
	        
						<tr>
							<td class="table-light col-sm-2" scope="row">내 용</td>
							<td>
								<textarea name="content" id="content" class="form-control"></textarea>
							</td>
						</tr>
						
					</table>
					
					<table class="table table-borderless mb-5">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn btn-dark" onclick="sendOk();">보내기&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/course/article?pageNo=1&num=${dto.num}';">취소&nbsp;<i class="bi bi-x"></i></button>
								<div id="forms-receiver-list"></div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="myDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">받는 사람</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-auto p-1">
						<select name="condition" id="condition" class="form-select">
							<option value="userName">이름</option>
							<option value="userId">아이디</option>
						</select>
					</div>
					<div class="col-auto p-1">
						<input type="text" name="keyword" id="keyword" class="form-control" value="${dto.userId}">
					</div>
					<div class="col-auto p-1">
						<button type="button" class="btn btn-light btnReceiverFind"> <i class="bi bi-search"></i> </button>
					</div>				
				</div>
				<div class="row p-1">
					<div class="border p-1 dialog-receiver-list">
						<ul></ul>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btnAdd">추가</button>
				<button type="button" class="btn btn-secondary btnClose">닫기</button>
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
		var movSrc = 'https://www.youtube.com/embed/'+url+'?autoplay=1&enablejsapi=1&version=3&playerapiid=ytplayer';
		// var movSrc = 'https://www.youtube.com/embed/'+url;
		document.getElementById("sampleMovie").setAttribute("allow", "accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture");
		document.getElementById("sampleMovie").setAttribute("allowfullscreen", 1);
		document.getElementById("sampleMovie").setAttribute("src", movSrc);
		
		
		$("#watchVideoModal").modal("show");
	
	});
	
	var myModalEl = document.getElementById('watchVideoModal');
	myModalEl.addEventListener('hide.bs.modal', function (event) {
		var frame = document.getElementById("sampleMovie");
	    frame.contentWindow.postMessage('{"event":"command","func":"' + 'stopVideo' + '","args":""}', '*');
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