<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_teacher.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<%-- <section class="content">
    <div class="container-fluid">
        <div class="block-header">
            <h2>Teacher PAGE</h2>
        </div>
    </div>
</section> --%>
<body>
<section class="content" >
    
    <div class="col-md-12 top-20 padding-0">
		<div class="col-md-12">
			<div class="panel">
				<div class="panel-heading">
					<div style="width: 30%;display: inline-block;">
						<h4 style="display: inline-block;">내 강의목록</h4>
					</div>
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
											style="width: 215px;">강의 번호</th>
										<th class="sorting" tabindex="0"
											aria-controls="datatables-example" rowspan="1" colspan="1"
											aria-label="Position: activate to sort column ascending"
											style="width: 329px;">강의명</th>
										<th class="sorting" tabindex="0"
											aria-controls="datatables-example" rowspan="1" colspan="1"
											aria-label="Office: activate to sort column ascending"
											style="width: 167px;">강사님 명</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${list}" var="teacher">
										<tr style="cursor: pointer;">
											<td><c:out value="${teacher.lecture_no }" /></td>
											<td><a class="move" href="${teacher.lecture_no}"><b>[<c:out
														value="${teacher.lecture_description }" />]</b></a></td>
											<td><c:out value="${teacher.lecture_name }" /></td>
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
									<li class="page_btn"><a href="${pageMaker.startPage - 1}" aria-label="Previous"> <span
											aria-hidden="true">&laquo;</span>
									</a></li>
								</c:if>
								<c:forEach var="num" begin="${pageMaker.startPage }"
										end="${pageMaker.endPage }">
									<li 
									class='page_btn ${pageMaker.cri.pageNum == num?"active":""}'><a href="${num}">${num}</a></li>
								</c:forEach>
								<c:if test="${pageMaker.next }">
									<li class="page_btn"><a href="${pageMaker.endPage + 1 }" aria-label="Next"> <span
											aria-hidden="true">&raquo;</span>
									</a></li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</section>
</body>
<form id='actionForm' action="/teacher/teacher_main" method='get'>
<%-- 	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
	<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'>
	<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'> --%>
</form>
<script>
$(document).ready(function(){
	function openModal(modalname) {
		document.get
		$("#modal").fadeIn(300);
		$("." + modalname).fadeIn(300);
	}
	var result = '<c:out value="${result}"/>';
	checkModal(result);

	history.replaceState({}, null, null);

	function checkModal(result) {
		if (result === '' || history.state)
			return;
		if (parseInt(result) > 0) {
			$("#modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
		}
		openModal('reg-modal');
	}
	$('.move').on("click", function(e){		
		e.preventDefault();
		console.log("move click");
 		$('#actionForm').append("<input type='hidden' name='lecture_no' value='"
				+$(this).attr('href')+"' />"); //href에 적혀져있는 값의 속성을 변경,추가한다.
		$('#actionForm').attr("action","/teacher/teacher_check");
		$('#actionForm').submit();
	});
	$('.page_btn>a').on("click", function(e){
		e.preventDefault();
		console.log("click");
		$('#actionForm').find("input[name='pageNum']").val($(this).attr("href"));
		$('#actionForm').submit();
	});
	$('#regBtn').on("click", function() {
		location.href = "/cust/regist";
	});
});
</script>
<%@ include file="/WEB-INF/views/include/footer_teacher.jsp" %>