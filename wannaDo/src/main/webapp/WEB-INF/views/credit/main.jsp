<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">
<script type="text/javascript">
<c:if test="${not empty sessionScope.member}">
$(function(){
	$("#tab-list").addClass("active");
    $("button[role='tab']").on("click", function(e){
		var tab = $(this).attr("data-tab");
		
		if(tab === "list") {
			listPage(1);
		} else if(tab === "listUse") {
			listUse(1);
    	} else {
			 buyPage();
		}
    });
});
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
		    	if(jqXHR.status===403) {
		    		login();
		    		return false;
		    	} else if(jqXHR.status === 402) {
		    		alert("권한이 없습니다.");
		    		return false;
				} else if(jqXHR.status === 400) {
					alert("요청 처리가 실패 했습니다.");
					return false;
		    	}
				console.log(jqXHR.responseText);
			}
		});
	}
	<c:if test="${not empty sessionScope.member}">
	$(function(){
		listPage(1);
	});
	</c:if>
	
	<c:if test="${not empty sessionScope.member}">
	$(function(){
		listUse(1);
	});
	</c:if>
	
	<c:if test="${empty sessionScope.member}">
	$(function(){
		buyPage();
	});
	</c:if>
	
	function listPage(page) {
		var url = "${pageContext.request.contextPath}/credit/list";
		var query = "pageNo="+page;
		var selector = ".content-frame";
		
		var fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}
	
	function listUse(page) {
		var url = "${pageContext.request.contextPath}/credit/listUse";
		var query = "pageNo="+page;
		var selector = ".content-frame";
		
		var fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}
	
	function buyPage() {
		var url = "${pageContext.request.contextPath}/credit/buy";
		var query = null;
		var selector = ".content-frame";
		
		var fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}
	$(function(){
		var isLogin = "${not empty sessionScope.member ? 'true':'false'}";
		if(isLogin === "true") {
			myCookie();
		}
		function myCookie() {
			var url = "${pageContext.request.contextPath}/credit/myCookie";
			$.ajax({
				type:"POST",
				url:url,
				async:false,
				data:null,
				dataType:"json",
				success:function(data) {
					var myCookie = data.myCookie;
					$("#myCookie").html(myCookie);
				}
			});
		}
	});
	
</script>

<div class="container px-5 py-5">
	<div class="body-container">	
		<div class="body-title mb-3">
			<c:choose>
				<c:when test="${not empty sessionScope.member}">
					<span><h3>내쿠키</h3></span><span>보유 중인 쿠키 : </span><span id="myCookie"></span><span> <img class="rounded-circle me-3" src="https://user-images.githubusercontent.com/93500782/145944393-e33135d9-16c1-495c-9d34-5f5fd1d79f32.png" width="15" height="15"/></span>
				</c:when>
				<c:otherwise>
					<h3>쿠키샵</h3>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="body-main">
		<c:if test="${not empty sessionScope.member}">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-list" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="list" aria-selected="true" data-tab="list">구매내역</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-listUse" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="listUse" aria-selected="false" data-tab="listUse">쿠키사용내역</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-buy" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="buy" aria-selected="false" data-tab="buy">쿠키샵</button>
				</li>
			</ul>
		</c:if>
			<div class="body-main content-frame">
			</div>
		</div>
	</div>
</div>
