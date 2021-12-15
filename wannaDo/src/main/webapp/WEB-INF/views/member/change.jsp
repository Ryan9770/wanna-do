<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.img-viewer{
	cursor:pointer;
	border : 1px solid #ccc;
	width :45px;
	height: 45px;
	border-radius : 45px;
	position:relative;
	z-index : 9999;
	background-image : url("${pageContext.request.contextPath}/resources/images/add_photo.png");
	background-repeat: no-repeat;
	background-size : cover;
}
</style>

<script type="text/javascript">
function changeOk() {
	var f = document.memberForm;
	var str;

	if(f.creatorNameValid.value === "false") {
		str = "<span style='color:red; font-weight: bold;'> 크리에이터 명 중복 검사가 실행되지 않았습니다.</span>";
		$(".creatorName-box").find(".help-block").html(str);
		f.creatorName.focus();
		return;
	}

    str = f.creatorTel1.value;
    if( !str ) {
        alert("전화번호를 입력하세요. ");
        f.creatorTel1.focus();
        return;
    }

    str = f.creatorTel2.value;
    if( !/^\d{3,4}$/.test(str) ) {
        alert("숫자만 가능합니다. ");
        f.creatorTel2.focus();
        return;
    }

    str = f.creatorTel3.value;
    if( !/^\d{4}$/.test(str) ) {
    	alert("숫자만 가능합니다. ");
        f.creatorTel3.focus();
        return;
    }
    
    str = f.creatorEmail1.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.creatorEmail1.focus();
        return;
    }

    str = f.creatorEmail2.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.creatorEmail2.focus();
        return;
    }

   	f.action = "${pageContext.request.contextPath}/member/change";
    f.submit();
}

function creatorNameCheck() {
	// 크리에이터 명 중복 검사
	var creatorName=$("#creatorName").val();
	if( ! creatorName){
		alert("크리에이터 명을 입력하세요");
		document.memberForm.creatorName.focus();
		return;
	}
	var url = "${pageContext.request.contextPath}/member/creatorNameCheck";
	var query = "creatorName=" + encodeURIComponent(creatorName);
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var passed = data.passed;

			if(passed === "true") {
				var str = "크리에이터 명 <span style='color:blue; font-weight: bold;'> " + creatorName + "</span> 는 사용가능 합니다.";
				$(".creatorName-box").find(".help-block").html(str);
				$("#creatorNameValid").val("true");
			} else {
				var str = "크리에이터 명 <span style='color:red; font-weight: bold;'>" + creatorName + "</span> 는 사용할수 없습니다.";
				$(".creatorName-box").find(".help-block").html(str);
				$("#creatorName").val("");
				$("#creatorNameValid").val("false");
				$("#creatorName").focus();
			}
		}
	});
}

function changeCreatorEmail() {
    var f = document.memberForm;
	    
    var str = f.selectCreatorEmail.value;
    if(str != "direct") {
        f.creatorEmail2.value = str; 
        f.creatorEmail2.readOnly = true;
        f.creatorEmail1.focus(); 
    }
    else {
        f.creatorEmail2.value = "";
        f.creatorEmail2.readOnly = false;
        f.creatorEmail1.focus();
    }
}

function changeCancle(){
	if(! confirm("전환을 취소하시겠습니까?")){
		return;
	}
	location.href='${pageContext.request.contextPath}/';
}

