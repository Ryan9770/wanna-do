<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.body-container {
	max-width: 800px;
}
.board {
	margin: 50px;
	width: 60%;
	vertical-align: center; 
	text-align: center; 
	padding-top: 60px; 
	margin: auto;
}
.trade-form {
	margin: auto;
	width: 60%;	
	border: 1px solid #BDBDBD;
	padding: 50px;
	border-radius: 5px;
	border-spacing: 10px;
	vertical-align: center; 
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

img {
  width: 450px;
  height: auto;
  object-fit: cover;
}

.cent-align {
  position: absolute;
  left: 60%;
  transform: translateX(-60%);
}

</style>


<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/ckeditor.js"></script>
<script type="text/javascript">

function sendOk() {
    var f = document.boardForm; 
    var str = f.subject.value;

	if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

    var str = f.price.value;
    if(!str) {
        alert("가격을 숫자로 입력하세요. ");
        f.price.focus();
        return;
    }
    
   	str = window.editor.getData().trim();
   	if(!str) {
   		alert("내용을 입력하세요.");
   		window.editor.focus();
   		return;
   	}
   	f.content.value = str;
   	
   	var mode = "${mode}";
   	if( (mode === "write") && (!f.selectFile.value) ) {
   		alert("이미지 파일을 추가 하세요.");
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

function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}
  
  
  
</script>



            
<div class="board">
	<div class="title">
	    <h3> 중고거래 글 작성 </h3>
	    <p style="color: grey;"> 중고 물품을 거래할 수 있습니다.  </p>
	</div>
</div>	

<div>
	<form class="trade-form" name="boardForm" method="post" enctype="multipart/form-data"> 
		 	<div class="pt-1" style="width:60%;"></div>
			<div class="btn-group btn-group-sm" role="group" aria-label="Basic radio toggle button group">
			
			<input type="radio" class="btn-check" name="type" id="btnradio1" autocomplete="off" value="판매" checked>
			<label class="btn btn-outline-danger" for="btnradio1"> 구매 </label>
			
			<input type="radio" class="btn-check" name="type" id="btnradio2" autocomplete="off" value="구매">
			<label class="btn btn-outline-danger" for="btnradio2"> 판매 </label>
		
		</div>
		<br>
		<br>
		<div style="width: 30%;">
		<div class="input-group mb-3">
			<span class="input-group-text">₩</span>
				<input type="text" class="form-control" placeholder="가격을 숫자로 입력하세요." oninput="this.value = this.value.replaceAll(/\D/g, '')" name="price" maxlength="8" onkeyup="inputNumberFormat(this)" value="${dto.price}">
			<span class="input-group-text">원</span>
		</div>
		</div>
		<div class="mb-3">
			  <label for="exampleFormControlInput1" class="form-label" style="font-weight: bold; align: left">제목</label>
			  <input type="text" value="${dto.subject}" name="subject" class="form-control" id="exampleFormControlInput1" placeholder="제목을 입력하세요.">
		</div>
		
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label" style="font-weight: bold;">내용</label>	
			<div class="editor">${dto.content}</div> <input type="hidden" name="content">
		</div>
		
		<div>
			<label for="exampleFormControlInput1" class="form-label" style="font-weight: bold; align: left">썸네일</label>
			<input type="file" name="selectFile" accept="image/*" class="form-control">
			<p style="color: grey;"> ※ 썸네일 등록은 필수입니다. </p>
		</div>

		<table class="table">
			<tr> 
				<td align="center">
					<div>
						<label style="color: grey; font-size: 14px;"> (주)Wanna Do는 통신판매의 당사자가 아니며 상품 거래에 대한 책임은 판매자 및 구매자에게 있습니다. 
						</label>
						
					</div>
						<button class="btn btn-danger" type="button" name="checkButton" onclick="sendOk();"> ${mode=="update"?"수정완료":"등록완료"} </button>
						<button class="btn btn-outline-secondary" type="reset" class="btn">다시입력</button>
						<button class="btn btn-outline-secondary" type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/trade/list';">${mode=="update"?"수정취소":"돌아가기"}</button>
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
<div style="padding-bottom: 60px;"></div>

<script type="text/javascript">
    // 3. CKEditor5를 생성할 textarea 지정
	ClassicEditor
		.create( document.querySelector( '.editor' ), {
			fontFamily: {
	            options: [
	                'default',
	                '맑은 고딕, Malgun Gothic, 돋움, sans-serif',
	                '나눔고딕, NanumGothic, Arial'
	            ]
	        },
	        fontSize: {
	            options: [
	                9, 11, 13, 'default', 17, 19, 21
	            ]
	        },
			toolbar: {
				items: [
					'heading','|',
					'fontFamily','fontSize','bold','italic','fontColor','|',
					'alignment','bulletedList','numberedList','|',
					'imageUpload','insertTable','sourceEditing','blockQuote','mediaEmbed','|',
					'undo','redo','|',
					'link','outdent','indent','|',
				]
			},
			image: {
	            toolbar: [
	                'imageStyle:full',
	                'imageStyle:side',
	                '|',
	                'imageTextAlternative'
	            ],
	
	            // The default value.
	            styles: [
	                'full',
	                'side'
	            ]
	        },
			language: 'ko',
			ckfinder: {
		        uploadUrl: '${pageContext.request.contextPath}/image/upload' // 업로드 url (post로 요청 감)
		    }
		})
		.then( editor => {
			window.editor = editor;
		})
		.catch( err => {
			console.error( err.stack );
		});
</script>


