<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<main>
<div class="body-container">	
	<div class="body-title">
		<h2><i class="icofont-notification"></i> 공지사항 </h2>
	</div>
	
	<div class="body-main content-frame shadow">
	</div>
</div>
</main>

<form name="searchForm" method="post">
	<input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>

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
	    	if(jqXHR.status===403) {
	    		login();
	    		return false;
	    	} else if(jqXHR.status === 402) {
	    		alert("권한이 없습니다.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
	    	} else if(jqXHR.status === 410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxFileFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		processData: false, 
		contentType: false,  
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status===403) {
				login();
				return false;
	    	} else if(jqXHR.status === 402) {
	    		alert("권한이 없습니다.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
	    	} else if(jqXHR.status === 410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	listPage(1);
});


function listPage(page) {
	var url = "${pageContext.request.contextPath}/admin/noticeManage/list";
	var query = "pageNo="+page;
	var search = $('form[name=searchForm]').serialize();
	query = query+"&"+search;
	var selector = ".content-frame";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

function reloadBoard() {
	var f = document.searchForm;
	f.condition.value = "all";
	f.keyword.value = "";
	
	listPage(1);
}

function searchList() {
	var f=document.searchForm;
	
	f.condition.value=$("#condition").val();
	f.keyword.value=$.trim($("#keyword").val());
	listPage(1);
}

function articleBoard(num, page) {
	var url = "${pageContext.request.contextPath}/admin/noticeManage/article";
	var query = "num="+num;
	var search = $('form[name=searchForm]').serialize();
	query = query+"&pageNo="+page+"&"+search;
	var selector = ".content-frame";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

function insertForm() {
	var url = "${pageContext.request.contextPath}/admin/noticeManage/write";
	var query = "tmp="+new Date().getTime();
	var selector = ".content-frame";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}


function updateForm(num, page) {
	var url = "${pageContext.request.contextPath}/admin/noticeManage/update";
	var query = "num="+num+"&pageNo="+page;

	var selector = ".content-frame";
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}


function sendOk(mode, page) {
    var f = document.noticeForm;
    var str;
    
	str = f.subject.value;
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
    
    var url ="${pageContext.request.contextPath}/admin/noticeManage/"+mode;
    var query = new FormData(f); 
    
	var fn = function(data){
		var state = data.state;
        if(state === "false") {
            alert("게시물을 추가(수정)하지 못했습니다. !!!");
            return false;
        }
        
    	if(! page) {
    		page="1";
    	}
    	
    	if(mode === "write") {
    		reloadBoard()
    	} else {
    		listPage(page);
    	}
	};
	
	ajaxFileFun(url, "post", query, "json", fn);
}


function sendCancel(page) {
	if( ! page ) {
		page = "1";
	}
	
	listPage(page);
}


function deleteOk(num, page) {
	var url = "${pageContext.request.contextPath}/admin/noticeManage/delete";
	var query = "num="+num;
	
	if(! confirm("위 게시물을 삭제 하시 겠습니까 ? ")) {
		  return;
	}
	
	var fn = function(data){
		listPage(page);
	};
	ajaxFun(url, "post", query, "json", fn);
}

function deleteFile(fileNum) {
	var url="${pageContext.request.contextPath}/admin/noticeManage/deleteFile";
	$.post(url, {fileNum:fileNum}, function(data){
		$("#f"+fileNum).remove();
	}, "json");
}	

</script>

