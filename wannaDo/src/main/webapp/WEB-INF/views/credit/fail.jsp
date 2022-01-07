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
    <h1>결제 실패</h1>
    <p>${message}</p>
    <span>에러코드: ${code}</span>
    <button onclick="location.href='${pageContext.request.contextPath}/credit/main';">내쿠키로</button>
</section>
</body>
</html>