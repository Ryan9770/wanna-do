<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<script type="text/javascript">
function pay() {
	f.action = "${pageContext.request.contextPath}/credit/refundCourse"
	f.submit();
}
</script>
<body>
	<form name="refundForm" method="post">
		<div class="container px-5 py-2">
			<div class="row justify-content-center">
				<div class="col-lg-8 col-xxl-6">
					<div class="text-center my-5">
						<h1 class="fw-bolder mb-3">환불 확인</h1>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">강의명 : ${courseName}</p>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">가격 : ${amount} 쿠키</p>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">상기 내용대로 환불하시겠습니까?</p>
						<button onclick="pay();"class="btn btn-lg btn-primary">환불하기</button>
						<input type="hidden" name="amount" value="${amount}"/>
	                    <input type="hidden" name="courseName" value="${courseName}"/>
	                    <input type="hidden" name="courseNum" value="${courseNum}"/>
	                    <input type="hidden" name="num" value="${num}"/>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
