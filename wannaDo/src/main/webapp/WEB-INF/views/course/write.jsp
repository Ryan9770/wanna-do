<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.body-container {
	max-width: 800px;
}

.ck.ck-editor {
	max-width: 97%;
}

.ck-editor__editable {
	min-height: 250px;
}

.ck-content .image>figcaption {
	min-height: 25px;
}

.table-category input, .table-category select {
	border: none;
}
.table-category input:disabled, .table-category select:disabled {
	background: #f8f9fa; text-align: center;
}

.table-category th, .table-category td {
	border: 1px solid #eee;
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boot-board.css"
	type="text/css">

<style type="text/css">
.write-form .img-viewer {
	cursor: pointer;
	border: 1px solid #ccc;
	width: 45px;
	height: 45px;
	border-radius: 45px;
	background-image:
		url("${pageContext.request.contextPath}/resources/images/add_photo.png");
	position: relative;
	z-index: 9999;
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/ckeditor.js"></script>
<script type="text/javascript">
function sendOk() {
	var f = document.courseForm;
	var str;

	if(! f.courseName.value.trim()) {
		alert("강좌 제목을 입력하세요. ");
		f.courseName.focus();
		return;
	}
	
	if(! f.courseLevel.value) {
		alert("난이도를 선택하세요. ");
		f.courseLevel.focus();
		return;
	}

	if(! f.categoryNum.value) {
		alert("과목을 선택하세요. ");
		f.categoryNum.focus();
		return;
	}
	
	if(! f.tag.value) {
		alert("태그를 입력하세요. ");
		f.tag.focus();
		return;
	}
	
	if(! f.recommended.value) {
		alert("추천 대상을 입력하세요. ");
		f.recommended.focus();
		return;
	}
        
	if(! f.price.value) {
		alert("가격을 입력하세요. ");
		f.price.focus();
		return;
	}
	


	// 값 가져오기
	// window.editor.getData();
	// 값 셋팅
	    // window.editor.setData('<p>example</p>');
	
	str = window.editor.getData().trim();
    if(! str) {
        alert("내용을 입력하세요. ");
        window.editor.focus();
        return;
    }  
	f.content.value = str;
	
    var mode = "${mode}";
    if( (mode === "write") && (!f.selectFile.value) ) {
        alert("이미지 파일을 추가 하세요. ");
        f.selectFile.focus();
        return;
	}    

	f.action="${pageContext.request.contextPath}/course/${mode}";
	f.submit();
}


</script>

<script type="text/javascript">
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
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	// 카테고리 수정 대화상자
	$("body").on("click", ".btnCategoryDialog", function(){
		$("form[name=categoryForm]").each(function(){
			this.reset();
		});
		
		$("#myDialogModal").modal("show");
	});
	
	
	var myModalEl = document.getElementById('myDialogModal');
	
	// 모달이 show 될 때
	myModalEl.addEventListener('show.bs.modal', function (event) {
		var url="${pageContext.request.contextPath}/course/listAllCategory?tmp="+(new Date()).getTime();
		$(".category-list").load(url);
	});
	
	// 모달이 hide 될 때
	myModalEl.addEventListener('hide.bs.modal', function (event) {
		  $("form[name=courseForm] select[name=categoryNum]").find('option').remove();

		  var url="${pageContext.request.contextPath}/course/listCategory";
		  var query="mode=enabled";
			
		  var fn=function(data) {
				$.each(data.listCategory, function(index, item){
					var categoryNum = item.categoryNum;
					var category = item.category;
					var s = "<option value='"+categoryNum+"'>"+category+"</option>";
					$("form[name=courseForm] select[name=categoryNum]").append(s);
				});
				
				var mode="${mode}";
				if(mode=="update") {
					$("form[name=courseForm] select[name=categoryNum]").val("${dto.categoryNum}");
				}
		  };
		  ajaxFun(url, "get", query, "json", fn);
	});
	
});

