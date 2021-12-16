<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<script type="text/javascript">

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
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	listPage(1);
	
    $("button[role='tab']").on("click", function(e){
		// var tab = $(this).attr("aria-controls");
    	listPage(1);
    	
    });
});

//글리스트 및 페이징 처리
function listPage(page) {
	var $tab = $("button[role='tab'].active");
	var categoryNum = $tab.attr("data-categoryNum");
	
	var level = "";
	$(".course-level").find(".btn-level").each(function(){
		if($(this).hasClass("btn-primary")) {
			level = $(this).text();
			return false;
		}
	});
	if(level == "모두") level = "";
	
	var url="${pageContext.request.contextPath}/course/list";
	var query="pageNo="+page+"&categoryNum="+categoryNum;
	
	query=query+"&level="+encodeURIComponent(level);
	
	var selector = "#nav-content";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 검색
function searchList() {
	var f=document.courseSearchForm;
	f.condition.value=$("#condition").val();
	f.keyword.value=$.trim($("#keyword").val());

	listPage(1);
}

// 새로고침
function reloadCourse() {
	var f=document.courseSearchForm;
	f.condition.value="all";
	f.keyword.value="";
	
	listPage(1);
}

$(function(){
	$(".btn-level").click(function(){
		$(".course-level").find(".btn-level").removeClass("btn-primary");
		$(".course-level").find(".btn-level").addClass("btn-danger");
		$(this).removeClass("btn-danger").addClass("btn-primary");
		
		listPage(1);
	});
});

</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title" style="text-align: center;">
			<h1>강좌 목록 </h1>
		</div>
	    		
		<div class="body-main">
	<div class="container">
		<div class="col course-level" style="width: 50%">
			<h5 style="text-align: center;">난이도 필터</h5>
			<button type="button" class="btn btn-primary btn-level">모두</button>
			<button type="button" class="btn btn-danger btn-level">초급</button>
			<button type="button" class="btn btn-danger btn-level">중급</button>
			<button type="button" class="btn btn-danger btn-level">고급</button>
		</div>
		
		<div class="col" style="width: 50%">
			<h5 style="text-align: center;">과목별 필터</h5>
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="tab-0" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="0" aria-selected="true" data-categoryNum="0">모두</button>
				</li>
				<c:forEach var="dto" items="${listCategory}" varStatus="status">
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="tab-${status.count}" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="${status.count}" aria-selected="true" data-categoryNum="${dto.categoryNum}">${dto.category}</button>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
			
			<div class="tab-content pt-2" id="nav-tabContent" >
				<div class="tab-pane fade show active" id="nav-content" role="tabpanel" aria-labelledby="nav-tab-content">
				</div>
			</div>
			
		</div>
				<div class="col text-end">
					<button type="button" class="btn btn-light"
						onclick="location.href='${pageContext.request.contextPath}/course/write';">강좌
						등록</button>
				</div>
	</div>
</div>

<section class="py-1 bg-light">
	<div class="container px-3 my-3">
		<h2 class="display-3 fw-bolder mb-3">쿠키가 부족하면?</h2>
		<a class="btn btn-lg btn-primary"
			href="${pageContext.request.contextPath}/credit/buy">여기눌러</a>
	</div>
</section>

