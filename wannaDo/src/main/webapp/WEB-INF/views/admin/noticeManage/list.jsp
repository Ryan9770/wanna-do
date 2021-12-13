<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="row board-list-header">
    <div class="col-auto me-auto">
    	${dataCount}개(${pageNo}/${total_page} 페이지)
    </div>
    <div class="col-auto">&nbsp;</div>
</div>				

<table class="table table-hover board-list">
	<thead class="table-light">
		<tr>
			<th class="bw-60">번호</th>
			<th class="bw-auto">제목</th>
			<th class="bw-100">작성자</th>
			<th class="bw-100">작성일</th>
			<th class="bw-70">조회수</th>
			<th class="bw-50">파일</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="dto" items="${noticeList}">
			<tr>
				<td><span class="badge bg-primary">공지</span></td>
				<td class="left">
					<a href="javascript:articleBoard('${dto.num}', '${pageNo}');" class="text-reset">${dto.subject}</a>
				</td>
				<td>관리자</td>
				<td>${dto.reg_date}</td>
				<td>${dto.hitCount}</td>
				<td>
					<c:if test="${dto.fileCount != 0}">
						<a href="${pageContext.request.contextPath}/admin/noticeManage/zipdownload?num=${dto.num}" class="text-reset"><i class="bi bi-file-arrow-down"></i></a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
						
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.listNum}</td>
				<td class="left">
					<a href="javascript:articleBoard('${dto.num}', '${pageNo}');" class="text-reset">${dto.subject}</a>
				</td>
				<td>관리자</td>
				<td>${dto.reg_date}</td>
				<td>${dto.hitCount}</td>
				<td>
					<c:if test="${dto.fileCount != 0}">
						<a href="${pageContext.request.contextPath}/admin/noticeManage/zipdownload?num=${dto.num}" class="text-reset"><i class="bi bi-file-arrow-down"></i></a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="page-box">
	${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
</div>

<div class="row board-list-footer">
	<div class="col">
		<button type="button" class="btn btn-light" onclick="reloadBoard();">새로고침</button>
	</div>
	<div class="col-6 text-center">
		<div class="row">
			<div class="col-auto p-1">
				<select name="condition" id="condition" class="form-select">
					<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
					<option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
					<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
					<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
					<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
				</select>
			</div>
			<div class="col-auto p-1">
				<input type="text" name="keyword" id="keyword" value="${keyword}" class="form-control">
			</div>
			<div class="col-auto p-1">
				<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
			</div>
		</div>
	</div>
	<div class="col text-end">
		<c:if test="${sessionScope.member.membership>50}">
			<button type="button" class="btn btn-light" onclick="insertForm();">글올리기</button>
		</c:if>
	</div>
</div>
