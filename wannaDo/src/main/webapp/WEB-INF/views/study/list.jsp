<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style type="text/css">
.board {
	margin: 50px;
	width: 90%;
	vertical-align: center; 
	text-align: center; 
	padding-top: 60px; 
	margin: auto;
}
.body {
}

.num {
	width: 70px;
	text-align: center;
}

.name {
	width: 120px;
	text-align: center;
	
}

.regdate {
	width: 200px;
	text-align: center;
}

.hitcount {
	width: 80px;
	text-align: center;
}

a:link {
	color: black;
	text-decoration: none;
}
a:visited {
	color: black;
	text-decoration: none;
}
a:hover {
	color: black;
	text-decoration: underline;
	font: bold;
}
a:active {
    text-decoration: none;
}

table {
	padding: 50px;
}

td {
	min-height: 100px;
}


</style>


<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}

</script>

<div class="board">
	<div class="title">
	    <h3> 스터디 룸 </h3>
	    <p style="color: grey;"> 스터디를 모집하거나 참가할 수 있습니다.  </p>
	    <hr>
	</div>
</div>	

<br>

<div>
	<table class="table table-light" style="width: 90%; vertical-align: center; margin: auto;">
		<tr>
			<th class="num">번호</th>
			<th class="name">말머리</th>
			<th class="subject">제목</th>
			<th class="name">작성자</th>
			<th class="regdate">작성일</th>
			<th class="hitcount">조회수</th>
		</tr>
		<c:forEach var="dto" items="${list}">
		<table  class="table table-hover" style="width: 90%; vertical-align: center; margin: auto;">
			<tr>
				<td class="num"> ${dto.listNum} </td>
				<td class="name"> ${dto.state} </td>
				<td class="subject"><a href="${articleUrl}&num=${dto.num}">${dto.subject}  &nbsp;
										<span class="badge bg-danger rounded-pill">${dto.replyCount}</span>
									</a></td>
				<td class="name"> ${dto.userName} </td>
				<td class="regdate"> ${dto.reg_date} </td>
				<td class="hitcount"> ${dto.hitCount} </td>
			</tr>
		</table>
		</c:forEach>
	</table>
</div>
 
<br>

<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">
		<li>${dataCount == 0 ? "등록된 게시물이 없습니다." :  paging} </li>
	</ul>
</nav>

<table class="table" style="width: 90%; vertical-align: center; margin: auto;">
		<tr>
			<td align="left">
				<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/study/list';">새로고침</button>
			</td>
				<td align="center">
				<div class="col-6 text-center" style="margin-left: 120px;">
					<form class="row" name="searchForm" action="${pageContext.request.contextPath}/study/list" method="post">
						<div class="col-auto p-1">
						<select name="condition" class="form-select">
							<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
							<option value="name" ${condition=="name"?"selected='selected'":""}>작성자</option>
							<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="state" ${condition=="state"?"selected='selected'":""}>말머리</option>
						</select> &nbsp;
						</div>
						<div class="col-auto p-1">
							<input type="text" name="keyword" placeholder="검색어를 입력하세요." value="${keyword}" class="form-control">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				</td>
			<td align="right">
				<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/study/write';">글올리기</button>
			</td>
		<tr>
	</tr>
</table>
