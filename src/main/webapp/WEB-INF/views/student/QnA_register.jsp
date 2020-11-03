<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​

<style>
.divBtn{
	margin-left: 20px;
}
.menu{
	padding: 20px;
}
#txtContent{
	height: 70px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
}
#txtTitle, #txtWriter{
	height: 50px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
}
</style>
<body>
	<section class="content">
		<!-- start: Content -->
		<div id="content">
			<div class="col-md-12 top-20 padding-0">
				<div class="col-md-12">
					<div class="panel form-element-padding">
						<div class="panel-heading">
							<h4></h4>
						</div>
						<div class="panel-body" style="padding-bottom: 30px;">

							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div class="row clearfix">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="card">
										<div class="header">
											<h2>
												<b>문의하기</b><small>글 등록</small>
											</h2>
										</div>
										<div class="body table-responsive">
											<div class="menu">
												<label>글제목&nbsp
												<input type="text" name="title" id="txtTitle" >
												</label>												
											</div>
											<div class="menu">
												<label>글내용&nbsp
												<input type="text" name="content" id="txtContent" maxlength="100">
												</label>
											</div>
											<div class="menu">
												<label>작성자&nbsp
												<input type="text" name="writer" id="txtWriter" value="<sec:authentication property='principal.user.user_id'/>" readonly>
												</label>
											</div>
											<hr>
											<div class="divBtn">
												<button type="button" id="btnRegister" class="btn bg-blue-grey waves-effect">등록</button>&nbsp											
												<button type="button" id="btnCancel" class="btn bg-blue-grey waves-effect">취소</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>

<form id='actionForm' action="/student/QnA_list" method='get'>	
	<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'> 
</form>
<script>
$(document).ready(function(){
	$('#btnRegister').on("click", function(){
		alert("글 등록");		
	});

	$('#btnCancel').on("click", function(){
		location.href="/student/QnA_list";
	});
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>