$(function(){
	var img = "${dto.imageFilename}";
	if(img){ // 수정인경우
		img = "${pageContext.request.contextPath}/uploads/creatorInfo/"+img;
		$(".img-viewer").empty();
		$(".img-viewer").css("background-image","url("+img+")");
	}
	$(".img-viewer").click(function(){
		$("form[name=memberForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=memberForm] input[name=selectFile]").change(function(){
		var file = this.files[0];
		if(! file){
			$(".img-viewer").empty();
			if(img){
				img = "${pageContext.request.contextPath}/uploads/creatorInfo/" + img;
				$(".img-viewer").css("background-image","url("+img+")");
			} else{
				img = "${pageContext.request.contextPath}/resources/images/add_photo.png";
				$(".img-viewer").css("background-image", "url("+img+")");
			}
			return false;
		}
		
		if(! file.type.match("image.*")){	// 첨부 파일 형식 
			this.focus();
			return false;
		}
		
		var reader = new FileReader();
		reader.onload = function(e){
			$(".img-viewer").empty();
			$(".img-viewer").css("background-image","url("+e.target.result+")");
		}
		reader.readAsDataURL(file);
	});

	
})

</script>
<div class="container px-5 mt-5">
	<div class="body-container">	
		<div class="body-title mb-3">
			<h3>크리에이터 전환</h3>
		</div>
		
	    <div class="alert alert-info mb-3" role="alert">
	        <i class="bi bi-person-check-fill"></i> 크리에이터 회원이 되시면 온라인 클래스 오픈에 필요한 제작 지원부터 광고까지 모두 무료로 이용하실 수 있습니다.
	    </div>
		    		
		<div class="body-main">

			<form name="memberForm" method="post" enctype="multipart/form-data">
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="userId">아이디 </label>
					<div class="col-sm-10 userId-box">
						<div class="row">
							<div class="col-5 pe-1">
								<input type="text" name="userId" id="userId" class="form-control" value="${dto.userId}" 
										${mode=="change" ? "readonly='readonly' ":""}
										placeholder="아이디" style="margin-left:0">
							</div>
							<div class="col-3 ps-1"></div>
						</div>
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="creatorName">크리에이터 명</label>
					<div class="col-sm-10 creatorName-box">
						<div class="row">
							<div class="col-5 pe-1">
								<input type="text" name="creatorName" id="creatorName" class="form-control" value="${dto.creatorName}" placeholder="크리에이터 명">
							</div>
							<div class="col-3 ps-1">
								<button type="button" class="btn btn-light" onclick="creatorNameCheck();">중복검사</button>
							</div>
						</div>
						<small class="form-control-plaintext help-block">강좌 개설 시 사용할 이름을 등록해주세요. 이후 변경할 수 없습니다.</small>
					</div>
				</div>			 
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="selectFile">프로필 사진</label>
					<div class="col-sm-10">
						<div class="img-viewer"></div>
						<input type="file" name="selectFile" id="selectFile" accept="image/*" style="display:none;" class="form-control">
			            <small class="form-control-plaintext"></small>
			        </div>
			    </div>	
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="intro">한 줄 소개</label>
					<div class="col-sm-10">
			            <input type="text" name="intro" id="intro" class="form-control" value="${dto.intro}" autocomplete="off" placeholder="한 줄 소개">
			            <small class="form-control-plaintext">나를 표현할 한 줄 소개를 적어주세요.</small>
			        </div>
			    </div>			 
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="creatorTel1">전화번호</label>
			        <div class="col-sm-10 row">
						<div class="col-sm-3 pe-2">
							<input type="text" name="creatorTel1" id="creatorTel1" class="form-control" value="${dto.creatorTel1}" maxlength="3">
						</div>
						<div class="col-sm-1 px-1" style="width: 2%;">
							<p class="form-control-plaintext text-center">-</p>
						</div>
						<div class="col-sm-3 px-1">
							<input type="text" name="creatorTel2" id="creatorTel2" class="form-control" value="${dto.creatorTel2}" maxlength="4">
						</div>
						<div class="col-sm-1 px-1" style="width: 2%;">
							<p class="form-control-plaintext text-center">-</p>
						</div>
						<div class="col-sm-3 ps-1">
							<input type="text" name="creatorTel3" id="creatorTel3" class="form-control" value="${dto.creatorTel3}" maxlength="4">
						</div>
			        </div>
			    </div>
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="selectCreatorEmail">이메일</label>
			        <div class="col-sm-10 row">
						<div class="col-3 pe-0">
							<select name="selectCreatorEmail" id="selectCreatorEmail" class="form-select" onchange="changeCreatorEmail();">
								<option value="">선 택</option>
								<option value="naver.com" ${dto.creatorEmail2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
								<option value="gmail.com" ${dto.creatorEmail2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
								<option value="hanmail.net" ${dto.creatorEmail2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
								<option value="hotmail.com" ${dto.creatorEmail2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
								<option value="direct">직접입력</option>
							</select>
						</div>
						
						<div class="col input-group">
							<input type="text" name="creatorEmail1" class="form-control" maxlength="30" value="${dto.creatorEmail1}" >
						    <span class="input-group-text p-1" style="border: none; background: none;">@</span>
							<input type="text" name="creatorEmail2" class="form-control" maxlength="30" value="${dto.creatorEmail2}" readonly="readonly">
						</div>		
	
			        </div>
			    </div>			
			    
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="agree">약관 동의</label>
					<div class="col-sm-8" style="padding-top: 5px;">
						<input type="checkbox" id="agree" name="agree"
							class="form-check-input"
							checked="checked"
							style="margin-left: 0;"
							onchange="form.sendButton.disabled = !checked">
						<label class="form-check-label">
							<a href="#" class="text-decoration-none">이용약관</a>에 동의합니다.
						</label>
					</div>
			    </div>
			     
			    <div class="row mb-3">
			        <div class="text-center">
			            <button type="button" name="sendButton" class="btn btn-primary" onclick="changeOk();">전환신청<i class="bi bi-check2"></i></button>
			            <button type="button" class="btn btn-danger" onclick="changeCancle();">전환취소<i class="bi bi-x"></i></button>
						<input type="hidden" name="creatorNameValid" id="creatorNameValid" value="false">
						<input type="hidden" name="originalCreatorName" id="originalCreatorName" value="${dto.creatorName}">
						<input type="hidden" name="sessionId" id="sessionId" value="${sessionScope.member.userId}">
						<c:if test="${mode=='changeUpdate'}">
							<input type="hidden" name="imageFilename" value="${dto.imageFilename}">
						</c:if>							
			        </div>
			    </div>
			
			    <div class="row">
					<p class="form-control-plaintext text-center">${message}</p>
			    </div>
			</form>

		</div>
	</div>
</div>

