<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css" type="text/css">

<style type="text/css">
.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}
</style>

<main>
	<div class="body-container">	
		<div class="body-title">
			<h2><i class="icofont-basket"></i>중고거래 게시판 관리</h2>
		</div>
		
	  <div class="body-main shadow">
			<table class="table">
				<tr>
					<td align="left" width="50%">
						${dataCount}개(${page}/${total_page} 페이지)
					</td>
				</tr>
			</table>		

			<table class="table table-hover table-list">
				<thead class="table-light">
					<tr>
						<th class="col-1">번호</th>
						<th class="col-4">제목</th>
						<th class="col-2">작성자</th>
						<th class="col-2">작성일</th>
						<th class="col-1">조회수</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="dto" items="${list}">
						<tr class="hover-tr" onclick="detailtrade('${dto.num}')">
							<td>${dto.listNum}</td>
							<td>
							${dto.subject}&nbsp;
							<c:if test="${dto.replyCount!=0}">(${dto.replyCount})</c:if>
							</td>
							<td>${dto.userName}</td>
							<td>${dto.reg_date}</td>
							<td>${dto.hitCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
				<div class="page-box">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>
						
				<table class="table">
					<tr>
						<td align="left" width="100">
							<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/tradeManage/list';">새로고침</button>
						</td>
						<td align="center">
							<form name="searchForm" action="${pageContext.request.contextPath}/admin/tradeManage/list" method="post">
								<select name="condition" id="condition" class="selectField">
									<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
									<option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
									<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
									<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
									<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
								</select>
								<input type="text" name="keyword" id="keyword" class="boxTF" value="${keyword}">
								<input type="hidden" name="page" value="1">
								<button type="button" class="btn" onclick="search()">검색</button>
							</form>
						</td>
						<td align="right" width="100">&nbsp;</td>
					</tr>
				</table>
			
			</div>
			
	    </div>

	<div id="trade-dialog" style="display: none;"></div>
</main>

<script type="text/javascript">


function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR) {
			if (jqXHR.status == 403) {
				location.href="${pageContext.request.contextPath}/member/login";
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
		}
	});
}

function detailtrade(num){
	var dlg = $("#trade-dialog").dialog({
		autoOpen: false,
		modal: true,
		buttons:{
			"삭제" : function() {
				deleteOk(num);
			},
			 " 닫기 " : function() {
		    	$(this).dialog("close");
	        }
		},
		height:768,
		width:1024,
		title: "게시글 정보",
		close:function(event, ui) {
		}
	});
	
	var url = "${pageContext.request.contextPath}/admin/tradeManage/detail";
	var query = "num="+num;
	
	var fn = function(data) {
		$("#trade-dialog").html(data);
		dlg.dialog("open");
	};
	ajaxFun(url,"post", query, "html", fn);
}

function deleteOk(num) {
	if(! confirm("선택한 게시글을 삭제하시겠습니까 ? ")){
		return false;
	}
	var query = "page="+${page}+"&num="+num;
	var url = "${pageContext.request.contextPath}/admin/tradeManage/delete?"+query;
	location.href=url;	
}


function listPage(page) {
	var url = "${pageContext.request.contextPath}/admin/tradeManage/list?";
	var query = "page="+page;
	
	location.href=url+query;
}

$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("댓글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum = $(this).attr("data-replyNum");
		var page = $(this).attr("data-page");
		
		var url = "${pageContext.request.contextPath}/admin/tradeManage/deleteReply";
		var query = "replyNum="+replyNum;
		
		var fn = function(data){
			$("#trade-dialog").dialog("close");
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

function search() {
	var f=document.searchForm;
	f.condition.value=$("#condition").val();
	f.keyword.value=$.trim($("#keyword").val());
	f.action = "${pageContext.request.contextPath}/admin/tradeManage/list";
	f.submit();
}
</script>