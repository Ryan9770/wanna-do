
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style type="text/css">
</style>



<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
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
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	$(".btnSendTradeLike").click(function(){
		var $i = $(this).find("i");
		var userLiked = $i.hasClass("bi-hand-thumbs-up-fill");
		var msg = userLiked ? "찜한 것을 취소할까요? " : "이 거래글을 찜할까요? ";
		
		if(! confirm( msg )) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/trade/insertTradeLike";
		var num=$(this).attr("data-num");
		var query="num="+num+"&userLiked="+userLiked;
		
		var fn = function(data){
			var state = data.state;
			if(state==="true") {
				if( userLiked ) {
					$i.removeClass("bi-hand-thumbs-up-fill").addClass("bi-hand-thumbs-up");
				} else {
					$i.removeClass("bi-hand-thumbs-up").addClass("bi-hand-thumbs-up-fill");
				}
				
				var count = data.tradeLikeCount;
				$("#tradeLikeCount"+num).text(count);
			} else if(state==="liked") {
				alert("게시글 공감은 한번만 가능합니다. !!!");
			} else if(state==="false") {
				alert("게시물 공감 여부 처리가 실패했습니다. !!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


</script>
<div>
<div style="margin-top: 50px; margin-left: 80px; width: 90%;">
	<div>
		<p style="text-align: left; font-size: 25px;"> 중고거래 게시판</p>
	 	<p style="color: grey; font-size: 14px;"> 중고거래 게시판입니다. </p>
	<hr size="5" width="90%" align="center">
	</div>
</div>

<section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
				<c:forEach var="dto" items="${list}" varStatus="status">                    
					<div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
		                            <a href="${articleUrl}&num=${dto.num}" title="${dto.subject}">
					 					<img class="img-fluid img-thumbnail w-100 h-100" src="${pageContext.request.contextPath}/uploads/trade/${dto.originalFilename}">
					 				</a>
					 		<!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                  <p style="color: grey;"> ${dto.type} </p>  <h5 class="fw-bolder"><a href="${articleUrl}&num=${dto.num}">${dto.subject} ${replyCount} </a></h5>
                                    <!-- Product price-->
                                    ₩ ${dto.price}"
                                    <br> ${dto.reg_date}
                                    <br> ${dto.userName}
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
	                             <div class="text-center">
									<button type="button" class="btn btn-outline-secondary btnSendTradeLike" data-num="${dto.num}" title="찜하기"><i class="bi ${userTradeLiked ? 'bi-hand-thumbs-up-fill':'bi-hand-thumbs-up' }"></i>&nbsp;&nbsp;<span id="tradeLikeCount${dto.num}">${dto.tradeLikeCount}</span></button>
	                        	</div>
                           	<!--
                                 <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#"> 찜 </a></div>
                             -->
                            </div>
                        </div>
                    </div>
               </c:forEach>
              </div>
            </div>
              
			<div class="page-box">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
			
			<div class="row board-list-footer">
				<div class="col">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/trade/list';">새로고침</button>
			</div>
			
			<div class="col-6 text-center">
					<form class="row" name="searchForm" action="${pageContext.request.contextPath}/trade/list" method="post">
						<div class="col-auto p-1">
							<select name="condition" class="form-select">
								<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
								<option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
								<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
								<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
								<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
								<option value="type" ${condition=="type"?"selected='selected'":""}>말머리</option>
							</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="keyword" value="${keyword}" class="form-control">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				<div class="col text-end">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/trade/write';">글올리기</button>
				</div>
			</div>
</section>
</div>