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
	<div class="container px-5 py-2">
		<div class="row justify-content-center">
			<div class="col-lg-8 col-xxl-6">
				<div class="text-center my-5">
				    <h1 class="fw-bolder mb-3">결제 성공</h1>
				    <h3 class="lead fw-normal mb-4" style="font-size: 16px;">결제 금액: &#8361; <fmt:formatNumber value="${amount}" pattern="#,###" /></h3>
				    <h3 class="lead fw-normal mb-4" style="font-size: 16px;">주문번호: ${orderId}</h3>
				    <p class="lead fw-normal mb-4" style="font-size: 16px;">확인 버튼을 <b>꼭</b> 눌러 결제를 완료해주세요!</p>
				    <form name="payForm" method="post">
						<input type="hidden" name="amount"/>
						<input type="hidden" name="price"/>
						<input type="hidden" name="num"/>
						<button onclick="pay();" class="btn btn-lg btn-primary">확인</button>
				    </form>
				</div>
			</div>
		</div>
	</div>
</section>
</body>
</html>