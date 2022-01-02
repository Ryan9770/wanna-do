<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css" type="text/css">

<style type="text/css">

.body-main {
	max-width: 1200px;
}

.hover-tr:hover {
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
	var enabled = $("#selectEnabled").val();
	var url = "${pageContext.request.contextPath}/creator/courseManage/list?enabled="+enabled;
	location.href=url;
}	

function updateOk(){
	var f = document.courseDetailForm;
	f.action="${pageContext.request.contextPath}/creator/courseManage/update";

	/*
	var url = "${pageContext.request.contextPath}/creator/courseManage/update";
	var query=$("#courseDetailForm").serialize();
	var fn = function(data){
		console.log(data);
		alert('수정이 완료되었습니다.📌');
		$('#course-dialog').dialog("close");	
	};

	ajaxFun(url, "post", query, "json", fn);
	*/
	

	alert('수정이 완료되었습니다.📌');
	$('#course-dialog').dialog("close");
	window.location.href='${pageContext.request.contextPath}/creator/courseManage/list';
	f.submit();
}

function detailCourse(num){
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
		  title: "강좌상세정보",
		  close: function(event, ui) {
		  }
	});
	var url ="${pageContext.request.contextPath}/creator/courseManage/detail";
	var query = "num="+num;
	
	var fn = function(data){
		$('#course-dialog').html(data);
		dlg.dialog("open");
	};
	ajaxFun(url, "post", query, "html", fn);
}

function courseStateDetailView(){
	$('#CourseStateDetail').dialog({
		  modal: true,
		  minHeight: 100,
		  maxHeight: 450,
		  width: 750,
		  title: '강좌 상세',
		  close: function(event, ui) {
			   $(this).dialog("destroy");
		  }
	  });
}
</script>

<main>
	<div class="body-container">
	    <div class="body-title">
			<h2> 내 강좌 목록 </h2>
	    </div>
	    
	    <div class="body-main ms-30">
			<table class="table">
				<tr>
					<td align="left" width="50%">
						${dataCount}개(${page}/${total_page} 페이지)
					</td>
					<td align="right">
						<select id="selectEnabled" name="enabled" class="selectField" onchange="searchList();">
							<option value="" ${enabled=="" ? "selected='selected'":""}>::강좌상태::</option>
							<option value="1" ${enabled=="1" ? "selected='selected'":""}>승인</option>
							<option value="0" ${enabled=="0" ? "selected='selected'":""}>미승인</option>
						</select>
					</td>
				</tr>
			</table>
					
			<table class="table table-border table-list">
				<thead>
					<tr> 
						<th class="col-1 ">번호</th>
						<th class="col-1 ">카테고리</th>
						<th class="col-5 ">강의명</th>
						<th class="col-2 ">강의등록날짜</th>
						<th class="col-1 ">수강생 수</th>
						<th class="col-1 ">챕터추가</th>
						<th class="col-1 ">승인상태</th>
					</tr>
				</thead>
					
				<tbody>
					<c:forEach var="dto" items="${list}">
					<tr class="hover-tr" > 
						<td>${dto.listNum}</td>
						<td>${dto.category}</td>
						<td style="cursor:pointer" onclick="detailCourse('${dto.num}');">${dto.courseName}</td>
						<td>${dto.reg_date}</td>
						<td>${dto.studentCount==null?"0":dto.studentCount}명</td>
						<c:if test="${dto.enabled==1}">
							<td style="cursor:pointer" onclick="javascript:location.href='${pageContext.request.contextPath}/course/article?pageNo=1&num=${dto.num}'"><i class="bi bi-folder-plus"></i></td>						
						</c:if>
						<c:if test="${dto.enabled!=1}">
							<td>-</td>						
						</c:if>
						<td>${dto.enabled==1?"승인":"미승인"}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="page-box">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
			<table class="table" >
				<tr>
					<td align="left" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/creator/courseManage/list';">새로고침</button>
					</td>
					<td align="right" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/creator/courseManage/write';">강좌등록</button>
					</td>
				</tr>
			</table>						 

		</div>
    </div>
    
	<div id="course-dialog" style="display: none;"></div>	
</main>
