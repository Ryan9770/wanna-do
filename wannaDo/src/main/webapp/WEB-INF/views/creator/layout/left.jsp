<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
// 메뉴 활성화
$(function() {
    var url = window.location.pathname;
    var urlRegExp = new RegExp(url.replace(/\/$/, '') + "$");  
    $('nav>ul>li a').each(function() {
  	  if (urlRegExp.test(this.href.replace(/\/$/, ''))) {
            $(this).addClass('active');
        }
    });
});

</script>
<nav>
	<header>
		<span></span>
		크리에이터
		<a href="${pageContext.request.contextPath}/"></a>
	</header>

	<ul>
		<li><span>Navigation</span></li>
		<li><a href="${pageContext.request.contextPath}/creator">Home</a></li>
		<li><a href="${pageContext.request.contextPath}/creator/courseManage/list">강좌관리</a></li>
		<li><a href="${pageContext.request.contextPath}/creator/memberManage/list">수강생관리</a></li>
		<li><span>Other</span></li>
		<li><a href="${pageContext.request.contextPath}/creator/withdraw/list">환전목록</a></li>
		<li><a href="${pageContext.request.contextPath}/member/logout">Logout</a></li>
	</ul>
</nav>
