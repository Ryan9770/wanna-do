<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://cdn.ckeditor.com/ckeditor5/11.0.1/classic/ckeditor.js"></script>


<style>
.board {
	margin: 50px;
	width: 90%;
}

.trade-form {
	margin: 50px;
	width: 90%;	
	border: 1px solid #BDBDBD;
	padding: 50px;
	border-radius: 5px;
	border-spacing: 10px;
	
}

.trade-table-main {
	margin: 30px;
	padding: 15px;	
}

.input-file-button{
  padding: 6px 25px;
  background-color:#FF6600;
  border-radius: 4px;
  color: white;
  cursor: pointer;
}

.ck-editor__editable {
    min-height: 400px;
}

</style>


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

<div class="board" style="vertical-align: center; text-align: center;">
	<div class="title">
	    <h3> 스터디 룸 글 작성 </h3>
	    <p style="color: grey;"> 스터디를 모집하거나 참가할 수 있습니다.  </p>
	    <hr>
	</div>
</div>	
		
	 <form class="trade-form" name="boardForm" method="post" enctype="multipart/form-data"> 
	 
 	 	<div class="pt-1" style="width:90%;"> 
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="state" value="모집" id="btnradio1" autocomplete="off" checked>
			  <label class="btn btn-outline-danger" for="btnradio1">모집</label>
			
			  <input type="radio" class="btn-check" name="state" value="참가" id="btnradio2" autocomplete="off">
			  <label class="btn btn-outline-danger" for="btnradio2">참가</label>
			
			  <input type="radio" class="btn-check" name="state" value="마감" id="btnradio3" autocomplete="off">
			  <label class="btn btn-outline-danger" for="btnradio3">마감</label>
			</div>
		</div>
		<br>
		<br>
		<div class="mb-3">
			  <label for="exampleFormControlInput1" class="form-label" style="font: bold;">제목</label>
			  <input type="text" value="${dto.subject}" name="subject" class="form-control" id="exampleFormControlInput1" placeholder="제목을 입력하세요.">
		</div>
		
		<div class="mb-3">
			  <label for="exampleFormControlTextarea1" class="form-label" style="font: bold;">내용</label>
			<!--  <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="5" placeholder="내용을 입력하세요."> ${dto.content} </textarea>    -->
			<textarea name="content" class="form-control" id="editor" rows="10" placeholder="내용을 입력하세요."> ${dto.content} </textarea>  
			
		</div>

	
	
		<table class="table">
			<tr> 
				<td align="center">
						<button class="btn btn-danger" type="button" name="checkButton" onclick="sendOk();"> ${mode=="update"?"수정완료":"등록완료"} </button>
						<button class="btn btn-outline-secondary" type="reset" class="btn">다시입력</button>
						<button class="btn btn-outline-secondary" type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/study/list';">${mode=="update"?"수정취소":"돌아가기"}</button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="num" value="${dto.num}">
						<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
						<input type="hidden" name="page" value="${page}">
					</c:if>
				</td>
			</tr>
		</table>
	</form>

<script>
    // 3. CKEditor5를 생성할 textarea 지정
    ClassicEditor
        .create( document.querySelector( '#editor' ) )
        .catch( error => {
            console.error( error );
        } );
    s
</script>