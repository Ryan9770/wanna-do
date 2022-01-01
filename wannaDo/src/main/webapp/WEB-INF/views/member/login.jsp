<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<script type="text/javascript">
function sendLogin() {
    var f = document.loginForm;
	var str;
	
	str = f.userId.value;
    if(!str) {
        f.userId.focus();
        return;
    }

    str = f.userPwd.value;
    if(!str) {
        f.userPwd.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/login";
    f.submit();
}

</script>

<div class="container px-5 py-5 ">
	<div class="row justify-content-center">	

        <div class="row justify-content-md-center mt-5 mb-5">
            <div class="col-md-6">
                <div class="border mt-3 p-4">
                    <form name="loginForm" action="" method="post" class="row g-3">
                        <h3 class="text-center"><i class="bi bi-lock"></i> 회원 로그인</h3>
                        <div class="col-12">
                            <label class="mb-1">아이디</label>
                            <input type="text" name="userId" class="form-control" placeholder="아이디">
                        </div>
                        <div class="col-12">
                            <label class="mb-1">패스워드</label>
                            <input type="password" name="userPwd" class="form-control" placeholder="패스워드">
                        </div>
                        <div class="col-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMe">
                                <label class="form-check-label" for="rememberMe"> 아이디 저장</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <button type="button" class="btn btn-danger float-end" onclick="sendLogin();">&nbsp;Login&nbsp;<i class="bi bi-check2"></i></button>
                        </div>
                    </form>
                    <hr class="mt-3">
                    <div class="col-12">
                        <p class="text-center mb-0">
                        	<a href="#" class="text-decoration-none me-2 text-danger">아이디 찾기</a>
                        	<a href="#" class="text-decoration-none me-2 text-danger">패스워드 찾기</a>
                        	<a href="${pageContext.request.contextPath}/member/member" class="text-decoration-none text-danger">회원가입</a>
                        </p>
                    </div>
                </div>

                <div class="d-grid">
						<p class="form-control-plaintext text-center">${message}</p>
                </div>
            </div>
        </div>

	</div>
</div>