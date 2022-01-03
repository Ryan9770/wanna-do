<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script type="text/javascript">
$(function(){
	$(".btnBuyCourse").click(function(){
		var $i = $(this).find("i");
		var userBought = $i.hasClass("bi-bag-fill");
		var msg = userBought ? "" : "강좌를 구매하십니까 ? ";
		
		if(! confirm( msg )) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/course/insertCourseBuy";
		var num="${dto.num}";
		var query="num="+num+"&userBought="+userBought;
		
		var fn = function(data){
			var state = data.state;
			if(state==="true") {
				if( userBought ) {
					$i.removeClass("bi-bag-fill").addClass("bi-bag");
				} else {
					$i.removeClass("bi-bag").addClass("bi-bag-fill");
				}
				
				var count = data.courseBuyCount;
				$("#courseBuyCount").text(count);
			} else if(state==="bought") {
				alert("");
			} else if(state==="false") {
				alert("");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
	    	if(jqXHR.status===403) {
	    		login();
	    		return false;
	    	} else if(jqXHR.status === 402) {
	    		alert("권한이 없습니다.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
	    	}
			console.log(jqXHR.responseText);
		}
	});
}
$(function(){
	var isLogin = "${not empty sessionScope.member ? 'true':'false'}";
	if(isLogin === "true") {
		myCookie();
	}

	function myCookie() {
		var url = "${pageContext.request.contextPath}/credit/myCookie";
		$.ajax({
			type:"POST",
			url:url,
			data:null,
			async:false,
			dataType:"json",
			success:function(data) {
				var myCookie = data.myCookie;
				$("#myCookie").html(myCookie);
			}
		});
	}
});
function pay() {
	var url = "${pageContext.request.contextPath}/credit/myCookie";
	$.ajax({
		type:"POST",
		url:url,
		data:null,
		async:false,
		dataType:"json",
		success:function(data) {
			var myCookie = data.myCookie;
			var f = document.payForm;
			
			var num = f.courseNum.value;
			
			if(myCookie >= ${dto.price}) {
			f.action = "${pageContext.request.contextPath}/course/pay";
			f.submit();
			} else {
				alert("쿠키가 부족합니다.");
			}
		}
	});
	
}
</script>
<body>
	<form name="payForm" method="post">
		<div class="container px-5 py-2">
			<div class="row justify-content-center">
				<div class="col-lg-8 col-xxl-6">
					<div class="text-center my-5">
						<h1 class="fw-bolder mb-3">결제 확인</h1>
						
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">강의명 : ${dto.courseName}</p>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">필요한 쿠키 : ${dto.price}</p>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">보유 중인 쿠키 : <span id=myCookie></span></p>
						<p class="lead fw-normal text-muted mb-4" style="font-size: 16px;">상기 내용대로 결제하시겠습니까?</p>
						<button type="button" onclick="pay();" class="btn btn-lg btn-primary btnBuyCourse">결제하기</button>
						<input type="hidden" name="courseName" value="${dto.courseName}"/>
	                    <input type="hidden" name="price" value="${dto.price}"/>
	                    <input type="hidden" name="courseNum" value="${dto.num}"/>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
