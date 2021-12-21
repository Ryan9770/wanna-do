
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style type="text/css">
.body {
}
.num {
	width: 70px;
}

.name {
	width: 120px;
}

.regdate {
	width: 200px;
}

.hitcount {
	width: 80px;
}

.price {
	width: 90px;
}

.likebutton {
	width: 70px;
}
</style>



<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}


</script>

<div>
<div style="margin-top: 50px; margin-left: 80px; width: 90%;">
	<div>
		<p style="text-align: left; font-size: 25px;"> 중고거래 게시판</p>
	 	<p style="color: grey; font-size: 14px;"> 중고거래 게시판입니다. </p>
	<hr size="5" width="90%" align="center">
	</div>
</div>

<br>

<div>
	<table class="table table-striped" style="width: 90%; vertical-align: center; margin: auto;">
		<tr>
			<th class="num">번호</th>
			<th class="name">말머리</th>
			<th class="subject">제목</th>
			<th class="name">작성자</th>
			<th class="regdate">작성일</th>
			<th class="hitcount">조회수</th>
			<th class="price"> 가격 </th>
		</tr>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td> ${dto.listNum} </td>
				<td> ${dto.type} </td>
				<td><a href="${articleUrl}&num=${dto.num}">${dto.subject} ${replyCount} </a></td>
				<td> ${dto.userName} </td>
				<td> ${dto.reg_date} </td>
				<td> ${dto.hitCount} </td>
				<td> <fmt:formatNumber value="${dto.price }" pattern="#,###" /> </td>
			</tr>
		</c:forEach>
	</table>
</div>
 
 <br>
 <nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
    <li>${dataCount == 0 ? "등록된 게시물이 없습니다." :  paging} </li>
</ul>
</nav>

<table class="table">
		<tr>
			<td width="100">
				<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/trade/list';">새로고침</button>
			</td>
				<td align="left">
					<form name="searchForm" action="${pageContext.request.contextPath}/trade/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
							<option value="name" ${condition=="name"?"selected='selected'":""}>작성자</option>
							<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="type" ${condition=="type"?"selected='selected'":""}>말머리</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF">
						<button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
				</td>
			<td align="right" width="100">
		<tr>
		<td align="right" width="100">
			<button type="button" class="button" onclick="location.href='${pageContext.request.contextPath}/trade/write';">글올리기</button>
		</td>
	</tr>
</table> </div>