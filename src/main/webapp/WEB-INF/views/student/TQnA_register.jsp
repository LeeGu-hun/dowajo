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
#txtTitle{
	height: 30px; width: 500px;
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
	height: 30px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	background-color: #d4f0ff;	
	text-align: center;
}
table, tr, td{
	padding: 5px 0;
}
</style>
<body>
	<section class="content">
		<!-- start: Content -->
		<div id="content">
			<div class="col-md-12 top-20 padding-0">
				<div class="col-md-12">
				<h1>
				강사 Q&A
				</h1>	
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
											<h3>
											질문하기
											</h3>
										</div>
										<div class="body table-responsive">
											<table>
												<tr>
													<td>
													   <select class="form-control show-tick" name="tqa_replyer" id="tqa_replyer" >
	                                    				<option value="">강사 선택</option>
	                                    				<c:forEach items="${list}" var="list">                                        				
	                                        				<option value="${list}">${list}</option>                                        				                                        				
	                                    				</c:forEach>
	                                    				</select>                                    			  
	                                				</td>
                                				</tr>
												<tr>													
													<td>														
														제 목<br>
														<input type="text" name="tqa_title" id="txtTitle" placeholder="제목 입력" >
													</td>													
												</tr>
												<tr>
													<td>
														질문 내용<br>
														<textarea name="tqa_content" id="txtContent" maxlength="100" placeholder="내용 입력"></textarea>
													</td>													
												</tr>
												<tr>
													<td>
														작성자<br>
														<input type="text" name="tqa_writer" id="txtWriter" value="<sec:authentication property='principal.user.user_name'/>" readonly>
													</td>
												</tr>											
											</table>											
											<div class="menu">												
																								
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
		if($('#tqa_replyer').val()==""){
			alert("질문할 강사를 선택해주세요.");
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