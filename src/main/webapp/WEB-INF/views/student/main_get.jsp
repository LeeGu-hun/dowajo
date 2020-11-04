<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
</style>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<br>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">
							<form role="form" action="/user/main_get" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
							<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	 						<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
							<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>						
							<div class="msg">
								<b>공지사항</b>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">format_list_numbered</i> 공지번호 :  
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="qa_no" id="qa_no" value="${user.qa_no}" readonly>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon"> 
									<i class="material-icons">title</i> 제목 :  
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="qa_title" id="qa_title" value="${user.qa_title}" readonly>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon" > 
									<i class="material-icons">content_paste</i> 내용 : 
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="qa_content" value="${user.qa_content}" readonly>
								</div>
							</div>
							<div class="input-group">
								<span class="input-group-addon">
									<i class="material-icons">person</i> 작성자 : 
								</span>
								<div class="form-line">
									<input type="text" class="form-control" name="qa_writer" value="${user.qa_writer}" readonly>
								</div>
							</div>							
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
	
});

</script>
<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>