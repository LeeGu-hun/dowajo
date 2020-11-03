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
						<th>강의실 번호</th>
						<th>강의실 제목</th>
						<th>선생님 이름</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${leCo}" var="leco">
						<tr>
							<td><c:out value="${leco.lecture_no }" /></td>
							<td><a class="move" href="${leco.lecture_no }">
							<c:out value="${leco.lecture_name }" /></a></td>
							<td><c:out value="${leco.user_name }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>			
		</div>
	</div>


	<h3>수강신청중인 강의 목록</h3>
	<br>
	<div id="container">
		<div id="list"
			style="overflow: auto; width: 100%; height: 100%; border: 1px solid black;">
			<table class="table table-condensed">
				<thead>
					<tr>
						<th>강의실 번호</th>
						<th>강의실 제목</th>
						<th>선생님 이름</th>
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
	
	
</section>

<form id='actionForm' action="/student/lecturelist" method='get'>	
	<input type='hidden' name='user_no' value='<sec:authentication property="principal.user.user_no"/>'> 
</form>

<script type="text/javascript">
$(document).ready(function(){
	var result = '<c:out value="${result}"/>';	
	if (result) {
		alert("신청이 완료되었습니다.");
	}

	$('.move').on("click", function(e){

		e.preventDefault();
		
		$("#actionForm").append("<input type='hidden' name='lecture_no' value='"+$(this).attr("href")+"' />");
		$("#actionForm").attr("action", "/student/lecture");
		$("#actionForm").submit();
		});
	
});
</script>



<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>