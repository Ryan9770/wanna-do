<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
function text(){
	var location = "${pageContext.request.contextPath}/course/article?pageNo=1&num=${dto.num}"
	var el = document.getElementById("listChater");
	
}
</script>
<style type="text/css">
	
	h4{
		margin: 40px 0;
		text-align: center;
	}
	
	table, td, th {
	  border-collapse : collapse;
	}

	th{
		border-bottom:2px solid gainsboro;
		text-align: center;
		background-color: whitesmoke;
		height:40px;
	}
	
	td{
		text-align: center;
		border-bottom:1px solid gainsboro;
		height:35px;
	}
	
	.bi{
		font-size:20px;
	}
	
	.bi:hover{
		cursor: pointer;
	}
	
</style>

<div class="container px-5 mt-5 mb-5">
	<div class="body-container py-3">	
		<div class="body-title mb-3">
			<h3>나의 학습</h3>		
		</div>
		<h4>찜한 강좌</h4>
		<table style="width:100%">
			<thead>
				<tr>
					<th class="col-1 ">번호</th>
					<th class="col-1 ">카테고리</th>
					<th class="col-4 ">강의명</th>
					<th class="col-1 ">난이도</th>
					<th class="col-2 ">가격</th>
					<th class="col-1 ">자세히</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${listLike}" varStatus="status">
					<tr> 
						<td>${status.count}</td>
						<td>${dto.category}</td>
						<td>${dto.courseName}</td>
						<td>${dto.courseLevel}</td>
						<td>쿠키 ${dto.price}개</td>
						<td><i class="bi bi-box-arrow-in-right" onclick="javascript:location.href='${pageContext.request.contextPath}/course/article?pageNo=1&num=${dto.num}'"></i></td>
					</tr>
				</c:forEach>
				<c:if test="${list.size()==0}">
					<tr>
						<td>찜한 강좌가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>			
		</table>
		<h4>수강중인 강좌</h4>
		<table style="width:100%">
			<thead>
				<tr>
					<th class="col-1 ">번호</th>
					<th class="col-1 ">카테고리</th>
					<th class="col-4 ">강의명</th>
					<th class="col-1 ">난이도</th>
					<th class="col-2 ">수료여부</th>
					<th class="col-1 ">영상보기</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${listMyCourse}" varStatus="status">
					<tr> 
						<td>${status.count}</td>
						<td>${dto.category}</td>
						<td>${dto.courseName}</td>
						<td>${dto.courseLevel}</td>
						<td>미수료</td>
						<td><i class="bi bi-play-btn" onclick="javascript:location.href='${pageContext.request.contextPath}/course/article?pageNo=1&num=${dto.num}#listVideoChapter'"></i></td>
					</tr>
				</c:forEach>
				<c:if test="${list.size()==0}">
					<tr>
						<td>찜한 강좌가 없습니다.</td>
					</tr>
				</c:if>				
			</tbody>
		</table>
	</div>
</div>