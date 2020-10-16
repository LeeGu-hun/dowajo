<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header_student.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<section class="content">
	<label><h3>강의실 찾기</h3><input type="search" class="form-control input-sm" placeholder="" aria-controls="DataTables_Table_0"></label><br>
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
							<td><c:out value="${leAL.lecture_name }" /></td>
							<td><c:out value="${leAL.lecture_twitchid }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</section>




<%@ include file="/WEB-INF/views/include/footer_student.jsp"%>