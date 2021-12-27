<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i>강좌 정보</h3>
<table class="table border mx-auto my-10">
	<tr>
		<td class="wp-15 text-right pe-7 bg">강의 번호</td>
		<td class="wp-35 text-start">${dto.num}</td>
		<td class="wp-15 text-right pe-7 bg">카테고리</td>
		<td class="wp-35 text-start">${dto.category}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">강좌명</td>
		<td class="text-start">${dto.courseName}</td>
		<td class="text-right pe-7 bg">강좌등록일</td>
		<td class="text-start">${dto.reg_date}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">난이도</td>
		<td class="text-start">${dto.courseLevel}</td>
		<td class="text-right pe-7 bg">태그</td>
		<td class="text-start">${dto.tag}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">수강생 수</td>
		<td class="text-start"></td>
		<td class="text-right pe-7 bg">가격</td>
		<td class="text-start">${dto.price}개</td>
	</tr>
	<tr>
		<td class="text-right pe-3 bg align-middle">추천대상</td>
		<td colspan="3" class="text-start">
			${dto.recommended}
		</td>
	</tr>
	<tr>
		<td class="text-right pe-3 bg align-middle">강의승인여부</td>
		<td colspan="3" class="text-start">
			${dto.enabled==1?"승인":"비공개전환"}
			<c:if test="${dto.enabled==0 && not empty courseState}">, ${courseState.memo}</c:if>
			&nbsp;<span class="btn" onclick="courseStateDetailView();" style="cursor: pointer;">자세히</span>
		</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg align-middle">강의소개</td>
		<td class="text-start align-middle" colspan="3">
			<c:if test="${ not empty dto.imageFile}">
			<img src="${pageContext.request.contextPath}/uploads/image/${dto.imageFile}">
			</c:if>
			${dto.content}
		</td>
	</tr>
</table>


<div id="CourseStateDetail" style="display: none;">
	<table class="table border mx-auto my-10">
		<tr class="bg text-center">
			<td>내용</td>
			<td width="200">등록일</td>
		</tr>
		
		<c:forEach var="vo" items="${listState}">
			<tr align="center">
				<td class="text-start">${vo.memo} (${vo.stateCode})</td>
				<td>${vo.sReg_date}</td>
			</tr>
		</c:forEach>
  
		<c:if test="${listState.size()==0}">
			<tr align="center">
				<td colspan="3">등록된 정보가 없습니다.</td>
			</tr>  
		</c:if>
	</table>  
</div>
