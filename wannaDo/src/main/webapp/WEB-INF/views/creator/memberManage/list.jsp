<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	table{
		text-align: center;
		margin-top: 0
	}
	
	textarea {
		resize: none;
		height:300px;
	}
	
	.modal-body{
		max-height:500px;
	}
	
	#receivers{
		background: transparent;
		border: none;
	}
</style>
<script type="text/javascript">
$(document).keydown(function(e) {
    if (e.keyCode == 27) { 
		$("#qnaMessageModal").modal("hide");	
    }
});

//쪽지
$(function(){
	$("body").on("click", ".btnQnaMessage", function(){
		$("form[name=qnaForm]").each(function(){
			this.reset();
		});
		$a =$(this).attr("data-receiveId");
		
		var receiver = $('#receivers');
		receiver.val($a);
		
		$("#qnaMessageModal").modal("show");

	});
});

function sendOk() {
	var f = document.qnaForm;
	var str;
	

	str = f.content.value.trim();
	if(!str) {
		alert("내용을 입력하세요.");
		f.content.focus();
		return;
	}

	f.action="${pageContext.request.contextPath}/note/write";

	f.submit();
}

</script>
<main>
	<div class="body-container">
	    <div class="body-title">
			<h2> 수강생 관리 </h2>
	    </div>
	    
	    <div class="body-main">
			<table class="table">
				<tr>
					<td align="left" width="50%">
						${dataCount}개(${page}/${total_page} 페이지)
					</td>
				</tr>
			</table>
				
			<table class="table table-border table-list">
				<thead>
					<tr> 
						<th class="col-1">번호</th>
						<th class="col-1">카테고리</th>
						<th class="col-2">아이디</th>
						<th class="col-5">강좌명</th>
						<th class="col-2">수강신청일</th>
						<th class="col-2">쪽지</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="dto" items="${list}">
					<tr> 
						<td>${dto.listNum}</td>
						<td>${dto.category}</td>
						<td>${dto.userId}</td>
						<td>${dto.courseName}</td>
						<td>${dto.buy_date}</td>
						<td>
							<button type='button'
								class='btn btn-sm btn-outline-dark btnQnaMessage'
								data-receiveId="${dto.userId}" style="cursor: pointer;">
								<i class="bi bi-envelope"></i>보내기
							</button>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
					 
			<div class="page-box">
				${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
			</div>
					
			<table class="table">
				<tr>
					<td align="left" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/creditManage/listBuy';">새로고침</button>
					</td>
					<td align="right" width="100">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
	
	
	<div class="modal fade" id="qnaMessageModal" tabindex="-1"
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="myDialogModalLabel2" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content" style="width: 550px; height: 600px">
				<div class="modal-header">
					<h5 class="modal-title" id="myDialogModalLabel2">쪽지 보내기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form name="qnaForm" method="post">
						<table class="table write-form">
							<tr>
								<td class="table-light col-sm-2" scope="row">받는 이</td>
								<td>
									<input type="text" name="receivers" id="receivers" value="" class="form-control" readonly="readonly">
								</td>							
							</tr>
	
							<tr>
								<td class="table-light col-sm-2" scope="row">제 목</td>
								<td><input type="text" name="subject" class="form-control"
									value=""></td> 
							</tr>
	
							<tr>
								<td class="table-light col-sm-2" scope="row">내 용</td>
								<td><textarea name="content" id="content"
										class="form-control"></textarea></td>
							</tr>
	
						</table>
	
						<table class="table table-borderless mb-5">
							<tr>
								<td class="text-center">
									<button type="button" class="btn btn-dark" onclick="sendOk();">
										보내기&nbsp;<i class="bi bi-check2"></i>
									</button>
									<button type="reset" class="btn btn-light">다시입력</button>
									<button type="button" class="btn btn-light"
										onclick="location.href='${pageContext.request.contextPath}/creator/memberManage/list?page=${page}';">
										취소&nbsp;<i class="bi bi-x"></i>
									</button>
									<div id="forms-receiver-list"></div>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</main>