$(function(){
	// 카테고리 등록
	$("body").on("click", ".btnCategoryAddOk", function(){	
		var $tr=$(this).closest("tr");
		var category = $tr.find("input[name=category]").val().trim();

		
		if(! category) {
			$tr.find("input[name=category]").focus();
			return false;
		}
		
		category = encodeURIComponent(category);
		var url="${pageContext.request.contextPath}/course/insertCategory";
		var query="category="+category;
		
		var fn = function(data){
			// var state=data.state;
			$("form[name=categoryForm]").each(function(){
				this.reset();
			});
			
			url = "${pageContext.request.contextPath}/course/listAllCategory?tmp="+(new Date()).getTime();
			$(".category-list").load(url); 
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});

	// 카테고리 수정
	$("body").on("click", ".btnCategoryUpdate", function(){	
		var $tr = $(this).closest("tr");
		$tr.find("input").prop("disabled", false);
		$tr.find("select").prop("disabled", false);
		
		$tr.find(".btnCategoryUpdate").hide();
		$tr.find(".btnCategoryDeleteOk").hide();

		$tr.find(".btnCategoryUpdateOk").show();
		$tr.find(".btnCategoryUpdateCancel").show();
	});

	// 카테고리 수정 완료
	$("body").on("click", ".btnCategoryUpdateOk", function(){	
		var $tr=$(this).closest("tr");
		var categoryNum = $tr.find("input[name=categoryNum]").val();
		var category = $tr.find("input[name=category]").val().trim();

		
		if(! category) {
			$tr.find("input[name=category]").focus();
			return false;
		}
		
		
		category = encodeURIComponent(category);
		var url = "${pageContext.request.contextPath}/course/updateCategory";
		var query = "categoryNum="+categoryNum+"&category="+category;
		
		var fn = function(data){
			var state = data.state;
			if(state === "false") {
				alert("카테고리 삭제가 불가능합니다.");
				return false;
			}
			
			url = "${pageContext.request.contextPath}/course/listAllCategory?tmp="+(new Date()).getTime();
			$(".category-list").load(url); 
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});

	// 카테고리 수정 취소
	$("body").on("click", ".btnCategoryUpdateCancel", function(){	
		var $tr = $(this).closest("tr");
		$tr.find("input").prop("disabled", true);
		$tr.find("select").prop("disabled", true);
		
		$tr.find(".btnCategoryUpdateOk").hide();
		$tr.find(".btnCategoryUpdateCancel").hide();

		$tr.find(".btnCategoryUpdate").show();
		$tr.find(".btnCategoryDeleteOk").show();
	});

	// 카테고리 삭제
	$("body").on("click", ".btnCategoryDeleteOk", function(){
		if(! confirm("카테고리를 삭제 하시겠습니까 ?")) {
			return false;
		}
		
		var $tr = $(this).closest("tr");
		var categoryNum = $tr.find("input[name=categoryNum]").val();
		
		var url = "${pageContext.request.contextPath}/course/deleteCategory";
		var query = "categoryNum="+categoryNum;
		
		var fn = function(data){
			url = "${pageContext.request.contextPath}/course/listAllCategory?tmp="+(new Date()).getTime();
			$(".category-list").load(url); 
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


$(function() {
	var img = "${dto.imageFile}";
	if( img ) { // 수정인 경우
		img = "${pageContext.request.contextPath}/uploads/course/" + img;
		$(".write-form .img-viewer").empty();
		$(".write-form .img-viewer").css("background-image", "url("+img+")");
	}
	
	$(".write-form .img-viewer").click(function(){
		$("form[name=courseForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=courseForm] input[name=selectFile]").change(function(){
		var file=this.files[0];
		if(! file) {
			$(".write-form .img-viewer").empty();
			if( img ) {
				img = "${pageContext.request.contextPath}/uploads/course/" + img;
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

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3>
				<i class="bi bi-book-half"></i> 강좌 등록
			</h3>
		</div>

		<div class="body-main">

			<form name="courseForm" method="post" enctype="multipart/form-data">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-sm-2" scope="row">강좌 이름</td>
						<td><input type="text" name="courseName" class="form-control"
							value="${dto.courseName}"></td>
					</tr>
					<tr>
						<td class="table-light col-sm-2" scope="row">작성자명</td>
						<td>
							<p class="form-control-plaintext">${sessionScope.member.userId}</p>
						</td>
					</tr>
					<tr>
						<td class="table-light col-sm-2" scope="row">난이도</td>
						<td>
							<div class="row">
								<div class="col-sm-4 pe-1">
									<select name="courseLevel" class="form-select">
										<option value="">:: 난이도 선택 ::</option>
										<option value="초급" ${dto.courseLevel=="초급"?"selected='selected'":""}>초급</option>
										<option value="중급" ${dto.courseLevel=="중급"?"selected='selected'":""}>중급</option>
										<option value="고급" ${dto.courseLevel=="고급"?"selected='selected'":""}>고급</option>

									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="table-light col-sm-2" scope="row">과목</td>
						<td>
							<div class="row">
								<div class="col-sm-4 pe-1">
									<select name="categoryNum" class="form-select">
											<option value="">:: 난이도 선택 ::</option>
										<c:forEach var="vo" items="${listCategory}">
											<option value="${vo.categoryNum}"
												${dto.categoryNum==vo.categoryNum?"selected='selected'":""}>${vo.category}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col ps-1">
									<button class="btn btn-light btnCategoryDialog" type="button">과목추가</button>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="table-light col-sm-2" scope="row">태 그</td>
						<td><textarea name="tag" id="tag" class="form-control"
								style="height: 100px;">${dto.tag}</textarea></td>
					</tr>
					<tr>
						<td class="table-light col-sm-2" scope="row">추천 대상</td>
						<td><textarea name="recommended" id="recommended"
								class="form-control" style="height: 100px;">${dto.recommended}</textarea>
					</tr>

					<tr>
						<td class="table-light col-sm-2" scope="row">강좌 가격</td>
						<td><input type="text" name="price" class="form-control" style="width: 20%"
							value="${dto.price}"></td>
		
					</tr>


					<tr>
						<td class="table-light col-sm-2" scope="row">강의 소개</td>
						<td>
							<div class="editor">${dto.content}</div> <input type="hidden"
							name="content">
						</td>
					</tr>

					<tr>
						<td class="table-light col-sm-2" scope="row">썸네일</td>
						<td>
							<div class="img-viewer"></div> <input type="file"
							name="selectFile" accept="image/*" class="form-control"
							style="display: none;">
						</td>
					</tr>
				</table>



				<table class="table table-borderless">
					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i
									class="bi bi-check2"></i>
							</button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light"
								onclick="location.href='${pageContext.request.contextPath}/course/main';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i
									class="bi bi-x"></i>
							</button> <c:if test="${mode=='update'}">
								<input type="hidden" name="num" value="${dto.num}">
								<input type="hidden" name="imageFile"
									value="${dto.imageFile}">
								<input type="hidden" name="page" value="${page}">
								<input type="hidden" name="group" value="${group}">
							</c:if>
						</td>
					</tr>
				</table>


			</form>

		</div>
	</div>
</div>
<div class="modal fade" id="myDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">카테고리 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
        		
				<form name="categoryForm" method="post">
					<table class="table table-borderless table-category">
						<thead class="table-light">
							<tr class="border-top border-bottom text-center"> 
								<th width="150">카테고리</th>
								<th>변경</th>
							</tr>
						</thead>
						<tbody>
							<tr align="center">
								<td class="p-0"> <input type="text" name="category" class="form-control"> </td>
	
								<td class="p-0"> <button type="button" class="btn btnCategoryAddOk">등록하기</button> </td>
							</tr>
						</tbody>
						<tfoot class="category-list"></tfoot>
					</table>
				</form>
        		
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
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