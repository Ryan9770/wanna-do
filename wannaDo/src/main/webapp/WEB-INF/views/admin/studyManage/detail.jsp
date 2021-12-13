<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 요청 정보</h3>
<table class="table border mx-auto my-10">
	<tr>
		<td class="wp-15 text-right pe-7 bg">강의 번호</td>
		<td class="wp-35 ps-5">${dto.num}</td>
		<td class="wp-15 text-right pe-7 bg">말머리</td>
		<td class="wp-35 ps-5">${dto.state}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">아이디</td>
		<td class="ps-5">${dto.userId}</td>
		<td class="text-right pe-7 bg">이름</td>
		<td class="ps-5">${dto.userName}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">게시글 작성일</td>
		<td class="ps-5">${dto.reg_date}</td>
		<td class="text-right pe-7 bg">제목</td>
		<td class="ps-5">&${dto.subject}</td>
	</tr>
	
	<tr>
		<td class="text-right pe-7 bg">내용</td>
		<td colspan="3" class="ps-5" style="height: 150px;">
			${dto.content}
		</td>
	</tr>
	</table>
	<table style="margin-top: 50px;">
	<tr>
		<td class="text-right pe-7 bg">게시글의 댓글</td>
		<c:forEach var="vo" items="${listReply}">
		<td class="ps-5">${vo.replyNum}</td>
		<td class="ps-5">${vo.userName}</td>
		<td class="ps-5">${vo.content}</td>
		<td class="ps-5">${vo.reg_date}</td>
		<td class="ps-5">${vo.answer}</td>
		</c:forEach>
	</tr>
</table>
