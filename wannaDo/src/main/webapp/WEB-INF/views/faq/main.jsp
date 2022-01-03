<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
}
.board {
	margin: 50px;
	width: 50%;
	vertical-align: center; 
	text-align: center; 
	padding-top: 60px; 
	margin: auto;
}

.trade-form {
	margin: 50px;
	width: 90%;	
	border: 1px solid #BDBDBD;
	padding: 50px;
	border-radius: 5px;
	border-spacing: 10px;
	
}

.cent-align {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
}

a.linkoption:link {
	color: black;
	text-decoration: none;
}
a.linkoption:visited {
	color: black;
	text-decoration: none;
}
a.linkoption:hover {
	color: black;
	text-decoration: underline;
	font: bold;
}
a.linkoption:active {
    text-decoration: none;
}

.cent-align {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
}

.hrtag {
	width: 50%;
	vertical-align: center; 
	text-align: center; 
	margin: auto;
}


</style>

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
	
	var url="${pageContext.request.contextPath}/faq/list";
	var query="pageNo="+page+"&categoryNum="+categoryNum;
	var search=$('form[name=faqSearchForm]').serialize();
	query=query+"&"+search;
	
	var selector = "#nav-content";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 검색
function searchList() {
	var f=document.faqSearchForm;
	f.condition.value=$("#condition").val();
	f.keyword.value=$.trim($("#keyword").val());

	listPage(1);
}

// 새로고침
function reloadFaq() {
	var f=document.faqSearchForm;
	f.condition.value="all";
	f.keyword.value="";
	
	listPage(1);
}

// 글 삭제
function deleteFaq(num, page) {
	var url="${pageContext.request.contextPath}/faq/delete";
	
	var query="num="+num;
	
	if(! confirm("위 게시물을 삭제 하시 겠습니까 ? ")) {
		  return;
	}
	
	var fn = function(data){
		listPage(page);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}
</script>

<div class="board">
	<div class="title">
	    <h3> 자주묻는 질문 </h3>
	    <p style="color: grey;"> 자주묻는 질문들을 빠르게 알아보세요! </p>
	    <hr>
	</div>
</div>

<div class="container px-5 py-5">
	<div class="body-container">		
	    <div class="alert alert-info" role="alert">
	        <i class="bi bi-search"></i> 궁금한 문의 사항을 빠르게 검색 할 수 있습니다.
	    </div>
	    		
		<div class="body-main">
			
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
			
			<div class="tab-content pt-2" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-content" role="tabpanel" aria-labelledby="nav-tab-content">
				</div>
			</div>
			
		</div>
	</div>
</div>

<form name="faqSearchForm" method="post">
	<input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>
