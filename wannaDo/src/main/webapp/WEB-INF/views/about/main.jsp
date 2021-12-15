<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
.aa a{
color:#6c757d;
}
.aa a:hover{
color:#495057;
}
</style>
</head>
<body>
     <div class="container px-5 py-5">
         <div class="row justify-content-center">
             <div class="col-lg-8 col-xxl-6">
                 <div class="text-center my-5">
                     <h1 class="fw-bolder mb-3">Our mission is to make building websites for every dreamer.</h1>
                     <p class="lead fw-normal text-muted mb-4">"Where there is a will there's a way." <br>
                  	 "뜻이 있는 곳에 길이 있다." - Angela Merkel<br>
                  	 <br> Start studying English with <span class="text-danger">WANNA DO</span>.<br>
                     If not now, then when?
                     </p>
                     <a class="btn btn-danger btn-lg" href="#scroll-target">Read our story</a>
                 </div>
             </div>
         </div>
     </div>
    <!-- About section one-->
    <section class="py-5 bg-light" id="scroll-target">
        <div class="container px-5 my-5">
            <div class="row gx-5 align-items-center">
                <div class="col-lg-6"><img class="img-fluid rounded mb-5 mb-lg-0" src="${pageContext.request.contextPath}/resources/images/about1.png"/></div>
                <div class="col-lg-6">
                    <h2 class="fw-bolder">Our founding</h2>
                    <p class="lead fw-normal text-muted mb-0">영어가 필수를 넘어 기본이 된 요즘. <br>보다 쉽고 자유롭게 가르치고 배우는 환경을 꿈꿨습니다.<br>열정이 있다면 주저없이 <span class="text-danger">와나두</span>와 함께하세요.</p>
                </div>
            </div>
        </div>
    </section>
    <!-- About section two-->
    <section class="py-5">
        <div class="container px-5 my-5">
            <div class="row gx-5 align-items-center">
                <div class="col-lg-6 order-first order-lg-last"><img class="img-fluid rounded mb-5 mb-lg-0" src="${pageContext.request.contextPath}/resources/images/meet.jpg" /></div>
                <div class="col-lg-6">
                    <h2 class="fw-bolder">Growth &amp; beyond</h2>
                    <p class="lead fw-normal text-muted mb-0">간단한 절차의 가입, 하지만 체계적인 검수 과정을 통해 <br>보다 높은 품질의 강의를 공유하고자 합니다.
                    <br>또한 지속적인 사용자 관점 연구를 통해<br>더 나은 서비스를 제공할 것 입니다.</p>
                </div>
            </div>
        </div>
    </section>
    <!-- Team members section-->
    <section class="py-5 bg-light">
        <div class="container px-5 my-5">
            <div class="text-center">
                <h2 class="fw-bolder">Our team</h2>
                <p class="lead fw-normal text-muted mb-5">Dedicated to quality and your success</p>
            </div>
            <div class="row gx-5 row-cols-1 row-cols-sm-2 row-cols-xl-5 justify-content-center">
                <div class="col mb-5 mb-5 mb-xl-0">
                    <div class="text-center">
                        <img class="img-fluid rounded-circle mb-4 px-4" src="${pageContext.request.contextPath}/resources/images/ye.png"/>
                        <h5 class="fw-bolder">Kim YeLim</h5>
                        <div class="fst-italic text-muted aa"><a href="https://github.com/piatarr/" target="_blank">📌 Git</a></div>
                    </div>
                </div>
                <div class="col mb-5 mb-5 mb-xl-0">
                    <div class="text-center">
                        <img class="img-fluid rounded-circle mb-4 px-4" src="${pageContext.request.contextPath}/resources/images/jun.png"/>
                        <h5 class="fw-bolder">Park JunHo</h5>
                        <div class="fst-italic text-muted aa"><a href="https://github.com/pajh94" target="_blank">📌 Git</a></div>
                    </div>
                </div>
                <div class="col mb-5 mb-5 mb-sm-0">
                    <div class="text-center">
                        <img class="img-fluid rounded-circle mb-4 px-4" src="${pageContext.request.contextPath}/resources/images/tae.png"/>
                        <h5 class="fw-bolder">Park TaeHoon</h5>
                        <div class="fst-italic text-muted aa"><a href="https://github.com/MichelPark" target="_blank">📌 Git</a></div>
                    </div>
                </div>
                <div class="col mb-5 mb-5 mb-sm-0">
                    <div class="text-center">
                        <img class="img-fluid rounded-circle mb-4 px-4" src="${pageContext.request.contextPath}/resources/images/ho.png"/>
                        <h5 class="fw-bolder">Lee JeongHo</h5>
                        <div class="fst-italic text-muted aa"><a href="https://github.com/Ryan9770" target="_blank">📌 Git</a></div>
                    </div>
                </div>                
                <div class="col mb-5 mb-5 mb-sm-0">
                    <div class="text-center">
                        <img class="img-fluid rounded-circle mb-4 px-4" src="${pageContext.request.contextPath}/resources/images/chae.png"/>
                        <h5 class="fw-bolder">Chae JunHo</h5>
                        <div class="fst-italic text-muted aa"><a href="https://github.com/chaejunho689" target="_blank">📌 Git</a></div>
                    </div>
                </div>                
            </div>
        </div>
    </section>
</body>
</html>