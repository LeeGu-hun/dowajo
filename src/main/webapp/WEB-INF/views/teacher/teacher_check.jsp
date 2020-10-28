<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_teacher.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>


<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<h2>
				강의 신청 및 수업시작 <small>Taken by <a
					href="https://github.com/dbushell/Nestable" target="_blank">github.com/dbushell/Nestable</a></small>
			</h2>
		</div>
		<div class="row clearfix">
			<!-- Default Example -->
			<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
				<div class="card">
					<form method="get" action="cancel">
						<div class="header">
							<h2>
								등록된 학생 목록 <input type="button" id="regBtn"
									class="btn bg-red waves-effect" value="수강해제"
									style="float: right;"> <small>잘못 등록한 학생이있으면
									체크박스에 체크한뒤 버튼을 눌러주세요. </small>
							</h2>
						</div>
						<div class="panel-body">
							<div class="responsive-table">
								<div id="datatables-example_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap no-footer">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="datatables-example_length">

											</div>
										</div>
										<div class="col-sm-6" style="text-align: right;">
											<div id="datatables-example_filter" class="dataTables_filter">
											</div>
										</div>
									</div>
									<table class="table table-striped table-bordered" width="100%"
										cellspacing="0">
										<thead>
											<tr>
												<th class="sorting_asc" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 215px;">학 번</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Position: activate to sort column ascending"
													style="width: 329px;">이 름</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 167px;">전화번호</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 150px;">수강신청</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${cancel}" var="teacher">
												<tr style="cursor: pointer;">
													<td><c:out value="${teacher.st_no }" /></td>
													<td><c:out value="${teacher.user_name}" /></td>
													<td><c:out value="${teacher.mobile }" /></td>
													<td>
														<div class="demo-checkbox">
															<input type="checkbox" class="cancel_lc"
																id="<c:out value="${teacher.st_no}"/>"
																class="chk-col-pink"> <label
																for="<c:out value="${teacher.st_no}"/>">PINK</label>
														</div>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="col-md-6" style="padding-top: 20px;">
									<!-- <span>showing 0-10 of 30 items</span> -->
								</div>
								<div class="col-md-6">
									<ul class="pagination pull-right">
										<c:if test="${pageMaker.prev }">
											<li class="page_btn"><a
												href="${pageMaker.startPage - 1}" aria-label="Previous">
													<span aria-hidden="true">&laquo;</span>
											</a></li>
										</c:if>
										<c:forEach var="num" begin="${pageMaker.startPage }"
											end="${pageMaker.endPage }">
											<li
												class='page_btn ${pageMaker.cri.pageNum == num?"active":""}'><a
												href="${num}">${num}</a></li>
										</c:forEach>
										<c:if test="${pageMaker.next }">
											<li class="page_btn"><a href="${pageMaker.endPage + 1 }"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
										</c:if>
									</ul>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
				<div class="card">
					<form method="get" action="" name="sign_up">
						<div class="header">
							<h2>
								수강신청한 학생 목록 <input type="button" id="signBtn"
									class="btn bg-red waves-effect" value="수강등록"
									style="float: right;"> <small>등록하고자 하는 학생이있으면
									체크박스에 체크한뒤 버튼을 눌러주세요.</small>
							</h2>

						</div>
						<div class="panel-body">
							<div class="responsive-table">
								<div id="datatables-example_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap no-footer">
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_length" id="datatables-example_length">

											</div>
										</div>
										<div class="col-sm-6" style="text-align: right;">
											<div id="datatables-example_filter" class="dataTables_filter">
											</div>
										</div>
									</div>
									<table class="table table-striped table-bordered" width="100%"
										cellspacing="0">
										<thead>
											<tr>
												<th class="sorting_asc" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 215px;">학 번</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Position: activate to sort column ascending"
													style="width: 329px;">이 름</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 167px;">전화번호</th>
												<th class="sorting" tabindex="0"
													aria-controls="datatables-example" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 150px;">수강신청</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${sign_up}" var="teacher">
												<tr style="cursor: pointer;">
													<td><c:out value="${teacher.st_no }" /></td>
													<td><c:out value="${teacher.user_name}" /></td>
													<td><c:out value="${teacher.mobile }" /></td>
													<td>
														<div class="demo-checkbox">
															<input type="checkbox" class="chk_not_reg"
																id="<c:out value="${teacher.st_no}"/>"
																value="<c:out value="${teacher.st_no}"/>"
																class="chk-col-pink"> <label
																for="<c:out value="${teacher.st_no}"/>">PINK</label>
														</div>
													</td>
												</tr>
											</c:forEach>

										</tbody>
									</table>
								</div>
								<div class="col-md-6" style="padding-top: 20px;">
									<!-- <span>showing 0-10 of 30 items</span> -->
								</div>
								<div class="col-md-6">
									<ul class="pagination pull-right">
										<c:if test="${pageMaker.prev }">
											<li class="page_btn"><a
												href="${pageMaker.startPage - 1}" aria-label="Previous">
													<span aria-hidden="true">&laquo;</span>
											</a></li>
										</c:if>
										<c:forEach var="num" begin="${pageMaker.startPage }"
											end="${pageMaker.endPage }">
											<li
												class='page_btn ${pageMaker.cri.pageNum == num?"active":""}'><a
												href="${num}">${num}</a></li>
										</c:forEach>
										<c:if test="${pageMaker.next }">
											<li class="page_btn"><a href="${pageMaker.endPage + 1 }"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
										</c:if>
									</ul>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- #END# Default Example -->
		</div>
		<!-- Draggable Handles -->
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<button type="button" id="start_class"
						class="btn btn-primary waves-effect" style="float: right;">수업시작</button>
				</div>
			</div>
		</div>
		<!-- #END# Draggable Handles -->
	</div>
</section>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ready(function() {


		
		$('#start_class').on("click", function() {
			location.href = "/teacher/lecture/";
		});
		$('#signBtn').on("click", function() {
			
			 var checkArr = [];
			$('.chk_not_reg:checked').each(function(i) {
				checkArr.push($(this).val());
			})
			for (var i = 0; i < checkArr.length; i++) {
				console.log("arr:"+checkArr[i]);
			} 
			var lecture_no = $('<c:out value="${teacher.lecture_no }" />');
			console.log(lecture_no);
			$.ajax({
				type : 'post',
				url : '/teacher/test',
				dataType : 'text',//받을떄 타입
				data : {"checkArr" : checkArr
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},

				success : function(result, status, xhr) {
					//result 값 return 해서 append추가해서 위에 값 구성
				},
				error : function(xhr, status, er) {
					if (error) {
						error(er);
					}
				}
			});
		});
	});
</script>

<%@ include file="/WEB-INF/views/include/footer_teacher.jsp"%>