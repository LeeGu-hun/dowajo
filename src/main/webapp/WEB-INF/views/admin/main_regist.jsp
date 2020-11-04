<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_admin.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
</style>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<h2>공지등록</h2>
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">
							<form role="form" action="/admin/main_regist" method="POST">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
							<input type="hidden" name="user_no" value="${user.user_no}"> 					
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">person</i> 작성자 :  
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="qa_writer" id="qa_writer" value="<sec:authentication property='principal.user.user_id'/>" readonly>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">title</i> 제목 : 
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="qa_title" id="qa_title" value="<c:out value="${user.qa_title}"/>">
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon" > 
									<i class="material-icons">content_paste</i> 내용 : 
								</span>
								<div class="form-line">
									<textarea rows="4" class="form-control no-resize" id="qa_content" name="qa_content" value="<c:out value="${user.qa_content}"/>"></textarea>
									<span id="idcheck" style="color:red;"></span>
								</div>
							</div>
							<button id="submitBtn" class="btn bg-green waves-effect" type="submit" ">공지등록</button>
							<button id="listbtn"type="button" class="btn bg-black waves-effect waves-light">뒤로가기</button>						
					</div>
				</div>
			</div>
		</div>		
	</div>
</section>
<script>

$(document).ready(function() {
	
	var formObj = $("form");
	$('#listbtn').on("click", function(){
		history.back();
	});
	$('#submitBtn').on("click", function(e){
		e.preventDefault();
		if($('#qa_title').val()==''){
			alert("제목을 입력해주세요");$('#qa_title').focus();return false;
		}
		if($('#qa_content').val()==''){
			alert("내용을 입력해주세요");$('#qa_content').focus();return false;
		}
		formObj.submit();
	});
	function checkId(){
		$('#idcheck').html('');
		var id = $("#qa_content");
		var idReg = /^[a-z0-9_]{10,30}$/g;
  if( !idReg.test(id.val())) {
	  $('#idcheck').html('(조건이 만족되지 않습니다.)');
	  $("#qa_content").focus();
    return false;
  } else {
    return true;
  }
	}	
	
});

</script>
<%@ include file="/WEB-INF/views/include/footer_admin.jsp"%>