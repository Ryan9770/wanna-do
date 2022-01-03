<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="hrtag">
    <hr>
</div>

<br>
<div>
	<table class="table table-light" style="width: 50%; vertical-align: center; margin: auto;">
			<tr>
				<th class="num">번호</th>
				<th class="subject">제목</th>
				<th class="name">작성자</th>
				<th class="regdate">작성일</th>
				<th class="hitcount">조회수</th>
			</tr>
		<c:forEach var="dto" items="${noticeList}">
			<table  class="table table-hover" style="width: 50%; vertical-align: center; margin: auto;">
				<tr>
					<td class="num"><span class="badge bg-danger">공지</span></td>
					<td class="subject">
						<a href="javascript:articleBoard('${dto.num}', '${pageNo}');" class="linkoption" style="font-weight: bold;">${dto.subject}</a>
					</td>
					<td class="name">관리자</td>
					<td class="regdate">${dto.reg_date}</td>
					<td class="hitcount">${dto.hitCount}</td>
				</tr>
			</table>
		</c:forEach>
						
		<c:forEach var="dto" items="${list}">
			<table  class="table table-hover" style="width: 50%; vertical-align: center; margin: auto;">			
				<tr>
					<td class="num">${dto.listNum}</td>
					<td class="left">
						<a href="javascript:articleBoard('${dto.num}', '${pageNo}');" class="linkoption">${dto.subject}</a>
					</td>
					<td class="name">관리자</td>
					<td class="regdate">${dto.reg_date}</td>
					<td class="hitcount">${dto.hitCount}</td>
				</tr>
			</table>
		</c:forEach>
	</table>
</div>
 
<br>
<div class="page-box" style="text-align: center">
	${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
</div>

<div class="cent-align">
	<form class="row" name="searchForm" action="${pageContext.request.contextPath}/notice/main" method="post" style="text-align: center">
		<div class="col-auto p-1">
		<select name="condition" class="form-select">
			<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
			<option value="name" ${condition=="userName"?"selected='selected'":""}>작성자</option>
			<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
			<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
			<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		</select> &nbsp;
		</div>
		<div class="col-auto p-1">
			<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요." value="${keyword}" class="form-control">
		</div>
		<div class="col-auto p-1">
			<button type="button" class="btn btn-outline-danger" onclick="searchList()"> <i class="bi bi-search"></i> </button>
		</div>
	</form>
</div>



<table class="table" style="width: 50%; vertical-align: center; margin: auto;">
		<tr>
			<td align="left">
				<button type="button" class="btn btn-outline-danger" onclick="reloadBoard();">새로고침</button>
			</td>
		<tr>
	</tr>
</table>