<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
table, td{
text-align : center;
}
</style>

<section class="content">
	<h1>나의 강의목록</h1>
	<br>
	<div class="container-fluid">
		<div class="block-header">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">						
						<div class="body">
							<div class="table-responsive">
								<h3>수강 목록</h3>
								<div id="DataTables_Table_1_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap"
									style="height:200px; overflow:scroll;">									
									<table
										class="table table-bordered table-striped table-hover dataTable js-exportable"
										id="DataTables_Table_1" role="grid"
										aria-describedby="DataTables_Table_1_info">
										<thead>
											<tr role="row">
												<th class="sorting_asc" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 50px; text-align:center;">강의실 번호</th>
												<th class="sorting" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-label="Position: activate to sort column ascending"
													style="width: 80px; text-align:center;">강의실 제목</th>
												<th class="sorting_asc" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 50px; text-align:center;">선생님 이름</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${leCo}" var="leco">
												<tr>
													<td><c:out value="${leco.lecture_no }" /></td>
													<td><a class="move" href="${leco.lecture_no }"> <c:out
																value="${leco.lecture_name }" /></a></td>
													<td><c:out value="${leco.user_name }" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container-fluid">
		<div class="block-header">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">						
						<div class="body">
							<div class="table-responsive">
							<h3>대기 목록</h3>
								<div id="DataTables_Table_1_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap" 
									style="height:200px; overflow:scroll;">									
									<table
										class="table table-bordered table-striped table-hover dataTable js-exportable"
										id="DataTables_Table_1" role="grid"
										aria-describedby="DataTables_Table_1_info">
										<thead>
											<tr role="row">
												<th class="sorting_asc" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 50px; text-align:center;">강의실 번호</th>
												<th class="sorting" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-label="Position: activate to sort column ascending"
													style="width: 80px; text-align:center;">강의실 제목</th>
												<th class="sorting_asc" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 50px; text-align:center;">선생님 이름</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${leLi}" var="lect">
												<tr>
													<td><c:out value="${lect.lecture_no }" /></td>
													<td><c:out value="${lect.lecture_name }" /></td>
													<td><c:out value="${lect.user_name }" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</section>

<form id='actionForm' action="/student/lecturelist" method='get'>
	<input type='hidden' name='user_no'
		value='<sec:authentication property="principal.user.user_no"/>'>
</form>

<script type="text/javascript">
	$(document).ready(
			function() {
				var result = '<c:out value="${result}"/>';
				if (result) {
					alert("신청이 완료되었습니다.");
				}

				$('.move')
						.on(
								"click",
								function(e) {

									e.preventDefault();

									$("#actionForm").append(
											"<input type='hidden' name='lecture_no' value='"
													+ $(this).attr("href")
													+ "' />");
									$("#actionForm").attr("action",
											"/student/lecture");
									$("#actionForm").submit();
								});

			});
</script>



<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>