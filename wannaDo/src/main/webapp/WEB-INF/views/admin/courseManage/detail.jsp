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
		<td class="text-right pe-7 bg">아이디</td>
		<td class="text-start">${dto.userId}</td>
		<td class="text-right pe-7 bg">이름</td>
		<td class="text-start">${dto.creatorName}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">강좌등록일</td>
		<td class="text-start">${dto.reg_date}</td>
		<td class="text-right pe-7 bg">크리에이터 전환일</td>
		<td class="text-start">${dto.creator_reg_date}</td>
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

<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i>영상 정보</h3>
<table class="table border mx-auto my-10">
	<c:forEach var="vo" items="${listChapter}" varStatus="status">
		<c:if test="${empty vo.videoLink}">
			<tr>
					<td>${vo.orderNo}.${vo.subject}</td>
			</tr>
		</c:if>
		<c:if test="${not empty vo.videoLink}">
			<tr>
				<td><iframe width="50%" height="300px;"
					src="${vo.videoLink}"
					title="YouTube video player" frameborder="0"
					allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
					allowfullscreen></iframe>
				</td>
			</tr>
		</c:if>
	</c:forEach>			
</table>

<form id="detailCourseForm" name="detailCourseForm" method="post">
<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 강좌 상태 변경</h3>
	<table class="table border mx-auto my-2">
		<tr>
			<td class="wp-15 text-right pe-7 bg align-middle">강의상태</td>
			<td class="text-start align-middle">
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
			<td class="text-right pe-7 bg align-middle">메모</td>
			<td class="text-start align-middle">
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
				<td class="text-start">${vo.memo} (${vo.stateCode})</td>
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
