<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.chart-container{
	background-color : #fff;
	display : inline-block;
	border : 1px solid #333;
	min-width: 500px;
	height: 500px;
}

.myCourseLi{
	border: 1px solid black;
	margin:0;
}

.myCourseUl{
	border: 2px solid black;
}

.myCourseUl li{
	height: 60px;
	text-align:center;
	line-height: 60px;
}

</style>

<main class=" bg-secondary bg-opacity-10">
	<h1>Dashboard</h1>
	
	<div class="body-container">
		<div class="chart-box row justify-content-center">	
			<h2>내 정보</h2>
			<div class="chart-container m-3 col-6 shadow d-flex" id="">
			
			</div>
			
			
			<h2>나의 강좌</h2>
			<div class="chart-container shadow m-3 col-6 d-flex" id="" style="border:none">
				<ul class="myCourseUl">
					<c:forEach var="dto" items="${list}">
						<li class="myCourseLi"><a href="${pageContext.request.contextPath}/course/article?pageNo=1&num=${dto.num}">${dto.courseName}</a></li>	
					</c:forEach>
					<c:if test="${list.size()==0}">
						<li>개설한 강좌가 없습니다.</li>
					</c:if>
				 </ul>
				 <ul style="margin-top:10px; float:right;">
				 	<li><button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/creator/courseManage/write';">강좌등록</button></li>
				 </ul>
			</div>
		</div>
	</div>
</main>
