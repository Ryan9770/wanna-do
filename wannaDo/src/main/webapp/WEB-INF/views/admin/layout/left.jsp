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
<style type="text/css">


.accordion{
  width: 230px;
  background: #003366;
  border-radius: 0px;
  
}

.active, .accordion:hover{
	background: #54a4fc;
}


</style>
<nav>
	<header>
		<span></span>
		관리자
		<a href="${pageContext.request.contextPath}/"></a>
	</header>

	<ul>
		<li><span>Navigation</span></li>
		<li><a href="${pageContext.request.contextPath}/admin">Home</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/memberManage/list">일반회원관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/memberManage/clist">크리에이터관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/courseManage/list">강의관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/studyManage/list">스터디게시판관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/tradeManage/list">거래게시판관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/noticeManage/main">공지사항관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/scheduleManage/main">일정관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/creditManage/list">매출관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/contactManage/list">고객의 소리</a></li>
		<li><span>Other</span></li>
		<c:choose>
			<c:when test="${sessionScope.member.membership >= 99 }">
				<li><a href="${pageContext.request.contextPath}/admin/employeeManage/list">사원관리</a></li>
			</c:when>
			<c:otherwise>
				<li style="display: none;">사원관리</li>
			</c:otherwise>
		</c:choose>		
		<li><a href="${pageContext.request.contextPath}/member/logout">Logout</a></li>
	</ul>
</nav>
