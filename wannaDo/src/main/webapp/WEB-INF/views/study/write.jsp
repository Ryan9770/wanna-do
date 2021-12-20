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
	
    f.action = "${pageContext.request.contextPath}/study/${mode}";
    f.submit();
}
</script>


<div class="board">
	<div class="title">
	    <h3><span>|</span> 게시판</h3>
	</div>

	<form name="boardForm" method="post">
		<div class="form-check" >
			<input class="form-check-input" type="radio" name="state" value="모집 중" id="flexRadioDefault1">
			  <label class="form-check-label" for="flexRadioDefault1">
			    모집 중
			  </label> 
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="radio" name="state" value="완료" id="flexRadioDefault2" checked>
			  <label class="form-check-label" for="flexRadioDefault2">
			    완료
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

		</table>
			
		<table class="table">
			<tr> 
				<td align="center">
					<button type="button" class="btn" onclick="sendOk();">${mode=="update"?"수정완료":"등록완료"}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/study/list';">${mode=="update"?"수정취소":"등록취소"}</button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="num" value="${dto.num}">
						<input type="hidden" name="page" value="${page}">
					</c:if>
				</td>
			</tr>
		</table>

	</form>
	
</div>
