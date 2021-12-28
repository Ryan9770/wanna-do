<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/jquery/css/jquery-ui.min.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/util-jquery.js"></script>

<script type="text/javascript">

function imageViewer2(src) {
	var viewer = $(".photo-layout");
	var s="<img src='"+src+"'>";
	//viewer.html(s);
	$(".dialog-photo").dialog({
		title:"이미지",
		width: 600,
		height: 530,
		modal: true
	});
}

function imageViewer(){
	$('.dialog-photo').dialog({
		  modal: true,
		  height: 500,
		  width: 500,
		  title: '크리에이터 프로필',
		  close: function(event, ui) {
			   $(this).dialog("destroy");
		  }
	  });
	
}
</script>

<style type="text/css">
  table {
    /* border: 1px solid #444444; */
    border-collapse: collapse;
    margin-top:30px;
  }
  
  td {
    border: 1px solid gainsboro;
	height:50px;
	text-align: center;
	font-size:18px;
  }
  
 .img-viewer {
	cursor: pointer;
	border: 1px solid #ccc;
	width: 45px;
	height: 45px;
	border-radius: 45px;
	background-image: url("${pageContext.request.contextPath}/uploads/creatorInfo/${dto.imageFilename}");
	position: relative;
	z-index: 9999;
	background-repeat : no-repeat;
	background-size : cover;
	display: inline-block;
	}

	.photo-layout img {
		width: 570px; height: 450px;
	}
	
	.title{
		background-color: whitesmoke;
		color:#3c434a;
		font-size:18px;
	}
	
	.buttonTd td p{
		padding:0;
		margin: 0
	}
	
	.buttonTd td:hover{
		cursor: pointer;
	}	
	
	.buttonTd td p:hover{
		font-size: 17px
	}		

</style>

<div class="container px-5 mt-5" style="min-height: 533px">
	<c:if test="${sessionScope.member.membership<22 }">
		<div class="body-container py-3">	
			<div class="body-title mb-3">
				<h3>기본 정보</h3>
				<table style="width:100%">
					<tr>
						<td class="title">아이디</td>
						<td>${dto.userId}</td>
						<td class="title">닉네임</td>
						<td>${dto.userName}</td>
					</tr>
					<tr>
						<td class="title">생년월일</td>
						<td colspan="3">${dto.birth}</td>
					</tr>
					<tr>
						<td class="title">전화</td>
						<td colspan="3">${dto.tel}
					</tr>				
					<tr>
						<td class="title">이메일</td>
						<td colspan="3">${dto.email}</td>
					</tr>	
					<tr>
						<td class="title">가입일</td>
						<td colspan="3">${dto.register_date}</td>
					</tr>	
				</table>
				<table class="table">
					<tr class="buttonTd">
						<td colspan="2" style="border:none; cursor: default;"></td>
						<td align="right" width="155" onclick="javascript:location.href='${pageContext.request.contextPath}/member/pwd';">
							<button type="button" class="btn" ><p>내 정보 수정</p></button>
						</td>
						<td align="right" width="155" onclick="javascript:location.href='${pageContext.request.contextPath}/credit/main';">
							<button type="button" class="btn" ><p>쿠키 결제 내역</p></button>
						</td>
						<td align="right" width="155"  onclick="javascript:location.href='${pageContext.request.contextPath}/member/change';">
							<button type="button" class="btn"><p>크리에이터 전환</p></button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</c:if>
	
	<c:if test="${sessionScope.member.membership>21 && sessionScope.member.membership<51 }">
		<div class="body-container">	
			<div class="body-title mb-5">
				<h3>기본 정보</h3>
				<table style="width:100%">
					<tr>
						<td width="120" class="title">아이디</td>
						<td width="30%">${dto.userId}</td>
						<td width="120" class="title">닉네임</td>
						<td>${dto.userName}</td>
					</tr>
					<tr>
						<td class="title">크리에이터 명</td>
						<td colspan="3">${dto.creatorName}<div class="img-viewer" onclick="imageViewer('${pageContext.request.contextPath}/uploads/creatorInfo/${dto.imageFilename}');"></div></td>
					</tr>
					<tr>
						<td class="title">생년월일</td>
						<td colspan="3">${dto.birth}</td>
					</tr>
					<tr>
						<td rowspan="2" class="title">전화번호</td>
						<td align="center" style="color:#3c434a;">기본</td>
						<td colspan="2">${dto.tel}</td>
					</tr>
					<tr>
						<td align="center" style="color:#3c434a;">크리에이터</td>
						<td colspan="2">${dto.creatorTel}</td>
					</tr>
					<tr>
						<td rowspan="2" class="title">이메일</td>
						<td align="center" style="color:#3c434a;">기본</td>
						<td colspan="2">${dto.email}</td>
					</tr>				
					<tr>
						<td align="center" style="color:#3c434a;">크리에이터</td>
						<td colspan="2">${dto.creatorEmail}</td>
					</tr>		
					<tr>
						<td class="title">한 줄 소개</td>
						<td colspan="3">${dto.intro}</td>
					</tr>
					<tr>
						<td class="title">전환일</td>
						<td colspan="3">${dto.creator_reg_date}</td>
					</tr>
				</table>	
			</div>			
		</div>
		<div class="dialog-photo" style="display: none;"></div>
	</c:if>
</div>