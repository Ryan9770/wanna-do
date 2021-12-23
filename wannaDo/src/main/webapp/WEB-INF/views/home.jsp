<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<header class="bg-dark py-5">
	    <div class="container px-5">
	        <div class="row gx-5 align-items-center justify-content-center">
	            <div class="col-lg-8 col-xl-7 col-xxl-6">
	                <div class="my-5 text-center text-xl-start">
	                    <h1 class="display-5 fw-bolder text-white mb-2">Wanna-do와 함께하는 <br>영어 클래스</h1>
	                    <p class="lead fw-normal text-white-50 mb-4">도전에 특별함을 잇다!<br></p>
	                    <div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
	                        <a class="btn btn-danger btn-lg px-4 me-sm-3" href="${pageContext.request.contextPath}/member/member">Get Started</a>
	                        <a class="btn btn-outline-light btn-lg px-4" href="${pageContext.request.contextPath}/about">More Detail</a>
	                    </div>
	                </div>
	            </div>
	            <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center"><img class="img-fluid rounded-3 my-5" src="${pageContext.request.contextPath}/resources/images/about1.png" /></div>
	        </div>
	    </div>
	</header>
            
    <section class="py-5" id="features">
       <div class="container px-5 my-5">
           <div class="row gx-5">
               <div class="col-lg-4 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0">A better way to start teaching.</h2></div>
               <div class="col-lg-8">
                   <div class="row gx-5 row-cols-1 row-cols-md-2">
                       <div class="col mb-5 h-100">
                           <div class="feature bg-danger bg-gradient text-white rounded-3 mb-3"><i class="bi bi-collection"></i></div>
                           <h2 class="h5">간단한 가입</h2>
                           <p class="mb-0">필수 정보만 입력하면 가입 완료 ! <br>자유로운 크리에이터 전환도 가능 😎</div>
                       <div class="col mb-5 h-100">
                           <div class="feature bg-danger bg-gradient text-white rounded-3 mb-3"><i class="bi bi-building"></i></div>
                           <h2 class="h5">꼼꼼한 영상 품질 관리</h2>
                           <p class="mb-0">간단한 절차 속에 꼼꼼한 검수를 통해 <br>보장된 퀄리티의 강의 영상을 제공합니다👋</p>
                       </div>
                       <div class="col mb-5 mb-md-0 h-100">
                           <div class="feature bg-danger bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                           <h2 class="h5">쿠키 결제</h2>
                           <p class="mb-0">결제한 쿠키는 강의 구매 뿐 아니라 <br>추후 굿즈 구매에도 사용할 수 있습니다.🍪</p>
                       </div>
                       <div class="col h-100">
                           <div class="feature bg-danger bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                           <h2 class="h5">와나두 챌린지</h2>
                           <p class="mb-0">와나두는 회원들의 실제 실력 향상을 바랍니다.<br>함께, 하지만 스스로 공부할 수 있는 다양한 방법을 제시할 것 입니다.👨‍🏫</p>
	                  </div>
                   </div>
               </div>
           </div>
       </div>
   	</section>
   	
    <!-- Testimonial section-->
    <div class="py-5 bg-light">
        <div class="container px-5 my-5">
            <div class="row gx-5 justify-content-center">
                <div class="col-lg-10 col-xl-7">
                    <div class="text-center">
                        <div class="fs-4 mb-4 fst-italic">"영어가 기본이 된 사회이지만,<br>그래서 더 어려운 것이 영어 공부입니다.<br>본인만의 노하우가 담긴 공부법을 체계적으로 공유하고,<br>수강생은 나의 스타일에 맞는 강의를 마음 껏 고르는 것.<br>흥미롭지 않나요?"</div>
                        <div class="d-flex align-items-center justify-content-center">
                            <img class="rounded-circle me-3" style="width:45px; heigth:45px" src="${pageContext.request.contextPath}/resources/images/jun.png"/>
                            <div class="fw-bold">
                                Han Saem
                                <span class="fw-bold text-danger mx-1">/</span>
                                CEO, Wanna-do.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Blog preview section-->
    <section class="py-5">
        <div class="container px-5 my-5">
            <div class="row gx-5 justify-content-center">
                <div class="col-lg-8 col-xl-6">
                    <div class="text-center">
                        <h2 class="fw-bolder">인기 강의</h2>
                        <p class="lead fw-normal text-muted mb-5">수강생들의 가장 많은 픽을 받은,<br>이번 달 Wanna-Do의 추천강의</p>
                    </div>
                </div>
            </div>
            <div class="row gx-5">
                <div class="col-lg-4 mb-5">
                    <div class="card h-100 shadow border-0">
                        <img class="card-img-top" src="https://dummyimage.com/600x350/ced4da/6c757d" alt="..." />
                        <div class="card-body p-4">
                            <div class="badge bg-danger bg-gradient rounded-pill mb-2">News</div>
                            <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">Blog post title</h5></a>
                            <p class="card-text mb-0">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                        </div>
                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                            <div class="d-flex align-items-end justify-content-between">
                                <div class="d-flex align-items-center">
                                    <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                    <div class="small">
                                        <div class="fw-bold">Kelly Rowan</div>
                                        <div class="text-muted">March 12, 2021 &middot; 6 min read</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-5">
                    <div class="card h-100 shadow border-0">
                        <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." />
                        <div class="card-body p-4">
                            <div class="badge bg-danger bg-gradient rounded-pill mb-2">Media</div>
                            <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">Another blog post title</h5></a>
                            <p class="card-text mb-0">This text is a bit longer to illustrate the adaptive height of each card. Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                        </div>
                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                            <div class="d-flex align-items-end justify-content-between">
                                <div class="d-flex align-items-center">
                                    <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                    <div class="small">
                                        <div class="fw-bold">Josiah Barclay</div>
                                        <div class="text-muted">March 23, 2021 &middot; 4 min read</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-5">
                    <div class="card h-100 shadow border-0">
                        <img class="card-img-top" src="https://dummyimage.com/600x350/6c757d/343a40" alt="..." />
                        <div class="card-body p-4">
                            <div class="badge bg-danger bg-gradient rounded-pill mb-2">News</div>
                            <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">The last blog post title is a little bit longer than the others</h5></a>
                            <p class="card-text mb-0">Some more quick example text to build on the card title and make up the bulk of the card's content.</p>
                        </div>
                        <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                            <div class="d-flex align-items-end justify-content-between">
                                <div class="d-flex align-items-center">
                                    <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                    <div class="small">
                                        <div class="fw-bold">Evelyn Martinez</div>
                                        <div class="text-muted">April 2, 2021 &middot; 10 min read</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Call to action-->
            <aside class="bg-danger bg-gradient rounded-3 p-4 p-sm-5 mt-5">
                <div class="d-flex align-items-center justify-content-between flex-column flex-xl-row text-center text-xl-start">
                    <div class="mb-4 mb-xl-0">
                        <div class="fs-3 fw-bold text-white">New products, delivered to you.</div>
                        <div class="text-white-50">Sign up for our newsletter for the latest updates.</div>
                    </div>
                    <div class="ms-xl-4">
                        <div class="input-group mb-2">
                            <input class="form-control" type="text" placeholder="Email address..." aria-label="Email address..." aria-describedby="button-newsletter" />
                            <button class="btn btn-outline-light" id="button-newsletter" type="button">Sign up</button>
                        </div>
                        <div class="small text-white-50">We care about privacy, and will never share your data.</div>
                    </div>
                </div>
            </aside>
        </div>
    </section>
    