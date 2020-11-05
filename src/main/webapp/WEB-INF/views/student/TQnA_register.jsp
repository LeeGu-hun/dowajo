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
#txtTitle{
	height: 50px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	padding-left: 20px;
}
#txtContent{
	height: 70px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	padding-left: 20px;
}
#txtWriter{
	height: 50px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	background-color: #ffc1b8;	
	text-align: center;
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
							<form id='actionForm' action="/student/TQnA_register" method="POST">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>
							<div class="row clearfix">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="card">
										<div class="header">
											<h2>
												<b>질문하기</b><small>글 등록</small>
											</h2>
										</div>
										<div class="body table-responsive">
											<div class="menu">
												<label>글제목&nbsp
												<input type="text" name="tqa_title" id="txtTitle" placeholder="제목 입력" >
												</label>												
											</div>
											<div class="menu">
												<label style="">글내용&nbsp
												<textarea name="tqa_content" id="txtContent" maxlength="100" placeholder="내용 입력"></textarea>
												</label>
											</div>
											<div class="menu">
												<label>작성자&nbsp
												<input type="text" name="tqa_writer" id="txtWriter" value="<sec:authentication property='principal.user.user_name'/>" readonly>
												</label>
											</div>
											<div class="menu">												
												<div class="col-sm-6">
                                    				<select class="form-control show-tick" name="tqa_teacher" id="tqa_teacher">
                                        				<option value="">질문드릴 선생님</option>
                                        				<option value="강사">강사</option>
                                        				<option value="강사2">강사2</option>
                                        				<option value="강사3">강사3</option>                                        				
                                    				</select>
                                				</div>												
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
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>

 

<script>
$(document).ready(function(){
	var formObj = $("#actionForm");
	$('#btnRegister').on("click", function(){
		if($('#txtTitle').val() == ""){
			alert("제목을 입력해주세요.");
			$('#txtTitle').focus();	
			return false;		
		}
		if($('#tqa_teacher').val()==""){
			alert("질문할 교사를 선택해주세요.");
			return false;
		}
		formObj.submit();
	});

	$('#btnCancel').on("click", function(){
		history.back();
	});
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>