<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<style type="text/css">
.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}
</style>

<main>
	<div class="body-container">
	    <div class="body-title">
			<h2><i class="icofont-drawing-tablet"></i> 크리에이터 관리 </h2>
	    </div>
	    
	    <div class="body-main shadow">
				<div class="container d-flex justify-content-around">
					<div class="row">
					<c:forEach var="dto" items="${list}">
					  <div class="col-4 p-5 text-center">
						 <a onclick="detailedMember('${dto.userId}')">
						 	<img src="${pageContext.request.contextPath}/uploads/creatorInfo/${dto.imageFilename}" class="img-fluid">
						 <span class="fw-bold fs-5">${dto.creatorName}</span>
						 <span>: ${dto.enabled==0?"계정 잠금":"계정 활성"}</span>
						 </a>
					  </div>
					  </c:forEach>
					</div>
				</div>
						 
				<div class="page-box">
					${dataCount == 0 ? "등록된 크리에이터가 없습니다." : paging}
				</div>
						
				<table class="table">
					<tr>
						<td align="left" width="100">
							<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/memberManage/clist';">새로고침</button>
						</td>
						<td align="center">
							<form name="searchForm" action="${pageContext.request.contextPath}/admin/memberManage/clist" method="post">
								<select name="condition" class="selectField">
									<option value="userId"     ${condition=="userId" ? "selected='selected'":""}>아이디</option>
									<option value="creatorName"   ${condition=="creatorName" ? "selected='selected'":""}>이름</option>		
								</select>
								<input type="text" name="keyword" class="boxTF" value="${keyword}">
								<input type="hidden" name="page" value="1">
								<button type="button" class="btn" onclick="searchList()">검색</button>
							</form>
						</td>
						<td align="right" width="100">&nbsp;</td>
					</tr>
				</table>
			
			</div>
			
	    </div>
	<div id="member-dialog" style="display: none;"></div>
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
			console.log(jqXHR.responseText);
		}
	});
}

function searchList() {
	var f=document.searchForm;
	f.action="${pageContext.request.contextPath}/admin/memberManage/clist";
	f.submit();
}
	
function detailedMember(userId) {
	var dlg = $("#member-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 수정 " : function() {
		    	   updateOk(); 
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 520,
		  width: 800,
		  title: "크리에이터 상세정보",
		  close: function(event, ui) {
		  }
	});
	
	console.log(userId);
	var url = "${pageContext.request.contextPath}/admin/memberManage/detail";
	var query = "userId="+userId;
	
	console.log(url);
	var fn = function(data){
		$('#member-dialog').html(data);
		console.log(data);
		dlg.dialog("open");
	};
	ajaxFun(url, "post", query, "html", fn);
}
	
function updateOk() {
	var f = document.deteailedMemberForm;
	
	if(! f.stateCode.value) {
		f.stateCode.focus();
		return;
	}
	if(! $.trim(f.memo.value)) {
		f.memo.focus();
		return;
	}
	
	var url = "${pageContext.request.contextPath}/admin/memberManage/updateMemberState";
	var query=$("#deteailedMemberForm").serialize();

	var fn = function(data){
		$("form input[name=page]").val("${page}");
		searchList();
	};
	ajaxFun(url, "post", query, "json", fn);
		
	$('#member-dialog').dialog("close");
}



function memberStateDetaileView() {
	$('#memberStateDetaile').dialog({
		  modal: true,
		  minHeight: 100,
		  maxHeight: 450,
		  width: 750,
		  title: '계정상태 상세',
		  close: function(event, ui) {
			   $(this).dialog("destroy");
		  }
	  });	
}

function selectStateChange() {
	var f = document.deteailedMemberForm;
	
	var s = f.stateCode.value;
	var txt = f.stateCode.options[f.stateCode.selectedIndex].text;
	
	f.memo.value = "";	
	if(! s) {
		return;
	}

	if(s!="0" && s!="6") {
		f.memo.value = txt;
	}
	
	f.memo.focus();
}
</script>
