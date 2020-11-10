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
				<h1>
				강사 Q&A
				</h1>	
					<div class="panel form-element-padding">
						<div class="panel-heading">								
						</div>
						<div class="panel-body" style="padding-bottom: 30px;">
							
							<div class="row clearfix">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="card">
										<div class="header">
																				
											<h3>
											목록
											</h3>
										</div>
										<div class="body table-responsive">
											<table class="table table-hover" >
												<thead>
													<tr>
														<th>번호</th>
														<th>작성자</th>
														<th>제목</th>
														<th>지정 강사</th>
														<th>작성 일자</th>
														<th>답변 상태</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list}" var="list">
														<tr style="cursor: pointer;">
															<td><c:out value="${list.tqa_no }" /></td>
															<td><c:out value="${list.tqa_writer}" /></td>																															
															<td><a class="move" href="${list.tqa_no}"><c:out value="${list.tqa_title}" /></a></td>
															<td><c:out value="${list.tqa_replyer}"/></td>
															<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.tqa_date}" /></td>
															<td>
															<c:if test="${list.tqa_status eq 0}">대기</c:if>
															<c:if test="${list.tqa_status eq 1}"><p style="color:#0703fc;">완료</p></c:if>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<div class="divBtn">
											<button type="button" id = "btn" class="btn bg-blue-grey waves-effect">질문하기</button>
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
<form id='actionForm' action="/student/tQnA_list" method='get'>	
	<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
</form>
</body>
<script>
$(document).ready(function(){
	$('#btn').on("click", function(){
		location.href="/student/TQnA_register?user_no=<sec:authentication property='principal.user.user_no'/>";
		
	});

	$('.move').on("click", function(e){
		e.preventDefault();
		console.log("move click");
		$('#actionForm').append("<input type='hidden' name='tqa_no' value='"
				+$(this).attr('href')+"' />");
		$('#actionForm').attr("action","/student/TQnA_get");
		$('#actionForm').submit();
	});

	
	
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>