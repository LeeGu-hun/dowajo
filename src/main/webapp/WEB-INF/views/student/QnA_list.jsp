<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​

<style>
table, tr, th{
	text-align: center;
}
.divBtn{
	margin-left: 20px;
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
												<b>문의하기</b><small>목록</small>
											</h2>
										</div>
										<div class="body table-responsive">
											<table class="table table-hover" >
												<thead>
													<tr>
														<th>번호</th>
														<th>작성자</th>
														<th>제목</th>
														<th>작성 일자</th>
														<th>답변 여부</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list}" var="list">
														<tr style="cursor: pointer;">
															<td><c:out value="${list.qa_no }" /></td>
															<td><c:out value="${list.qa_writer}" /></td>																															
															<td><a class="move" href="${list.qa_no}"><c:out value="${list.qa_title}" /></a></td>
															<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.qa_date}" /></td>
															<td><c:out value="${list.qa_status}"/></td>															
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<div class="divBtn">
											<button type="button" id = "btn" class="btn bg-blue-grey waves-effect">글 등록</button>
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
<form id='actionForm' action="/student/QnA_list" method='get'>	
	<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
</form>
</body>
<script>
$(document).ready(function(){
	$('#btn').on("click", function(){
		location.href="/student/QnA_register";		
	});

	$('.move').on("click", function(e){
		e.preventDefault();
		console.log("move click");
		$('#actionForm').append("<input type='hidden' name='qa_no' value='"
				+$(this).attr('href')+"' />");
		$('#actionForm').attr("action","/student/QnA_get");
		$('#actionForm').submit();
	});

	if($('#qa_status').val() == 0){
		
	}
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>