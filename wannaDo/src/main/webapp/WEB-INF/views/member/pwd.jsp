﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

</style>

<script type="text/javascript">
function sendOk() {
	var f = document.pwdForm;

	var str = f.userPwd.value;
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.userPwd.focus();
		return;
	}

	f.action = "${pageContext.request.contextPath}/member/pwd";
	f.submit();
}
</script>

<div class="container px-5 py-5 ">
	<div class="row justify-content-center">	

        <div class="row justify-content-md-center mt-5 mb-5">
            <div class="col-md-7">
                <div class="border mt-5 p-4 mb-5">
                    <form name="pwdForm" method="post" class="row g-3">
                        <h3 class="text-center fw-bold">패스워드 재확인</h3>
                        
		                <div class="d-grid">
							<p class="form-control-plaintext text-center">정보보호를 위해 패스워드를 다시 한 번 입력해주세요.</p>
		                </div>
                        
                        <div class="d-grid">
                            <input type="text" name="userId" class="form-control form-control-lg" placeholder="아이디"
                            		value="${sessionScope.member.userId}" 
                            		readonly="readonly">
                        </div>
                        <div class="d-grid">
                            <input type="password" name="userPwd" class="form-control form-control-lg" placeholder="패스워드">
                        </div>
                        <div class="d-grid">
                            <button type="button" class="btn btn-lg btn-danger" onclick="sendOk();">확인 <i class="bi bi-check2"></i> </button>
                            <input type="hidden" name="mode" value="${mode}">
                        </div>
                    </form>
                </div>

                <div class="d-grid">
					<p class="form-control-plaintext text-center">${message}</p>
                </div>
            </div>
        </div>
	        
	</div>
</div>