<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css" type="text/css">

<style type="text/css">
.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}

.videoFrame{
	max-width:800px;
	max-height:640px;
}
</style>

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
	var url = "${pageContext.request.contextPath}/admin/courseManage/list";
	location.href=url;
}	

function detailCourse(num) {
	var dlg = $("#course-dialog").dialog({
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
		  height: 640,
		  width: 1080,
		  title: "강의상세정보",
		  close: function(event, ui) {
		  }
	});

	var url = "${pageContext.request.contextPath}/admin/courseManage/detail";
	var query = "num="+num;
	
	var fn = function(data){
		$('#course-dialog').html(data);
		dlg.dialog("open");
	};
	ajaxFun(url, "post", query, "html", fn);
}
	
function updateOk() {
	var f = document.detailCourseForm;
	
	if(! f.stateCode.value) {
		f.stateCode.focus();
		return;
	}
	if(! $.trim(f.memo.value)) {
		f.memo.focus();
		return;
	}
	
	var url = "${pageContext.request.contextPath}/admin/courseManage/updateCourseState";
	var query=$("#detailCourseForm").serialize();

	var fn = function(data){
		$("form input[name=page]").val("${page}");
		searchList();
	};
	ajaxFun(url, "post", query, "json", fn);
		
	$('#course-dialog').dialog("close");
}

function courseStateDetailView() {
	$('#CourseStateDetail').dialog({
		  modal: true,
		  minHeight: 100,
		  maxHeight: 450,
		  width: 750,
		  title: '강의 상세',
		  close: function(event, ui) {
			   $(this).dialog("destroy"); // 이전 대화상자가 남아 있으므로 필요
		  }
	  });	
}

function selectStateChange() {
	var f = document.detailCourseForm;
	
	var s = f.stateCode.value;
	var txt = f.stateCode.options[f.stateCode.selectedIndex].text;
	console.log(s);
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

<main>
	<div class="body-container">
	    <div class="body-title">
			<h2><i class="icofont-book"></i> 강의 관리 </h2>
	    </div>
	    
	    <div class="body-main shadow">
				<table class="table">
					<tr>
						<td align="left" width="50%">
							${dataCount}개(${page}/${total_page} 페이지)
						</td>
						<td align="right">
							<select id="selectEnabled" name="searchForm" class="selectField" onchange="searchList();">
								<option value="" ${enabled=="" ? "selected='selected'":""}>::강좌상태::</option>
								<option value="0" ${enabled=="0" ? "selected='selected'":""}>잠금</option>
								<option value="1" ${enabled=="1" ? "selected='selected'":""}>활성</option>
							</select>
						</td>
					</tr>
				</table>
					
				<table class="table table-border table-list">
					<thead>
						<tr> 
							<th class="col-1 ">번호</th>
							<th class="col-1 ">카테고리</th>
							<th class="col-1 ">아이디</th>
							<th class="col-1 ">이름</th>
							<th class="col-4 ">강의명</th>
							<th class="col-3 ">강의등록날짜</th>
							<th class="col-1 ">승인상태</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}">
						<tr class="hover-tr" onclick="detailCourse('${dto.num}');"> 
							<td>${dto.listNum}</td>
							<td>${dto.category}</td>
							<td>${dto.userId}</td>
							<td>${dto.creatorName}</td>
							<td>${dto.courseName}</td>
							<td>${dto.reg_date}</td>
							<td>${dto.enabled==1?"승인":"미승인"}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
						 
				<div class="page-box">
					${dataCount == 0 ? "등록된 강좌가 없습니다." : paging}
				</div>
						
				<table class="table">
					<tr>
						<td align="left" width="100">
							<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/courseManage/list';">새로고침</button>
						</td>
					</tr>
				</table>
			
			</div>
			
	    </div>

	<div id="course-dialog" style="display: none;"></div>
</main>
