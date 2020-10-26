<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<section class="content">
	<h3>수강중인 강의 목록</h3>
	<br>
	<div id="container">
		<div id="list"
			style="overflow: auto; width: 100%; height: 100%; border: 1px solid black;">
			<table class="table table-condensed">
				<thead>
					<tr>
						<th>#</th>
						<th>강의실명</th>
						<th>선생님 아이디</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${leLi}" var="lect">
						<tr>
							<td><c:out value="${lect.lecture_no }" /></td>
							<td><c:out value="${lect.lecture_name }" /></td>
							<td><c:out value="${lect.lecture_twitchid }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<h3>강의실 목록</h3>
	<br>
	<div id="container"></div>
	<div id="allList"
			style="overflow: auto; width: 100%; height: 100%; border: 1px solid black;">
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


<form id='actionForm' action="/student/lecturelist" method='get'>
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
	<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'>	
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


	$('.move').on("click", function(e){

		e.preventDefault();
		
		$("#actionForm").append("<input type='hidden' name='lecture_name' value='"+$(this).attr("href")+"' />");
		$("#actionForm").attr("action", "/student/lectureInfo");
		$("#actionForm").submit();
		});

	
});
</script>



<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>