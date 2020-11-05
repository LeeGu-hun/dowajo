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
										<form id='searchForm' action="/admin/questions" method='get'>
											<ul class='pagination'>
											<select name='type'>
											<option value="" <c:out value="${pageMaker.cri.type==null?'selected':'' }"/>>목록</option>
											<option value="N" <c:out value="${pageMaker.cri.type eq 'N'?'selected':'' }"/>>아이디</option>
											<option value="Q" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>											
											</select> 
											<input type='hidden' name='user_auth' value='${user_auth}'>
											<input type="search" id="keyword" name="keyword" value='<c:out value="${pageMaker.cri.keyword}" />'/>
											<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
											<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>			
											<button class="btn bg-red waves-effect">Search</button>
											</ul>
										</form>
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
												<th class="sorting" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-label="Position: activate to sort column ascending"
													style="width: 397px;">제목</th>
												<th class="sorting_asc" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 250px;">아이디</th>	
												<th class="sorting" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 187px;">날짜</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${questions}" var="user">
												<tr role="row" class="odd">
												<td><c:out value="${user.qa_no }" /></td>
												<td><a class="move" href="${user.qa_no}"><c:out value="${user.qa_title }" /></a></td>
												<td><c:out value="${user.qa_writer }" /></td>
												<td><fmt:formatDate pattern="yyyy-MM-dd"
													value="${user.qa_date }" /></td>
											</tr>
											</c:forEach>
										</tbody>	
									</table>
								</div>
								<div class='pull-right'>
								  <ul class='pagination'>
								  <c:if test="${pageMaker.prev}">
								  <li class="paginate_button previous"><a href="${pageMaker.startPage -1}">Previous</a>
								  </li>
								  </c:if>
								  
								  <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
								  <li class="paginate_button ${pageMaker.cri.pageNum==num?"active":""}"><a href="${num}">${num}</a></li>
								  
								  </c:forEach>
								  
								  <c:if test="${pageMaker.next}">
								  <li class="paginate_button next"><a href="${pageMaker.endPage+1}">Next</a>
								  </li>
								  </c:if>
								  </ul>
								  </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<form id='actionForm' action="/admin/questions" method='get'>
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
	<input type='hidden' name='type' value='${pageMaker.cri.type}'>
	<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
</form>

<script type="text/javascript">
$(document).ready(function(){
	var actionForm = $("#actionForm");

	$(".paginate_button a").on("click", function(e){
		e.preventDefault();

		console.log('click');

		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
		});

	$("#searchForm>button").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택하세요");
			return false;
			}
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
			}

		searchForm.find("input[name='pageNum']").val('1');
		e.preventDefault();

		searchForm.submit();
		});

	$('.move').on("click", function(e){
		e.preventDefault();
		console.log("move click");
		$('#actionForm').append("<input type='hidden' name='qa_no' value='"
				+$(this).attr('href')+"' />");
		$('#actionForm').attr("action","/admin/QnA_get");
		$('#actionForm').submit();
	});	
	
});
</script>

<%@ include file="/WEB-INF/views/include/footer_admin.jsp"%>