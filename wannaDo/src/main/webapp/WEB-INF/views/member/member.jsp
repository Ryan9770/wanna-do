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
function memberOk() {
	var f = document.memberForm;
	var str;

	str = f.userId.value;
	if( !/^[a-z][a-z0-9_]{4,9}$/i.test(str) ) { 
		alert("아이디를 다시 입력 하세요.\n아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.👻");
		f.userId.focus();
		return;
	}

	var mode = "${mode}";
	if(mode === "member" && f.userIdValid.value === "false") {
		str = "<span style='color:red; font-weight: bold;'>아이디 중복 검사가 실행되지 않았습니다.</span>";
		$(".userId-box").find(".help-block").html(str);
		f.userId.focus();
		return;
	}
	
	if(f.userNameValid.value === "false") {
		
		str = "<span style='color:red; font-weight: bold;'>닉네임 중복 검사가 실행되지 않았습니다.</span>";
		$(".userName-box").find(".help-block").html(str);
		f.userName.focus();
		return;
	}

	str = f.userPwd.value;
	if( !/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str) ) { 
		alert("패스워드를 다시 입력 하세요. \n패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.👻");
		f.userPwd.focus();
		return;
	}

	if( str != f.userPwd2.value ) {
        alert("패스워드가 일치하지 않습니다. ");
        f.userPwd.focus();
        return;
	}

    str = f.birth.value;
    if( !str ) {
        alert("생년월일를 입력하세요. ");
        f.birth.focus();
        return;
    }
    
    str = f.tel1.value;
    if( !str ) {
        alert("전화번호를 입력하세요. ");
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
    if( !/^\d{3,4}$/.test(str) ) {
        alert("숫자만 가능합니다. ");
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
    if( !/^\d{4}$/.test(str) ) {
    	alert("숫자만 가능합니다. ");
        f.tel3.focus();
        return;
    }
    
    str = f.email1.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }

    str = f.email2.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.email2.focus();
        return;
    }
    
    var membership = "${sessionScope.member.membership}";
    if(membership==22){
    	if(f.creatorNameValid.value === "false") {
    		str = "<span style='color:red; font-weight: bold;'>크리에이터 명 중복 검사가 실행되지 않았습니다.</span>";
    		$(".creatorName-box").find(".help-block").html(str);
    		f.creatorName.focus();
    		return;
    	}   	
    }

   	f.action = "${pageContext.request.contextPath}/member/${mode}";
    f.submit();
}

function changeEmail() {
    var f = document.memberForm;
	    
    var str = f.selectEmail.value;
    if(str != "direct") {
        f.email2.value = str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value = "";
        f.email2.readOnly = false;
        f.email1.focus();
    }
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

function userIdCheck() {
	// 아이디 중복 검사
	var userId=$("#userId").val();
	
	if( !/^[a-z][a-z0-9_]{4,9}$/i.test(userId) ) { 
		alert("아이디를 다시 입력 하세요.\n 아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.👻");
		f.userId.focus();
		return;
	}
	
	var url = "${pageContext.request.contextPath}/member/userIdCheck";
	var query = "userId=" + userId;
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var passed = data.passed;

			if(passed === "true") {
				var str = "<span style='color:blue; font-weight: bold;'>" + userId + "</span> 아이디는 사용가능 합니다.";
				$(".userId-box").find(".help-block").html(str);
				$("#userIdValid").val("true");
			} else {
				var str = "<span style='color:red; font-weight: bold;'>" + userId + "</span> 아이디는 사용할수 없습니다.";
				$(".userId-box").find(".help-block").html(str);
				$("#userId").val("");
				$("#userIdValid").val("false");
				$("#userId").focus();
			}
		}
	});
}


function nickNameCheck() {
	// 이름 중복 검사
	var userId=$("#userId").val();
	var sesssionId = $("#sessionId").val();
	
	if(userId===sesssionId) {
		$(".userName-box").find(".help-block").html("기존 닉네임과 동일합니다.");
		$("#userNameValid").val("true");
		return true;
	}
	
	var userName=$("#userName").val();
	
	var url = "${pageContext.request.contextPath}/member/nickNameCheck";
	var query = "userName=" + encodeURIComponent(userName);
		
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var passed = data.passed;

			if(passed === "true") {
				var str = "<span style='color:blue; font-weight: bold;'>" + userName + "</span> 은 사용가능 합니다.";
				$(".userName-box").find(".help-block").html(str);
				$("#userNameValid").val("true");
			} else {
				var str = "<span style='color:red; font-weight: bold;'>" + userName + "</span> 은 사용할 수 없습니다.";
				$(".userName-box").find(".help-block").html(str);
				$("#userName").val("");
				$("#userNameValid").val("false");
				$("#userName").focus();

			}
		}
	});
}

