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
									<textarea rows="10" class="form-control no-resize" id="qa_content" name="qa_content" value="<c:out value="${user.qa_content}"/>"></textarea>
									<span><em>500</em> / 500</span>  
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
	var idObj = $('#qa_content');
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
	
	 $("textarea").keydown(function(){
		 
		    var numChar = $(this).val().length;
		    var maxNum = 500;
		    var charRemain = maxNum - numChar;
		    
		    $("span > em").text(charRemain);
		    
		    if(charRemain < 0){
		      $("span > em").addClass("warning");
		      $("#submitBtn").prop("disabled", true);
		    } else {
		      $("#submitBtn").prop("disabled", false);
		    }
	 });
});

</script>
<%@ include file="/WEB-INF/views/include/footer_admin.jsp"%>