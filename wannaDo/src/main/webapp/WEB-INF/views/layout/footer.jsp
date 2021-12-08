<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

   <footer class="bg-dark py-4 mt-auto">
       <div class="container px-5">
           <div class="row align-items-center justify-content-between flex-column flex-sm-row">
               <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; Your Website 2021</div></div>
               <div class="col-auto">
                   <a class="link-light small" href="#!">Privacy</a>
                   <span class="text-white mx-1">&middot;</span>
                   <a class="link-light small" href="#!">Terms</a>
                   <span class="text-white mx-1">&middot;</span>
                   <a class="link-light small" href="${pageContext.request.contextPath}/contact/write">Contact</a>
               </div>
           </div>
       </div>
   </footer>