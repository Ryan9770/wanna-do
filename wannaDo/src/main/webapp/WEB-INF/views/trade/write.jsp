<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function sendOk() {
    var f = document.boardForm;

    var str = f.subject.value;
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

    str = f.content.value;
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }
    
    var mode = "${mode}";
    if( (mode === "write") && (!f.selectFile.value) ) {
        alert("이미지 파일을 추가 하세요. ");
        f.selectFile.focus();
        return;
	}  
	
    f.action = "${pageContext.request.contextPath}/trade/${mode}";
    f.submit();
}

<c:if test="${mode=='update'}">
function deleteFile(num) {
	if( ! confirm("파일을 삭제하시겠습니까 ?") ) {
		return;
	}
	var url = "${pageContext.request.contextPath}/trade/deleteFile?num=" + num + "&page=${page}";
	location.href = url;
}
</c:if>

$(function() {
	var img = "${dto.originalFilename}";
	if( img ) { // 수정인 경우
		img = "${pageContext.request.contextPath}/uploads/trade/" + img;
		$(".write-form .img-viewer").empty();
		$(".write-form .img-viewer").css("background-image", "url("+img+")");
	}
	
	$(".write-form .img-viewer").click(function(){
		$("form[name=photoForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=photoForm] input[name=selectFile]").change(function(){
		var file=this.files[0];
		if(! file) {
			$(".write-form .img-viewer").empty();
			if( img ) {
				img = "${pageContext.request.contextPath}/uploads/trade/" + img;
				$(".write-form .img-viewer").css("background-image", "url("+img+")");
			} else {
				img = "${pageContext.request.contextPath}/resources/images/add_photo.png";
				$(".write-form .img-viewer").css("background-image", "url("+img+")");
			}
			return false;
		}
		
		if(! file.type.match("image.*")) {
			this.focus();
			return false;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$(".write-form .img-viewer").empty();
			$(".write-form .img-viewer").css("background-image", "url("+e.target.result+")");
		}
		reader.readAsDataURL(file);
	});
});

</script>

<div class="board">
	<div class="title">
	    <h3><span>|</span> 글 올리기 </h3>
	</div>

	<form name="boardForm" method="post" enctype="multipart/form-data">
		<div class="form-check" >
			<input class="form-check-input" type="radio" name="type" value="판매" id="flexRadioDefault1">
			  <label class="form-check-label" for="flexRadioDefault1">
			    판매
			  </label> 
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="type" value="구매" id="flexRadioDefault2" checked>
			  <label class="form-check-label" for="flexRadioDefault2">
			    구매
			  </label>
		</div>

		<table class="table table-border table-form">
				
			<tr> 
				<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td> 
					<input type="text" name="subject" maxlength="100" class="boxTF" value="${dto.subject}">
				</td>
			</tr>
			<tr> 
				<td>내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top"> 
					<textarea name="content" class="boxTA">${dto.content}</textarea>
				</td>
			</tr>
			<tr>
				<td class="table-light col-sm-2" scope="row">이미지</td>
				<td>
					<input type="file" name="selectFile" accept="image/*" class="form-control">
				</td>
			</tr>
	
			<tr> 
				<td>가 격</td>
				<td> 
					<input type="text" name="price" maxlength="70" class="boxTF" value="${dto.price}">
				</td>
			</tr>
		</table>
			
		<table class="table">
			<tr> 
				<td align="center">
					<button type="button" class="btn" onclick="sendOk();">${mode=="update"?"수정완료":"등록완료"}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/trade/list';">${mode=="update"?"수정취소":"등록취소"}</button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="num" value="${dto.num}">
						<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
						<input type="hidden" name="page" value="${page}">
					</c:if>
				</td>
			</tr>
		</table>

	</form>
	
</div>
