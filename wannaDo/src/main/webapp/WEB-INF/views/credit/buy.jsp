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
<body>
	<div class="container px-5 py-2">
		<div class="row justify-content-center">
			<div class="col-lg-8 col-xxl-6">
				<div class="text-center my-5">
					<h1 class="fw-bolder mb-3">Cookie Shop</h1>
					<p class="lead fw-normal text-muted mb-4">쿠키로 구매한 강좌는 기간, 횟수 제한 없이 수강할 수 있습니다.</p>
					<p class="lead fw-normal text-muted mb-4">사용하지 않은 쿠키는 구매일로부터 일주일 이내에 청약철회가 가능합니다.</p>
					<button onclick="location.href='${pageContext.request.contextPath}/credit/list';">구매 내역</button>
				</div>
			</div>
		</div>
	</div>


	<section>
		<form>
			<div class="container px-5">
				<div class="row gx-5">
	                <div class="col-lg-3 mb-3">
	                    <div class="card h-100 shadow border-0">
	                        <div class="card-body p-4" style="text-align: center;">
	                            <div class="bg-danger bg-gradient rounded-pill" style="text-align: center; color: white;"><h6>10쿠키 구매</h6></div>
	                            <p class="text-decoration-none link-dark stretched-link card-title mb-3"><h5>&#8361; 1,000</h5></p>
	                            <p class="card-text mb-0">정상가 : <del>&#8361; 1,000</del><br>&#8595;<br>할인가 : &#8361; 1,000</p>
	                        </div>
	                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
	                            <div class="d-flex align-items-end justify-content-between">
	                                <div class="d-flex align-items-center">
	                                    <img class="rounded-circle me-3" src="https://user-images.githubusercontent.com/93500782/145944393-e33135d9-16c1-495c-9d34-5f5fd1d79f32.png" width="50" height="50"/>
	                                    <div class="small">
	                                        <div class="fw-bold">10쿠키</div>
	                                        <div class="text-muted">구매하기</div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-3 mb-3">
	                    <div class="card h-100 shadow border-0">
	                        <div class="card-body p-4" style="text-align: center;">
	                            <div class="bg-danger bg-gradient rounded-pill" style="text-align: center; color: white;"><h6>50쿠키 구매</h6></div>
	                            <p class="text-decoration-none link-dark stretched-link card-title mb-3"><h5>&#8361; 4,500</h5></p>
	                            <p class="card-text mb-0">정상가 : <del>&#8361; 5,000</del><br>&#8595;<br>할인가 : &#8361; 4,500</p>
	                        </div>
	                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
	                            <div class="d-flex align-items-end justify-content-between">
	                                <div class="d-flex align-items-center">
	                                    <img class="rounded-circle me-3" src="https://user-images.githubusercontent.com/93500782/145944393-e33135d9-16c1-495c-9d34-5f5fd1d79f32.png" width="50" height="50"/>
	                                    <div class="small">
	                                        <div class="fw-bold">50쿠키</div>
	                                        <div class="text-muted">구매하기</div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-3 mb-3">
	                    <div class="card h-100 shadow border-0">
	                        <div class="card-body p-4" style="text-align: center;">
	                            <div class="bg-danger bg-gradient rounded-pill" style="text-align: center; color: white;"><h6>100쿠키 구매</h6></div>
	                            <p class="text-decoration-none link-dark stretched-link card-title mb-3"><h5>&#8361; 9,000</h5></p>
	                            <p class="card-text mb-0">정상가 : <del>&#8361; 10,000</del><br>&#8595;<br>할인가 : &#8361; 9,000</p>
	                        </div>
	                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
	                            <div class="d-flex align-items-end justify-content-between">
	                                <div class="d-flex align-items-center">
	                                    <img class="rounded-circle me-3" src="https://user-images.githubusercontent.com/93500782/145944393-e33135d9-16c1-495c-9d34-5f5fd1d79f32.png" width="50" height="50"/>
	                                    <div class="small">
	                                        <div class="fw-bold">100쿠키</div>
	                                        <div class="text-muted">구매하기</div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                 <div class="col-lg-3 mb-3">
	                    <div class="card h-100 shadow border-0">
	                        <div class="card-body p-4" style="text-align: center;">
	                            <div class="bg-danger bg-gradient rounded-pill" style="text-align: center; color: white;"><h6>500쿠키 구매</h6></div>
	                            <p class="text-decoration-none link-dark stretched-link card-title mb-3"><h5>&#8361; 45,000</h5></p>
	                            <p class="card-text mb-0">정상가 : <del>&#8361; 50,000</del><br>&#8595;<br>할인가 : &#8361; 45,000</p>
	                        </div>
	                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
	                            <div class="d-flex align-items-end justify-content-between">
	                                <div class="d-flex align-items-center">
	                                    <img class="rounded-circle me-3" src="https://user-images.githubusercontent.com/93500782/145944393-e33135d9-16c1-495c-9d34-5f5fd1d79f32.png" width="50" height="50"/>
	                                    <div class="small">
	                                        <div class="fw-bold">500쿠키</div>
	                                        <div class="text-muted">구매하기</div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
			</div>
		</form>
	</section>
</body>
</html>