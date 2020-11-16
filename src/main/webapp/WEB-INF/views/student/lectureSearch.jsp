 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
table, td{
text-align : center;
}
</style>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h1>추천 강의 찾기</h1>
						</div>
						<div class="body">
							<div class="table-responsive">
								<div id="DataTables_Table_1_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap">
									<div id="DataTables_Table_1_filter" class="dataTables_filter">
										<form id='searchForm' action="/student/lectureSearch" method='get'>
											<ul class='pagination'>
											<select name='type'>
											<option value="" <c:out value="${pageMaker.cri.type==null?'selected':'' }"/>>검색항목</option>
											<option value="N" <c:out value="${pageMaker.cri.type eq 'N'?'selected':'' }"/>>강의제목</option>
											<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>선생님 이름</option>											
											<option value="NT" <c:out value="${pageMaker.cri.type eq 'NT'?'selected':'' }"/>>강의 제목  or 선생님 이름</option>
											</select> 
											<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>		
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
													style="width: 50px; text-align:center;">강의실 번호</th>
												<th class="sorting" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-label="Position: activate to sort column ascending"
													style="width: 100px; text-align:center;">강의 사진</th>
												<th class="sorting_asc" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-sort="ascending"
													aria-label="Name: activate to sort column descending"
													style="width: 150px; text-align:center;">강의실 제목</th>
												<th class="sorting" tabindex="0"
													aria-controls="DataTables_Table_1" rowspan="1" colspan="1"
													aria-label="Office: activate to sort column ascending"
													style="width: 100px; text-align:center;">선생님 이름</th>												
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${leAL}" var="leAL">
											<tr>
								<td><c:out value="${leAL.lecture_no }" /></td>						
							<td>
							<c:if test="${leAL.savedLecImage==null}">
							<img src='<spring:url value="/lec_img/defaultImage.jpg"/>' height ="50dp">
							</c:if>
							<c:if test="${leAL.savedLecImage!=null}">
							<img src='<spring:url value="/lec_img/${leAL.savedLecImage}"/>' height ="50dp">
							</c:if>							
							</td>
							<td><a class="move" href="${leAL.lecture_no }">
							<c:out value="${leAL.lecture_name }" /></a></td>
							<td><c:out value="${leAL.user_name }" /></td>
						</tr>
					</c:forEach>
				</tbody>
									</table>
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
	</div>
</section>

<form id='actionForm' action="/student/lectureSearch" method='get'>
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
	<input type='hidden' name='type' value='${pageMaker.cri.type}'>
	<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>	
	<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>	
</form>

<script type="text/javascript">
$(document).ready(function(){
	var actionForm = $("#actionForm");
	var searchForm = $("#searchForm");

	
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
		
		$("#actionForm").append("<input type='hidden' name='lecture_no' value='"+$(this).attr("href")+"' />");
		$("#actionForm").attr("action", "/student/lectureInfo");
		$("#actionForm").submit();
		});
	
});
</script>


<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>