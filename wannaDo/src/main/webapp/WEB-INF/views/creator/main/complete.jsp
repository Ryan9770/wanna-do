<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.section{
		width: 600px;
		height: 450px;
		margin : 90px auto 0;
		background-color: white;
	    box-shadow: 3px 3px 5px grey;
    	border-radius: 30px;
    	text-align: center;
    	padding-top: 70px;
	}
	
	.text-section{
		width : 70%;
		height:30%;
		margin : 50px auto 0;
		padding-top: 20px;
		color:white;
    	border-radius: 30px;
		background-color: #003366;
	}
	
	.msg-section{
		margin: 40px 0;
	}
	
	button {
		color:white;
    	border-radius: 30px;
    	width:90px;
		background-color: #003366;
	}
</style>

<main class=" bg-secondary bg-opacity-10" style="background-color: whitesmoke">

	<div class="body-container">
		<div class="section">
			<h4>출금신청이 완료되었습니다.</h4>
			<div class="text-section">
				<h6><b>환전 쿠키 개수</b> ${map.amountCookie}<b>개</b></h6>
				<h6><b>실 환전액</b> ${map.money}<b>원</b></h6>
				<h6><b>잔여 쿠키 개수</b> ${map.afterRemainer}<b>개</b></h6>
			</div>
			<div class="msg-section">
				<p>관리자 확인 후 입력한 계좌 <b>${map.accountBank} ${map.accountNumber}</b>로 <br>
				7일 내 입금됩니다. 문의사항은 <a href="${pageContext.request.contextPath}/contact/write">Get in touch</a>를 이용해주세요.</p>		
			</div>
			<button type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/creator'">홈으로</button>		
		</div>
	</div>
	
</main>