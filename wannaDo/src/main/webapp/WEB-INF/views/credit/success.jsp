<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
console.log(payData.num);
console.log(payData.amount);
console.log(payData.price);
function pay() {
	var payData = JSON.parse(localStorage.getItem("payData"));
	
	var f = document.payForm;
	
	f.amount.value  = payData.amount;
	f.price.value  = payData.price;
	f.num.value  = payData.num;
	
	f.action = "${pageContext.request.contextPath}/credit/pay"
	f.submit();
}
</script>
<head>
    <title>결제 성공</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="/stylesheets/style.css" />
</head>
<body>
<section>
    <h1>결제 성공</h1>
    <h3>결제 금액: &#8361; <fmt:formatNumber value="${amount}" pattern="#,###" /></h3>
    <h3>주문번호: ${orderId}</h3>
    <p>${payData.amount}</p>
    <p>${payData.price}</p>
    <p>${payData.num}</p>
    <form name="payForm" method="post">
		<input type="hidden" name="amount"/>
		<input type="hidden" name="price"/>
		<input type="hidden" name="num"/>
		<button onclick="pay();" class="btn btn-lg btn-primary">확인</button>
    </form>
    
</section>
</body>
</html>