<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 요청 정보</h3>
<table class="table border mx-auto my-10">
	<tr>
		<td class="wp-15 text-right pe-7 bg">강의 번호</td>
		<td class="wp-35 ps-5">${dto.num}</td>
		<td class="wp-15 text-right pe-7 bg">카테고리</td>
		<td class="wp-35 ps-5">${dto.category}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">아이디</td>
		<td class="ps-5">${dto.userId}</td>
		<td class="text-right pe-7 bg">이름</td>
		<td class="ps-5">${dto.userName}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">강좌등록일</td>
		<td class="ps-5">${dto.creg_date}</td>
		<td class="text-right pe-7 bg">비고</td>
		<td class="ps-5">&nbsp;</td>
	</tr>
	
	<tr>
		<td class="text-right pe-7 bg">강의승인여부</td>
		<td colspan="3" class="ps-5">
			${dto.enabled==1?"승인":"비공개전환"}
			<c:if test="${dto.enabled==0 && not empty courseState}">, ${courseState.memo}</c:if>
			&nbsp;<span class="btn" onclick="courseStateDetailView();" style="cursor: pointer;">자세히</span>
		</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">강의소개</td>
		<td class="ps-5" colspan="3">
			<div class="videoFrame">${dto.content}</div>
		</td>
	</tr>
</table>



<form id="detailCourseForm" name="detailCourseForm" method="post">
	<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 강의 상태 변경</h3>
	
	<table class="table border mx-auto my-5">
		<tr>
			<td class="wp-15 text-right pe-7 bg">강의상태</td>
			<td class="ps-5">
				<select class="selectField" name="stateCode" id="stateCode" onchange="selectStateChange()">
					<option value="">::상태코드::</option>
					<c:if test="${dto.enabled==0}">
						<option value="0">잠금 해제</option>
					</c:if>
					<option value="2">카테고리에 맞지 않는 강의</option>
					<option value="3">불건전 강의 등록</option>
					<option value="4">부적절한 표현이 포함됨</option>
					<option value="5">타인을 비방하는 표현이 포함됨</option>
					<option value="6">기타 약관 위반</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="text-right pe-7 bg">메모</td>
			<td class="ps-5">
				<input type="text" name="memo" id="memo" class="boxTF" style="width: 90%;">
			</td>
		</tr>
	</table>
	
	<input type="hidden" name="num" value="${dto.num}">
	<input type="hidden" name="userId" value="${dto.userId}">
	<input type="hidden" name="registerId" value="${sessionScope.member.userId}">
	<input type="hidden" name="enabled" value="${dto.enabled}"> 
</form>

<div id="CourseStateDetail" style="display: none;">
	<table class="table border mx-auto my-10">
		<tr class="bg text-center">
			<td>내용</td>
			<td width="130">변경아이디</td>
			<td width="200">등록일</td>
		</tr>
		
		<c:forEach var="vo" items="${listState}">
			<tr align="center">
				<td class="ps-5">${vo.memo} (${vo.stateCode})</td>
				<td>${vo.registerId}</td>
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
