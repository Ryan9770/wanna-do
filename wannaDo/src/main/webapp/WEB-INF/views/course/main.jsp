<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.btn-level + .btn-level,
.btn-courses + .btn-courses{
	margin-left:0.5rem
}
.btn-level,.btn-courses{
	border-radius:5000rem;
}
.btn-courses{
	border-color:#212529;
}
.btn-courses:hover{
	background-color:#212529;
	color:#fff;
}
.btn-courses:focus{
	box-shadow:0 0 0 0.25rem rgb(33,37,41,0.25);
}
.btn-courses.active{
	background-color:#212529;
	color:#fff;
}

.level-badge{
	left:10px;
	top:10px;
	border-radius:5000rem;
}
</style>

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
		if($(this).hasClass("active")) {
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



$(function(){
	$(".btn-level").click(function(){
// 		$(".course-level").find(".btn-level").removeClass("btn-primary");
// 		$(".course-level").find(".btn-level").addClass("btn-danger");
// 		$(this).removeClass("btn-danger").addClass("btn-primary");

		$(this).addClass("active");
		$(this).siblings(".btn-level").removeClass("active");
		
		listPage(1);
	});
});

</script>

<div class="container">
	<div class="body-container">	
		<div class="body-title pt-5 mt-5" style="text-align: center;">
			<h1>All Courses</h1>
			<div>와나두와 함께하는 실력향상</div>
			<div>우리가 제공하는 강좌들을 살펴보세요.</div>
		</div>
	    		
	<div class="body-main mt-5 pt-4">
	<div class="container">
		<div class="col course-level d-flex align-items-center">
			<div class="me-3">난이도 필터</div>
			<button type="button" class="btn btn-outline-danger btn-level active">모두</button>
			<button type="button" class="btn btn-outline-danger btn-level">초급</button>
			<button type="button" class="btn btn-outline-danger btn-level">중급</button>
			<button type="button" class="btn btn-outline-danger btn-level">고급</button>
		</div>
		
		<div class="col d-flex align-items-center mt-2">
			<div class="me-3">과목별 필터</div>
			<div class="nav " id="myTab" role="tablist">
				<button class="btn btn-courses active" id="tab-0" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="0" aria-selected="true" data-categoryNum="0">모두</button>
				<c:forEach var="dto" items="${listCategory}" varStatus="status">
					<button class="btn btn-courses" id="tab-${status.count}" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="${status.count}" aria-selected="true" data-categoryNum="${dto.categoryNum}">${dto.category}</button>
				</c:forEach>
			</div>
		</div>
	</div>
			
			<div class="tab-content border-top border-danger border-2 mt-4 " id="nav-tabContent" >
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

<section class="py-1 bg-light my-3">
	<div class="container px-3 my-3">
		<h2 class="display-3 fw-bolder mb-3">쿠키가 부족하면?</h2>
		<a class="btn btn-lg btn-primary"
			href="${pageContext.request.contextPath}/credit/main">여기눌러</a>
	</div>
</section>

