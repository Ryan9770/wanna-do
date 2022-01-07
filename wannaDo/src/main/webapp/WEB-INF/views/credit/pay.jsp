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
<script src="https://js.tosspayments.com/v1"></script>
<script>
    var tossPayments = TossPayments("test_ck_JQbgMGZzorzzXdypGB7rl5E1em4d");

    	$("body").on("click", "#payment-button", function(){
    		var method = document.querySelector('input[name=method]:checked').value; // "카드" 혹은 "가상계좌"

            var paymentData = {
                amount: ${price},
                orderId: 'WannaDo'+${orderNo},
                orderName: ${amount}+'쿠키',
                customerName: '${userName}',
                successUrl: window.location.origin + "/wd/credit/success",
                failUrl: window.location.origin + "/wd/credit/fail",
            };

            if (method === '가상계좌') {
                paymentData.virtualAccountCallbackUrl = window.location.origin + '/virtual-account/callback'
            }

            tossPayments.requestPayment(method, paymentData);
    	});
    	var payData = {
    			"num" : ${orderNo},
    			"amount" : ${amount},
    			"price" : ${price},
    	};
    	localStorage.setItem("payData", JSON.stringify(payData));
</script>
<body>
	<form name="payForm" method="post">
		<div class="container px-5 py-2">
			<div class="row justify-content-center">
				<div class="col-lg-8 col-xxl-6">
					<div class="text-center my-5">
						<h1 class="fw-bolder mb-3">결제 확인</h1>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">쿠키 갯수 : ${amount}</p>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">가격 : <fmt:formatNumber value="${price}" pattern="#,###" /> 원</p>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">상기 내용대로 결제하시겠습니까?</p>
						<button type="button" id="payment-button" class="btn btn-lg btn-primary">결제하기</button>
						<p><br></p>
						<div><label><input type="radio" name="method" value="카드" checked/>신용카드</label></div>
    					<div><label><input type="radio" name="method" value="가상계좌"/>가상계좌</label></div>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;"><br><br>환불 규정</p>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">쿠키는 <em>사용하지 않은 쿠키에</em> 한하여 <b>구매 후 일주일 내로</b> 청약철회가 가능합니다.</p>
						<input type="hidden" name="amount" value="${amount}"/>
	                    <input type="hidden" name="price" value="${price}"/>
	                    <input type="hidden" name="orderNo" value="${orderNo}"/>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
