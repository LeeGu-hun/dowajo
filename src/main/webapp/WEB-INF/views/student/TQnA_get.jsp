<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​

<style>
.txtTitle{
	height: 30px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	padding-left: 20px;	
	text-align: center;
}
.txtContent{
	height: 70px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	padding-left: 20px;
	
}
.txtWriter{
	height: 30px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	background-color: #d3fcc5;	
	text-align: center;
}
.txtReply{
	height: 130px; width: 500px;
	border : 1px solid black;
	border-radius: 10px;
	padding-left: 20px;
}
table{
	margin-left: 200px;
}
table, tr, td{	
	padding: 5px 5px;
}
.divBtn{
	margin-left: 650px;
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
							<div class="row clearfix">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="card">
										<div class="header">
											<h2>
												<b>질문하기</b><small>내용 보기</small>
											</h2>
										</div>
										<div class="body table-responsive">
											<table>
												<tr>													
													<td>														
														제 목<br>
														<input type="text" name="tqa_title" class="txtWriter" value='<c:out value="${tqa.tqa_title }"/>' readonly>
													</td>
													
												</tr>
												<tr>
													<td>
														문의 내용<br>
														<textarea name="tqa_content" class="txtContent" readonly>${tqa.tqa_content}</textarea>
													</td>													
												</tr>
												<tr>
													<td>
														작성자<br>
														<input type="text" name="tqa_writer" class="txtWriter" value="<sec:authentication property='principal.user.user_name'/>" readonly>
													</td>
													<td>
														답변자<br>
														<input type="text" name="tqa_teacher" class="txtWriter" value="<c:out value="${tqa.tqa_teacher }"/>" readonly>
													</td>
													
												</tr>													
												<tr>
													<td>
														작성 시간<br>
														<input type="text" name="tqa_date" class="txtTitle"  value='<fmt:formatDate pattern="yyyy/MM/dd" value="${tqa.tqa_date}" />' readonly>
													</td>
													
												</tr>												
											</table>																																	
											<hr>											
											<div class="divBtn">																							
												<button type="button" id="btn" class="btn bg-blue-grey waves-effect">돌아가기</button>
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
<script>
$(document).ready(function(){		
	$('#btn').on("click", function(){
		history.back();
	});
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>