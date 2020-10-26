<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_admin.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>문의사항</h2>
						</div>
						<div class="body">
							<div class="table-responsive">
								<div id="DataTables_Table_1_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap">
									<div id="DataTables_Table_1_filter" class="dataTables_filter">
										<label>Search:<input type="search"
											class="form-control input-sm" placeholder=""
											aria-controls="DataTables_Table_1"></label>
									</div>
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
													style="width: 150px;">번호</th>
												<th class="sorting_asc" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 250px;">아이디</th>
												<th class="sorting" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-label="Position: activate to sort column ascending"
													style="width: 397px;">제목</th>
												<th class="sorting" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 187px;">날짜</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${questions}" var="user">
												<tr role="row" class="odd">
												<td><c:out value="${user.que_no }" /></td>
												<td><c:out value="${user.que_writer }" /></td>
												<td><c:out value="${user.que_title }" /></td>
												<td><fmt:formatDate pattern="yyyy-MM-dd"
													value="${user.que_date }" /></td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
									<div class="dataTables_info" id="DataTables_Table_1_info"
										role="status" aria-live="polite">Showing 1 to 10 of 57
										entries</div>
									<div class="dataTables_paginate paging_simple_numbers"
										id="DataTables_Table_1_paginate">
										<ul class="pagination">
											<li class="paginate_button previous disabled"
												id="DataTables_Table_1_previous"><a href="#"
												aria-controls="DataTables_Table_1" data-dt-idx="0"
												tabindex="0">Previous</a></li>
											<li class="paginate_button active"><a href="#"
												aria-controls="DataTables_Table_1" data-dt-idx="1"
												tabindex="0">1</a></li>
											<li class="paginate_button "><a href="#"
												aria-controls="DataTables_Table_1" data-dt-idx="2"
												tabindex="0">2</a></li>
											<li class="paginate_button "><a href="#"
												aria-controls="DataTables_Table_1" data-dt-idx="3"
												tabindex="0">3</a></li>
											<li class="paginate_button "><a href="#"
												aria-controls="DataTables_Table_1" data-dt-idx="4"
												tabindex="0">4</a></li>
											<li class="paginate_button "><a href="#"
												aria-controls="DataTables_Table_1" data-dt-idx="5"
												tabindex="0">5</a></li>
											<li class="paginate_button "><a href="#"
												aria-controls="DataTables_Table_1" data-dt-idx="6"
												tabindex="0">6</a></li>
											<li class="paginate_button next" id="DataTables_Table_1_next"><a
												href="#" aria-controls="DataTables_Table_1" data-dt-idx="7"
												tabindex="0">Next</a></li>
										</ul>
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

<%@ include file="/WEB-INF/views/include/footer_admin.jsp"%>