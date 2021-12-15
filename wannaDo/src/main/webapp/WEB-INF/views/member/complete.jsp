<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<div class="container px-5 py-5">
	<div class="row justify-content-center">	

        <div class="row justify-content-md-center">
            <div class="col-md-8">
                <div class="border bg-light mt-5 p-4 mb-5">
                       <h4 class="text-center fw-bold mt-3">${title}</h4>
                       <hr class="mt-4">
                       
	                <div class="d-grid p-4">
						<p class="text-center">${message}</p>
	                </div>
                       
                       <div class="d-grid mb-4">
                           <button type="button" class="btn btn-lg btn-danger" onclick="location.href='${pageContext.request.contextPath}/';">메인화면 <i class="bi bi-check2"></i> </button>
                       </div>
                </div>

            </div>
        </div>
	        
	</div>
</div>