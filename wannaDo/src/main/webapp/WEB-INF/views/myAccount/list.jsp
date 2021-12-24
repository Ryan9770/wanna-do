<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

function imageViewer(src) {
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
</script>

<style type="text/css">
  table {
    /* border: 1px solid #444444; */
    border-collapse: collapse;
    margin-top:30px;
    background-color:#fcf0f1;
  }
  
  td {
    border: 3px solid white;
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
	}

	.photo-layout img {
		width: 570px; height: 450px;
	}
	
	.title{
		background-color: #ffabaf;
		color:#DC3545;
		font-size:18px;
	}
</style>

<div class="container px-5 mt-5">
	
	<c:if test="${sessionScope.member.membership<22 }">
		<div class="body-container">	
			<div class="body-title mb-3">
				<h3>기본 정보</h3>
				<table>
					<tr>
						<td class="title">아이디</td>
						<td>${dto.userId}</td>
						<td>닉네임</td>
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
				</table>
			</div>
			<hr>
			<div class="body-title mb-5">
				<h3>쿠키 사용 정보</h3>
				<table style="width:100%">
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
						<td align="center" style="color:#DC3545;">기본</td>
						<td colspan="2">${dto.tel}</td>
					</tr>
					<tr>
						<td align="center" style="color:#DC3545;">크리에이터</td>
						<td colspan="2">${dto.creatorTel}</td>
					</tr>
					<tr>
						<td rowspan="2" class="title">이메일</td>
						<td align="center" style="color:#DC3545;">기본</td>
						<td colspan="2">${dto.email}</td>
					</tr>				
					<tr>
						<td align="center" style="color:#DC3545;">크리에이터</td>
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
		<div class="dialog-photo">
	     		<div class="photo-layout" style="display:hidden"></div>
		</div>
	</c:if>
</div>