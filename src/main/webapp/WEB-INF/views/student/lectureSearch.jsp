<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<section class="content">
	<label><h3>강의실 찾기</h3></label><br>
	<div id="container">
	<div class="row">
	<form id='searchForm' action="/student/lectureSearch" method='get'>
		<select name='type'>
		<option value="" <c:out value="${pageMaker.cri.type==null?'selected':'' }"/>>검색항목</option>
		<option value="N" <c:out value="${pageMaker.cri.type eq 'N'?'selected':'' }"/>>강의제목</option>
		<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>선생님 아이디</option>										
		<option value="NT" <c:out value="${pageMaker.cri.type eq 'NT'?'selected':'' }"/>>강의 제목  or 선생님 아이디</option>
		</select> 
		<input type="search" id="keyword" name="keyword" value='<c:out value="${pageMaker.cri.keyword}" />'/>
		<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
		<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>			
		<button class='btn btn-default'>Search</button>
	</form>
	</div>
	</div>
	<h3>강의실 목록</h3>
	<br>
	<div id="container">
	<div id="allList" style="overflow: auto; width: 100%; height: 100%; border: 1px solid black;">
			<table class="table table-condensed">
				<thead>
					<tr>
						<th>#</th>
						<th>강의실명</th>
						<th>선생님 아이디</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${leAL}" var="leAL">
						<tr>
							<td><c:out value="${leAL.lecture_no }" /></td>							
							<td><a class="move" href="${leAL.lecture_name }">
							<c:out value="${leAL.lecture_name }" /></a></td>
							<td><c:out value="${leAL.lecture_twitchid }" /></td>
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

</section>

<form id='actionForm' action="/student/lectureSearch" method='get'>
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
	<input type='hidden' name='type' value='${pageMaker.cri.type}'>
	<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
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
		
		$("#actionForm").append("<input type='hidden' name='lecture_name' value='"+$(this).attr("href")+"' />");
		$("#actionForm").attr("action", "/student/lectureInfo");
		$("#actionForm").submit();
		});
	
});
</script>


<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>