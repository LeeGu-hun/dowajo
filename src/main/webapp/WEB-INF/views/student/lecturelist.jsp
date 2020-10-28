<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<section class="content">
	<h3>수강할 수 있는 강의 목록</h3>
	<br>
	<div id="container">
		<div id="list"
			style="overflow: auto; width: 100%; height: 100%; border: 1px solid black;">
			<table class="table table-condensed">
				<thead>
					<tr>
						<th>#</th>
						<th>강의실명</th>
						<th>선생님 이름</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${leCo}" var="leco">
						<tr>
							<td><c:out value="${leco.lecture_no }" /></td>
							<td><c:out value="${leco.lecture_name }" /></td>
							<td><c:out value="${leco.lecture_afreecaid }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>			
		</div>
	</div>


	<h3>수강신청한 강의 목록</h3>
	<br>
	<div id="container">
		<div id="list"
			style="overflow: auto; width: 100%; height: 100%; border: 1px solid black;">
			<table class="table table-condensed">
				<thead>
					<tr>
						<th>#</th>
						<th>강의실명</th>
						<th>선생님 이름</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${leLi}" var="lect">
						<tr>
							<td><c:out value="${lect.lecture_no }" /></td>
							<td><c:out value="${lect.lecture_name }" /></td>
							<td><c:out value="${lect.lecture_afreecaid }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>			
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
		
});
</script>



<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>