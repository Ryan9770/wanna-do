<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>결제 실패</title>
    <meta http equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="/stylesheets/style.css" />
</head>
<body>
<section>
	<div class="container px-5 py-2">
		<div class="row justify-content-center">
			<div class="col-lg-8 col-xxl-6">
				<div class="text-center my-5">
					<h1 class="fw-bolder mb-3">결제 성공</h1>
					<h3 class="lead fw-normal mb-4" style="font-size: 16px;">${message}</h3>
					<h3 class="lead fw-normal mb-4" style="font-size: 16px;">에러코드: ${code}</h3>
					<p class="lead fw-normal mb-4" style="font-size: 16px;">결제를 다시 시도해주시거나 관리자에게 문의해주세요!</p>
					<button class="btn btn-lg btn-primary" onclick="location.href='${pageContext.request.contextPath}/credit/main';">내쿠키로</button>
				</div>
			</div>
		</div>
	</div>
</section>
</body>
</html>