function creatorNameCheck() {
	// 크리에이터 명 중복 검사
	var creatorName=$("#creatorName").val();
	var originalCreatorName = "${dto.creatorName}";
	
	if( ! creatorName){
		alert("크리에이터 명을 입력하세요");
		document.memberForm.creatorName.focus();
		return;
	}
	
	if(creatorName==originalCreatorName){
		$(".creatorName-box").find(".help-block").html("기존 크리에이터 명과 동일합니다.");
		$("#creatorNameValid").val("true");
		return true;
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
				var str = "크리에이터 명 <span style='color:blue; font-weight: bold;'> " + creatorName + "</span>는 사용가능 합니다.";
				$(".creatorName-box").find(".help-block").html(str);
				$("#creatorNameValid").val("true");
			} else {
				var str = "크리에이터 명 <span style='color:red; font-weight: bold;'>" + creatorName + "</span>는 사용할 수 없습니다.";
				$(".creatorName-box").find(".help-block").html(str);
				$("#creatorName").val("");
				$("#creatorNameValid").val("false");
				$("#creatorName").focus();
			}
		}
	});
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
			<h3> ${mode=="member"?"회원가입":"내정보 수정"} </h3>
		</div>
		
	    <div class="alert alert-info" role="alert">
	        <i class="bi bi-person-check-fill"></i> WannaDo에서 당신의 성공 잠재력을 깨워줄 특별한 클래스를 만나보세요.
	    </div>
		    		
		<div class="body-main">

			<form name="memberForm" method="post" enctype="multipart/form-data">
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="userId">아이디</label>
					<div class="col-sm-10 userId-box">
						<div class="row">
							<div class="col-5 pe-1">
								<input type="text" name="userId" id="userId" class="form-control" value="${dto.userId}" 
										${mode=="update" ? "readonly='readonly' ":""}
										placeholder="아이디">
							</div>
							<div class="col-3 ps-1">
								<c:if test="${mode=='member'}">
									<button type="button" class="btn btn-light" onclick="userIdCheck();">아이디중복검사</button>
								</c:if>
							</div>
						</div>
						<c:if test="${mode=='member'}">
							<small class="form-control-plaintext help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
						</c:if>
					</div>
				</div>
 				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="userName">닉네임</label>
					<div class="col-sm-10 userName-box">
						<div class="row">
							<div class="col-5 pe-1">
								<input type="text" name="userName" id="userName" class="form-control" value="${dto.userName}" placeholder="이름">
							</div>
							<div class="col-3 ps-1">
									<button type="button" class="btn btn-light" onclick="nickNameCheck();">닉네임 중복검사</button>
							</div>
							<small class="form-control-plaintext help-block"></small>
						</div>
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="userPwd">패스워드</label>
					<div class="col-sm-10">
			            <input type="password" name="userPwd" id="userPwd" class="form-control" autocomplete="off" placeholder="패스워드">
			            <small class="form-control-plaintext">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
			        </div>
			    </div>
			    
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="userPwd2">패스워드 확인</label>
			        <div class="col-sm-10">
			            <input type="password" name="userPwd2" id="userPwd2" class="form-control" autocomplete="off" placeholder="패스워드 확인">
			            <small class="form-control-plaintext">패스워드를 한번 더 입력해주세요.</small>
			        </div>
			    </div>			 
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="birth">생년월일</label>
			        <div class="col-sm-10">
			            <input type="date" name="birth" id="birth" class="form-control" value="${dto.birth}" placeholder="생년월일">
			            <small class="form-control-plaintext">생년월일은 2000-01-01 형식으로 입력 합니다.</small>
			        </div>
			    </div>
			    
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="tel1">전화번호</label>
			        <div class="col-sm-10 row">
						<div class="col-sm-3 pe-2">
							<input type="text" name="tel1" id="tel1" class="form-control" value="${dto.tel1}" maxlength="3">
						</div>
						<div class="col-sm-1 px-1" style="width: 2%;">
							<p class="form-control-plaintext text-center">-</p>
						</div>
						<div class="col-sm-3 px-1">
							<input type="text" name="tel2" id="tel2" class="form-control" value="${dto.tel2}" maxlength="4">
						</div>
						<div class="col-sm-1 px-1" style="width: 2%;">
							<p class="form-control-plaintext text-center">-</p>
						</div>
						<div class="col-sm-3 ps-1">
							<input type="text" name="tel3" id="tel3" class="form-control" value="${dto.tel3}" maxlength="4">
						</div>
			        </div>
			    </div>
		    			
			    <div class="row mb-3">
			        <label class="col-sm-2 col-form-label" for="selectEmail">이메일</label>
			        <div class="col-sm-10 row">
						<div class="col-3 pe-0">
							<select name="selectEmail" id="selectEmail" class="form-select" onchange="changeEmail();">
								<option value="">선 택</option>
								<option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
								<option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
								<option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
								<option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
								<option value="direct">직접입력</option>
							</select>
						</div>
						
						<div class="col input-group">
							<input type="text" name="email1" class="form-control" maxlength="30" value="${dto.email1}" >
						    <span class="input-group-text p-1" style="border: none; background: none;">@</span>
							<input type="text" name="email2" class="form-control" maxlength="30" value="${dto.email2}" readonly="readonly">
						</div>		
	
			        </div>
			    </div>

			    <c:if test="${sessionScope.member.membership==22}">
				    <hr>
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
				            <c:if test="${mode=='update'}">
				            	<input type="hidden" name="imageFilename" value="${dto.imageFilename}">
				            </c:if>
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
			    </c:if>
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
			            <button type="button" name="sendButton" class="btn btn-primary" onclick="memberOk();"> ${mode=="member"?"회원가입":"정보수정"} <i class="bi bi-check2"></i></button>
			            <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/';"> ${mode=="member"?"가입취소":"수정취소"} <i class="bi bi-x"></i></button>
						<input type="hidden" name="userIdValid" id="userIdValid" value="false">
						<input type="hidden" name="userNameValid" id="userNameValid" value="false">
						<input type="hidden" name="userNameValid" id="creatorNameValid" value="false">
						<input type="hidden" name="sessionId" id="sessionId" value="${sessionScope.member.userId}">
			        </div>
			    </div>			
			    <div class="row">
					<p class="form-control-plaintext text-center">${message}</p>
			    </div>
			</form>

		</div>
	</div>
</div>

